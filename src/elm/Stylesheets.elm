port module Stylesheets exposing (..)

import Css.File exposing (..)
import MainCss as Main


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    toFileStructure [ ( "src/static/styles/main.css", compile [ Main.css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files cssFiles
