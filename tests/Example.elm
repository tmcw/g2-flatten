module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import GeoJson exposing (GeoJsonObject(..), Geometry(..))
import GeoJsonFlatten exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "GeoJsonFlatten"
        [ describe "flatten"
            [ test "does nothing to a simple point" <|
                \_ ->
                    Expect.equal (flatten (FeatureCollection [])) (FeatureCollection [])
            , test "Flattens a MultiPoint into multiple points" <|
                \_ ->
                    Expect.equal
                        (flattenGeometry (Just (MultiPoint [ ( 1, 2, 0 ), ( 3, 4, 0 ) ])))
                        [ Just (Point ( 1, 2, 0 )), Just (Point ( 3, 4, 0 )) ]
            , test "Flattens a MultiLineString into multiple line strings" <|
                \_ ->
                    Expect.equal
                        (flattenGeometry
                            (Just
                                (MultiLineString
                                    [ [ ( 1, 2, 0 ), ( 3, 4, 0 ) ]
                                    , [ ( 2, 2, 0 ), ( 3, 4, 0 ) ]
                                    ]
                                )
                            )
                        )
                        [ Just
                            (LineString
                                [ ( 1, 2, 0 ), ( 3, 4, 0 ) ]
                            )
                        , Just
                            (LineString
                                [ ( 2, 2, 0 ), ( 3, 4, 0 ) ]
                            )
                        ]
            , test "Flattens a MultiPolygon into multiple polygons" <|
                \_ ->
                    Expect.equal
                        (flattenGeometry
                            (Just
                                (MultiPolygon
                                    [ [ [ ( 1, 2, 0 ), ( 3, 4, 0 ) ] ]
                                    , [ [ ( 2, 2, 0 ), ( 3, 4, 0 ) ] ]
                                    ]
                                )
                            )
                        )
                        [ Just
                            (Polygon
                                [ [ ( 1, 2, 0 ), ( 3, 4, 0 ) ] ]
                            )
                        , Just
                            (Polygon
                                [ [ ( 2, 2, 0 ), ( 3, 4, 0 ) ] ]
                            )
                        ]
            ]
        ]
