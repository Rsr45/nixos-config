{ ... }: {
  boot.kernel.sysctl = {
    ## Copyright (C) 2019 - 2025 ENCRYPTED SUPPORT LLC <adrelanos@whonix.org>
    ## See the file COPYING for copying conditions.

    ## NOTE:
    ## This file has a special name to ensure that /usr/lib/sysctl.d/99-protect-links.conf
    ## is parsed first, followed by /usr/lib/sysctl.d/990-security-misc.conf.
    ## https://github.com/Kicksecure/security-misc/pull/135

    ## Definitions:
    ## KSPP=yes: compliant with recommendations by the KSPP
    ## KSPP=partial: partially compliant with recommendations by the KSPP
    ## KSPP=no: not (currently) compliant with recommendations by the KSPP
    ## If there is no explicit KSPP compliance notice, the setting is not mentioned by the KSPP.

    ## This configuration file is divided into 6 sections:
    ## 1. Kernel Space
    ## 2. User Space
    ## 3. Core Dumps
    ## 4. Swap Space
    ## 5. Networking
    ## 6. CD-ROM/DVD

    ## For detailed explanations of most of the selected commands, refer to:
    ## https://docs.kernel.org/admin-guide/sysctl/index.html
    ## https://docs.kernel.org/networking/ip-sysctl.html

    ## 1. Kernel Space:
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "kernel.unprivileged_bpf_disabled" = 1;
    "dev.tty.ldisc_autoload" = 0;
    "vm.unprivileged_userfaultfd" = 0;
    "kernel.kexec_load_disabled" = 1;
    "kernel.sysrq" = 0;
    "kernel.perf_event_paranoid" = 3;
    "kernel.panic" = "-1";
    "dev.tty.legacy_tiocsti" = 0;
    "kernel.io_uring_disabled" = 2;
    "abi.vsyscall32" = 0;

    ## 2. User Space:
    "fs.protected_hardlinks" = 1;
    "fs.protected_symlinks" = 1;
    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;
    "kernel.randomize_va_space" = 2;
    "vm.mmap_min_addr" = "65536";
    "vm.max_map_count" = "1048576";

    ## 3. Core Dumps:
    "kernel.core_pattern" = "|/bin/false";
    "fs.suid_dumpable" = 0;
    "kernel.core_uses_pid" = 1;

    ## 4. Swap Space:
    "vm.swappiness" = 1;

    ## 5. Networking:
    "net.core.bpf_jit_harden" = 2;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_rfc1337" = 1;
    "net.ipv4.conf.*.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.*.accept_redirects" = 0;
    "net.ipv4.conf.*.send_redirects" = 0;
    "net.ipv6.conf.*.accept_redirects" = 0;
    "net.ipv4.conf.*.shared_media" = 0;
    "net.ipv4.conf.*.arp_filter" = 1;
    "net.ipv4.conf.*.arp_ignore" = 2;
    "net.ipv4.conf.*.drop_gratuitous_arp" = 1;
    "net.ipv4.icmp_echo_ignore_all" = 1;
    "net.ipv6.icmp.echo_ignore_all" = 1;
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    "net.ipv4.conf.*.accept_source_route" = 0;
    "net.ipv6.conf.*.accept_source_route" = 0;
    "net.ipv6.conf.*.accept_ra" = 0;
    "net.ipv4.tcp_timestamps" = 0;
    "net.ipv4.tcp_tw_reuse" = 0;
    "net.ipv4.conf.*.log_martians" = 1;

    ## 6. CD-ROM/DVD
    "dev.cdrom.autoclose" = 0;
    "dev.cdrom.autoeject" = 0;
    "dev.cdrom.debug" = 0;

    # # Disable module loading. For example, this can be set after the system has finished booting and initializing hardware:
    # # https://outflux.net/blog/archives/2009/07/31/blocking-module-loading/
    # "kernel.modules_disabled" = 1;

    # # Block all PTRACE_ATTACH. If you need ptrace to work, then avoid non-ancestor ptrace access to running processes and their credentials, and use value "1".
    # "kernel.yama.ptrace_scope" = 3;

    # # Disable User Namespaces, as it opens up a large attack surface to unprivileged users.
    # # "user.max_user_namespaces" = 0;

    # # Reboot after even 1 WARN or BUG/Oops. Adjust for your tolerances. (Since v6.2)
    # # If you want to set oops_limit greater than one, you will need to disable CONFIG_PANIC_ON_OOPS.
    # "kernel.warn_limit" = 1;
    # "kernel.oops_limit" = 1;
  };
}
