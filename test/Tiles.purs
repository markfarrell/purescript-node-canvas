module Test.Tiles
  ( Tile
  , tiles
  , drawTile
  ) where

import Prelude

import Data.Tuple (Tuple(..))
import Data.Tuple (fst, snd) as Tuple
import Data.Array (range) as Array
import Data.Int (toNumber) as Int

import Effect.Aff (Aff)

import Node.Canvas (CanvasImageSource, Context2D)
import Node.Canvas.Aff (drawImage) as Canvas

data Tile = Tile CanvasImageSource { x :: Number, y :: Number, w :: Number, h :: Number }

instance showTile :: Show Tile where
  show (Tile image t) = "Tile" <> " " <> show image <> " " <> show t

positions :: Number -> Number -> Int -> Int -> Array (Tuple Number Number)
positions width height repeatX repeatY = 
  let
    xs = positions' width repeatX
    ys = positions' height repeatY
  in
    Tuple <$> xs <*> ys
  where
    positions' s t = (*) s <$> Int.toNumber <$> flip (-) 1 <$> Array.range 1 t

tiles :: Number -> Number -> Int -> Int -> CanvasImageSource -> Array Tile
tiles width height repeatX repeatY image =
  let
    tiles' = \t -> Tile image { x : Tuple.fst t , y : Tuple.snd t, w : width, h : height }
  in
    tiles' <$> positions width height repeatX repeatY

drawTile :: Context2D -> Number -> Number -> Tile -> Aff Unit
drawTile context x y (Tile image t) =
  let
    drawImage' = Canvas.drawImage context image
  in
    drawImage' t.x t.y t.w t.h x y t.w t.h
