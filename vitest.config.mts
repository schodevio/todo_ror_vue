import { defineConfig } from 'vitest/config'
import { resolve } from 'path'

import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  test: {
    alias: {
      '@components': resolve(__dirname, 'app/frontend/components'),
      '@utils': resolve(__dirname, 'app/frontend/utils')
    },
    coverage: {
      reportsDirectory: 'public/fcoverage',
      exclude: ['app/frontend/**/*.{test,spec}.ts'],
      include: ['app/frontend/{components,utils}/**/*.{vue,ts}']
    },
    environment: 'happy-dom',
    include: ['app/frontend/**/*.{test,spec}.ts']
  }
})
