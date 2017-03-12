module MainCss exposing (..)

import Html exposing (Attribute)
import Html.Attributes
import Css exposing (Stylesheet, stylesheet, minHeight, paddingTop, class, textAlign, center)
import Css.Elements exposing (body, li)
import Css.Namespace exposing (namespace)


type CssClasses
    = NavBar
    | Jumbotron


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
        ]


styles : List Css.Mixin -> Attribute msg
styles =
    Css.asPairs >> Html.Attributes.style
