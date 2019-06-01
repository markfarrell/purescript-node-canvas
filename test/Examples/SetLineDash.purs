module Test.Examples.SetLineDash where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/setLineDash --}
main :: Effect Unit
main = 
  let
    width = 300.0
    height = 300.0
    log' = liftEffect <<< log
  in 
    void $ launchAff $ do
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.beginPath context
      _ <- Canvas.setLineDash context [5.0, 15.0]
      _ <- Canvas.moveTo context 0.0 50.0
      _ <- Canvas.lineTo context 300.0 50.0
      _ <- Canvas.stroke context
      _ <- Canvas.beginPath context
      _ <- Canvas.setLineDash context []
      _ <- Canvas.moveTo context 0.0 100.0
      _ <- Canvas.lineTo context 300.0 100.0
      _ <- Canvas.stroke context
      log' =<< Canvas.toDataURL canvas
