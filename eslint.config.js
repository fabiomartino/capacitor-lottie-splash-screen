// eslint.config.js
import js from '@eslint/js';
import tseslint from '@typescript-eslint/eslint-plugin';
import tsparser from '@typescript-eslint/parser';

export default [
  js.configs.recommended,

  // Base TypeScript setup
  {
    files: ['**/*.ts'],
    languageOptions: {
      parser: tsparser,
      parserOptions: {
        project: ['./tsconfig.json', './example-app/tsconfig.json'],
        tsconfigRootDir: process.cwd(),
      },
      globals: {
        window: 'readonly',
        console: 'readonly',
      },
    },
    plugins: {
      '@typescript-eslint': tseslint,
    },
    rules: {
      'no-unused-vars': 'off',
      '@typescript-eslint/no-unused-vars': 'off',
    },
  },

  // Node-based scripts
  {
    files: ['eslint.config.js', 'scripts/**/*.js'],
    languageOptions: {
      sourceType: 'module',
      ecmaVersion: 'latest',
      globals: {
        process: 'readonly',
        console: 'readonly',
        require: 'readonly',
        module: 'readonly',
        __dirname: 'readonly',
      },
    },
  },

  // Jasmine/Jest test files
  {
    files: ['**/*.spec.ts'],
    languageOptions: {
      globals: {
        describe: 'readonly',
        it: 'readonly',
        expect: 'readonly',
        beforeEach: 'readonly',
        afterEach: 'readonly',
        jest: 'readonly',
      },
    },
  },

  // Karma
  {
    files: ['**/karma.conf.js'],
    languageOptions: {
      sourceType: 'script',
      ecmaVersion: 'latest',
      globals: {
        require: 'readonly',
        module: 'readonly',
        __dirname: 'readonly',
      },
    },
  },

  // Ignores
  {
    ignores: [
      // Node/build artifacts
      'dist/**',
      'build/**',
      'node_modules/**',

      // Capacitor build outputs
      'example-app/www/**',
      'example-app/ios/DerivedData/**',
      'example-app/ios/App/App/public/**',
      'example-app/android/app/src/main/assets/public/**',

      // Android build internals
      'android/build/**',
      'example-app/android/app/build/**',
      'android/build/reports/**',

      // Native bridge copies
      '**/*.app/**',
      '**/Frameworks/**/*.js',
      '**/native-bridge.js',
    ],
  },
];
