module Node.Canvas.Aff
  ( createCanvas
  , getContext2D
  , getCanvasWidth
  , getCanvasHeight
  , toDataURL
  , drawImage
  , loadImage
  , getImageWidth
  , getImageHeight
  ) where

import Prelude

import Data.Tuple (curry, uncurry)

import Effect.Aff (Aff)
import Effect.Class (liftEffect)

import Node.Canvas (CanvasElement, Context2D, CanvasImageSource)
import Node.Canvas as Canvas

createCanvas :: Number -> Number -> Aff CanvasElement
createCanvas = curry $ liftEffect <<< uncurry Canvas.createCanvas

getContext2D :: CanvasElement -> Aff Context2D
getContext2D = liftEffect <<< Canvas.getContext2D

getCanvasWidth :: CanvasElement -> Aff Number
getCanvasWidth = liftEffect <<< Canvas.getCanvasWidth

getCanvasHeight :: CanvasElement -> Aff Number
getCanvasHeight = liftEffect <<< Canvas.getCanvasHeight

toDataURL :: CanvasElement -> Aff String
toDataURL = liftEffect <<< Canvas.toDataURL

loadImage :: String -> Aff CanvasImageSource
loadImage = Canvas.loadImage

drawImage :: Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Aff Unit
drawImage ctx img sx sy sw sh dx dy dw dh =
  do
    _ <- liftEffect $ Canvas.drawImage ctx img sx sy sw sh dx dy dw dh
    pure unit

getImageWidth :: CanvasImageSource -> Aff Number
getImageWidth = liftEffect <<< Canvas.getImageWidth

getImageHeight :: CanvasImageSource -> Aff Number
getImageHeight = liftEffect <<< Canvas.getImageHeight
