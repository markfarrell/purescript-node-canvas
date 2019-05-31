module Test.Examples.CreatePattern where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas.Aff as Canvas
import Node.Canvas (PatternRepeat(..)) as PatternRepeat

{-- Mozilla Canvas API Example: https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/createPattern --}
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
      image <- Canvas.loadImage "https://mdn.mozillademos.org/files/222/Canvas_createpattern.png"
      pattern <- Canvas.createPattern context image PatternRepeat.Repeat
      _ <- Canvas.setPatternFillStyle context pattern
      _ <- Canvas.fillRect context 0.0 0.0 width height
      log' =<< Canvas.toDataURL canvas
