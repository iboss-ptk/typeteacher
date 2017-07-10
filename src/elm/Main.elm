module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)


---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


title : String
title =
    """
████████╗██╗   ██╗██████╗ ███████╗████████╗███████╗ █████╗  ██████╗██╗  ██╗███████╗██████╗
 ╚══██╔══╝╚██╗ ██╔╝██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██╔══██╗
    ██║    ╚████╔╝ ██████╔╝█████╗     ██║   █████╗  ███████║██║     ███████║█████╗  ██████╔╝
    ██║     ╚██╔╝  ██╔═══╝ ██╔══╝     ██║   ██╔══╝  ██╔══██║██║     ██╔══██║██╔══╝  ██╔══██╗
    ██║      ██║   ██║     ███████╗   ██║   ███████╗██║  ██║╚██████╗██║  ██║███████╗██║  ██║
    ╚═╝      ╚═╝   ╚═╝     ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
"""


view : Model -> Html Msg
view model =
    div []
        [ text title
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
