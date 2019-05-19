module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

import Node.Canvas as Canvas

main :: Effect Unit
main =
  let
    width = 48.0
    height = 144.0
  in 
    do
      canvas <- Canvas.createCanvas 10.0 10.0
      width' <- Canvas.getCanvasWidth canvas
      height' <- Canvas.getCanvasHeight canvas
      log $ show width <> ", " <> show height
