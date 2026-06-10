''
  @import url(https://codeberg.org/ridge/Discord-Adblock/raw/branch/main/discord-adblock.css);


  * {
    border-radius: 0 !important;
  }

  *,
  *::before,
  *::after {
      border-radius: 0 !important;
  }

  /* UI top bar */
  nav[class^=wrapper_]:has(div[class^="unreadMentionsIndicatorTop_"]) {
    margin-top: 0.9em;
  }

  :root {
    --custom-app-top-bar-height: 0.1px;
  }

  div[class^="base__"] > div[class^="bar_"] {
    display: none;
  }

  /* Activity list in "server" user list */
  div[class^="members_"]  {
    h3:has(span[role="button"]) ,
    div > div:has(img[class^="contentImage"])
    { display: none; }
  }

  /* "Active now" sidebar in friends list */
  div[class^=nowPlayingColumn__] {
    display: none;
  }

  /* Download Apps button in web app */
  nav[class^="wrapper_"] div[class^=listItem__]:has(div[data-list-item-id=guildsnav___app-download-button]) {
    display: none;
  }

  /* Remove game collection buttons */
  div[class^="widgetPreviews__"],[class*="user-profile-popout"] section[class^="container__"]:has(div[class^="icons_"]) {
    display: none;
  }

  /* Chat box sticker button */
  div[class^=expression-picker-chat-input-button]:has(div[class*=stickerButton__]) {
    display: none;
  }

  /* App catalogue buttons */
  div[id="guild-header-popout-application-directory"] , /* Guild menu app catalogue */
  div[class~="app-launcher-entrypoint"] {               /* In-chat app catalogue    */
    display: none;
  }


  /* Server tag button in guild popout list */
  #guild-header-popout-guild-tag {
    display: none;
  }

  /* Clean up "server" invites */
  div[class^="guildInviteContainer"] div[class^="container"] {
    &:has(div[class^="gameIcon"]),
    &:has(div[class^="trait"])
    { display: none; }
  }

  /* Avatar decorations */
  svg[class^="avatarDecorationContainer__"] ,
  img[class^="avatarDecoration_"] {
    display: none;
  }

  /* Profile decorations */
  div[class^=profileEffects__] {
    display: none;
  }

  /* Animated nameplate */
  li[class*="dm_"] , div[class^="member"] {
    div[class^="container"]:has([src*="/collectibles-shop/"])
    { display: none; }
  }

  /* Community badges */
  span[class^="chipletContainerInner__"]:has(img[class^="badge__"]) ,
  span[class^="guildTagContainer__"] {
    display: none;
  }

  /* Profile tag nag ("You can now wear a tag from...") */
  div[id^="popout_"]:has(img[src*="/clan-badges/"]):has(div[class^="closeButton_"]) {
    display: none;
  }

  /* Custom status reaction buttons */
  div[class*="statusPopover"] {
    display: none;
  }

  /* Popout profile message box */
  div[class$="user-profile-popout"] div[class^="footer__"]:has(div[role="textbox"]) {
    display: none;
  }

  /* Remove "Find or start conversation" button in DM list */
  nav[class^=privateChannels_] > [class^=searchBar_] {
    display: none;
  }

  /* "Discover" button */
  div[class^=listItem__]:has(div[data-list-item-id=guildsnav___guild-discover-button]) {
    display: none;
  }

  /* Server boost elements */
  /* Boost settings */
  ul[class^="content_"] > li:has([data-list-item-id^="channels___skill-trees-"]) {
    display: none;
  }

  /* "Events" button at the top of channel list */
  #channels li:has([id^=upcoming-events-]) {
    display: none;
  }

  /* Username gradients in boosted guilds */
  span[class*="usernameGradient_"] {
    -webkit-text-fill-color: unset;
    background: none;
    color: var(--custom-gradient-color-1);
  }

  span[class^="nameGlow__"] {
    display: none;
  }


  /* In-call activities buttons */
  div[class^="actionButtons_"] > button:has(g[transform="matrix(2.700000047683716,0,0,2.700000047683716,-79.60000610351562,-81.35110473632812)"]) {
    display: none; /* Bottom left in-call activities button */
  }
  div[class^="buttonSection__"] > div[class^="buttonContainer__"]:has(g[transform="matrix(2.700000047683716,0,0,2.700000047683716,-79.60000610351562,-81.35110473632812)"]) {
    display: none; /* In-call users-screen activities button */
  }

  /* In-call soundboard buttons */
  div[class^="actionButtons_"] > span:has(g[transform="matrix(0.03999999910593033,0,0,0.03999999910593033,0,0)"]) {
    display: none; /* Bottom left in-call soundboard button */
  }
  div[class^="buttonSection__"] > div[class^="attachedCaretButtonContainer_"]:has(g[transform="matrix(25,0,0,25,299.98699951171875,300.0119934082031)"]) {
    display: none; /* In-call users-screen soundboard button */
  }
''
