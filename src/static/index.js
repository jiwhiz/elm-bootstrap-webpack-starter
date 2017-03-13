// pull in desired CSS/SASS files
require("../elm/Stylesheets.elm")

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
Elm.Main.embed( document.getElementById( 'main' ) );
