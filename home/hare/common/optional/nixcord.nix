{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.nixcord.homeModules.default ];

  programs.nixcord = {
    enable = true;
    discord.enable = false;
    # discord.vencord.package = pkgs.vencord;

    vesktop = {
      enable = true;
      autoscroll.enable = true;
    };

    equibop = {
      enable = true;
      settings = {
        MINIMIZE_TO_TRAY = false;
        TRAY = false;
      };
    };

    dorion.enable = true;

    # quickCss = "@import url(https://codeberg.org/ridge/Discord-Adblock/raw/branch/main/discord-adblock.css);\n@import url(https://codeberg.org/ridge/Discord-CSS-Tweaks/raw/branch/main/discord-css-tweaks.css);";
    quickCss = import ./nixcord-quickcss.nix;

    config = {
      useQuickCss = true;
      autoUpdate = true;
      plugins = {
        # must have
        blurNsfw.enable = true;
        # anonymiseFileNames.enable = true;
        silentTyping.enable = true;
        hideMedia.enable = true;

        # good to have
        fakeNitro.enable = true;
        favoriteEmojiFirst.enable = true;
        favoriteGifSearch.enable = true;
        fixCodeblockGap.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendInvites.enable = true;
        friendsSince.enable = true;
        fullSearchContext.enable = true;
        fullUserInChatbox.enable = true;
        experiments = {
          enable = true;
          toolbarDevMenu = true;
        };
        gifPaste.enable = true;
        greetStickerPicker.enable = true;
        imageZoom.enable = true;
        memberCount = {
          enable = true;
          memberList = false;
        };
        mentionAvatars = {
          enable = true;
          showAtSymbol = false;
        };
        # moreCommands.enable = true; #equicord required
        # moreKaomoji.enable = true; #equicord required
        # noBlockedMessages.enable = true;
        # noMosaic.enable = true;
        # noOnboardingDelay.enable = true;
        # noPendingCount = {
        #   enable = true;
        #   hideFriendRequestsCount = false;
        #   # hideMessageRequestCount = false;
        # };
        noProfileThemes.enable = true;
        # noRPC.enable = true;
        noReplyMention.enable = true;
        noUnblockToJump.enable = true;
        # normalizeMessageLinks.enable = true; # removed/only equicord
        # nsfwGateBypass.enable = true; # removed
        permissionsViewer.enable = true;
        petpet.enable = true;
        pictureInPicture.enable = true;
        quickMention.enable = true;
        readAllNotificationsButton.enable = true;
        replaceGoogleSearch = {
          enable = true;
          customEngineName = "DuckDuckGo";
          customEngineUrl = "https://duckduckgo.com/";
        };
        revealAllSpoilers.enable = true;
        reverseImageSearch.enable = true;
        roleColorEverywhere.enable = true;
        serverInfo.enable = true;
        showAllMessageButtons.enable = true;
        showConnections.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        showMeYourName = {
          enable = true;
          # mode = "nick-user";
        };
        showTimeoutDuration.enable = true;
        # spotifyControls.enable = true;
        # spotifyCrack.enable = true;
        # spotifyShareCommands.enable = true;
        startupTimings.enable = true;
        # typingIndicator.enable = true;
        typingTweaks.enable = true;
        unlockedAvatarZoom.enable = true;
        unsuppressEmbeds.enable = true;
        userVoiceShow.enable = true;
        validReply.enable = true;
        validUser.enable = true;
        voiceChatDoubleClick.enable = true;
        # whoReacted.enable = true;
        # youtubeAdblock.enable = true;
        noTypingAnimation.enable = true;
        # clearURLs.enable = true;
        # colorSighted.enable = true;
        # disableCallIdle.enable = true;
        # ctrlEnterSend.enable = true;
        # copyFileContents.enable = true;
        # callTimer.enable = true;
        # biggerStreamPreview.enable = true;
        # betterUploadButton.enable = true;
        # betterSettings.enable = true; # no background with midnight
        # betterRoleContext.enable = true;
        # betterGifPicker.enable = true;
        # betterGifAltText.enable = true;
        # accountPanelServerProfile.enable = true;
        # ignoreActivities = {
        #   enable = true;
        #   ignorePlaying = true;
        #   ignoreWatching = true;
        # };

        blockKrisp.enable = true;
        # altKrispSwitch.enable = true;
        anonymiseFileNames.enable = true;
        autoZipper.enable = true;
        betterBlockedUsers.enable = true;
        betterCommands.enable = true;
        cleanChannelName.enable = true;
        equibopStreamFixes.enable = true;
        declutter = {
          enable = true;
          removeAvatarDecoration = true;
          removeNameplate = true;
          removeProfileEffect = true;
          removeClanTag = true;
          alwaysShowUsername = true;
          removeShopAboveDm = true;
          removeQuestsAboveDm = true;
          removeServerBoostInfo = true;
          removeBillingSettings = true;
          removeGiftButton = true;
          removeUnavailableEmojiPicker = true;
          removeAudioMenus = true;
          removeButtonTooltips = true;
        };
        exportMessages.enable = true;
        keyboardNavigation.enable = true;
        questify = {
          enable = true;
          disableQuestsEverything = true;
        };
        channelBadges = {
          enable = true;
          showTextBadge = false;
          showVoiceBadge = false;
        };
        globalBadges.enable = true;
        betterInvites.enable = true;
      };
    };
  };
}
