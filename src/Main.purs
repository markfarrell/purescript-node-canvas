module Main where

import Prelude
import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)

import Node.Canvas as Canvas

main :: Effect Unit
main = 
  let
    width = 48.0
    height = 144.0
  in
    void $ launchAff $ do
      canvas <- liftEffect $ Canvas.createCanvas width height
      image <- Canvas.loadImage "public/images/characters/skin/1.png"
      ctx <- liftEffect $ Canvas.getContext2D canvas
      _ <- liftEffect $ Canvas.drawImage ctx image 0.0 0.0 width height 0.0 0.0 width height
      url <- liftEffect $ Canvas.toDataURL canvas
      liftEffect $ log url
