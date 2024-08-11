const defaultTheme = require('tailwindcss/defaultTheme')

const purgecss = require("@fullhuman/postcss-purgecss")({
  content: [
    "./app/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/assets/javascripts/**/*.js",
  ],
  defaultExtractor: (content) => {
    const broadMatches = content.match(/[^<>"'`\s]*[^<>"'`\s:]/g) || [];
    const innerMatches = content.match(/[^<>"'`\s.()]*[^<>"'`\s.():]/g) || [];
    return broadMatches.concat(innerMatches);
  },
});

module.exports = {
  //prefix: 'tw-',
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/views/**/*',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        bad_script: ['Bad script', ...defaultTheme.fontFamily.sans],
        messiri: ['El Messiri', ...defaultTheme.fontFamily.sans],
      },
      screens: {
        'xs': '320x',
        'sm': '640px',
        'md': '768px',
        'lg': '1024px',
        'xl': '1280px',
        '2xl': '1536px',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    //require('flowbite/plugin'),
    ...(process.env.NODE_ENV === "production" ? [purgecss] : []),
  ]
}
