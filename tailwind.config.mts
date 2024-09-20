import type { Config } from 'tailwindcss'
import tailwindScrollbar from 'tailwind-scrollbar'

export default {
  content: [
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/views/**/*.{html,html.haml,haml}',
    './app/frontend/**/*.{js,ts,vue,css,scss}',
  ],
  theme: {
    extend: {}
  },
  plugins: [
    tailwindScrollbar
  ]
} satisfies Config
