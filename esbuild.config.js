const esbuild = require('esbuild')

esbuild.build({
  entryPoints: ['application.js'],
  bundle: true,
  minify: true,
  sourcemap: true,
  outfile: 'output.js',
}).catch(() => process.exit(1))