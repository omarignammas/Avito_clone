// config/tailwind.config.js
module.exports = {
    content: [
      './app/views/**/*.html.erb',
      './app/helpers/**/*.rb',
      './app/assets/builds/**/*.js',
      './app/javascript/**/*.js',
      './config/initializers/simple_form.rb',
    ],
    theme: {
      extend: {
        colors: {
          'avito-red': '#e74c3c',
          'avito-blue': '#3498db',
          'avito-green': '#2ecc71',
        },
        fontFamily: {
          sans: ['Inter var', 'sans-serif'],
        },
      },
    },
    plugins: [
      require('@tailwindcss/forms'),
      require('@tailwindcss/typography'),
      require('@tailwindcss/aspect-ratio'),
    ],
  }