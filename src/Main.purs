module Main where

import Prelude

import Data.Array (drop) as Array
import Data.Traversable (sequence)
import Data.Tuple (curry, uncurry)

import Effect (Effect)
import Effect.Aff (Aff, launchAff)
import Effect.Class (liftEffect)
import Effect.Console (logShow)

import Process (argv) as Process

import Node.Canvas (CanvasElement, CanvasImageSource, Context2D)
import Node.Canvas as Canvas

createCanvas' :: Number -> Number -> Aff CanvasElement
createCanvas' = curry $ liftEffect <<< uncurry Canvas.createCanvas

drawImage' :: Context2D -> Number -> Number -> CanvasImageSource -> Aff Unit
drawImage' context width height image = liftEffect $ Canvas.drawImage context image 0.0 0.0 width height 0.0 0.0 width height

layer :: Number -> Number -> Array CanvasImageSource -> Aff CanvasElement
layer width height images =
  do
    canvas <- createCanvas' width height
    context <- liftEffect $ Canvas.getContext2D canvas
    _ <- sequence $ drawImage' context width height <$> images
    pure canvas

layer' :: Number -> Number -> Array String -> Aff String
layer' width height sources =
  do
    images <- sequence $ Canvas.loadImage <$> sources
    canvas <- layer width height $ images
    liftEffect $ Canvas.toDataURL canvas

main :: Effect Unit
main =
  void $ launchAff $ do
    sources <- liftEffect $ Array.drop 2 <$> Process.argv
    dataURL <- layer' 48.0 144.0 sources
    liftEffect $ logShow dataURL
