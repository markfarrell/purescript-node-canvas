module Test.Sources where

import Prelude
import Data.Array (drop) as Array

import Effect (Effect)
import Effect.Aff (launchAff) as Aff
import Effect.Console (logShow) as Console
import Effect.Class (liftEffect) as Effect

import Process (argv) as Process
import Sources (layer) as Sources

main :: Effect Unit
main =
  let
    width = 48.0
    height = 144.0
  in
    void $ Aff.launchAff $ do
      sources <- Effect.liftEffect $ Array.drop 2 <$> Process.argv
      dataURL <- Sources.layer width height sources
      Effect.liftEffect $ Console.logShow dataURL
