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
    width = 16.0
    height = 18.0
  in
    void $ launchAff $ do
      canvas <- liftEffect $ Canvas.createCanvas width height
      image <- Canvas.loadImage "public/images/characters/skin/1.png"
      ctx <- liftEffect $ Canvas.getContext2D canvas
      _ <- liftEffect $ Canvas.drawImage ctx image 0.0 0.0 16.0 18.0 0.0 0.0 16.0 18.0
      url <- liftEffect $ Canvas.toDataURL canvas
      liftEffect $ log url
