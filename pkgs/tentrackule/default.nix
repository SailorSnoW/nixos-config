{
  lib,
  pkg-config,
  openssl,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  apple-sdk,
}:

let
  version = "0.1.0";
  hash = "sha256-cNqOTIseWpGA0eRr5FdX9p20dwIH3gXvue0cbCKHfo4=";
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
    rev = "1ec12ca7eb99ddc7086588c7e7e2e4e39171a0e1";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [ openssl ] ++ lib.optional stdenv.hostPlatform.isDarwin apple-sdk;

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
