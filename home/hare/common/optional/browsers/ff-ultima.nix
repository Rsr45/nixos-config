{ ... }:
{
  programs.schizofox.theme = {
    extraUserChrome = ''
      /*///////////////////////////////////////////////////////////////////////////////////////\

      ┏┓┏┓  ┳┳┓ ┏┳┓┳┳┳┓┏┓
      ┣ ┣   ┃┃┃  ┃ ┃┃┃┃┣┫
      ┻ ┻   ┗┛┗┛ ┻ ┻┛ ┗┛┗
                         
      FF Ultima:         https://github.com/soulhotel/FF-ULTIMA
      Wiki:              https://ff-ultima.github.io/docs/getting-started
      Latest Version:    https://github.com/soulhotel/FF-ULTIMA/releases/latest                 
      License:           https://github.com/soulhotel/FF-ULTIMA/blob/main/LICENSE MPL 2.0

      \////////////////////////////////////////////////////////////////////////////////////////*/

      @import url(theme/ffu-global-positioning.css);
      @import url(theme/ffu-internal-appearance.css);
      @import url(theme/ffu-private-browsing.css);

      @import url(theme/color-schemes/apply-cs.css); /*color schemes*/

      @import url(theme/settings-context-menus.css);
      @import url(theme/settings-extensions-panel.css);

      @import url(theme/settings-urlbar.css);
      @import url(theme/settings-navbar.css);
      @import url(theme/settings-navbar-windowcontrols.css);
      @import url(theme/settings-icons.css);
      @import url(theme/settings-findbar.css);
      @import url(theme/settings-sidebar-sidebery.css);
      @import url(theme/settings-TABS.css);
      @import url(theme/settings-tabs-group-and-containers.css);

      @import url(theme/ffu-special-configs.css);

      @import url(customChrome.css);
    '';
  };
  extraUserContent = ''
    /*///////////////////////////////////////////////////////////////////////////////////////\
    
    ┏┓┏┓  ┳┳┓ ┏┳┓┳┳┳┓┏┓
    ┣ ┣   ┃┃┃  ┃ ┃┃┃┃┣┫
    ┻ ┻   ┗┛┗┛ ┻ ┻┛ ┗┛┗
                       
    FF Ultima:         https://github.com/soulhotel/FF-ULTIMA
    Wiki:              https://ff-ultima.github.io/docs/getting-started
    Latest Version:    https://github.com/soulhotel/FF-ULTIMA/releases/latest                 
    License:           https://github.com/soulhotel/FF-ULTIMA/blob/main/LICENSE MPL 2.0
    
    \////////////////////////////////////////////////////////////////////////////////////////*/
    
    /* 
    - Dont like a websites styling? remove the line associated below.
    */
    
    @import url(theme/website-aboutconfig.css); /*        styling for aboutconfig */
    @import url(theme/website-aboutaddons.css); /*        styling for aboutaddons */
    @import url(theme/website-styles.css); /*       styling for multiple websites */
    @import url(theme/website-newtab.css); /*                        new tab page */
    @import url(theme/website-reddit.css); /*                              reddit */
    @import url(theme/website-yt.css); /*                                 youtube */
    @import url(theme/website-private.css); /*               private new tab page */
    
    @import url(theme/color-schemes/apply-cs.css);            /* import color scheme colors */
    @import url(theme/color-schemes/apply-cs-extensions.css); /* apply colors to extensions */
    @import url(theme/color-schemes/apply-cs-wallpapers.css); /* apply colors to wallpapers */
    
    @import url(custom.css);
  '';
}
