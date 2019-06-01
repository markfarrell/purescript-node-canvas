module Test.Examples.SetGlobalCompositeOperation where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Graphics.Canvas (Composite(..)) as Composite

import Node.Canvas as Canvas

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
      _ <- Canvas.setGlobalCompositeOperation context Composite.Xor
      _ <- Canvas.setFillStyle context "blue"
      _ <- Canvas.fillRect context $
        { x : 10.0
        , y : 10.0
        , width : 100.0
        , height : 100.0
        }
      _ <- Canvas.setFillStyle context "red"
      _ <- Canvas.fillRect context $ 
        { x : 50.0
        , y : 50.0
        , width : 100.0
        , height : 100.0
        }
      log' =<< Canvas.toDataURL canvas
