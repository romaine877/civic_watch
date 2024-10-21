import 'package:civic_watch/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<UserModel?> loginAnonymously() async {
    try {
      final response = await _supabaseClient.auth.signInAnonymously(data: {});
      return UserModel(
        id: response.user!.id,
        email: response.user!.email,
        name: response.user?.userMetadata?["name"],
        photoUrl: response.user?.userMetadata?["picture"],
      );
    } catch (e) {
      rethrow;
    }
  }

  //   Future<UserModel?> loginWithApple() async {
  //   final rawNonce = _supabaseClient.auth.generateRawNonce();
  //   final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
  //   String? fullname;

  //   final credential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //     nonce: hashedNonce,
  //   );

  //   try {
  //     final idToken = credential.identityToken;
  //     if (idToken == null) {
  //       throw const AuthException(
  //           'Could not find ID Token from generated credential.');
  //     }

  //     final response = await _supabaseClient.auth.signInWithIdToken(
  //       provider: OAuthProvider.apple,
  //       idToken: idToken,
  //       nonce: rawNonce,
  //     );

  //     if (credential.givenName != null && credential.familyName != null) {
  //       fullname = '${credential.givenName} ${credential.familyName}';
  //       await _supabaseClient.auth.updateUser(UserAttributes(
  //         data: {
  //           'email': response.user!.email,
  //           'name': fullname,
  //         },
  //       ));
  //     }

  //     return UserModel(
  //       id: response.user!.id,
  //       email: response.user?.userMetadata?["email"],
  //       name: fullname ?? response.user?.userMetadata?["name"],
  //       photoUrl: response.user?.userMetadata?["picture"],
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //   Future<UserModel?> loginWithGoogle() async {
  //   String webClientId = Env.webClientId;

  //   String iosClientId = Env.iosClientId;

  //   final GoogleSignIn googleSignIn = GoogleSignIn(
  //     clientId: iosClientId,
  //     serverClientId: webClientId,
  //   );
  //   final googleUser = await googleSignIn.signIn();

  //   if (googleUser == null) {
  //     return null;
  //   }

  //   final googleAuth = await googleUser.authentication;
  //   final accessToken = googleAuth.accessToken;
  //   final idToken = googleAuth.idToken;

  //   if (accessToken == null) {
  //     throw 'No Access Token found.';
  //   }
  //   if (idToken == null) {
  //     throw 'No ID Token found.';
  //   }

  //   try {
  //     final response = await supabase.auth.signInWithIdToken(
  //       provider: OAuthProvider.google,
  //       idToken: idToken,
  //       accessToken: accessToken,
  //     );
  //     await googleSignIn.signOut();
  //     return UserModel(
  //       id: response.user!.id,
  //       email: response.user!.email,
  //       name: response.user?.userMetadata?["name"],
  //       photoUrl: response.user?.userMetadata?["picture"],
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //sign out
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
