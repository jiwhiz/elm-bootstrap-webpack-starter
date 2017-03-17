# elm-bootstrap-webpack-starter


### About:
A simple Webpack 2 setup for writing [Elm](http://elm-lang.org/) apps 
with [elm-bootstrap](http://elm-bootstrap.info/):

* Dev server with live reloading, HMR
* Support for CSS/SCSS (with Autoprefixer), image assets
* Bundling and minification for deployment
* Bootstrap 4 Template 
  [fixed navbar example](https://v4-alpha.getbootstrap.com/examples/navbar-top-fixed) 
  implemented by [elm-bootstrap Navbar](http://elm-bootstrap.info/navbar)
* Use [elm-css](https://github.com/rtfeldman/elm-css) to generate css from elm code
* Use [elm-css-webpack-loader](https://github.com/jiwhiz/elm-css-webpack-loader/tree/upgrade)
  to load Stylesheets.elm as css


### Install:
Clone this repo into a new project folder, e.g. `my-elm-project`:
```
git clone https://github.com/jiwhiz/elm-bootstrap-webpack-starter my-elm-project
cd my-elm-project
```

Re-initialize the project folder as your own repo:
```
rm -rf .git         # on Windows: rmdir .git /s /q
git init
git add .
git commit -m 'first commit'
```

Install all dependencies using the handy `reinstall` script:
```
npm run reinstall
```
*This does a clean (re)install of all npm and elm packages.*


### Serve locally:
```
npm start
```
* Access app at `http://localhost:8080/`
* Get coding! The entry point file is `src/elm/Main.elm`
* Browser will refresh automatically on any file changes..


### Build & bundle for prod:
```
npm run build
```

* Files are saved into the `/dist` folder
* To run locally, use `npm run local`


### Credits:

* [elm-community/elm-webpack-starter](https://github.com/elm-community/elm-webpack-starter)
* [rundis/albums](https://github.com/rundis/albums)
* [ohanhi/elm-taco](https://github.com/ohanhi/elm-taco)
