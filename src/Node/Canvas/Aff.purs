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
  , getImageData
  , getImageDataBuffer
  , getImageDataWidth
  , getImageDataHeight
  , getImageDataIndex
  , setFillStyle
  , fillRect
  , setStrokeStyle
  , strokeRect
  , clearRect
  ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Tuple (curry, uncurry)

import Effect.Aff (Aff)
import Effect.Class (liftEffect)

import Node.Canvas (CanvasElement, Context2D, CanvasImageSource, ImageData)
import Node.Canvas as Canvas

import Data.ArrayBuffer.Types (Uint8ClampedArray)

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

getImageData :: Context2D -> Number -> Number -> Number -> Number -> Aff ImageData
getImageData ctx sx sy width height =
  do
    imageData <- liftEffect $ Canvas.getImageData ctx sx sy width height
    pure imageData

getImageDataBuffer :: ImageData -> Aff Uint8ClampedArray
getImageDataBuffer = liftEffect <<< Canvas.getImageDataBuffer

getImageDataWidth :: ImageData -> Aff Number
getImageDataWidth = liftEffect <<< Canvas.getImageDataWidth

getImageDataHeight :: ImageData -> Aff Number
getImageDataHeight = liftEffect <<< Canvas.getImageDataHeight

getImageDataIndex :: ImageData -> Int -> Aff (Maybe Number)
getImageDataIndex imageData index = liftEffect $ Canvas.getImageDataIndex imageData index

setFillStyle :: Context2D -> String -> Aff Unit
setFillStyle ctx style = liftEffect $ Canvas.setFillStyle ctx style

fillRect :: Context2D -> Number -> Number -> Number -> Number -> Aff Unit
fillRect ctx sx sy width height = liftEffect $ Canvas.fillRect ctx sx sy width height

setStrokeStyle :: Context2D -> String -> Aff Unit
setStrokeStyle ctx style = liftEffect $ Canvas.setStrokeStyle ctx style

strokeRect :: Context2D -> Number -> Number -> Number -> Number -> Aff Unit
strokeRect ctx sx sy width height = liftEffect $ Canvas.strokeRect ctx sx sy width height
 
clearRect :: Context2D -> Number -> Number -> Number -> Number -> Aff Unit
clearRect ctx sx sy width height = liftEffect $ Canvas.clearRect ctx sx sy width height
