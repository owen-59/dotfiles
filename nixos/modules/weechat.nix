{
  pkgs,
  ...
}:

{
  systemd.user.services.weechat = {
    description = "Persistent WeeChat session in tmux";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "default.target" ];

    serviceConfig = {
      Type = "forking";
      RemainAfterExit = true;
      ExecStart = "${pkgs.tmux}/bin/tmux -L weechat new-session -d -s weechat ${pkgs.weechat}/bin/weechat";
      ExecStop = "${pkgs.tmux}/bin/tmux -L weechat kill-session -t weechat";
    };
  };
}
