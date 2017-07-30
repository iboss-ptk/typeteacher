module Utils exposing (..)


x : model -> ( model, Cmd msg )
x model =
    ( model, Cmd.none )


cycleBack : List a -> List a
cycleBack l =
    let
        rev =
            List.reverse l

        last =
            List.head rev

        withoutLast =
            List.tail rev
                |> Maybe.map List.reverse
    in
        case ( last, withoutLast ) of
            ( Just last, Just withoutLast ) ->
                last :: withoutLast

            _ ->
                []


cycleForth : List a -> List a
cycleForth l =
    let
        head =
            List.head l

        withoutHead =
            List.drop 1 l
    in
        case head of
            Just head ->
                List.append withoutHead [ head ]

            Nothing ->
                []
