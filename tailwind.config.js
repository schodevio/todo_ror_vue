/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/views/**/*.{html,html.haml,haml}',
    './app/frontend/**/*.{js,ts,vue,css,scss}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
