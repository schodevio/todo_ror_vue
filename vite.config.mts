import { defineConfig } from 'vite'
import { resolve } from 'path'

import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue()
  ],
  resolve: {
    alias: {
      'vue': 'vue/dist/vue.esm-bundler.js',
      '@components': resolve(__dirname, 'app/frontend/components'),
      '@utils': resolve(__dirname, 'app/frontend/utils')
    }
  }
})
