module Router exposing (..)

import Html exposing (..)
import Navigation exposing (Location)
import Html exposing (Html, Attribute, a)
import Bootstrap.Grid as Grid
import Bootstrap.Navbar
import HomePage
import Navbar
import RouteHelper exposing (..)


type Msg
    = ChangeLocation String
    | OnLocationChange Location
    | NavbarMsg Bootstrap.Navbar.State
    | HomePageMsg HomePage.Msg


type alias Model =
    { route : Route
    , navbarState : Bootstrap.Navbar.State
    , homePageModel : HomePage.Model
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation location

        ( navbarState, navbarCmd ) =
            Bootstrap.Navbar.initialState NavbarMsg
    in
        ( { route = currentRoute
          , navbarState = navbarState
          , homePageModel = HomePage.init
          }
        , navbarCmd
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLocation path ->
            ( model, Navigation.newUrl path )

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        NavbarMsg state ->
            ( { model | navbarState = state }, Cmd.none )

        HomePageMsg homePageMsg ->
            updateHomePage homePageMsg model


updateHomePage : HomePage.Msg -> Model -> ( Model, Cmd Msg )
updateHomePage msg model =
    let
        ( homePageModel, homePageCmd ) =
            HomePage.update msg model.homePageModel
    in
        ( { model | homePageModel = homePageModel }, homePageCmd |> Cmd.map HomePageMsg )


view : Model -> Html Msg
view model =
    div []
        [ Navbar.view model.navbarState model.route ChangeLocation NavbarMsg
        , page model
        ]


page : Model -> Html Msg
page model =
    Grid.container []
        [ case model.route of
            HomeRoute ->
                Html.map HomePageMsg (HomePage.view model.homePageModel)

            AboutRoute ->
                text "About"

            NotFoundRoute ->
                text "Not Found"
        ]
