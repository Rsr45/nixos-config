{ ... }: {
  boot.kernelParams = [
    # Don't merge slabs
    "slab_nomerge"

    # Overwrite free'd pages
    "page_poison=1"

    # Enable page allocator randomization
    "page_alloc.shuffle=1"

    # Disable debugfs
    "debugfs=off"

    # enables zeroing of memory during allocation and free time
    # helps mitigate use-after-free vulnerabilaties
    "init_on_alloc=1"
    "init_on_free=1"
    # enables Kernel Page Table Isolation, which mitigates Meltdown and
    # prevents some KASLR bypasses
    "pti=on"
    # randomizes the kernel stack offset on each syscall
    # making attacks that rely on a deterministic stack layout difficult
    "randomize_kstack_offset=on"
    # disables vsyscalls, they've been replaced with vDSO
    "vsyscall=none"
    # certain exploits cause an "oops", this makes the kernel panic if an "oops" occurs
    "oops=panic"
    # only alows kernel modules that have been signed with a valid key to be loaded
    # making it harder to load malicious kernel modules
    # can make VirtualBox or Nvidia drivers unusable
    "module.sig_enforce=1"
    # prevents user space code excalation
    "lockdown=confidentiality"
    # "rd.udev.log_level=3"
    # "udev.log_priority=3"
  ];
}
