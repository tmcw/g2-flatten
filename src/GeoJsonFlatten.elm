module GeoJsonFlatten exposing (flatten, flattenFeature, flattenGeometry)

import GeoJson exposing (FeatureObject, GeoJsonObject(..), Geometry(..))
import Json.Encode


flattenFeatureCollection : List FeatureObject -> GeoJsonObject
flattenFeatureCollection features =
    FeatureCollection (List.concatMap flattenFeature features)


flattenGeometry : Maybe Geometry -> List (Maybe Geometry)
flattenGeometry geometry =
    case geometry of
        Nothing ->
            [ Nothing ]

        Just (Point p) ->
            [ Just (Point p) ]

        Just (LineString p) ->
            [ Just (LineString p) ]

        Just (Polygon p) ->
            [ Just (Polygon p) ]

        Just (GeometryCollection g) ->
            List.map Just g

        Just (MultiPoint mp) ->
            List.map (\sp -> Just (Point sp)) mp

        Just (MultiPolygon mpl) ->
            List.map (\pl -> Just (Polygon pl)) mpl

        Just (MultiLineString p) ->
            List.map (\l -> Just (LineString l)) p



--- TODO: try to flatten a feature. currently struggling with FeatureObject


flattenFeature : FeatureObject -> List FeatureObject
flattenFeature { geometry, id, properties } =
    List.map (\geom -> { geometry = geom, id = id, properties = properties })
        (flattenGeometry geometry)


flatten : GeoJsonObject -> GeoJsonObject
flatten fc =
    case fc of
        FeatureCollection features ->
            flattenFeatureCollection features

        Feature feature ->
            FeatureCollection (flattenFeature feature)

        Geometry geom ->
            Geometry geom
