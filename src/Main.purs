module Main where

import Prelude

import Data.Traversable (sequence)
import Data.Array (drop) as Array

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff (launchAff) as Aff
import Effect.Console (logShow) as Console
import Effect.Class (liftEffect) as Effect

import Process (argv) as Process

import Node.Canvas (CanvasElement)
import Node.Canvas.Aff as Canvas

import Tiles (Tile)
import Tiles as Tiles

drawTile' :: Number -> Number -> Number -> Number -> Tile -> Aff CanvasElement
drawTile' width height x y tile =
  do
    canvas <- Canvas.createCanvas width height
    context <- Canvas.getContext2D canvas
    _ <- Tiles.drawTile context x y tile
    pure canvas

main :: Effect Unit
main =
  let
    argv' = Array.drop 2 <$> Process.argv
    width = 16.0
    height = 18.0
    tiles' = Tiles.tiles width height 3 8
    logShow' = Effect.liftEffect <<< Console.logShow
    drawTile'' = drawTile' width height 0.0 0.0
  in
    void $ Aff.launchAff $ do
      sources <- Effect.liftEffect $ argv'
      images <- sequence $ Canvas.loadImage <$> sources
      tiles'' <- pure $ join $ tiles' <$> images
      canvases <- sequence $ drawTile'' <$> tiles''
      dataURLs <- sequence $ Canvas.toDataURL <$> canvases 
      logShow' dataURLs
