module HomePage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Bootstrap.Button as Button
import Css
import Html.CssHelpers
import MainCss
import Components.Hello exposing (hello)


type Msg
    = Increment


type alias Model =
    { count : Int
    }


{ id, class, classList } =
    Html.CssHelpers.withNamespace "ebws"


init : Model
init =
    { count = 0
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( { count = model.count + 1 }, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class [ MainCss.Jumbotron ] ]
        [ img
            [ src "static/img/elm.jpg"
            , MainCss.styles
                [ Css.width (Css.pct 33)
                , Css.border3 (Css.px 4) Css.solid (Css.hex "#337AB7")
                ]
            ]
            []
        , hello model.count
        , p [] [ text ("Elm Bootstrap Webpack Starter") ]
        , Button.button
            [ Button.primary
            , Button.large
            , Button.attrs [ onClick Increment ]
            ]
            [ span [] []
            , span [] [ text "FTW!" ]
            ]
        ]
