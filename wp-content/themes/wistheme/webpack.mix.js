// webpack.mix.js

const mix = require('laravel-mix');

mix.js('src/app.js', 'dist/app.js') // Output the compiled JavaScript as dist/app.js
   .sass('src/app.scss', 'dist/app.css'); // Output the compiled CSS as dist/app.css

mix.setResourceRoot('/'); // Set the resource root to the root folder

mix.webpackConfig({
    output: {
        publicPath: '/',
        chunkFilename: 'dist/[name].js',
    },
});
