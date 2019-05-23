module Test.Sources where

import Prelude
import Data.Array (drop) as Array

import Effect (Effect)
import Effect.Aff (launchAff) as Aff
import Effect.Console (logShow) as Console
import Effect.Class (liftEffect) as Effect

import Node.Process (argv) as Process
import Sources (layer) as Sources

main :: Effect Unit
main =
  let
    argv' = Array.drop 2 <$> Process.argv
    width = 48.0
    height = 144.0
  in
    void $ Aff.launchAff $ do
      sources <- Effect.liftEffect $ argv'
      dataURL <- Sources.layer width height sources
      Effect.liftEffect $ Console.logShow dataURL
