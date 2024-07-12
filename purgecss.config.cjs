module.exports = {
  content: ['./app/**/*.html.erb', './app/helpers/**/*.rb'],
  css: ['./app/assets/builds/application.css', './app/assets/builds/tailwind.css'],
  output: './app/assets/builds',
  safelist: {
      standard: [
          'textarea',
          'input',
          'button',
          'select',
          'optgroup',
          'turbo-frame',
          'pre',
          'html',
          'body'
      ],
      deep: [/some-custom-class/]
  }
}