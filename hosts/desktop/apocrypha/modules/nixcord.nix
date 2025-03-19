{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nixcord.homeManagerModules.nixcord];

  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    discord.enable = false;
    discord.vencord.package = pkgs.vencord;
    vesktop.enable = true;
    config = {
      plugins = {
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
        moreCommands.enable = true;
        moreKaomoji.enable = true;
        noBlockedMessages.enable = true;
        noMosaic.enable = true;
        noOnboardingDelay.enable = true;
        noPendingCount = {
          enable = true;
          hideFriendRequestsCount = false;
          hideMessageRequestCount = false;
        };
        noProfileThemes.enable = true;
        noRPC.enable = true;
        noReplyMention.enable = true;
        noUnblockToJump.enable = true;
        normalizeMessageLinks.enable = true;
        nsfwGateBypass.enable = true;
        permissionsViewer.enable = true;
        petpet.enable = true;
        pictureInPicture.enable = true;
        quickMention.enable = true;
        readAllNotificationsButton.enable = true;
        replaceGoogleSearch = {
          enable = true;
          customEngineName = "DuckDuckGo";
          customEngineURL = "https://duckduckgo.com/";
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
          mode = "nick-user";
        };
        showTimeoutDuration.enable = true;
        silentTyping.enable = true;
        spotifyControls.enable = true;
        spotifyCrack.enable = true;
        spotifyShareCommands.enable = true;
        startupTimings.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        unlockedAvatarZoom.enable = true;
        unsuppressEmbeds.enable = true;
        userVoiceShow.enable = true;
        validReply.enable = true;
        validUser.enable = true;
        voiceChatDoubleClick.enable = true;
        whoReacted.enable = true;
        youtubeAdblock.enable = true;
        noTypingAnimation.enable = true;
        clearURLs.enable = true;
        colorSighted.enable = true;
        disableCallIdle.enable = true;
        ctrlEnterSend.enable = true;
        copyFileContents.enable = true;
        callTimer.enable = true;
        blurNSFW.enable = true;
        biggerStreamPreview.enable = true;
        betterUploadButton.enable = true;
        betterSettings.enable = true;
        betterRoleContext.enable = true;
        betterGifPicker.enable = true;
        betterGifAltText.enable = true;
        anonymiseFileNames.enable = true;
        accountPanelServerProfile.enable = true;
        hideAttachments.enable = true; # Enable a Vencord plugin
        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
        };
      };
    };
  };
}
