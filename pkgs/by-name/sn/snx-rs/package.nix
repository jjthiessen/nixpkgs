{
  fetchFromGitHub,
  glib,
  # gtk3,
  gtk4,
  iproute2,
  # kdePackages,
  lib,
  # libappindicator,
  # libappindicator-gtk2,
  # libappindicator-gtk3,
  # libayatana-appindicator,
  libsoup_3,
  openssl,
  pkg-config,
  rustPlatform,
  webkitgtk_4_1,
  nix-update-script,
}:
rustPlatform.buildRustPackage rec {
  pname = "snx-rs";
  version = "4.4.1";

  src = fetchFromGitHub {
    owner = "ancwrd1";
    repo = "snx-rs";
    tag = "v${version}";
    hash = "sha256-Juv38ALXf1nMeokBH7Z+39oIscXW7S+OxdD/ZSNs49U=";
  };

  passthru.updateScript = nix-update-script { };

  nativeBuildInputs = [
    iproute2
    pkg-config
  ];

  buildInputs = [
    glib
    # gtk3
    gtk4
    # kdePackages.kstatusnotifieritem
    # libappindicator
    # libappindicator-gtk2
    # libappindicator-gtk3
    # libayatana-appindicator
    libsoup_3
    openssl
    webkitgtk_4_1
  ];

  # postPatch = ''
  #   substituteInPlace $cargoDepsCopy/libappindicator-sys-*/src/lib.rs \
  #     --replace-fail "libayatana-appindicator3.so.1" "${libayatana-appindicator}/lib/libayatana-appindicator3.so.1"
  # '';

  checkFlags = [
    "--skip=platform::linux::net::tests::test_default_ip"
    "--skip=platform::linux::tests::test_xfrm_check"
  ];

  useFetchCargoVendor = true;
  cargoHash = "sha256-NcoTdu/CQRu0RuZjlngP8lTPaomEiPTcfn2hAt+YjwA=";

  meta = {
    description = "Open source Linux client for Checkpoint VPN tunnels";
    homepage = "https://github.com/ancwrd1/snx-rs";
    license = lib.licenses.agpl3Plus;
    changelog = "https://github.com/ancwrd1/snx-rs/blob/v${version}/CHANGELOG.md";
    maintainers = with lib.maintainers; [
      shavyn
    ];
    mainProgram = "snx-rs";
  };
}
