import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/user_model.dart';
import '../../../core/constants/app_constants.dart';

part 'auth_remote_datasource.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) =>
    AuthRemoteDataSource(
      FirebaseAuth.instance,
      FirebaseFirestore.instance,
      GoogleSignIn(),
    );

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._auth, this._db, this._google);

  final FirebaseAuth     _auth;
  final FirebaseFirestore _db;
  final GoogleSignIn     _google;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection(AppConstants.usersCollection);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel> getCurrentUser() async {
    final u = _auth.currentUser;
    if (u == null) throw Exception('Not authenticated');
    return _fetchProfile(u.uid);
  }

  Future<UserModel> signInWithEmail(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email, password: password);
    return _fetchOrCreate(cred.user!);
  }

  Future<UserModel> registerWithEmail(String email, String password, String fullName) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);
    await cred.user!.updateDisplayName(fullName);
    return _createProfile(cred.user!, fullName);
  }

  Future<UserModel> signInWithGoogle() async {
    final gUser = await _google.signIn();
    if (gUser == null) throw Exception('Google sign-in cancelled');
    final gAuth = await gUser.authentication;
    final cred  = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken:     gAuth.idToken,
    );
    final userCred = await _auth.signInWithCredential(cred);
    return _fetchOrCreate(userCred.user!);
  }

  Future<String> sendPhoneOtp(String phoneNumber) async {
    String? vid;
    await _auth.verifyPhoneNumber(
      phoneNumber:           phoneNumber,
      verificationCompleted: (_) {},
      verificationFailed:    (e) => throw e,
      codeSent:              (id, _) => vid = id,
      codeAutoRetrievalTimeout: (_) {},
    );
    if (vid == null) throw Exception('Verification ID not received');
    return vid!;
  }

  Future<UserModel> verifyPhoneOtp(String verificationId, String otp) async {
    final cred = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode:        otp,
    );
    final userCred = await _auth.signInWithCredential(cred);
    return _fetchOrCreate(userCred.user!);
  }

  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), _google.signOut()]);
  }

  Future<UserModel> updateProfile({String? fullName, String? photoUrl, String? phoneNumber}) async {
    final u = _auth.currentUser;
    if (u == null) throw Exception('Not authenticated');
    final updates = <String, dynamic>{};
    if (fullName    != null) { updates['full_name']    = fullName;    await u.updateDisplayName(fullName); }
    if (photoUrl    != null) { updates['photo_url']    = photoUrl;    await u.updatePhotoURL(photoUrl); }
    if (phoneNumber != null) { updates['phone_number'] = phoneNumber; }
    if (updates.isNotEmpty)  await _users.doc(u.uid).update(updates);
    return getCurrentUser();
  }

  Future<UserModel> _fetchOrCreate(User u) async {
    final doc = await _users.doc(u.uid).get();
    if (doc.exists) return UserModel.fromFirestore(doc);
    return _createProfile(u, u.displayName ?? u.email!.split('@').first);
  }

  Future<UserModel> _fetchProfile(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) throw Exception('Profile not found');
    return UserModel.fromFirestore(doc);
  }

  Future<UserModel> _createProfile(User u, String fullName) async {
    final model = UserModel(
      id:        u.uid,
      email:     u.email ?? '',
      fullName:  fullName,
      photoUrl:  u.photoURL,
      addresses: [],
      createdAt: DateTime.now(),
    );
    await _users.doc(u.uid).set(model.toFirestore());
    return model;
  }
}