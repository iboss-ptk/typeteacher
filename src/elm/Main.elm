module Main exposing (..)

import Html exposing (Html, div, img, text)
import Page.Home as HomePage exposing (view)


---- MODEL ----


type alias Page =
    { home : HomePage.Model }


init : ( Page, Cmd Msg )
init =
    case HomePage.init of
        ( model, cmd ) ->
            ( { home = model }, cmd |> Cmd.map HomeMsg )



---- UPDATE ----


type Msg
    = HomeMsg HomePage.Msg


update : Msg -> Page -> ( Page, Cmd Msg )
update msg page =
    case msg of
        HomeMsg subMsg ->
            case HomePage.update subMsg page.home of
                ( newModel, cmd ) ->
                    ( { page | home = newModel }, cmd |> Cmd.map HomeMsg )



---- VIEW ----


view : Page -> Html Msg
view page =
    HomePage.view page.home
        |> Html.map HomeMsg



---- PROGRAM ----


main : Program Never Page Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
