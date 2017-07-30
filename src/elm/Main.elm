module Main exposing (..)

import Html exposing (Html, div, img, text)
import Page.Home as HomePage exposing (subscriptions, view, Msg(Go))
import Route exposing (..)
import Utils exposing (x)


---- MODEL ----


type alias Model =
    { route : Route
    , home : HomePage.Model
    }


init : ( Model, Cmd Msg )
init =
    x
        { route = HomeRoute
        , home = HomePage.init
        }



---- UPDATE ----


type Msg
    = HomeMsg HomePage.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeMsg (HomePage.Go route) ->
            x { model | route = route }

        HomeMsg subMsg ->
            case HomePage.update subMsg model.home of
                ( newModel, cmd ) ->
                    ( { model | home = newModel }
                    , cmd |> Cmd.map HomeMsg
                    )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.route of
        HomeRoute ->
            HomePage.view model.home
                |> Html.map HomeMsg

        NormalModeRoute ->
            div [] [ text "normal mode" ]

        CorrectingModeRoute ->
            div [] [ text "correcting mode" ]



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    HomePage.subscriptions model.home |> Sub.map HomeMsg



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
