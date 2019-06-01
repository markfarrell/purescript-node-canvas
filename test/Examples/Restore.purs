module Test.Examples.Restore where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/restore --}
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
      _ <- Canvas.save context
      _ <- Canvas.setFillStyle context "green"
      _ <- Canvas.fillRect context $
        { x : 10.0
        , y : 10.0
        , width : 100.0
        , height : 100.0
        }
      _ <- Canvas.restore context
      _ <- Canvas.fillRect context $
        { x : 150.0
        , y : 40.0
        , width : 100.0
        , height : 100.0
        }
      log' =<< Canvas.toDataURL canvas
