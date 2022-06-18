{-# LANGUAGE CPP #-}

module Options where

import qualified Data.ByteString.Char8 as C

#if !MIN_VERSION_base(4,11,0)
import           Data.Monoid              ((<>))
#endif

import           Data.NanoID
import           Options.Applicative

data Options =
  Options
    { alphabet :: String
    , length   :: Int
    , quantity :: Int
    , newline  :: Bool
    }

opts :: ParserInfo Options
opts = info (options <**> helper)
  ( fullDesc
    <> progDesc "NanoID generator"
    <> header "nanoid v3.2.0, (c) Michel Boucey 2022" )

options :: Parser Options
options =
  Options
    <$>
      strOption
        ( short 'a'
          <> long "alphabet"
          <> help "Use an alternative alphabet (ascii chars only)"
          <> value (C.unpack $ unAlphabet defaultAlphabet) )
    <*>
      option auto
        ( short 'l'
          <> long "length"
          <> help "Get a shorter NanoID (Default length is 21 chars)"
          <> value 21 )
    <*>
      option auto
        ( short 'q'
          <> long "quantity"
          <> help "Quantity of NanoID to generate"
          <> value 1 )
    <*>
      flag True False
        ( short 'n'
          <> long "newline"
          <> help "Do not output the trailing newline" )

