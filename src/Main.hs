{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Semigroup ((<>))
import qualified Data.Version as Version
import qualified Options.Applicative as OptApplicative
import Options.Applicative ((<**>))
import qualified Paths_teleport as Teleport

-- COMMANDS
data Command
  = Add String
  | Warp String
  | Remove String

warpPointArg :: OptApplicative.Parser String
warpPointArg =
  OptApplicative.strArgument
    (OptApplicative.idm <> OptApplicative.metavar "WARP_POINT")

createCommand ::
     String
  -> OptApplicative.Parser cmd
  -> String
  -> OptApplicative.Mod OptApplicative.CommandFields cmd
createCommand commandName commandArgParser commandDescription =
  OptApplicative.command
    commandName
    (OptApplicative.info
       commandArgParser
       (OptApplicative.progDesc commandDescription))

commandOption :: OptApplicative.Parser Command
commandOption =
  OptApplicative.subparser $
  createCommand
    "add"
    (fmap Add warpPointArg)
    "Add a warp point to the current directory" <>
  createCommand
    "warp"
    (fmap Warp warpPointArg)
    "Warp to the specified warp point" <>
  createCommand
    "rm"
    (fmap Remove warpPointArg)
    "Remove the specified warp point"

-- OPTIONS
data Options = Options
  { command :: Command
  , version :: Bool
  }

versionSwitch :: OptApplicative.Parser Bool
versionSwitch =
  OptApplicative.switch $
  OptApplicative.long "version" <> OptApplicative.short 'v' <>
  OptApplicative.help "Version of Teleport"

options :: OptApplicative.Parser Options
options = Options <$> commandOption <*> versionSwitch

info :: OptApplicative.ParserInfo Options
info =
  OptApplicative.info
    (options <**> OptApplicative.helper)
    (OptApplicative.fullDesc <>
     OptApplicative.progDesc
       "Save & teleport to differnt locations on your filesystem" <>
     OptApplicative.header "Teleport CLI tool")

-- MAIN ROUTINE
mainRoutine :: Options -> IO ()
mainRoutine a =
  case a of
    (Options _ True) -> putStrLn $ Version.showVersion Teleport.version
    (Options cmd False) ->
      case cmd of
        Add name -> putStrLn $ "adding current directory " ++ name
        Warp _ -> putStrLn "warping"
        Remove _ -> putStrLn "remove"

-- RUNNER
main :: IO ()
main = mainRoutine =<< OptApplicative.execParser info
