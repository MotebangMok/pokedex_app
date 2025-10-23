import 'package:flutter/material.dart';
import 'package:pokedex_app/core/constants/pokemon_size_constant.dart';
import 'package:pokedex_app/views/screens/auth/register_view.dart';
import 'package:pokedex_app/views/view_models/auth_view_model.dart';

class LoginFormBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? confirmPasswordController;
  final AuthState authState;
  final VoidCallback onLogin;
  final String title;

  const LoginFormBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.authState,
    required this.onLogin,
    required this.title,
    this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.catching_pokemon,
          size: 100,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: PokemonSizeConstants.extraLargeSpacing),
        Text(
          'Pokédex',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: PokemonSizeConstants.mediumSpacing),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: PokemonSizeConstants.contentPadding),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        if (confirmPasswordController != null) ...[
          const SizedBox(height: PokemonSizeConstants.contentPadding),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
        if (authState.errorMessage != null) ...[
          const SizedBox(height: PokemonSizeConstants.contentPadding),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              authState.errorMessage!,
              style: TextStyle(color: Colors.red.shade900),
            ),
          ),
        ],
        const SizedBox(height: PokemonSizeConstants.largeSpacing),
        ElevatedButton(
          onPressed: authState.isLoading ? null : onLogin,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(PokemonSizeConstants.contentPadding),
          ),
          child: authState.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(confirmPasswordController != null ? 'Register' : 'Login'),
        ),
        if (confirmPasswordController == null) ...[
          const SizedBox(height: PokemonSizeConstants.contentPadding),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const RegisterView()));
            },
            child: const Text('Don\'t have an account? Register'),
          ),
        ],
      ],
    );
  }
}
