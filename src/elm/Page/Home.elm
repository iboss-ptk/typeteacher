module Page.Home exposing (view, init, update, subscriptions, Model, Msg(Go))

import Char exposing (fromCode, toCode)
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Keyboard
import Route exposing (..)
import Utils exposing (x)


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
    | NoOp



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Select Normal ->
            x Normal

        Select Correcting ->
            x Correcting

        Go route ->
            x model

        NoOp ->
            x model



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

        upKeyCodes =
            [ toCode 'w', toCode 'k' ]

        downKeyCodes =
            [ toCode 's', toCode 'j' ]

        routeMap mode =
            case mode of
                Normal ->
                    NormalModeRoute

                Correcting ->
                    CorrectingModeRoute
    in
        Keyboard.presses
            (\code ->
                if (code == enterCode) then
                    Go <| routeMap model
                else if (upKeyCodes |> List.member code) then
                    Select Normal
                else if (downKeyCodes |> List.member code) then
                    Select Correcting
                else
                    NoOp
            )
