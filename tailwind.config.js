/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/views/**/*.{html,html.haml,haml}',
    './app/frontend/**/*.{js,ts,vue,css,scss}',
  ],
  theme: {
    extend: {
      height: {
        '10.5': '2.625rem',
        '11.5': '2.875rem'
      }
    },
  },
  plugins: [],
}
