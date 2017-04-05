module MainCss exposing (..)

import Html exposing (Attribute)
import Html.Attributes
import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)


type CssClasses
    = NavBar
    | Jumbotron
    | BrandLogo


type CssIds
    = Page


css : Stylesheet
css =
    (stylesheet << namespace "ebws")
        [ body
            [ minHeight (Css.rem 75)
            , paddingTop (Css.rem 4.5)
            ]
        , class Jumbotron
            [ textAlign center
            ]
        , class BrandLogo
            [ width (px 30)
            ]
        ]


styles : List Css.Mixin -> Attribute msg
styles =
    Css.asPairs >> Html.Attributes.style
