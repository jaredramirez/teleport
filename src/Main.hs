{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Semigroup ((<>))

{- import qualified Data.Version as Version -}
{- import qualified Paths_teleport as Teleport -}
import qualified Options.Applicative as Opt
import Options.Applicative ((<**>))

data Sample = Sample
  { hello :: String
  , quiet :: Bool
  , enthusiasm :: Int
  }

sample :: Opt.Parser Sample
sample =
  Sample <$>
  Opt.strOption
    (Opt.long "hello" <> Opt.metavar "TARGET" <>
     Opt.help "Target for the greeting") <*>
  Opt.switch
    (Opt.long "quiet" <> Opt.short 'q' <> Opt.help "Whether to be quiet") <*>
  Opt.option
    Opt.auto
    (Opt.long "enthusiasm" <> Opt.help "How enthusiastically to greet" <>
     Opt.showDefault <>
     Opt.value 1 <>
     Opt.metavar "INT")

greet :: Sample -> IO ()
greet s =
  case s of
    (Sample h False n) -> putStrLn $ "Hello " ++ h ++ replicate n '!'
    _ -> return ()

main :: IO ()
main = greet =<< Opt.execParser opts
  where
    opts =
      Opt.info
        (sample <**> Opt.helper)
        (Opt.fullDesc <> Opt.progDesc "Print a greeting for TARGET" <>
         Opt.header "hello - a test for optparse-applicative")
