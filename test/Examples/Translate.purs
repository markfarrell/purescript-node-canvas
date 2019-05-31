module Test.Examples.Translate where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas.Aff as Canvas

{-- Mozilla Canvas API Example: https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/translate --}
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
      _ <- Canvas.translate context 110.0 30.0
      _ <- Canvas.setFillStyle context "red"
      _ <- Canvas.fillRect context 0.0 0.0 80.0 80.0
      _ <- Canvas.setTransform context 1.0 0.0 0.0 1.0 0.0 0.0
      _ <- Canvas.setFillStyle context "gray"
      _ <- Canvas.fillRect context 0.0 0.0 80.0 80.0
      log' =<< Canvas.toDataURL canvas
