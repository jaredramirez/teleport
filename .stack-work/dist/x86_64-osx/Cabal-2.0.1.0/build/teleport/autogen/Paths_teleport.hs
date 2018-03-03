{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_teleport (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/jaredramirez/dev/src/github.com/jaredramirez/teleport/.stack-work/install/x86_64-osx/lts-10.7/8.2.2/bin"
libdir     = "/Users/jaredramirez/dev/src/github.com/jaredramirez/teleport/.stack-work/install/x86_64-osx/lts-10.7/8.2.2/lib/x86_64-osx-ghc-8.2.2/teleport-0.1.0.0-4pwt7i0jvAcHiAgwUESSvR-teleport"
dynlibdir  = "/Users/jaredramirez/dev/src/github.com/jaredramirez/teleport/.stack-work/install/x86_64-osx/lts-10.7/8.2.2/lib/x86_64-osx-ghc-8.2.2"
datadir    = "/Users/jaredramirez/dev/src/github.com/jaredramirez/teleport/.stack-work/install/x86_64-osx/lts-10.7/8.2.2/share/x86_64-osx-ghc-8.2.2/teleport-0.1.0.0"
libexecdir = "/Users/jaredramirez/dev/src/github.com/jaredramirez/teleport/.stack-work/install/x86_64-osx/lts-10.7/8.2.2/libexec/x86_64-osx-ghc-8.2.2/teleport-0.1.0.0"
sysconfdir = "/Users/jaredramirez/dev/src/github.com/jaredramirez/teleport/.stack-work/install/x86_64-osx/lts-10.7/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "teleport_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "teleport_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "teleport_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "teleport_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "teleport_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "teleport_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
