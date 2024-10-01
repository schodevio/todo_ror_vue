import globals from 'globals'
import tseslint from 'typescript-eslint'
import pluginVue from 'eslint-plugin-vue'

export default tseslint.config(
  ...tseslint.configs.recommended,
  ...pluginVue.configs['flat/recommended'],

  { languageOptions: { globals: globals.browser } },
  { ignores: ['public/**/*.{js,ts,vue}'] },

  {
    files: ['app/frontend/**/*.vue'],
    languageOptions: {
      parserOptions: {
        parser: tseslint.parser
      }
    }
  },

  {
    rules: {
      'vue/attributes-order': ['off'],
      'vue/prop-name-casing': ['camelCase' | 'snake_case']
    }
  }
)
