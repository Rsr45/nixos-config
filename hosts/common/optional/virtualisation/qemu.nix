{ pkgs, ... }: {

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
    # allowedBridges = [
    #   "virbr0"
    #   "virbr1"
    #   "virbr2"
    #   "virbr3"
    # ];
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # networking.firewall.interfaces."virbr*".allowedUDPPorts = [
  #   53
  #   67
  # ];
  #
  # networking.firewall.interfaces.lxdbr0.allowedTCPPorts = [ 53 ];
  # networking.firewall.interfaces.lxdbr0.allowedUDPPorts = [
  #   53
  #   67
  # ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
    bridge-utils
    iproute2
  ];
}
