module Data.NanoID where

import           Control.Monad
import qualified Data.ByteString.Char8 as C
import           Data.Maybe
import           Numeric.Natural
import           System.Random.MWC

newtype NanoID = NanoID { unNanoID :: C.ByteString } deriving (Eq, Show)

newtype Alphabet = Alphabet { unAlphabet :: C.ByteString } deriving (Eq, Show)

type Length = Natural

-- | Standard 'NanoID' generator function
-- >λ: g <- createSystemRandom
-- >λ: NanoID g
-- >NanoID {unNanoID = "x2f8yFadImeVp14ByJ8R3"}
--
nanoID :: GenIO -> IO NanoID
nanoID = customNanoID defaultAlphabet 21

-- | Customable 'NanoID' generator function
customNanoID :: Alphabet  -- ^ An 'Alphabet' of your choice
             -> Length    -- ^ A 'NanoID' length (the standard length is 21 chars)
             -> GenIO     -- ^ The pseudo-random number generator state
             -> IO NanoID
customNanoID a l g =
  NanoID . C.pack <$> replicateM (fromEnum l) ((\r -> C.index ua (r-1)) <$> uniformR (1,al) g)
  where
    ua = unAlphabet a
    al = C.length ua

-- | The default 'Alphabet', made of URL-friendly symbols.
defaultAlphabet :: Alphabet
defaultAlphabet = Alphabet (C.pack "ABCDEFGHIJKLMNOPKRSTUVWXYZ_1234567890-abcdefghijklmnopqrstuvwxyz")

-- * Predefined Alphabets borrowed from https://github.com/CyberAP/nanoid-dictionary

numbers :: Alphabet
numbers = Alphabet (C.pack "1234567890")

hexadecimalLowercase :: Alphabet
hexadecimalLowercase = Alphabet (C.pack "0123456789abcdef")

hexadecimalUppercase :: Alphabet
hexadecimalUppercase = Alphabet (C.pack "0123456789ABCDEF")

lowercase :: Alphabet
lowercase = Alphabet (C.pack "abcdefghijklmnopqrstuvwxyz")

uppercase :: Alphabet
uppercase = Alphabet (C.pack "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

alphanumeric :: Alphabet
alphanumeric = Alphabet (C.pack "ABCDEFGHIJKLMNOPKRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz")

nolookalikes :: Alphabet
nolookalikes = Alphabet (C.pack "346789ABCDEFGHJKLMNPQRTUVWXYabcdefghijkmnpqrtwxyz")

nolookalikesSafe :: Alphabet
nolookalikesSafe = Alphabet (C.pack "6789ABCDEFGHJKLMNPQRTUWYabcdefghijkmnpqrtwyz")

