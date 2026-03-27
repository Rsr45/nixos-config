{ pkgs, ... }:
{

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
    # jack.enable = true;
    # media-session.enable = true;

    ## To replicate the vb audio setup without remembering how ti worked ahh me
    #and my stupid head oh well i think this should be equal to in principle
    #how it supposed to be woking
    # bcz of the way pipewire works i do not think i need to create Software
    # inputs or hardware Outputs as it will show and allow to route to hardware
    # devices but i need a sink to categorize and organize outputs or input
    # from apps so i need to have multiple virtual input/out ithink atleast so
    # i don ot even neeed to create Software inputs outputs as pipewire will
    # allow me to route app output to wherever i want huh so i just make
    # a default software input/output that pipewire uses or just undisconnect
    # anything from patchbay ... still though it might be better to still have
    # software inputs/outs rather than having my apps go straight from pre
    # categorized to hardware

    extraConfig.pipewire = {
      "91-null-sinks" = {
        "context.objects" = [
          {
            # A default dummy driver. This handles nodes marked with the "node.always-driver"
            # properyty when no other driver is currently active. JACK clients need this.
            factory = "spa-node-factory";
            args = {
              "factory.name" = "support.node.driver";
              "node.name" = "Dummy-Driver";
              "priority.driver" = 8000;
            };
          }
          ## Software Inputs/ used as output by apps eg atleast in vbaudio
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Software Input/B1";
              "node.description" = "Software Input/B1";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
              "monitor.channel-volumes" = true;
              "monitor.passthrough" = true;
            };
          }
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Software Input/B2";
              "node.description" = "Software Input/B2";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
              "monitor.channel-volumes" = true;
              "monitor.passthrough" = true;
            };
          }

          ## Software Outputs/ used as input by apps etc atleast in vbaudio
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Software Out/B1";
              "node.description" = "Software Out/B1";
              "media.class" = "Audio/Source/Virtual";
              "audio.position" = "FL,FR";
            };
          }
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Software Out/B2";
              "node.description" = "Software Out/B2";
              "media.class" = "Audio/Source/Virtual";
              "audio.position" = "FL,FR";
            };
          }

          ## INPUT
          # {
          #   factory = "adapter";
          #   args = {
          #     "factory.name" = "support.null-audio-sink";
          #     "node.name" = "Microphone-Proxy";
          #     "node.description" = "Microphone";
          #     "media.class" = "Audio/Source/Virtual";
          #     "audio.position" = "MONO";
          #   };
          # }
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Desktop";
              "node.description" = "Virtual Input 1";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
            };
          }
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Multimedia";
              "node.description" = "Virtual Input 2";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
            };
          }
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Com";
              "node.description" = "Virtual Input 3";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
            };
          }
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "Virtual-Input-4";
              "node.description" = "Virtual Input 4";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
            };
          }
        ];
      };
    };
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      playerctl
      qpwgraph
      ;
  };
}
