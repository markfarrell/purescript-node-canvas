module Test.Examples.Clip where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Math (pi) as Math

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/clip --}
main :: Effect Unit
main = 
  let
    width = 200.0
    height = 200.0
    log' = liftEffect <<< log
  in 
    void $ launchAff $ do
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.beginPath context
      _ <- Canvas.arc context $
        { x : 100.0
        , y : 75.0
        , radius : 50.0
        , start : 0.0
        , end : 2.0 * Math.pi
        }
      _ <- Canvas.clip context
      _ <- Canvas.setFillStyle context "blue"
      width' <- Canvas.getCanvasWidth canvas
      height' <- Canvas.getCanvasHeight canvas
      _ <- Canvas.fillRect context $
        { x : 0.0
        , y : 0.0
        , width : width'
        , height : height'
        }
      _ <- Canvas.setFillStyle context "orange"
      _ <- Canvas.fillRect context $
        { x : 0.0
        , y : 0.0
        , width : 100.0
        , height : 100.0
        }
      log' =<< Canvas.toDataURL canvas
