module Main where

import Prelude

import Data.Array (drop) as Array
import Data.Traversable (sequence)
import Data.Tuple (curry, uncurry)

import Effect (Effect)
import Effect.Aff (Aff, launchAff)
import Effect.Class (liftEffect)
import Effect.Console (logShow)

import Process (argv) as Process

import Node.Canvas (CanvasElement, CanvasImageSource, Context2D)
import Node.Canvas as Canvas

argv' :: Aff (Array String)
argv' = liftEffect $ Array.drop 2 <$> Process.argv

createCanvas' :: Number -> Number -> Aff CanvasElement
createCanvas' = curry $ liftEffect <<< uncurry Canvas.createCanvas

createCanvas'' :: CanvasImageSource -> Aff CanvasElement
createCanvas'' image =
  let
    getImageWidth' = liftEffect <<< Canvas.getImageWidth
    getImageHeight' = liftEffect <<< Canvas.getImageHeight
    getContext2D' = liftEffect <<< Canvas.getContext2D
  in
    do
      width <- getImageWidth' image
      height <- getImageHeight' image
      canvas <- createCanvas' width height
      context <- getContext2D' canvas
      _ <- drawImage' context image width height
      pure canvas

drawImage' :: Context2D -> CanvasImageSource -> Number -> Number -> Aff Unit
drawImage' context image width height = liftEffect $ Canvas.drawImage context image 0.0 0.0 width height 0.0 0.0 width height

toDataURL' :: CanvasElement -> Aff String
toDataURL' = liftEffect <<< Canvas.toDataURL

main :: Effect Unit
main =
  let
    logShow' = liftEffect <<< logShow
  in
    void $ launchAff $ do
      sources <- argv'
      images <- sequence $ Canvas.loadImage <$> sources
      canvases <- sequence $ createCanvas'' <$> images
      urls <- sequence $ toDataURL' <$> canvases
      logShow' urls
