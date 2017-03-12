module Main exposing (..)

import Html exposing (..)
import Html.CssHelpers
import Navigation exposing (Location)
import Bootstrap.Navbar
import Router


{ id, class, classList } =
    Html.CssHelpers.withNamespace "ebws"


type Msg
    = OnLocationChange Location
    | RouterMsg Router.Msg


type alias Model =
    { routerModel : Router.Model
    }


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        ( routerModel, routerCmd ) =
            Router.init location
    in
        ( { routerModel = routerModel
          }
        , routerCmd |> Cmd.map RouterMsg
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    Bootstrap.Navbar.subscriptions model.routerModel.navbarState Router.NavbarMsg |> Sub.map RouterMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                ( routerModel, routerCmd ) =
                    Router.update (Router.OnLocationChange location) model.routerModel
            in
                ( { model | routerModel = routerModel }, routerCmd |> Cmd.map RouterMsg )

        RouterMsg routerMsg ->
            let
                ( routerModel, routerCmd ) =
                    Router.update routerMsg model.routerModel
            in
                ( { model | routerModel = routerModel }, routerCmd |> Cmd.map RouterMsg )


view : Model -> Html Msg
view model =
    div []
        [ Router.view model.routerModel |> Html.map RouterMsg
        ]
