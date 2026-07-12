{
    config,
    pkgs,
    inputs,
    ...
}:
{
    xdg.enable = true;

    xdg.configFile."menus/applications.menu".text = ''
      <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
       "http://freedesktop.org">
      <Menu>
        <Name>Applications</Name>
        <DefaultAppDirs/>
        <DefaultDirectoryDirs/>
        <Include>
          <All/>
        </Include>
      </Menu>
    '';


    home.stateVersion = "26.05";
}
