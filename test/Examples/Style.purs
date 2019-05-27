module Test.Examples.Style where

import Prelude

import Data.Maybe (Maybe)
import Data.Array (drop) as Array
import Data.Traversable (sequence) as Traversable

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff (launchAff) as Aff
import Effect.Console (logShow) as Console
import Effect.Class (liftEffect) as Effect

import Node.Process (argv) as Process

import Node.Canvas.Aff as Canvas

import Test.Style (Style)
import Test.Style (fromArray) as Style

sampleStyle :: String -> Aff (Maybe Style)
sampleStyle style =
  let
    x = 0.0
    y = 0.0
    width = 1.0
    height = 1.0
    indices = [0, 1, 2, 3]
  in
    do
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.setStrokeStyle context style
      _ <- Canvas.strokeRect context x y width height
      _ <- Canvas.clearRect context x y width height
      _ <- Canvas.setFillStyle context style
      _ <- Canvas.fillRect context x y width height 
      imageData <- Canvas.getImageData context x y width height
      result <- Traversable.sequence $ Canvas.getImageDataIndex imageData <$> indices
      pure $ join $ Style.fromArray <$> Traversable.sequence result

main :: Effect Unit
main =
  let
    argv' = Effect.liftEffect $ Array.drop 2 <$> Process.argv
    logShow' = Effect.liftEffect <<< Console.logShow 
  in
    void $ Aff.launchAff $ do
      styles <- argv'
      result <- Traversable.sequence $ sampleStyle <$> styles
      logShow' $ Traversable.sequence result 
