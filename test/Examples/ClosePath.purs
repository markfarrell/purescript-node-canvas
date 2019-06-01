module Test.Examples.ClosePath where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/closePath --}
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
      _ <- Canvas.moveTo context 20.0 140.0
      _ <- Canvas.lineTo context 120.0 10.0
      _ <- Canvas.lineTo context 220.0 140.0
      _ <- Canvas.closePath context
      _ <- Canvas.stroke context
      log' =<< Canvas.toDataURL canvas
