module Test.Examples.SetShadowBlur where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/shadowBlur --}
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
      _ <- Canvas.setShadowColor context "red"
      _ <- Canvas.setShadowBlur context 15.0
      _ <- Canvas.setFillStyle context "blue"
      _ <- Canvas.fillRect context $
        { x : 20.0
        , y : 20.0
        , width : 150.0
        , height : 100.0
        }
      log' =<< Canvas.toDataURL canvas
