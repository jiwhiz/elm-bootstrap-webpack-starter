module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.Events exposing (onWithOptions)
import Navigation exposing (Location)
import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Navbar exposing (State)
import Routes exposing (..)


-- component import example

import Components.Hello exposing (hello)


type Msg
    = ChangeLocation String
    | OnLocationChange Location
    | NavbarMsg State
    | Increment


type alias Model =
    { route : Routes.Route
    , navbarState : Bootstrap.Navbar.State
    , count : Int
    }


initialModel : Routes.Route -> Bootstrap.Navbar.State -> Model
initialModel route state =
    { route = route
    , navbarState = state
    , count = 0
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLocation path ->
            ( model, Navigation.newUrl path )

        OnLocationChange location ->
            let
                newRoute =
                    Routes.parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        NavbarMsg state ->
            ( { model | navbarState = state }, Cmd.none )

        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )


view : Model -> Html Msg
view model =
    Grid.container
        [ style [ ( "margin-top", "30px" ), ( "text-align", "center" ) ]
        ]
        [ CDN.stylesheet
        , Grid.row []
            [ Grid.col [ Col.xs12 ]
                [ div []
                    [ nav model ChangeLocation
                    , page model
                    ]
                ]
            ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        HomeRoute ->
            div [ class "jumbotron" ]
                [ img [ src "static/img/elm.jpg", style styles.img ] []
                , hello model.count
                , p [] [ text ("Elm Bootstrap Webpack Starter") ]
                , Button.button
                    [ Button.primary
                    , Button.large
                    , Button.attrs [ onClick Increment ]
                    ]
                    [ span [ class "glyphicon glyphicon-star" ] []
                    , span [] [ text "FTW!" ]
                    ]
                ]

        AboutRoute ->
            text "About"

        NotFoundRoute ->
            text "Not Found"



-- PROGRAM


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routes.parseLocation location

        ( navbarModel, navbarCmd ) =
            initNavbar NavbarMsg
    in
        ( initialModel currentRoute navbarModel, navbarCmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- CSS STYLES


styles : { img : List ( String, String ) }
styles =
    { img =
        [ ( "width", "33%" )
        , ( "border", "4px solid #337AB7" )
        ]
    }



-- NAVBAR


initNavbar : (State -> msg) -> ( State, Cmd msg )
initNavbar tagger =
    let
        ( navbarState, navbarCmd ) =
            Bootstrap.Navbar.initialState tagger
    in
        ( navbarState, navbarCmd )


routeToItemLink : (String -> msg) -> Routes.Route -> Routes.Route -> String -> Bootstrap.Navbar.Item msg
routeToItemLink tagger curRoute route title =
    let
        path =
            Routes.encode route

        itemLink =
            if curRoute == route then
                Bootstrap.Navbar.itemLinkActive
            else
                Bootstrap.Navbar.itemLink
    in
        itemLink
            [ href path
            , attribute "data-navigate" path
            , Routes.catchNavigationClicks (tagger path)
            ]
            [ text title ]


nav : Model -> (String -> Msg) -> Html Msg
nav model changeLocationTagger =
    Bootstrap.Navbar.config NavbarMsg
        |> Bootstrap.Navbar.withAnimation
        |> Bootstrap.Navbar.brand
            [ href "/" ]
            [ img
                [ src "static/img/elm-bootstrap.svg"
                , class "d-inline-block align-top"
                , style [ ( "width", "30px" ) ]
                ]
                []
            , text " Project"
            ]
        |> Bootstrap.Navbar.items
            [ routeToItemLink changeLocationTagger model.route Routes.HomeRoute " Home"
            , routeToItemLink changeLocationTagger model.route Routes.AboutRoute " About"
            ]
        |> Bootstrap.Navbar.view model.navbarState
