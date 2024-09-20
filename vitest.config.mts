import { defineConfig } from 'vitest/config'

import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  test: {
    coverage: {
      reportsDirectory: 'public/fcoverage',
      exclude: ['app/frontend/**/*.{test,spec}.ts'],
      include: ['app/frontend/{components,utils}/**/*.{vue,ts}']
    },
    environment: 'happy-dom',
    include: ['app/frontend/**/*.{test,spec}.ts']
  }
})
