module Test.Examples.Arc where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Math (pi) as Math

import Node.Canvas.Aff as Canvas

{-- Mozilla Canvas API Example: https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/arc --}
main :: Effect Unit
main = 
  let
    width = 250.0
    height = 250.0
    log' = liftEffect <<< log
  in 
    void $ launchAff $ do
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.beginPath context
      _ <- Canvas.arc context 100.0 75.0 60.0 0.0 $ 2.0 * Math.pi
      _ <- Canvas.stroke context
      log' =<< Canvas.toDataURL canvas
