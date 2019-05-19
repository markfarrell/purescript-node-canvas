module Node.Canvas
  ( CanvasElement
  , Context2D
  , CanvasImageSource
  , createCanvas
  , getContext2D
  , loadImage
  , getCanvasWidth
  , getCanvasHeight
  , toDataURL
  ) where

import Prelude

import Effect (Effect)
import Effect.Aff(Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)

foreign import data CanvasElement :: Type

foreign import data Context2D :: Type

foreign import data CanvasImageSource :: Type

foreign import createCanvas :: Number -> Number -> Effect CanvasElement

foreign import getContext2D :: CanvasElement -> Effect Context2D

foreign import _loadImage :: String -> EffectFnAff CanvasImageSource

foreign import getCanvasWidth :: CanvasElement -> Effect Number

foreign import getCanvasHeight :: CanvasElement -> Effect Number

{-- Note: PureScript Strings are indeed UTF-16 strings. --}
foreign import toDataURL :: CanvasElement -> Effect String

loadImage :: String -> Aff CanvasImageSource
loadImage = fromEffectFnAff <<< _loadImage
