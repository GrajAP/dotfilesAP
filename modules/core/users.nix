{
  config,
  pkgs,
  ...
}: {
  users.users.GrajAP = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "gitea"
      "docker"
      "systemd-journal"
      "audio"
      "plugdev"
      "wireshark"
      "video"
      "input"
      "lp"
      "networkmanager"
      "power"
      "nix"
    ];
    uid = 1000;
    shell = pkgs.zsh;
    initialPassword = "grajap";
  };
}
