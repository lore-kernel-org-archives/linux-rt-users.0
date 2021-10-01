Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D356FC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE370610A2
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 09:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhJAJdT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:33:19 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:35182 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352943AbhJAJdR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Oct 2021 05:33:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A5375E30A;
        Fri,  1 Oct 2021 11:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1633080691; h=from:subject:date:message-id:to;
        bh=ajmSqt3TOpJUEUaBnga7oM7lBwHq28VNrIaHNFwCgRA=;
        b=aMlq1H62IWaP/oExufdEOuc4U8nXF3vvemg+QEc3r67EzCwEE/ZJ9aTV/Q6XQaP5YFiKVU
        OkLUihWYWLwhHxj3Yfwkv0RdSI+SGGiDuShuBu9cZHGxgKU/qD9Tj4AkIingkMaiyaPIfl
        o+B4uBKD1Tq1BKHVfpo9BKbnfz7GpJ1AswHKzdNQk9EMVoGAPMK6bSh5kyz+XgPo2UtYOR
        AZ/d7t0ziLOws5SobHxLXyTj/DPcb1XyDQtBTFnqmJLtGWqPUh3kKPgwpUT7p95eyZnGYR
        HWo2qinT29SUeYX1yf/Vszm1ob1wk1zWZBtzQW4/dibMqYhEVphZ4qJ3kDk4ng==
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.285-rt226
Date:   Fri, 01 Oct 2021 08:34:28 -0000
Message-ID: <163307726840.24858.2277036113555626320@beryllium.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.285-rt226 stable release.

There are some futex changes in the RT code which were necessary
because of the fuxex backports in v4.4.280. It took me a while to
figure the merge conflicts and what needs to be changed in the
futex/rtmutex patches. The v4.4 version of "Add the rtmutex rework"
path is updated. The the locking rules changed, see the fixup patch
for hb->lock and mutex->wait_lock.

Unfortunatly, I am not able to upload the patches to the usual places
because I had to create a new gpg subkey as my old one expired. And
now kup tells me my signature is invalid. I created a ed25519 signing
key instead of a rsa one. Maybe this is what kup upsets. No idea and
the security tools are helpful as always... NOT.

As I didn't want to delay the release even more I only pushed the
changes to the git tree.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: b045f6da3d00b1423045781f9ec069827ea6a42a

Enjoy!
Daniel

Changes from v4.4.277-rt224:
---

Adrian Bunk (1):
      bnx2x: Fix enabling network interfaces without VFs

Alex Xu (Hello71) (1):
      pipe: increase minimum default pipe size to 2 pages

Andreas Obergschwandtner (1):
      ARM: tegra: tamonten: Fix UART pad setting

Andrew Morton (1):
      mm/kmemleak.c: make cond_resched() rate-limiting more efficient

Andy Shevchenko (3):
      PCI: Sync __pci_register_driver() stub for CONFIG_PCI=n
      dmaengine: acpi-dma: check for 64-bit MMIO address
      dmaengine: acpi: Avoid comparison GSI with Linux vIRQ

Anna-Maria Gleixner (1):
      rcu: Update documentation of rcu_read_unlock()

Axel Lin (1):
      regulator: rt5033: Fix n_voltages settings for BUCK and LDO

Ben Dooks (1):
      ARM: 8918/2: only build return_address() if needed

Bob Peterson (1):
      gfs2: Don't call dlm after protocol is unmounted

Christoph Hellwig (1):
      cryptoloop: add a deprecation warning

Christophe JAILLET (2):
      drm/msm/dsi: Fix some reference counted resource leaks
      mtd: rawnand: cafe: Fix a resource leak in the error handling path of 'cafe_nand_probe()'

Colin Ian King (2):
      Bluetooth: increase BTNAMSIZ to 21 chars to fix potential buffer overflow
      parport: remove non-zero check on count

Cyrill Gorcunov (1):
      prctl: allow to setup brk for et_dyn executables

Damien Le Moal (1):
      libata: fix ata_host_start()

Dan Carpenter (4):
      bnx2x: fix an error code in bnx2x_nic_load()
      Bluetooth: sco: prevent information leak in sco_conn_defer_accept()
      ath6kl: wmi: fix an error code in ath6kl_wmi_sync_point()
      thermal/drivers/exynos: Fix an error code in exynos_tmu_probe()

Daniel Wagner (5):
      Merge tag 'v4.4.280' into v4.4-rt
      futex: fixup wait_lock/pi_lock locking rule changes
      Linux 4.4.280-rt225
      Merge tag 'v4.4.285' into v4.4-rt
      Linux 4.4.285-rt226

Daniele Palmas (1):
      USB: serial: option: add Telit FD980 composition 0x1056

Dave Gerlach (1):
      ARM: dts: am43x-epos-evm: Reduce i2c0 bus speed for tps65218

David Bauer (1):
      USB: serial: ftdi_sio: add device ID for Auto-M3 OP-COM v2

David Heidelberg (1):
      ARM: 9105/1: atags_to_fdt: don't warn about stack size

Denis Efremov (1):
      Revert "floppy: reintroduce O_NDELAY fix"

Desmond Cheong Zhi Xi (5):
      hfs: add missing clean-up in hfs_fill_super
      hfs: fix high memory mapping in hfs_bnode_read
      hfs: add lock nesting notation to hfs_find_init
      Bluetooth: fix repeated calls to sco_sock_kill
      Bluetooth: skip invalid hci_sync_conn_complete_evt

Ding Hui (1):
      cifs: fix wrong release in sess_alloc_buffer() failed path

Dinghao Liu (2):
      net: qlcnic: add missed unlock in qlcnic_83xx_flash_read32
      qlcnic: Remove redundant unlock in qlcnic_pinit_from_rom

Dmitry Osipenko (1):
      rtc: tps65910: Correct driver module alias

Dongliang Mu (3):
      ipack: tpci200: fix many double free issues in tpci200_pci_probe
      media: dvb-usb: fix uninit-value in dvb_usb_adapter_dvb_init
      media: dvb-usb: fix uninit-value in vp702x_read_mac_addr

Doug Anderson (1):
      mmc: dw_mmc: Wait for data transfer after response errors.

Douglas Anderson (1):
      mmc: dw_mmc: Fix occasional hang after tuning on eMMC

Eric Dumazet (3):
      ipv4: make exception cache less predictible
      net-caif: avoid user-triggerable WARN_ON(1)
      net/af_unix: fix a data-race in unix_dgram_poll

Esben Haabendal (1):
      net: ll_temac: Remove left-over debug message

Evgeny Novikov (1):
      usb: ehci-orion: Handle errors of clk_prepare_enable() in probe

Fangrui Song (1):
      powerpc/boot: Delete unneeded .globl _zimage_start

Florian Fainelli (1):
      r6040: Restore MDIO clock frequency after MAC reset

George Kennedy (1):
      fbmem: add margin check to fb_check_caps()

Giovanni Cabiddu (1):
      crypto: qat - do not ignore errors from enable_vf2pf_comms()

Goldwyn Rodrigues (1):
      btrfs: mark compressed range uptodate only if all bio succeed

Greg Kroah-Hartman (10):
      Linux 4.4.278
      Revert "Bluetooth: Shutdown controller after workqueues are flushed or cancelled"
      Linux 4.4.279
      Linux 4.4.280
      Linux 4.4.281
      i2c: dev: zero out array used for i2c reads from userspace
      Linux 4.4.283
      serial: 8250_pci: make setup_port() parameters explicitly unsigned
      Linux 4.4.284
      Linux 4.4.285

Grygorii Strashko (1):
      PM / wakeirq: Enable dedicated wakeirq for suspend

Guenter Roeck (2):
      parisc: Move pci_dev_is_behind_card_dino to where it is used
      drm/nouveau/nvkm: Replace -ENOSYS with -ENODEV

Gustavo A. R. Silva (1):
      ipv4: ip_output.c: Fix out-of-bounds warning in ip_copy_addrs()

H. Nikolaus Schaller (1):
      mips: Fix non-POSIX regexp

Hans Verkuil (1):
      media: videobuf2-core: dequeue if start_streaming fails

Hans de Goede (1):
      libata: add ATA_HORKAGE_NO_NCQ_TRIM for Samsung 860 and 870 SSDs

Harshvardhan Jha (1):
      scsi: megaraid_mm: Fix end of loop tests for list_for_each_entry()

Heiko Carstens (1):
      s390/jump_label: print real address in a case of a jump label bug

Hoang Le (2):
      tipc: fix sleeping in tipc accept routine
      tipc: increase timeout in tipc_sk_enqueue()

Hui Su (1):
      scripts/tracing: fix the bug that can't parse raw_trace_func

Ilya Leoshkevich (2):
      s390/bpf: Fix 64-bit subtraction of the -0x80000000 constant
      s390/bpf: Fix optimizing out zero-extensions

J. Bruce Fields (1):
      rpc: fix gss_svc_init cleanup on failure

Jaehoon Chung (1):
      mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default

Jan Kiszka (1):
      x86/asm: Ensure asm/proto.h can be included stand-alone

Jaroslav Kysela (1):
      ALSA: hda - fix the 'Capture Switch' value change notifications

Javier Martinez Canillas (1):
      usb: phy: isp1301: Fix build warning when CONFIG_OF is disabled

Jeff Layton (1):
      ceph: lockdep annotations for try_nonblocking_invalidate

Jens Axboe (1):
      net: split out functions related to registering inflight socket files

Jiapeng Chong (1):
      mlx4: Fix missing error code in mlx4_load_one()

Jiri Slaby (2):
      xtensa: ISS: don't panic in rs_init
      hvsi: don't panic on tty_register_driver failure

Johan Almbladh (2):
      bpf/tests: Fix copy-and-paste error in double word test
      bpf/tests: Do not PASS tests without actually testing the result

Johan Hovold (2):
      media: rtl28xxu: fix zero-length control request
      Revert "USB: serial: ch341: fix character loss at high transfer rates"

Johannes Berg (1):
      dmaengine: ioat: depends on !UML

Jonathan Cameron (1):
      iio: dac: ad5624r: Fix incorrect handling of an optional regulator.

Jouni Malinen (5):
      ath: Use safer key clearing with key cache entries
      ath9k: Clear key cache explicitly on disabling hardware
      ath: Export ath_hw_keysetmac()
      ath: Modify ath_key_delete() to not need full key entry
      ath9k: Postpone key cache entry deletion for TXQ frames reference it

Juergen Gross (1):
      xen: fix setting of max_pfn in shared_info

Junxiao Bi (2):
      ocfs2: fix zero out valid data
      ocfs2: issue zeroout to EOF blocks

Kai-Heng Feng (1):
      Bluetooth: Move shutdown callback before flushing tx and rx queue

Kelly Devilliv (1):
      usb: host: fotg210: fix the actual_length of an iso packet

Krzysztof Kozlowski (2):
      arm64: dts: exynos: correct GIC CPU interfaces address range on Exynos7
      power: supply: max17042: handle fails of reading status register

Krzysztof Wilczyński (1):
      PCI: Return ~0 data on pciconfig_read() CAP_SYS_ADMIN failure

Len Baker (1):
      CIFS: Fix a potencially linear read overflow

Letu Ren (1):
      net/qla3xxx: fix schedule while atomic in ql_wait_for_drvr_lock and ql_adapter_reset

Li Jinlin (1):
      blk-throttle: fix UAF by deleteing timer in blk_throtl_exit()

Li Manyi (1):
      scsi: sr: Return correct event when media event code is 3

Lin, Zhenpeng (1):
      dccp: don't duplicate ccid when cloning dccp sock

Linus Torvalds (1):
      vt_kdsetmode: extend console locking

Linus Walleij (1):
      clk: kirkwood: Fix a clocking boot regression

Liu Jian (1):
      igmp: Add ip_mc_list lock in ip_check_mc_rcu

Longfang Liu (1):
      USB:ehci:fix Kunpeng920 ehci hardware problem

Maciej W. Rozycki (3):
      serial: 8250: Mask out floating 16/32-bit bus bits
      MIPS: Malta: Do not byte-swap accesses to the CBUS UART
      serial: 8250: Define RX trigger levels for OxSemi 950 devices

Maciej Żenczykowski (1):
      usb: gadget: u_ether: fix a potential null pointer dereference

Marcelo Ricardo Leitner (3):
      sctp: validate chunk size in __rcv_asconf_lookup
      sctp: add param size validation for SCTP_PARAM_SET_PRIMARY
      sctp: validate from_addr_param return

Marco Chiappero (1):
      crypto: qat - fix reuse of completion variable

Marek Behún (2):
      PCI: Call Max Payload Size-related fixup quirks early
      PCI: Restrict ASMedia ASM1062 SATA Max Payload Size Supported

Marek Marczykowski-Górecki (1):
      PCI/MSI: Skip masking MSI-X on Xen PV

Martin KaFai Lau (1):
      tcp: seq_file: Avoid skipping sk during tcp_seek_last_pos

Mathias Nyman (1):
      Revert "USB: xhci: fix U1/U2 handling for hardware with XHCI_INTEL_HOST quirk set"

Mathieu Desnoyers (1):
      ipv4/icmp: l3mdev: Perform icmp error route lookup on source device routing table (v2)

Matthew Wilcox (1):
      lib/string.c: add multibyte memset functions

Mauro Carvalho Chehab (1):
      media: uvc: don't do DMA on stack

Maxim Kiselev (1):
      net: marvell: fix MVNETA_TX_IN_PRGRS bit number

Maxim Levitsky (1):
      KVM: nSVM: avoid picking up unsupported bits from L2 in int_ctl (CVE-2021-3653)

Maximilian Heyne (1):
      xen/events: Fix race in set_evtchn_to_irq

Michael Ellerman (1):
      powerpc/module64: Fix comment in R_PPC64_ENTRY handling

Mike Galbraith (1):
      futex: Handle transient "ownerless" rtmutex state correctly

Mike Rapoport (1):
      x86/mm: Fix kern_addr_valid() to cope with existing but not present entries

Miklos Szeredi (2):
      af_unix: fix garbage collect vs MSG_PEEK
      ovl: prevent private clone if bind mount is not allowed

Mikulas Patocka (1):
      parisc: fix crash with signals and alloca

Miquel Raynal (1):
      dt-bindings: mtd: gpmc: Fix the ECC bytes vs. OOB bytes equation

Muchun Song (1):
      mm/page_alloc: speed up the iteration of max_order

Nadezda Lutovinova (1):
      usb: gadget: mv_u3d: request_irq() after initializing UDC

Nanyong Sun (6):
      nilfs2: fix memory leak in nilfs_sysfs_create_device_group
      nilfs2: fix NULL pointer in nilfs_##name##_attr_release
      nilfs2: fix memory leak in nilfs_sysfs_create_##name##_group
      nilfs2: fix memory leak in nilfs_sysfs_delete_##name##_group
      nilfs2: fix memory leak in nilfs_sysfs_create_snapshot_group
      nilfs2: fix memory leak in nilfs_sysfs_delete_snapshot_group

Nathan Chancellor (1):
      vmlinux.lds.h: Handle clang's module.{c,d}tor sections

Neeraj Upadhyay (1):
      vringh: Use wiov->used to check for read/write desc order

Nguyen Dinh Phi (2):
      cfg80211: Fix possible memory leak in function cfg80211_bss_update
      tty: Fix data race between tiocsti() and flush_to_ldisc()

Ole Bjørn Midtbø (1):
      Bluetooth: hidp: use correct wait queue when removing ctrl_wait

Pablo Neira Ayuso (1):
      netfilter: nft_nat: allow to specify layer 4 protocol NAT only

Parav Pandit (1):
      virtio: Improve vq->broken access to avoid any compiler optimization

Patryk Duda (1):
      platform/chrome: cros_ec_proto: Send command again when timeout occurs

Paul Gortmaker (1):
      x86/reboot: Limit Dell Optiplex 990 quirk to early BIOS versions

Paul Jakma (1):
      NIU: fix incorrect error return, missed in previous revert

Pavel Skripkin (13):
      can: usb_8dev: fix memory leak
      can: ems_usb: fix memory leak
      can: esd_usb2: fix memory leak
      net: llc: fix skb_over_panic
      net: pegasus: fix uninit-value in get_interrupt_interval
      net: vxge: fix use-after-free in vxge_device_unregister
      net: 6pack: fix slab-out-of-bounds in decode_data
      media: stkwebcam: fix memory leak in stk_camera_probe
      m68k: emu: Fix invalid free in nfeth_cleanup()
      media: go7007: remove redundant initialization
      net: cipso: fix warnings in netlbl_cipsov4_add_std
      Bluetooth: add timeout sanity check to hci_inquiry
      profiling: fix shift-out-of-bounds bugs

Peter Ujfalusi (1):
      dmaengine: of-dma: router_xlate to return -EPROBE_DEFER if controller is not yet available

Peter Zijlstra (6):
      futex: Cleanup refcounting
      futex,rt_mutex: Introduce rt_mutex_init_waiter()
      futex: Pull rt_mutex_futex_unlock() out from under hb->lock
      futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()
      futex: Futex_unlock_pi() determinism
      futex,rt_mutex: Fix rt_mutex_cleanup_proxy_lock()

Philipp Zabel (1):
      tc358743: fix register i2c_rd/wr function fix

Prarit Bhargava (1):
      alpha: Send stop IPI to send to online CPUs

Pravin B Shelar (1):
      net: Fix zero-copy head len calculation.

Qu Wenruo (1):
      Revert "btrfs: compression: don't try to compress if we don't have enough pages"

Rafael J. Wysocki (2):
      PCI: PM: Enable PME if it can be signaled from D3cold
      PCI: Use pci_update_current_state() in pci_enable_device_flags()

Randy Dunlap (6):
      x86/tools: Fix objdump version check again
      dccp: add do-while-0 stubs for dccp_pr_debug macros
      xtensa: fix kconfig unmet dependency warning for HAVE_FUTEX_CMPXCHG
      openrisc: don't printk() unconditionally
      ptp: dp83640: don't define PAGE0
      ARC: export clear_user_page() for modules

Russell King (1):
      ARM: ensure the signal page contains defined contents

Sasha Levin (1):
      Linux 4.4.282

Sasha Neftin (1):
      e1000e: Fix the max snoop/no-snoop latency for 10M

Sean Anderson (2):
      crypto: mxs-dcp - Check for DMA mapping errors
      crypto: mxs-dcp - Use sg_mapping_iter to copy data

Sean Young (1):
      media: rc-loopback: return number of emitters rather than error

Sebastian Krzyszkowiak (1):
      power: supply: max17042_battery: fix typo in MAx17042_TOFF

Sergey Shtylyov (9):
      i2c: highlander: add IRQ check
      usb: gadget: udc: at91: add IRQ check
      usb: phy: fsl-usb: add IRQ check
      usb: phy: twl6030: add IRQ checks
      usb: host: ohci-tmio: add IRQ check
      usb: phy: tahvo: add IRQ check
      i2c: iop3xx: fix deferred probing
      i2c: s3c2410: fix IRQ check
      i2c: mt65xx: fix IRQ check

Shai Malin (1):
      qede: Fix memset corruption

Shreyansh Chouhan (1):
      reiserfs: check directory items on read from disk

Sreekanth Reddy (1):
      scsi: core: Avoid printing an error if target_alloc() returns -ENXIO

Stefan Berger (1):
      certs: Trigger creation of RSA module signing key if it's not an RSA key

Stefan Mätje (1):
      can: usb: esd_usb2: esd_usb2_rx_event(): fix the interchange of the CAN RX and TX error counters

Stian Skjelstad (1):
      udf_get_extendedattr() had no boundary checks.

Sudeep Holla (1):
      ARM: dts: versatile: Fix up interrupt controller node names

Takashi Iwai (4):
      r8152: Fix potential PM refcount imbalance
      ALSA: seq: Fix racy deletion of subscriber
      ASoC: intel: atom: Fix reference to PCM buffer address
      ASoC: intel: atom: Fix breakage for PCM buffer address setup

Takeshi Misawa (1):
      net: Fix memory leak in ieee802154_raw_deliver

Tetsuo Handa (2):
      Bluetooth: defer cleanup of resources in hci_unregister_dev()
      fbmem: don't allow too huge resolutions

Theodore Ts'o (1):
      ext4: fix race writing to an inline_data file while its xattrs are changing

Thomas Gleixner (11):
      futex: Rename free_pi_state() to put_pi_state()
      rtmutex: Make wait_lock irq safe
      futex: Avoid freeing an active timer
      PCI/MSI: Enable and mask MSI-X early
      PCI/MSI: Do not set invalid bits in MSI mask
      PCI/MSI: Correct misleading comments
      PCI/MSI: Use msi_mask_irq() in pci_msi_shutdown()
      PCI/MSI: Protect msi_desc::masked for multi-MSI
      PCI/MSI: Mask all unused MSI-X entries
      PCI/MSI: Enforce that MSI-X table entry is masked for update
      PCI/MSI: Enforce MSI[X] entry updates to be visible

Thomas Hebb (1):
      mmc: rtsx_pci: Fix long reads when clock is prescaled

Tianjia Zhang (1):
      Smack: Fix wrong semantics in smk_access_entry()

Tom Rix (1):
      USB: serial: mos7720: improve OOM-handling in read_mos_reg()

Tony Lindgren (4):
      crypto: omap-sham - clear dma flags only after omap_sham_update_dma_stop()
      mmc: dw_mmc: Fix issue with uninitialized dma_slave_config
      mmc: moxart: Fix issue with uninitialized dma_slave_config
      PM / wakeirq: Fix unbalanced IRQ enable for wakeirq

Tuo Li (1):
      gpu: drm: amd: amdgpu: amdgpu_i2c: fix possible uninitialized-variable access in amdgpu_i2c_router_select_ddc_port()

Vasily Gorbik (1):
      s390/disassembler: correct disassembly lines alignment

Vincent Whitchurch (1):
      mmc: dw_mmc: Fix hang on data CRC error

Vineet Gupta (1):
      ARC: fix allnoconfig build warning

Wang Hai (4):
      tulip: windbond-840: Fix missing pci_disable_device() in probe and remove
      sis900: Fix missing pci_disable_device() in probe and remove
      net: natsemi: Fix missing pci_disable_device() in probe and remove
      VMCI: fix NULL pointer dereference when unmapping queue pair

Willy Tarreau (1):
      USB: serial: ch341: fix character loss at high transfer rates

Xie Yongji (1):
      9p/trans_virtio: Remove sysfs file on probe failure

Xin Long (1):
      sctp: move 198 addresses from unusable to private scope

Xiyu Yang (1):
      net/l2tp: Fix reference count leak in l2tp_udp_recv_core

Yajun Deng (1):
      netlink: Deal with ESRCH error in nlmsg_notify()

Yang Li (1):
      ethtool: Fix an error code in cxgb2.c

Yang Yingliang (3):
      workqueue: fix UAF in pwq_unbound_release_workfn()
      net/802/mrp: fix memleak in mrp_request_join()
      net/802/garp: fix memleak in garp_request_join()

Yoshihiro Shimoda (1):
      net: renesas: sh_eth: Fix freeing wrong tx descriptor

Yu Kuai (2):
      reiserfs: add check for root_inode in reiserfs_fill_super
      dmaengine: usb-dmac: Fix PM reference leak in usb_dmac_probe()

YueHaibing (1):
      net: xilinx_emaclite: Do not print real IOMEM pointer

Zekun Shen (1):
      ath9k: fix OOB read ar9300_eeprom_restore_internal

Zelin Deng (1):
      KVM: x86: Update vCPU's hv_clock before back to guest when tsc_offset is adjusted

Zenghui Yu (1):
      bcma: Fix memory leak for internally-handled cores

Zhen Lei (1):
      pinctrl: single: Fix error return code in pcs_parse_bits_in_pinctrl_entry()

Zhengjun Zhang (1):
      USB: serial: option: add new VID/PID to support Fibocom FG150

Zheyu Ma (6):
      pcmcia: i82092: fix a null pointer dereference bug
      video: fbdev: kyro: fix a DoS bug by restricting user input
      tty: serial: jsm: hold port lock when reporting modem line changes
      video: fbdev: asiliantfb: Error out if 'pixclock' equals zero
      video: fbdev: kyro: Error out if 'pixclock' equals zero
      video: fbdev: riva: Error out if 'pixclock' equals zero

Ziyang Xuan (1):
      can: raw: raw_setsockopt(): fix raw_rcv panic for sock UAF

Zubin Mithra (1):
      ALSA: pcm: fix divide error in snd_pcm_lib_ioctl

王贇 (1):
      net: fix NULL pointer reference in cipso_v4_doi_free
