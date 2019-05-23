module Tiles (Tile, tiles, drawTile) where

import Prelude

import Data.Tuple (Tuple(..))
import Data.Tuple (fst, snd) as Tuple
import Data.Array (range) as Array
import Data.Int (toNumber) as Int

import Effect (Effect)

import Node.Canvas (CanvasImageSource, Context2D)
import Node.Canvas (drawImage) as Canvas

data Tile = Tile CanvasImageSource { x :: Number, y :: Number, w :: Number, h :: Number }

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

drawTile :: Context2D -> Tile -> Effect Unit
drawTile context (Tile image t) =
  let
    drawImage' = Canvas.drawImage context image
  in
    drawImage' t.x t.y t.w t.h t.x t.y t.w t.h
