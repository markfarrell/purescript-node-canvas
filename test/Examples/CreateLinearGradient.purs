module Test.Examples.CreateLinearGradient where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/createLinearGradient --}
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
      gradient <- Canvas.createLinearGradient context $
        { x0 : 20.0
        , y0 : 0.0
        , x1 : 220.0
        , y1 : 0.0
        }
      _ <- Canvas.addColorStop gradient 0.0 "green"
      _ <- Canvas.addColorStop gradient 0.5 "cyan"
      _ <- Canvas.addColorStop gradient 1.0 "green"
      _ <- Canvas.setGradientFillStyle context gradient
      _ <- Canvas.fillRect context $ 
        { x : 20.0
        , y : 20.0
        , width : 200.0
        , height : 100.0
        }
      log' =<< Canvas.toDataURL canvas
