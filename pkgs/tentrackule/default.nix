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
  hash = "sha256-FVx5al5XTyC2z7p7gZfmy1Nbd0ZxZmSrwuoWbx6pIoY=";
  cargoHash = "sha256-J5IqxB6SYt2VsbxmF2iFsqGG44yFlKpfRG08cqyBP3g=";
in

rustPlatform.buildRustPackage {
  inherit cargoHash version;

  useFetchCargoVendor = true;

  pname = "tentrackule";

  src = fetchFromGitHub {
    inherit hash;
    owner = "SailorSnoW";
    repo = "tentrackule";
    rev = "4832b157124313331dde7316a7ebbe955524768c";
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
