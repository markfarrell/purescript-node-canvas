module Node.Canvas
  ( createCanvas
  , loadImage
  , getContext2D
  , getCanvasWidth
  , getCanvasHeight
  , toDataURL
  , drawImage
  , getImageData
  , setFillStyle
  , fillRect
  , setStrokeStyle
  , strokeRect
  , clearRect
  , setFont
  , fillText
  , strokeText
  , measureText
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
  , setPatternFillStyle
  , setLineDash
  , quadraticCurveTo
  , bezierCurveTo
  , setGlobalCompositeOperation
  , setShadowBlur
  , setShadowColor
  ) where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)

import Graphics.Canvas
  ( CanvasElement
  , Context2D
  , CanvasImageSource
  , ImageData
  , TextMetrics
  , TextAlign
  , CanvasGradient
  , CanvasPattern
  , PatternRepeat
  , Rectangle
  , Arc
  , ScaleTransform
  , TranslateTransform
  , Transform
  , LinearGradient
  , RadialGradient
  , QuadraticCurve
  , BezierCurve
  , Composite
  )
import Graphics.Canvas as Graphics.Canvas

foreign import createCanvasImpl :: Number -> Number -> Effect CanvasElement

foreign import loadImageImpl :: String -> EffectFnAff CanvasImageSource

liftEffect1 :: forall m a b. MonadEffect m => (a -> Effect b) -> a -> m b
liftEffect1 = compose liftEffect

liftEffect2 :: forall m a b c. MonadEffect m => (a -> b -> Effect c) -> a -> b -> m c
liftEffect2 = compose liftEffect1

liftEffect3 :: forall m a b c d. MonadEffect m => (a -> b -> c -> Effect d) -> a -> b -> c -> m d
liftEffect3 = compose liftEffect2

liftEffect4 :: forall m a b c d e. MonadEffect m => (a -> b -> c -> d -> Effect e) -> a -> b -> c -> d -> m e
liftEffect4 = compose liftEffect3 

liftEffect5 :: forall m a b c d e f. MonadEffect m => (a -> b -> c -> d -> e -> Effect f) -> a -> b -> c -> d -> e -> m f
liftEffect5 = compose liftEffect4 

liftEffect6 :: forall m a b c d e f g. MonadEffect m => (a -> b -> c -> d -> e -> f -> Effect g) -> a -> b -> c -> d -> e -> f -> m g
liftEffect6 = compose liftEffect5 

createCanvas :: Number -> Number -> Aff CanvasElement
createCanvas = liftEffect1 <<< createCanvasImpl

loadImage :: String -> Aff CanvasImageSource
loadImage = fromEffectFnAff <<< loadImageImpl

getContext2D :: CanvasElement -> Aff Context2D
getContext2D = liftEffect <<< Graphics.Canvas.getContext2D

getCanvasWidth :: CanvasElement -> Aff Number
getCanvasWidth = liftEffect <<< Graphics.Canvas.getCanvasWidth

getCanvasHeight :: CanvasElement -> Aff Number
getCanvasHeight = liftEffect <<< Graphics.Canvas.getCanvasHeight

toDataURL :: CanvasElement -> Aff String
toDataURL = liftEffect <<< Graphics.Canvas.canvasToDataURL

drawImage :: Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Aff Unit
drawImage = liftEffect9 <<< Graphics.Canvas.drawImageFull
  where
    liftEffect9 = compose $ compose $ compose $ liftEffect6

getImageData :: Context2D -> Number -> Number -> Number -> Number -> Aff ImageData
getImageData = liftEffect4 <<< Graphics.Canvas.getImageData

setFillStyle :: Context2D -> String -> Aff Unit
setFillStyle = liftEffect1 <<< Graphics.Canvas.setFillStyle

fillRect :: Context2D -> Rectangle -> Aff Unit 
fillRect = liftEffect1 <<< Graphics.Canvas.fillRect

setStrokeStyle :: Context2D -> String -> Aff Unit
setStrokeStyle = liftEffect1 <<< Graphics.Canvas.setStrokeStyle

strokeRect :: Context2D -> Rectangle -> Aff Unit
strokeRect = liftEffect1 <<< Graphics.Canvas.strokeRect 

clearRect :: Context2D -> Rectangle  -> Aff Unit
clearRect = liftEffect1 <<< Graphics.Canvas.clearRect 

setFont :: Context2D -> String -> Aff Unit
setFont = liftEffect1 <<< Graphics.Canvas.setFont

fillText :: Context2D -> String -> Number -> Number -> Aff Unit
fillText = liftEffect3 <<< Graphics.Canvas.fillText

strokeText :: Context2D -> String -> Number -> Number -> Aff Unit
strokeText = liftEffect3 <<< Graphics.Canvas.strokeText

measureText :: Context2D -> String -> Aff TextMetrics
measureText = liftEffect1 <<< Graphics.Canvas.measureText

save :: Context2D -> Aff Unit
save = liftEffect <<< Graphics.Canvas.save

restore :: Context2D -> Aff Unit
restore = liftEffect <<< Graphics.Canvas.restore

setTextAlign :: Context2D -> TextAlign -> Aff Unit
setTextAlign = liftEffect1 <<< Graphics.Canvas.setTextAlign

fill :: Context2D -> Aff Unit
fill = liftEffect <<< Graphics.Canvas.fill

stroke :: Context2D -> Aff Unit
stroke = liftEffect <<< Graphics.Canvas.stroke

clip :: Context2D -> Aff Unit
clip = liftEffect <<< Graphics.Canvas.clip
 
rect :: Context2D -> Rectangle -> Aff Unit
rect = liftEffect1 <<< Graphics.Canvas.rect

arc :: Context2D -> Arc -> Aff Unit
arc = liftEffect1 <<< Graphics.Canvas.arc

beginPath :: Context2D -> Aff Unit
beginPath = liftEffect <<< Graphics.Canvas.beginPath

moveTo :: Context2D -> Number -> Number -> Aff Unit
moveTo = liftEffect2 <<< Graphics.Canvas.moveTo

lineTo :: Context2D -> Number -> Number -> Aff Unit
lineTo = liftEffect2 <<< Graphics.Canvas.lineTo

closePath :: Context2D -> Aff Unit
closePath = liftEffect <<< Graphics.Canvas.closePath

rotate :: Context2D -> Number -> Aff Unit
rotate = liftEffect1 <<< Graphics.Canvas.rotate

scale :: Context2D -> ScaleTransform -> Aff Unit
scale = liftEffect1 <<< Graphics.Canvas.scale

translate :: Context2D -> TranslateTransform -> Aff Unit
translate = liftEffect1 <<< Graphics.Canvas.translate

transform :: Context2D -> Transform -> Aff Unit
transform = liftEffect1 <<< Graphics.Canvas.transform

setTransform :: Context2D -> Transform -> Aff Unit
setTransform = liftEffect1 <<< Graphics.Canvas.setTransform

createLinearGradient :: Context2D -> LinearGradient -> Aff CanvasGradient
createLinearGradient = liftEffect1 <<< Graphics.Canvas.createLinearGradient

addColorStop :: CanvasGradient -> Number -> String -> Aff Unit
addColorStop = liftEffect2 <<< Graphics.Canvas.addColorStop

setGradientFillStyle :: Context2D -> CanvasGradient -> Aff Unit
setGradientFillStyle = liftEffect1 <<< Graphics.Canvas.setGradientFillStyle

createRadialGradient :: Context2D -> RadialGradient -> Aff CanvasGradient
createRadialGradient = liftEffect1 <<< Graphics.Canvas.createRadialGradient

createPattern :: Context2D -> CanvasImageSource -> PatternRepeat -> Aff CanvasPattern
createPattern = liftEffect2 <<< Graphics.Canvas.createPattern

setPatternFillStyle :: Context2D -> CanvasPattern -> Aff Unit
setPatternFillStyle = liftEffect1 <<< Graphics.Canvas.setPatternFillStyle

setLineDash :: Context2D -> Array Number -> Aff Unit
setLineDash = liftEffect1 <<< Graphics.Canvas.setLineDash

quadraticCurveTo :: Context2D -> QuadraticCurve -> Aff Unit
quadraticCurveTo = liftEffect1 <<< Graphics.Canvas.quadraticCurveTo

bezierCurveTo :: Context2D -> BezierCurve -> Aff Unit
bezierCurveTo = liftEffect1 <<< Graphics.Canvas.bezierCurveTo

setGlobalCompositeOperation :: Context2D -> Composite -> Aff Unit
setGlobalCompositeOperation = liftEffect1 <<< Graphics.Canvas.setGlobalCompositeOperation

setShadowBlur :: Context2D -> Number -> Aff Unit
setShadowBlur = liftEffect1 <<< Graphics.Canvas.setShadowBlur

setShadowColor :: Context2D -> String -> Aff Unit
setShadowColor = liftEffect1 <<< Graphics.Canvas.setShadowColor
