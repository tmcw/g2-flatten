module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import GeoJson exposing (GeoJsonObject(..))
import GeoJsonFlatten exposing (flatten)
import Test exposing (..)


suite : Test
suite =
    describe "GeoJsonFlatten"
        [ describe "flatten"
            [ test "does nothing to a simple point" <|
                \_ ->
                    Expect.equal (FeatureCollection []) (FeatureCollection [])
            ]
        ]
