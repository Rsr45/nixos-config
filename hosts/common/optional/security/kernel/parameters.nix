{ ... }: {
  security.forcePageTableIsolation = true;
  # security.protectKernelImage = true;
  security.allowSimultaneousMultithreading = true;

  # some are set through security.<name>
  boot.kernelParams =  [
    # Make sure CONFIG_HARDENED_USERCOPY stays enabled.
    "hardened_usercopy=1"

    # Wipe slab and page allocations (Since v5.3; supersedes "slub_debug=P" and "page_poison=1" below)
    # See CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y and CONFIG_INIT_ON_FREE_DEFAULT_ON=y above.
    "init_on_alloc=1"
    "init_on_free=1"

    # Randomize kernel stack offset on syscall entry (since v5.13).
    # See CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT above.
    "randomize_kstack_offset=on"

    # Randomize page allocator (needs CONFIG_SHUFFLE_PAGE_ALLOCATOR=y too).
    "page_alloc.shuffle=1"

    # Disable slab merging to make some heap overflow attacks more difficult. (See also CONFIG_SLAB_MERGE_DEFAULT)
    "slab_nomerge"

    # Always enable Kernel Page Table Isolation, even if the CPU claims it is safe from Meltdown.
    "pti=on"

    # To prevent against L1TF, at the cost of losing hyper threading (slow).
    # "nosmt"

    # Since v6.17, force exposed pointers to be hashed.
    "hash_pointers=always"

    # Enable SLUB redzoning and sanity checking (*slow*; requires CONFIG_SLUB_DEBUG=y above).
    # From v5.14 through v6.16, this disables pointer hashing (see above). From v6.17 on, using
    # `hash_pointers=always` will avoid this.
    "slub_debug=ZF"

    # (Before v5.3 without "init_on_free=1") Enable slub/slab allocator free poisoning (requires CONFIG_SLUB_DEBUG=y above).
    "slub_debug=P"

    # (Before v5.3 without "init_on_free=1") Enable buddy allocator free poisoning (see also CONFIG_PAGE_POISONING_ZERO above).
    "page_poison=1"

    # Force IOMMU TLB invalidation so devices will never be able to access stale data contents (see CONFIG_IOMMU_DEFAULT_DMA_STRICT=y above).
    "iommu.passthrough=0"
    "iommu.strict=1"

    # Disable bypassing of read-only permissions via /proc/$pid/mem.
    # To allow ptrace to do it (gdb, etc), use "...=ptrace".
    "proc_mem.force_override=never"

    # Mitigates all known CPU vulnerabilities, disabling SMT *if needed*.
    "mitigations=auto,nosmt"

    # Another way to enable KFENCE (see CONFIG_KFENCE_SAMPLE_INTERVAL).
    "kfence.sample_interval=100"

    # Remove vsyscall entirely to avoid it being a fixed-position ROP target of any kind.
    # (Same as CONFIG_LEGACY_VSYSCALL_NONE=y above.)
    "vsyscall=none"

    # Make sure COMPAT_VDSO stays disabled
    "vdso32=0"

    # Disable FineIBT since it is weaker than pure KCFI.
    "cfi=kcfi"
  ];
}
