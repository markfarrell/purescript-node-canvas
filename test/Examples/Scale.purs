module Test.Examples.Scale where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/scale --}
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
      _ <- Canvas.scale context $
        { scaleX : 9.0
        , scaleY : 3.0
        }
      _ <- Canvas.setFillStyle context "red"
      _ <- Canvas.fillRect context $
        { x : 10.0
        , y : 10.0
        , width : 8.0
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
      _ <- Canvas.setFillStyle context "gray"
      _ <- Canvas.fillRect context $
        { x : 10.0
        , y : 10.0
        , width : 8.0
        , height : 20.0
        }
      log' =<< Canvas.toDataURL canvas
