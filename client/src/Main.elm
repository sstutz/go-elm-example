module Main exposing (State)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Html.Events exposing ( onClick )

import Components.Release exposing ( release )


-- APP
main : Program (Maybe State)
main =
    App.programWithFlags
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }


-- MODEL
type alias State =
    { version : String
    , build   : String
    }


-- Initialize a state
init : Maybe State -> (State, Cmd Msg)
init state =
    case state of
        Just state ->
            ( state, Cmd.none )

        Nothing ->
           ( State "unknown" "unknown", Cmd.none )


-- UPDATE
type Msg
    = NoOp
    | Release


update : Msg -> State -> (State, Cmd Msg)
update msg state =
  case msg of
    NoOp ->
        ( state, Cmd.none )
    Release ->
        ( { state | version = "", build = "" }, Cmd.none )


-- VIEW
view : State -> Html Msg
view state =
    div[][
        release state
    ]
