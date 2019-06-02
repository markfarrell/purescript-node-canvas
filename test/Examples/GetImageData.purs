module Test.Examples.GetImageData where

import Prelude

import Data.Traversable (sequence)

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (logShow)

import Node.Canvas as Canvas

{-- https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Tutorial/Pixel_manipulation_with_canvas --}
main :: Effect Unit
main = 
  let
    x = 0.0
    y = 0.0
    logShow' = liftEffect <<< logShow
  in 
    {-- Sample Pixel RGBA at (x,y) --}
    void $ launchAff $ do
      image <- Canvas.loadImage "https://mdn.mozillademos.org/files/5397/rhino.jpg"
      width <- pure $ Canvas.imageWidth image
      height <- pure $ Canvas.imageHeight image
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.drawImage context image 0.0 0.0 width height 0.0 0.0 width height
      pixel <- Canvas.getImageData context x y 1.0 1.0
      result <- sequence $ Canvas.imageDataIndex pixel <$> [0, 1, 2, 3]
      logShow' $ sequence result 
