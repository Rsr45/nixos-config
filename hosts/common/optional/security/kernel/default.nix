{ ... }: {
  imports = [
    # ./parameters.nix
    # ./sysctl.nix
  ];
  # security = {
    # protectKernelImage = true;
    # lockKernelModules = false; # this breaks iptables, wireguard, and virtd
  # };

  # boot.kernelModules = [
  #   # USB
  #   "usb_storage"
  #   "uinput"
  #   "usbhid"
  #   "usbserial"
  #   # DVD
  #   "udf"
  #   "iso9660"
  #   # GPU
  #   "amdgpu"
  #   "i915"
  #   # Networking
  #   "nft_chain_nat"
  #   "xt_conntrack"
  #   "xt_CHECKSUM"
  #   "xt_MASQUERADE"
  #   "ipt_REJECT"
  #   "ip6t_REJECT"
  #   "nf_reject_ipv4"
  #   "nf_reject_ipv6"
  #   "xt_mark"
  #   "xt_comment"
  #   "xt_multiport"
  #   "xt_addrtype"
  #   "xt_connmark"
  #   "nf_conntrack_netlink"
  # ];

  # boot.blacklistedKernelModules = [
  #   # Obscure network protocols
  #   "ax25"
  #   "netrom"
  #   "rose"
  #
  #   # Old or rare or insufficiently audited filesystems
  #   "adfs"
  #   "affs"
  #   "bfs"
  #   "befs"
  #   "cramfs"
  #   "efs"
  #   "erofs"
  #   "exofs"
  #   "freevxfs"
  #   "f2fs"
  #   "hfs"
  #   "hpfs"
  #   "jfs"
  #   "minix"
  #   "nilfs2"
  #   "ntfs"
  #   "omfs"
  #   "qnx4"
  #   "qnx6"
  #   "sysv"
  #   "ufs"
  # ];
}
