module Test.Examples.Style where

import Prelude

import Data.Array (drop) as Array
import Data.Traversable (sequence) as Traversable

import Effect (Effect)
import Effect.Aff (launchAff) as Aff
import Effect.Console (logShow) as Console
import Effect.Class (liftEffect) as Effect

import Node.Process (argv) as Process

import Node.Canvas.Aff as Canvas

import Test.Style (fromArray) as Style

main :: Effect Unit
main =
  let
    argv' = Array.drop 2 <$> Process.argv
    logShow' = Effect.liftEffect <<< Console.logShow
    x = 0.0
    y = 0.0
    width = 1.0
    height = 1.0
    style = "red"
    indices = [0, 1, 2, 3]
  in
    void $ Aff.launchAff $ do
      sources <- Effect.liftEffect $ argv'
      canvas <- Canvas.createCanvas width height
      context <- Canvas.getContext2D canvas
      _ <- Canvas.setFillStyle context style
      _ <- Canvas.fillRect context x y width height 
      imageData <- Canvas.getImageData context x y width height
      result <- Traversable.sequence $ Canvas.getImageDataIndex imageData <$> indices
      result' <- pure $ join $ Style.fromArray <$> Traversable.sequence result
      logShow' $ result'
