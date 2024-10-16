class Env {
  static String get type => const String.fromEnvironment('ENV');
  static String get supabaseUrl => const String.fromEnvironment('SUPABASE_URL');
  static String get supabaseAnonKey => const String.fromEnvironment('SUPABASE_ANON_KEY');
}
