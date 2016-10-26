module Components.Release exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import String

-- Release component
-- release : Main.State -> Html a
release state =
    div[][p[][ text state.version ]
        , p[][ text state.build ]
    ]
