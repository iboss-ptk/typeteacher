module Page.Home exposing (view, init, update, Model, Msg)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)


---- MODEL ----


type Mode
    = Normal
    | Correcting


type alias Model =
    Mode


init : ( Mode, Cmd Msg )
init =
    ( Normal, Cmd.none )


type Msg
    = Select Mode



---- UPDATE ----


update : Msg -> Mode -> ( Mode, Cmd Msg )
update msg mode =
    case msg of
        Select Normal ->
            ( Normal, Cmd.none )

        Select Correcting ->
            ( Correcting, Cmd.none )



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


view : Mode -> Html Msg
view mode =
    let
        selected selectedMode =
            if (mode == selectedMode) then
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
