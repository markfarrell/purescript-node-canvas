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
  , setFont
  , fillText
  , strokeText
  , measureText
  , getTextMetricsWidth
  , save
  , restore
  , setTextAlign
  , fill
  , stroke
  , clip
  , rect
  , arc
  , beginPath
  , moveTo
  , lineTo
  , closePath
  , rotate
  , scale
  , translate
  , transform
  , setTransform
  , createLinearGradient
  , addColorStop
  , setGradientFillStyle
  , createRadialGradient
  , createPattern
  ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Tuple (curry, uncurry)

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (class MonadEffect, liftEffect)

import Node.Canvas
  ( CanvasElement
  , Context2D
  , CanvasImageSource
  , ImageData
  , TextMetrics
  , TextAlign
  , CanvasGradient
  , CanvasPattern
  , PatternRepeat
  )
import Node.Canvas as Canvas

import Data.ArrayBuffer.Types (Uint8ClampedArray) 

liftEffect1 :: forall m a b. MonadEffect m => (a -> Effect b) -> a -> m b
liftEffect1 = compose liftEffect

liftEffect2 :: forall m a b c. MonadEffect m => (a -> b -> Effect c) -> a -> b -> m c
liftEffect2 = compose $ compose liftEffect

liftEffect3 :: forall m a b c d. MonadEffect m => (a -> b -> c -> Effect d) -> a -> b -> c -> m d
liftEffect3 = compose $ compose $ compose liftEffect

liftEffect4 :: forall m a b c d e. MonadEffect m => (a -> b -> c -> d -> Effect e) -> a -> b -> c -> d -> m e
liftEffect4 = compose $ compose $ compose $ compose liftEffect

liftEffect5 :: forall m a b c d e f. MonadEffect m => (a -> b -> c -> d -> e -> Effect f) -> a -> b -> c -> d -> e -> m f
liftEffect5 = compose $ compose $ compose $ compose $ compose liftEffect

liftEffect6 :: forall m a b c d e f g. MonadEffect m => (a -> b -> c -> d -> e -> f -> Effect g) -> a -> b -> c -> d -> e -> f -> m g
liftEffect6 = compose $ compose $ compose $ compose $ compose $ compose liftEffect

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
drawImage = liftEffect9 <<< Canvas.drawImage
  where
    liftEffect9 = compose $ compose $ compose $ liftEffect6

getImageWidth :: CanvasImageSource -> Aff Number
getImageWidth = liftEffect <<< Canvas.getImageWidth

getImageHeight :: CanvasImageSource -> Aff Number
getImageHeight = liftEffect <<< Canvas.getImageHeight

getImageData :: Context2D -> Number -> Number -> Number -> Number -> Aff ImageData
getImageData = liftEffect4 <<< Canvas.getImageData

getImageDataBuffer :: ImageData -> Aff Uint8ClampedArray
getImageDataBuffer = liftEffect <<< Canvas.getImageDataBuffer

getImageDataWidth :: ImageData -> Aff Number
getImageDataWidth = liftEffect <<< Canvas.getImageDataWidth

getImageDataHeight :: ImageData -> Aff Number
getImageDataHeight = liftEffect <<< Canvas.getImageDataHeight

getImageDataIndex :: ImageData -> Int -> Aff (Maybe Number)
getImageDataIndex = liftEffect1 <<< Canvas.getImageDataIndex

setFillStyle :: Context2D -> String -> Aff Unit
setFillStyle = liftEffect1 <<< Canvas.setFillStyle

fillRect :: Context2D -> Number -> Number -> Number -> Number -> Aff Unit
fillRect =liftEffect4 <<< Canvas.fillRect

setStrokeStyle :: Context2D -> String -> Aff Unit
setStrokeStyle = liftEffect1 <<< Canvas.setStrokeStyle

strokeRect :: Context2D -> Number -> Number -> Number -> Number -> Aff Unit
strokeRect = liftEffect4 <<< Canvas.strokeRect
 
clearRect :: Context2D -> Number -> Number -> Number -> Number -> Aff Unit
clearRect = liftEffect4 <<< Canvas.clearRect
 
setFont :: Context2D -> String -> Aff Unit
setFont = liftEffect1 <<< Canvas.setFont

fillText :: Context2D -> String -> Number -> Number -> Aff Unit
fillText = liftEffect3 <<< Canvas.fillText

strokeText :: Context2D -> String -> Number -> Number -> Aff Unit
strokeText = liftEffect3 <<< Canvas.strokeText

measureText :: Context2D -> String -> Aff TextMetrics
measureText = liftEffect1 <<< Canvas.measureText

getTextMetricsWidth :: TextMetrics -> Aff Number
getTextMetricsWidth = liftEffect <<< Canvas.getTextMetricsWidth

save :: Context2D -> Aff Unit
save = liftEffect <<< Canvas.save

restore :: Context2D -> Aff Unit
restore = liftEffect <<< Canvas.restore

setTextAlign :: Context2D -> TextAlign -> Aff Unit
setTextAlign = liftEffect1 <<< Canvas.setTextAlign

fill :: Context2D -> Aff Unit
fill = liftEffect <<< Canvas.fill

stroke :: Context2D -> Aff Unit
stroke = liftEffect <<< Canvas.stroke

clip :: Context2D -> Aff Unit
clip = liftEffect <<< Canvas.clip
 
rect :: Context2D -> Number -> Number -> Number -> Number -> Aff Unit
rect = liftEffect4 <<< Canvas.rect

arc :: Context2D -> Number -> Number -> Number -> Number -> Number -> Aff Unit
arc = liftEffect5 <<< Canvas.arc

beginPath :: Context2D -> Aff Unit
beginPath = liftEffect <<< Canvas.beginPath

moveTo :: Context2D -> Number -> Number -> Aff Unit
moveTo = liftEffect2 <<< Canvas.moveTo

lineTo :: Context2D -> Number -> Number -> Aff Unit
lineTo = liftEffect2 <<< Canvas.lineTo

closePath :: Context2D -> Aff Unit
closePath = liftEffect <<< Canvas.closePath

rotate :: Context2D -> Number -> Aff Unit
rotate = liftEffect1 <<< Canvas.rotate

scale :: Context2D -> Number -> Number -> Aff Unit
scale = liftEffect2 <<< Canvas.scale

translate :: Context2D -> Number -> Number -> Aff Unit
translate = liftEffect2 <<< Canvas.translate

transform :: Context2D -> Number -> Number -> Number -> Number -> Number -> Number -> Aff Unit
transform = liftEffect6 <<< Canvas.transform

setTransform :: Context2D -> Number -> Number -> Number -> Number -> Number -> Number -> Aff Unit
setTransform = liftEffect6 <<< Canvas.setTransform

createLinearGradient :: Context2D -> Number -> Number -> Number -> Number -> Aff CanvasGradient
createLinearGradient = liftEffect4 <<< Canvas.createLinearGradient

addColorStop :: CanvasGradient -> Number -> String -> Aff Unit
addColorStop = liftEffect2 <<< Canvas.addColorStop

setGradientFillStyle :: Context2D -> CanvasGradient -> Aff Unit
setGradientFillStyle = liftEffect1 <<< Canvas.setGradientFillStyle

createRadialGradient :: Context2D -> Number -> Number -> Number -> Number -> Number -> Number -> Aff CanvasGradient
createRadialGradient = liftEffect6 <<< Canvas.createRadialGradient

createPattern :: Context2D -> CanvasImageSource -> PatternRepeat -> Aff CanvasPattern
createPattern = liftEffect2 <<< Canvas.createPattern
