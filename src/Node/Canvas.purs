module Node.Canvas
  ( CanvasElement
  , Context2D
  , CanvasImageSource
  , ImageData
  , TextMetrics
  , TextAlign
  , createCanvas
  , getContext2D
  , loadImage
  , getCanvasWidth
  , getCanvasHeight
  , toDataURL
  , drawImage
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
  ) where

import Prelude

import Control.Monad.Error.Class (try)

import Data.ArrayBuffer.Types (Uint8ClampedArray)
import Data.Maybe (Maybe(..))
import Data.Either (Either(..))

import Effect (Effect)
import Effect.Aff(Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)

foreign import data CanvasElement :: Type

foreign import data Context2D :: Type

foreign import data CanvasImageSource :: Type

foreign import data ImageData :: Type

foreign import data TextMetrics :: Type

data TextAlign
  = AlignLeft
  | AlignRight
  | AlignCenter
  | AlignStart
  | AlignEnd
                           
foreign import createCanvas :: Number -> Number -> Effect CanvasElement

foreign import getContext2D :: CanvasElement -> Effect Context2D

foreign import loadImageImpl :: String -> EffectFnAff CanvasImageSource

foreign import getCanvasWidth :: CanvasElement -> Effect Number

foreign import getCanvasHeight :: CanvasElement -> Effect Number

{-- Note: PureScript Strings are UTF-16 strings. --}
foreign import toDataURL :: CanvasElement -> Effect String

foreign import drawImage :: Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Effect Unit

foreign import getImageWidth :: CanvasImageSource -> Effect Number

foreign import getImageHeight :: CanvasImageSource -> Effect Number

foreign import getImageData :: Context2D -> Number -> Number -> Number -> Number -> Effect ImageData

foreign import getImageDataBuffer :: ImageData -> Effect Uint8ClampedArray

foreign import getImageDataWidth :: ImageData -> Effect Number

foreign import getImageDataHeight :: ImageData -> Effect Number

foreign import getImageDataIndexImpl :: ImageData -> Int -> Effect Number

foreign import setFillStyle :: Context2D -> String -> Effect Unit

foreign import fillRect :: Context2D -> Number -> Number -> Number -> Number -> Effect Unit

foreign import setStrokeStyle :: Context2D -> String -> Effect Unit

foreign import strokeRect :: Context2D -> Number -> Number -> Number -> Number -> Effect Unit

foreign import clearRect :: Context2D -> Number -> Number -> Number -> Number -> Effect Unit

foreign import setFont :: Context2D -> String -> Effect Unit

foreign import fillText :: Context2D -> String -> Number -> Number -> Effect Unit

foreign import strokeText :: Context2D -> String -> Number -> Number -> Effect Unit

foreign import measureText :: Context2D -> String -> Effect TextMetrics

foreign import getTextMetricsWidth :: TextMetrics -> Effect Number

foreign import save :: Context2D -> Effect Unit

foreign import restore :: Context2D -> Effect Unit

foreign import setTextAlignImpl :: Context2D -> String -> Effect Unit

foreign import fill :: Context2D -> Effect Unit

foreign import stroke :: Context2D -> Effect Unit

foreign import clip :: Context2D -> Effect Unit

foreign import rect :: Context2D -> Number -> Number -> Number -> Number -> Effect Unit

foreign import arc :: Context2D -> Number -> Number -> Number -> Number -> Number -> Effect Unit

foreign import beginPath :: Context2D -> Effect Unit

loadImage :: String -> Aff CanvasImageSource
loadImage = fromEffectFnAff <<< loadImageImpl

getImageDataIndex :: ImageData -> Int -> Effect (Maybe Number)
getImageDataIndex imageData index = 
  do
    result <- try $ getImageDataIndexImpl imageData index
    case result of
      Left _ -> pure $ Nothing
      Right value -> pure $ Just value

setTextAlign :: Context2D -> TextAlign -> Effect Unit
setTextAlign ctx AlignLeft = setTextAlignImpl ctx "left" 
setTextAlign ctx AlignRight = setTextAlignImpl ctx "right"
setTextAlign ctx AlignCenter = setTextAlignImpl ctx "center"
setTextAlign ctx AlignStart = setTextAlignImpl ctx "start"
setTextAlign ctx AlignEnd = setTextAlignImpl ctx "end"
