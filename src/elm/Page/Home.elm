module Page.Home exposing (view, init, update, subscriptions, Model, Msg)

import Char exposing (fromCode, toCode)
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Keyboard
import Route exposing (Route)


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
    | Go
    | NoOp



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg, Maybe Route )
update msg mode =
    let
        goTo route =
            ( mode, Cmd.none, Just route )

        select mode =
            ( mode, Cmd.none, Nothing )
    in
        case msg of
            Select Normal ->
                select Normal

            Select Correcting ->
                select Correcting

            Go ->
                goTo <| routeOf mode

            NoOp ->
                ( mode, Cmd.none, Nothing )



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
    in
        Keyboard.presses
            (\code ->
                if (code == enterCode) then
                    Go
                else if (upKeyCodes |> List.member code) then
                    Select Normal
                else if (downKeyCodes |> List.member code) then
                    Select Correcting
                else
                    NoOp
            )



---- Utils ----


routeOf : Model -> Route
routeOf model =
    case model of
        Normal ->
            Route.NormalMode

        Correcting ->
            Route.CorrectingMode
