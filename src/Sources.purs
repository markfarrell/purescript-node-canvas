module Sources (layer) where

import Prelude

import Data.Traversable (sequence)
import Data.Tuple (curry, uncurry)

import Effect.Aff (Aff)
import Effect.Class (liftEffect)

import Node.Canvas (CanvasElement, CanvasImageSource, Context2D)
import Node.Canvas as Canvas

createCanvas' :: Number -> Number -> Aff CanvasElement
createCanvas' = curry $ liftEffect <<< uncurry Canvas.createCanvas

drawImage' :: Context2D -> Number -> Number -> CanvasImageSource -> Aff Unit
drawImage' context width height image = liftEffect $ Canvas.drawImage context image 0.0 0.0 width height 0.0 0.0 width height

layerOnCanvas :: Number -> Number -> Array CanvasImageSource -> Aff CanvasElement
layerOnCanvas width height images =
  do
    canvas <- createCanvas' width height
    context <- liftEffect $ Canvas.getContext2D canvas
    _ <- sequence $ drawImage' context width height <$> images
    pure canvas

layer :: Number -> Number -> Array String -> Aff String
layer width height sources =
  do
    images <- sequence $ Canvas.loadImage <$> sources
    canvas <- layerOnCanvas width height $ images
    liftEffect $ Canvas.toDataURL canvas
