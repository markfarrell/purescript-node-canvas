module Test.Examples.Arc where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Math (pi) as Math

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/arc --}
main :: Effect Unit
main = 
  let
    width = 250.0
    height = 250.0
    params = 
      { x : 100.0
      , y : 75.0
      , radius : 60.0
      , start : 0.0
      , end : 2.0 * Math.pi
      }
    log' = liftEffect <<< log
  in 
    void $ launchAff $ do
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.beginPath context
      _ <- Canvas.arc context params 
      _ <- Canvas.stroke context
      log' =<< Canvas.toDataURL canvas
