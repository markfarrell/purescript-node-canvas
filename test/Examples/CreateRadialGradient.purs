module Test.Examples.CreateRadialGradient where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas.Aff as Canvas

{-- Mozilla Canvas API Example: https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/createRadialGradient --}
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
      gradient <- Canvas.createRadialGradient context 110.0 90.0 30.0 100.0 100.0 70.0
      _ <- Canvas.addColorStop gradient 0.0 "pink"
      _ <- Canvas.addColorStop gradient 0.9 "white"
      _ <- Canvas.addColorStop gradient 1.0 "green"
      _ <- Canvas.setGradientFillStyle context gradient
      _ <- Canvas.fillRect context 20.0 20.0 160.0 160.0
      log' =<< Canvas.toDataURL canvas
