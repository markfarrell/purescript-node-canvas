module Main where

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
  void $ Aff.launchAff $ do
    sources <- Effect.liftEffect $ Array.drop 2 <$> Process.argv
    dataURL <- Sources.layer 48.0 144.0 sources
    Effect.liftEffect $ Console.logShow dataURL
