import globals from 'globals';
import pluginJs from '@eslint/js';

export default [
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node // Isso define o ambiente Node.js
      }
    }
  },
  pluginJs.configs.recommended,
  {
    rules: {
      'no-console': 'error'
    }
  }
];
