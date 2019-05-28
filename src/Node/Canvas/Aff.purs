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
  ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Tuple (curry, uncurry)

import Effect.Aff (Aff)
import Effect.Class (liftEffect)

import Node.Canvas
  ( CanvasElement
  , Context2D
  , CanvasImageSource
  , ImageData
  , TextMetrics
  , TextAlign
  )
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
 
setFont :: Context2D -> String -> Aff Unit
setFont ctx font = liftEffect $ Canvas.setFont ctx font

fillText :: Context2D -> String -> Number -> Number -> Aff Unit
fillText ctx text x y = liftEffect $ Canvas.fillText ctx text x y

strokeText :: Context2D -> String -> Number -> Number -> Aff Unit
strokeText ctx text x y = liftEffect $ Canvas.strokeText ctx text x y

measureText :: Context2D -> String -> Aff TextMetrics
measureText ctx text = liftEffect $ Canvas.measureText ctx text

getTextMetricsWidth :: TextMetrics -> Aff Number
getTextMetricsWidth = liftEffect <<< Canvas.getTextMetricsWidth

save :: Context2D -> Aff Unit
save = liftEffect <<< Canvas.save

restore :: Context2D -> Aff Unit
restore = liftEffect <<< Canvas.restore

setTextAlign :: Context2D -> TextAlign -> Aff Unit
setTextAlign ctx textAlign = liftEffect $ Canvas.setTextAlign ctx textAlign

fill :: Context2D -> Aff Unit
fill = liftEffect <<< Canvas.fill

stroke :: Context2D -> Aff Unit
stroke = liftEffect <<< Canvas.stroke

clip :: Context2D -> Aff Unit
clip = liftEffect <<< Canvas.clip
 
rect :: Context2D -> Number -> Number -> Number -> Number -> Aff Unit
rect ctx x y width height = liftEffect $ Canvas.rect ctx x y width height

arc :: Context2D -> Number -> Number -> Number -> Number -> Number -> Aff Unit
arc ctx x y radius startAngle endAngle = liftEffect $ Canvas.arc ctx x y radius startAngle endAngle

beginPath :: Context2D -> Aff Unit
beginPath = liftEffect <<< Canvas.beginPath

moveTo :: Context2D -> Number -> Number -> Aff Unit
moveTo ctx x y = liftEffect $ Canvas.moveTo ctx x y

lineTo :: Context2D -> Number -> Number -> Aff Unit
lineTo ctx x y = liftEffect $ Canvas.lineTo ctx x y

closePath :: Context2D -> Aff Unit
closePath = liftEffect <<< Canvas.closePath

rotate :: Context2D -> Number -> Aff Unit
rotate ctx radians = liftEffect $ Canvas.rotate ctx radians

scale :: Context2D -> Number -> Number -> Aff Unit
scale ctx x y = liftEffect $ Canvas.scale ctx x y

translate :: Context2D -> Number -> Number -> Aff Unit
translate ctx x y = liftEffect $ Canvas.translate ctx x y

transform :: Context2D -> Number -> Number -> Number -> Number -> Number -> Number -> Aff Unit
transform ctx a b c d e f = liftEffect $ Canvas.transform ctx a b c d e f
