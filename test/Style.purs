module Test.Styles
  ( Style(..)
  , fromArray
  ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Array (index) as Array

data Style = Style Number Number Number Number

instance showStyle :: Show Style where
  show (Style r g b a) =
    let
      r' = show r
      g' = show g
      b' = show b
      a' = show a 
    in
      "(Style rgba(" <> r' <> ", " <> g' <> ", " <> b' <> ", " <> a' <> "))" 

fromArray :: Array Number -> Maybe Style
fromArray array =
  let
    index' = Array.index array
  in
    do
      r <- index' 0
      g <- index' 1
      b <- index' 2
      a <- index' 3
      pure $ Style r g b a
