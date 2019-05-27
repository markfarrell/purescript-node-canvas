module Node.Canvas
  ( CanvasElement
  , Context2D
  , CanvasImageSource
  , ImageData
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

foreign import createCanvas :: Number -> Number -> Effect CanvasElement

foreign import getContext2D :: CanvasElement -> Effect Context2D

foreign import _loadImage :: String -> EffectFnAff CanvasImageSource

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

foreign import _getImageDataIndex :: ImageData -> Int -> Effect Number

foreign import setFillStyle :: Context2D -> String -> Effect Unit

foreign import fillRect :: Context2D -> Number -> Number -> Number -> Number -> Effect Unit

instance showCanvasImageSource :: Show CanvasImageSource where
  show _ = "CanvasImageSource"

loadImage :: String -> Aff CanvasImageSource
loadImage = fromEffectFnAff <<< _loadImage

getImageDataIndex :: ImageData -> Int -> Effect (Maybe Number)
getImageDataIndex imageData index = 
  do
    result <- try $ _getImageDataIndex imageData index
    case result of
      Left _ -> pure $ Nothing
      Right value -> pure $ Just value
