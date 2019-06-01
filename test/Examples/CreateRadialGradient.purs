module Test.Examples.CreateRadialGradient where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/createRadialGradient --}
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
      gradient <- Canvas.createRadialGradient context $
        { x0 : 110.0
        , y0 : 90.0
        , r0 : 30.0
        , x1 : 100.0
        , y1 : 100.0
        , r1 :  70.0
        }
      _ <- Canvas.addColorStop gradient 0.0 "pink"
      _ <- Canvas.addColorStop gradient 0.9 "white"
      _ <- Canvas.addColorStop gradient 1.0 "green"
      _ <- Canvas.setGradientFillStyle context gradient
      _ <- Canvas.fillRect context $
        { x : 20.0
        , y : 20.0
        , width : 160.0
        , height : 160.0
        }
      log' =<< Canvas.toDataURL canvas
