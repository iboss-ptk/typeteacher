module Page.Home exposing (view, init, update, subscriptions, Model, Msg(Go))

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Keyboard
import Route exposing (..)


---- MODEL ----


type Mode
    = Normal
    | Correcting


type alias Model =
    Mode


init : Model
init =
    Normal


type Msg
    = Select Mode
    | Go Route



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Select Normal ->
            ( Normal, Cmd.none )

        Select Correcting ->
            ( Correcting, Cmd.none )

        Go route ->
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
    let
        selected selectedMode =
            if (model == selectedMode) then
                " selected"
            else
                ""

        modeWithLabelsToMenu modeWithLabels =
            div
                [ class <|
                    "option"
                        ++ selected modeWithLabels.mode
                , onClick <| Select modeWithLabels.mode
                ]
                [ text modeWithLabels.label ]
    in
        div [ id "home-page" ]
            [ div
                [ class "title" ]
                [ text title ]
            , div
                [ class "menu" ]
                (modeWithLabels |> List.map modeWithLabelsToMenu)
            ]


type alias ModeWithLabel =
    { mode : Mode
    , label : String
    }


modeWithLabels : List ModeWithLabel
modeWithLabels =
    [ { mode = Normal, label = "normal mode" }
    , { mode = Correcting, label = "correcting mode" }
    ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        enterCode =
            13

        routeMap mode =
            case mode of
                Normal ->
                    NormalModeRoute

                Correcting ->
                    CorrectingModeRoute
    in
        Keyboard.presses
            (\code ->
                case code of
                    enterCode ->
                        Go <| routeMap model
            )
