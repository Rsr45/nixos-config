{...}: {
  ## Updates
  "app.update.checkInstallTime.days" = 0;
  "app.update.badgeWaitTime" = 0;
  "app.update.notifyDuringDownload" = true;
  "app.update.promptWaitTime" = 0;
  "extensions.systemAddon.update.enabled" = true;
  "extensions.update.autoUpdateDefault" = true;
  "extensions.update.enabled" = true;
  "app.update.background.interval" = 3600;
  "app.update.interval" = 3600;
  "extensions.update.interval" = 3600;
  "services.settings.poll_interval" = 3600;
  "extensions.checkUpdateSecurity" = true;

  ## Privacy
  # does this even matter?
  "privacy.query_stripping.strip_list" = "__hsfp __hssc __hstc __s _bhlid _branch_match_id _branch_referrer _gl _hsenc _kx _openstat at_recipient_id at_recipient_list bbeml bsft_clkid bsft_uid dclid et_rid fb_action_ids fb_comment_id fbclid gbraid gclid guce_referrer guce_referrer_sig hsCtaTracking igshid irclickid mc_eid mkt_tok ml_subscriber ml_subscriber_hash msclkid mtm_cid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id pk_cid rb_clickid s_cid sc_customer sc_eh sc_uid srsltid ss_email_id twclid unicorn_click_id vero_conv vero_id vgo_ee wbraid wickedid yclid ymclid ysclid";

  "privacy.antitracking.isolateContentScriptResources" = true;
  "network.http.referer.XOriginTrimmingPolicy" = 2;

  ##
  "network.IDN_show_punycode" = true;
  "browser.urlbar.trimHttps" = false;
  "browser.urlbar.trimURLs" = false;

  "signon.autofillForms" = false;
  "signon.formlessCapture.enabled" = false;
  "network.auth.subresource-http-auth-allow" = 1;

  ## Performance
  "browser.cache.jsbc_compression_level" = 3;
  "javascript.options.asyncstack" = false;
  "javascript.options.asyncstack_capture_debuggee_only" = true;
  "sidebar.animation.enabled" = false;
  "ui.panelAnimations" = 0;
  "ui.prefersReducedMotion" = 1;
  "ui.swipeAnimationEnabled" = 0;
  "layout.css.report_errors" = false;
  "extensions.logging.enabled" = false;
  "network.http.pacing.requests.enabled" = false;
  "browser.preferences.defaultPerformanceSettings.enabled" = false;
  "javascript.options.wasm_simd_avx" = true;
  "layers.acceleration.disabled" = false;

  ## Translations
  "browser.ai.control.translations" = "enabled";
  # "browser.translations.automaticallyPopup" = false;
  "browser.translations.enable" = true;
  "browser.translations.select.enable" = true;
  "browser.translations.newSettingsUI.enable" = true;
  "browser.translations.simulateUnsupportedEngine" = false;
  "extensions.translations.disabled" = false;

  "ui.key.menuAccessKeyFocuses" = false;

  ## DRM
  "media.eme.enabled" = false;
  "browser.eme.ui.enabled" = false;
  ## ETP
  "browser.contentblocking.category" = "strict";
  "privacy.trackingprotection.allow_list.baseline.enabled" = true;
  "privacy.trackingprotection.allow_list.convenience.enabled" = false;
  ### Optional
  "privacy.antitracking.enableWebcompat" = false;
  ## RFP
  "privacy.resistFingerprinting" = true;
  "privacy.resistFingerprinting.pbmode" = true;
  "privacy.window.maxInnerWidth" = 1600;
  "privacy.window.maxInnerHeight" = 900;

  ## DOH & HTTPS
  "dom.security.https_only_mode" = true;
  "network.trr.mode" = 3;
  "network.trr.custom_uri" = "https://dns10.quad9.net/dns-query";
  "network.trr.uri" = "https://dns10.quad9.net/dns-query";
  # dnscrypt-proxy
  # Set network.trr.custom_uri and network.trr.uri to https://127.0.0.1:3000/dns-query
  # Set network.trr.mode to 2 or 3 info
  # Set network.dns.echconfig.enabled to true
  # Set network.dns.use_https_rr_as_altsvc to true
  # Set network.security.esni.enabled to true (deprecated)

  # General
  "browser.aboutConfig.showWarning" = false;

  "extensions.quarantineIgnoredByUser.tridactyl.vim@cmcaine.co.uk" = true;
  "general.autoScroll" = true;
  "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
  "browser.translations.automaticallyPopup" = false;

  "svg.context-properties.content.enabled" = true;
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

  "widget.use-xdg-desktop-portal.file-picker" = 1;
  "widget.use-xdg-desktop-portal.location" = 1;
  "widget.use-xdg-desktop-portal.mime-handler" = 1;
  "widget.use-xdg-desktop-portal.open-uri" = 1;
  "widget.use-xdg-desktop-portal.settings" = 1;

  "widget.gtk.libadwaita-colors.enabled" = false;
  "browser.tabs.inTitlebar" = 0;

  # WebRTC
  # "media.peerconnection.enabled" = false;

  # Optional
  "network.http.referer.XOriginPolicy" = 2;

  "signon.rememberSignons" = false;
  "extensions.formautofill.addresses.enabled" = false;
  "extensions.formautofill.creditCards.enabled" = false;
  # JIT
  # "javascript.options.ion" = false;
  # "javascript.options.baselinejit" = false;
  # "javascript.options.jithints" = false;
  # ## Enable JIT for WebExtensions
  # "javascript.options.jit_trustedprincipals" = true;
  # ## WebAssembly
  # "javascript.options.wasm" = true;
  # "javascript.options.main_process_disable_jit" = true;
  # "javascript.options.native_regexp" = false;
  # "javascript.options.wasm_baselinejit" = true;
  # "javascript.options.wasm_optimizingjit" = false;
  # ## Misc
  # "javascript.options.asmjs" = false;
}
