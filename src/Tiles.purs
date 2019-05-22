module Tiles (positions) where

import Prelude

import Data.Tuple (Tuple(..))
import Data.Array (range) as Array
import Data.Int (toNumber) as Int

positions :: Number -> Number -> Int -> Int -> Array (Tuple Number Number)
positions width height repeatX repeatY = 
  let
    xs = (*) width <$> Int.toNumber <$> flip (-) 1 <$> Array.range 1 repeatX
    ys = (*) height <$> Int.toNumber <$> flip (-) 1 <$>  Array.range 1 repeatY
  in
    Tuple <$> xs <*> ys
