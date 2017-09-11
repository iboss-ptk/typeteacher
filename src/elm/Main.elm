module Main exposing (..)

import Html exposing (Html, div, img, text)
import Page.Home as HomePage exposing (subscriptions, view, Msg)
import Route exposing (Route)
import Utils exposing (x)


---- MODEL ----


type alias Model =
    { route : Route
    , home : HomePage.Model
    }


init : ( Model, Cmd Msg )
init =
    x
        { route = Route.Home
        , home = HomePage.init
        }



---- UPDATE ----


type Msg
    = HomeMsg HomePage.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeMsg subMsg ->
            case HomePage.update subMsg model.home of
                ( newModel, cmd, route ) ->
                    ( { model
                        | home = newModel
                        , route = Maybe.withDefault model.route route
                      }
                    , cmd |> Cmd.map HomeMsg
                    )



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.route of
        Route.Home ->
            HomePage.view model.home
                |> Html.map HomeMsg

        Route.NormalMode ->
            div [] [ text "normal mode" ]

        Route.CorrectingMode ->
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
