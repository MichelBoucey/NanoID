{ mkDerivation, aeson, base, bytestring, cereal, extra, lib
, mwc-random, optparse-applicative, text
}:
mkDerivation {
  pname = "NanoID";
  version = "3.4.0.1";
  sha256 = "43785ef712a39c1b03e66b332d405083f95034a082494de871d0099d798c62bc";
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base bytestring cereal extra mwc-random text
  ];
  executableHaskellDepends = [
    base bytestring mwc-random optparse-applicative
  ];
  description = "NanoID generator";
  license = lib.licenses.bsd3;
  mainProgram = "nanoid";
}
