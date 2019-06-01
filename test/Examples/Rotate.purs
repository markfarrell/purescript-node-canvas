module Test.Examples.Rotate where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Math (pi) as Math

import Node.Canvas as Canvas

{-- Mozilla Canvas API Example: https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/rotate --}
main :: Effect Unit
main = 
  let
    width = 250.0
    height = 250.0
    log' = liftEffect <<< log
    rad = (*) $ Math.pi / 180.0
  in 
    void $ launchAff $ do
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.arc context $
        { x : 0.0
        , y : 0.0
        , radius : 5.0
        , start : 0.0
        , end : rad 360.0
        }
      _ <- Canvas.setFillStyle context "blue"
      _ <- Canvas.fill context
      _ <- Canvas.setFillStyle context "gray"
      _ <- Canvas.fillRect context $
        { x : 100.0
        , y : 0.0
        , width : 80.0
        , height : 20.0
        }
      _ <- Canvas.rotate context $ rad 45.0
      _ <- Canvas.setFillStyle context "red"
      _ <- Canvas.fillRect context $
        { x : 100.0 
        , y : 0.0
        , width : 80.0
        , height : 20.0
        }
      _ <- Canvas.setTransform context $
        { m11 : 1.0
        , m12 : 0.0
        , m21 : 0.0
        , m22 : 1.0
        , m31 : 0.0
        , m32 : 0.0
        }
      log' =<< Canvas.toDataURL canvas
