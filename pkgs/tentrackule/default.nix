{
  lib,
  pkg-config,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  apple-sdk,
}:

let
  version = "0.1.0";
  hash = "sha256-EkW6nvTIXz63XSo2vR5zxzOixTFm+nBNzoF4lRIF4R8=";
  cargoHash = "sha256-iKylrk+SllZNVoIuCHFRBE9VVGG48VPPPug+mGU4xIU=";
in

rustPlatform.buildRustPackage {
  inherit cargoHash version;

  useFetchCargoVendor = true;

  pname = "tentrackule";

  src = fetchFromGitHub {
    inherit hash;
    owner = "SailorSnoW";
    repo = "tentrackule";
    rev = "aae5f7134f156b0f186b8d97f8eb3584b99a6f88";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [ ] ++ lib.optional stdenv.hostPlatform.isDarwin apple-sdk;

  # Tests rely on API requests with an API Key set.
  doCheck = false;

  postInstall = '''';

  meta = {
    description = "Discord Bot to alert on new game results for LoL/TFT.";
    mainProgram = "tentrackule";
    homepage = "https://github.com/SailorSnoW/tentrackule";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      sailorsnow
    ];
  };
}
