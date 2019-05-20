module Main where

import Prelude

import Data.Array (drop) as Array
import Data.Traversable (sequence)

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (logShow)

import Process (argv) as Process

import Node.Canvas (CanvasImageSource)
import Node.Canvas as Canvas

args :: Effect (Array String)
args = Array.drop 2 <$> Process.argv

getDimensions :: CanvasImageSource -> Effect { width :: Number, height :: Number }
getDimensions image = 
  do
    width' <- Canvas.getImageWidth image
    height' <- Canvas.getImageHeight image 
    pure { width : width',  height : height' }

main :: Effect Unit
main =
  let
    args' = liftEffect $ args
    getDimensions' = liftEffect <<< getDimensions
    logShow' = liftEffect <<< logShow
  in
    void $ launchAff $ do
      sources <- args'
      images <- sequence $ Canvas.loadImage <$> sources
      dimensions <- sequence $ getDimensions' <$> images
      logShow' dimensions
