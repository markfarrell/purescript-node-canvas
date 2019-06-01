module Test.Examples.Transform where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/transform --}
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
      _ <- Canvas.transform context $
        { m11 : 1.0
        , m12 : 0.2
        , m21 : 0.8
        , m22 : 1.0
        , m31 : 0.0
        , m32 : 0.0
        }
      _ <- Canvas.fillRect context $
        { x : 0.0
        , y : 0.0
        , width : 100.0
        , height : 100.0 
        }
      log' =<< Canvas.toDataURL canvas
