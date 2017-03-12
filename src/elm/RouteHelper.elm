module RouteHelper exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import UrlParser exposing (Parser, (</>), int, oneOf, s)
import Navigation exposing (Location)
import Html.Attributes exposing (href, attribute)
import Html exposing (Html, Attribute, a)
import Html.Events exposing (onWithOptions)
import Bootstrap.Navbar
import Json.Decode as Json


type Route
    = HomeRoute
    | AboutRoute
    | NotFoundRoute


routeParser : Parser (Route -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map HomeRoute (UrlParser.s "")
        , UrlParser.map AboutRoute (UrlParser.s "about")
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
    case (UrlParser.parsePath routeParser location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


encode : Route -> String
encode route =
    case route of
        HomeRoute ->
            "/"

        AboutRoute ->
            "/about"

        NotFoundRoute ->
            "/"


navigate : Route -> Cmd msg
navigate route =
    Navigation.newUrl (encode route)


linkTo : Route -> List (Attribute msg) -> List (Html msg) -> Html msg
linkTo route attrs content =
    a ((linkAttrs route) ++ attrs) content


linkAttrs : Route -> List (Attribute msg)
linkAttrs route =
    let
        path =
            encode route
    in
        [ href path
        , attribute "data-navigate" path
        ]


catchNavigationClicks : msg -> Attribute msg
catchNavigationClicks message =
    onWithOptions "click"
        { stopPropagation = True
        , preventDefault = True
        }
        (Json.succeed message)


pathDecoder : Json.Decoder String
pathDecoder =
    Json.oneOf
        [ Json.at [ "data-navigate" ] Json.string
        , Json.at [ "parentElement" ] (Json.lazy (\_ -> pathDecoder))
        , Json.fail "no path found for click"
        ]
