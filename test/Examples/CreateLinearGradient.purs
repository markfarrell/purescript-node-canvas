module Test.Examples.CreateLinearGradient where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas.Aff as Canvas

{-- Mozilla Canvas API Example: https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/createLinearGradient --}
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
      gradient <- Canvas.createLinearGradient context 20.0 0.0 220.0 0.0
      _ <- Canvas.addColorStop gradient 0.0 "green"
      _ <- Canvas.addColorStop gradient 0.5 "cyan"
      _ <- Canvas.addColorStop gradient 1.0 "green"
      _ <- Canvas.setGradientFillStyle context gradient
      _ <- Canvas.fillRect context 20.0 20.0 200.0 100.0
      log' =<< Canvas.toDataURL canvas
