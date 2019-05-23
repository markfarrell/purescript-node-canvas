module Test.Sources
  ( layer
  ) where

import Prelude

import Data.Traversable (sequence)
import Effect.Aff (Aff)

import Node.Canvas (CanvasElement, CanvasImageSource, Context2D)
import Node.Canvas.Aff as Canvas

drawImage' :: Context2D -> Number -> Number -> CanvasImageSource -> Aff Unit
drawImage' context width height image = Canvas.drawImage context image 0.0 0.0 width height 0.0 0.0 width height

layerOnCanvas :: Number -> Number -> Array CanvasImageSource -> Aff CanvasElement
layerOnCanvas width height images =
  do
    canvas <- Canvas.createCanvas width height
    context <- Canvas.getContext2D canvas
    _ <- sequence $ drawImage' context width height <$> images
    pure canvas

layer :: Number -> Number -> Array String -> Aff String
layer width height sources =
  do
    images <- sequence $ Canvas.loadImage <$> sources
    canvas <- layerOnCanvas width height $ images
    Canvas.toDataURL canvas
