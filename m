Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C07C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74338613C7
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhGITGl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 15:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGITGk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 15:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B666613C3;
        Fri,  9 Jul 2021 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625857436;
        bh=pHoHsr7lcHzQYjHiYrQ99Wmvbur5xHuF9tkOt7EXlSA=;
        h=Subject:From:To:Date:From;
        b=d4A1AHKPgyBKRwwPd0ffSOFMuH/JEpKMuNLYHG5WE2B+NSduEEzltkw4UgWzVdN6Y
         +j774U0AHfMJToAO7co8p4YPuuwd2seaHih8DhVAKqFWBZ15WKY97ljZebez2VeORz
         F3s5QpCd7UZbhg7IUpsW07hjSIoITYxE8E2S2KjlfLQkWMCpn2xHffIs/0qT9gEXjp
         ukuazLxh224FmJ0/tSzBsd7F24h1NAVARL9VAUPtxpDmgLqYShz6F7Uk0Fz7wK+oQo
         bMjPn/QT4RGHtTqHteb9VsG3XaZiY18gckGD5NzYswxtMTGBdm6BaUveYb+BXSh+ix
         Fa+OaQ2/X8vew==
Message-ID: <979e1cdb3e8d203aeffa5b39c12819bae07c78e5.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.129-rt61
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 09 Jul 2021 14:03:54 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.129-rt61 stable release.

This release is just an update to the new stable 5.4.129
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 33e9529e6dac0748a6a38712158ec0f8124dd0f9

Or to build 5.4.129-rt61 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.129.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.129-rt61.patch.xz

Enjoy!

   Tom

Changes from v5.4.123-rt59:
---

Adrian Hunter (5):
      perf intel-pt: Fix sample instruction bytes
      perf intel-pt: Fix transaction abort handling
      perf scripts python: exported-sql-viewer.py: Fix copy to clipboard from Top Calls by elapsed Time report
      perf scripts python: exported-sql-viewer.py: Fix Array TypeError
      perf scripts python: exported-sql-viewer.py: Fix warning display

Ahelenia Ziemiańska (2):
      HID: multitouch: require Finger field to mark Win8 reports as MT
      HID: multitouch: set Stylus suffix for Stylus-application devices, too

Alaa Emad (2):
      media: dvb: Add check on sp8870_readreg return
      media: gspca: mt9m111: Check write_bridge for timeout

Alaa Hleihel (1):
      IB/mlx5: Fix initializing CQ fragments buffer

Alan Stern (1):
      USB: usbfs: Don't WARN about excessively large memory allocations

Aleksander Jan Bajkowski (3):
      net: lantiq: fix memory corruption in RX ring
      net: lantiq: disable interrupt before sheduling NAPI
      lantiq: net: fix duplicated skb in rx descriptor ring

Alex Shi (1):
      mm: add VM_WARN_ON_ONCE_PAGE() macro

Alexander Kuznetsov (1):
      cgroup1: don't allow '\n' in renaming

Alexander Usyskin (1):
      mei: request autosuspend after sending rx flow control

Alexandre GRIVEAUX (1):
      USB: serial: omninet: add device id for Zyxel Omni 56K Plus

Anand Jain (1):
      btrfs: fix unmountable seed device after fstrim

Anant Thazhemadam (1):
      nl80211: validate key indexes for cfg80211_registered_device

Andreas Gruenbacher (1):
      gfs2: Prevent direct-I/O write fallback errors from getting lost

Andrew Lunn (1):
      usb: core: hub: Disable autosuspend for Cypress CY7C65632

Andrew Morton (1):
      mm/slub.c: include swab.h

Andy Gospodarek (1):
      bnxt_en: Include new P5 HV definition in VF check.

Andy Shevchenko (2):
      platform/x86: intel_punit_ipc: Append MODULE_DEVICE_TABLE for ACPI
      usb: typec: wcove: Use LE to CPU conversion when accessing msg->header

Anirudh Rayabharam (3):
      net: fujitsu: fix potential null-ptr-deref
      ath6kl: return error code in ath6kl_wmi_set_roam_lrssi_cmd()
      HID: usbhid: fix info leak in hid_submit_ctrl

Anna Schumaker (2):
      NFSv4: Fix a NULL pointer dereference in pnfs_mark_matching_lsegs_return()
      NFS: Fix use-after-free in nfs4_init_client()

Antti Järvinen (1):
      PCI: Mark TI C667X to avoid bus reset

Ariel Levkovich (1):
      net/sched: act_ct: Fix ct template allocation for zone 0

Armin Wolf (1):
      hwmon: (dell-smm-hwmon) Fix index values

Arnaldo Carvalho de Melo (1):
      tools headers UAPI: Sync linux/in.h copy with the kernel sources

Arnd Bergmann (2):
      HID: i2c-hid: fix format string mismatch
      ARM: 9081/1: fix gcc-10 thumb2-kernel regression

Arvind Sankar (1):
      x86/boot: Add .text.* to setup.ld

Atul Gopinathan (1):
      serial: max310x: unregister uart driver in case of failure and abort

Aurelien Aptel (1):
      cifs: set server->cipher_type to AES-128-CCM for SMB3.0

Austin Kim (1):
      net: ethtool: clear heap allocations for ethtool function

Avraham Stern (1):
      cfg80211: avoid double free of PMSR request

Axel Lin (1):
      regulator: bd70528: Fix off-by-one for buck123 .n_voltages setting

Aya Levin (1):
      net/mlx5e: Block offload of outer header csum for UDP tunnels

Bindu Ramamurthy (1):
      drm/amd/display: Allow bandwidth validation for 0 streams.

Bixuan Cui (1):
      HID: gt683r: add missing MODULE_DEVICE_TABLE

Bjorn Andersson (1):
      usb: typec: mux: Fix copy-paste mistake in typec_mux_match

Boris Burkov (1):
      btrfs: return whole extents in fiemap

Brett Creeley (1):
      ice: Fix VFR issues for AVF drivers that expect ATQLEN cleared

Bumyong Lee (1):
      dmaengine: pl330: fix wrong usage of spinlock flags in dma_cyclc

Carlos M (1):
      ALSA: hda: Fix for mute key LED for HP Pavilion 15-CK0xx

Catherine Sullivan (2):
      gve: Check TX QPL was actually assigned
      gve: Upgrade memory barrier in poll routine

Changbin Du (1):
      net: make get_net_ns return error if NET_NS is disabled

Chen Li (1):
      radeon: use memcpy_to/fromio for UVD fw upload

Chengyang Fan (1):
      net: ipv4: fix memory leak in ip_mc_add1_src

Chinmay Agarwal (1):
      neighbour: Prevent Race condition in neighbour subsytem

Chiqijun (1):
      PCI: Work around Huawei Intelligent NIC VF FLR erratum

Chris Packham (4):
      powerpc/fsl: set fsl,i2c-erratum-a004447 flag for P2041 i2c controllers
      powerpc/fsl: set fsl,i2c-erratum-a004447 flag for P1010 i2c controllers
      i2c: mpc: Make use of i2c_recover_bus()
      i2c: mpc: implement erratum A-004447 workaround

Chris Park (1):
      drm/amd/display: Disconnect non-DP with no EDID

Christian Gmeiner (1):
      serial: 8250_pci: handle FL_NOIRQ board flag

Christian König (2):
      drm/nouveau: wait for moving fence after pinning v2
      drm/radeon: wait for moving fence after pinning

Christophe JAILLET (8):
      spi: spi-fsl-dspi: Fix a resource leak in an error handling path
      net: netcp: Fix an error message
      net: mdio: thunder: Fix a double free issue in the .remove function
      net: mdio: octeon: Fix some double free issues
      alx: Fix an error handling path in 'alx_probe()'
      qlcnic: Fix an error handling path in 'qlcnic_probe()'
      netxen_nic: Fix an error handling path in 'netxen_nic_probe()'
      be2net: Fix an error handling path in 'be_probe()'

Chunfeng Yun (1):
      usb: core: reduce power-on-good delay time of root hub

Chunyan Zhang (1):
      spi: sprd: Add missing MODULE_DEVICE_TABLE

Coco Li (1):
      ipv6: Fix KASAN: slab-out-of-bounds Read in fib6_nh_flush_exceptions

Colin Ian King (1):
      serial: tegra: Fix a mask operation that is always true

DENG Qingfang (1):
      net: dsa: mt7530: fix VLAN traffic leaks

Dai Ngo (1):
      NFSv4: nfs4_proc_set_acl needs to restore NFS_CAP_UIDGID_NOMAP on error.

Dan Carpenter (9):
      NFS: fix an incorrect limit in filelayout_decode_layout()
      net: dsa: fix a crash if ->get_sset_count() fails
      net: hso: check for allocation failure in hso_create_bulk_serial_device()
      staging: emxx_udc: fix loop in _nbu2ss_nuke()
      ASoC: cs35l33: fix an error code in probe()
      scsi: libsas: Use _safe() loop in sas_resume_port()
      net: mdiobus: get rid of a BUG_ON()
      NFS: Fix a potential NULL dereference in nfs_get_client()
      afs: Fix an IS_ERR() vs NULL check

Dan Robertson (1):
      net: ieee802154: fix null deref in parse dev addr

Daniel Wagner (1):
      scsi: qedf: Do not put host in qedf_vport_create() unconditionally

Daniele Palmas (1):
      USB: serial: option: add Telit LE910-S1 compositions 0x7010, 0x7011

Dave Ertman (1):
      ice: Allow all LLDP packets from PF to Tx

David Ahern (1):
      neighbour: allow NUD_NOARP entries to be forced GCed

David Awogbemila (3):
      gve: Update mgmt_msix_idx if num_ntfy changes
      gve: Add NULL pointer checks when freeing irqs.
      gve: Correct SKB queue index validation.

Davide Caratti (1):
      net/mlx5e: allow TSO on VXLAN over VLAN topologies

Desmond Cheong Zhi Xi (2):
      drm: Fix use-after-free read in drm_getunique()
      drm: Lock pointer access in drm_master_release()

Dima Chumak (3):
      net/mlx5e: Fix multipath lag activation
      net/mlx5e: Fix nullptr in add_vlan_push_action()
      net/mlx5e: Fix page reclaim for dead peer hairpin

Dinghao Liu (1):
      usb: cdns3: Fix runtime PM imbalance on error

Dmitry Baryshkov (1):
      regulator: core: resolve supply for boot-on/always-on regulators

Dmitry Bogdanov (1):
      scsi: target: qla2xxx: Wait for stop_phase1 at WWN removal

Dmitry Osipenko (1):
      regulator: max77620: Use device_set_of_node_from_dev()

Dmitry Torokhov (1):
      HID: hid-input: add mapping for emoji picker key

Dominik Andreas Schorpp (1):
      USB: serial: ftdi_sio: add IDs for IDS GmbH Products

Dongliang Mu (2):
      misc/uss720: fix memory leak in uss720_probe
      net: usb: fix possible use-after-free in smsc75xx_bind

Du Cheng (2):
      net: caif: remove BUG_ON(dev == NULL) in caif_xmit
      cfg80211: call cfg80211_leave_ocb when switching away from OCB

Eric Auger (1):
      KVM: arm/arm64: Fix KVM_VGIC_V3_ADDR_TYPE_REDIST read

Eric Dumazet (4):
      net/af_unix: fix a data-race in unix_dgram_sendmsg / unix_release_sock
      inet: annotate date races around sk->sk_txhash
      net/packet: annotate accesses to po->bind
      net/packet: annotate accesses to po->ifindex

Eric Farman (2):
      vfio-ccw: Check initialized flag in cp_init()
      vfio-ccw: Serialize FSM IDLE state with I/O completion

Eric Snowberg (2):
      certs: Add EFI_CERT_X509_GUID support for dbx entries
      certs: Move load_system_certificate_list to a common function

Erik Kaneda (1):
      ACPICA: Clean up context mutex during object deletion

Esben Haabendal (4):
      net: ll_temac: Make sure to free skb when it is completely used
      net: ll_temac: Fix TX BD buffer overwrite
      net: ll_temac: Add memory-barriers for TX BD access
      net: ll_temac: Avoid ndo_start_xmit returning NETDEV_TX_BUSY

Ewan D. Milne (1):
      scsi: scsi_devinfo: Add blacklist entry for HPE OPEN-V

Fabien Dessenne (1):
      pinctrl: stm32: fix the reported number of GPIO lines per bank

Fabio Estevam (2):
      ARM: dts: imx7d-meerkat96: Fix the 'tuning-step' property
      ARM: dts: imx7d-pico: Fix the 'tuning-step' property

Felix Fietkau (1):
      perf jevents: Fix getting maximum number of fds

Florian Westphal (1):
      netfilter: conntrack: unregister ipv4 sockopts on error unwind

Francesco Ruggeri (1):
      ipv6: record frag_max_size in atomic fragments in input path

Fuad Tabba (1):
      KVM: selftests: Fix kvm_check_cap() assertion

Fugang Duan (2):
      net: fec: fix the potential memory leak in fec_enet_init()
      net: fec_ptp: add clock rate zero check

Gao Xiang (1):
      lib/lz4: explicitly support in-place decompression

Geert Uytterhoeven (3):
      serial: sh-sci: Fix off-by-one error in FIFO threshold register setting
      i2c: sh_mobile: Use new clock calculation formulas for RZ/G2E
      ARM: dts: imx: emcon-avari: Fix nxp,pca8574 #gpio-cells

Geoffrey D. Bennett (2):
      ALSA: usb-audio: scarlett2: Fix device hang with ehci-pci
      ALSA: usb-audio: scarlett2: Improve driver startup messages

George McCollister (2):
      net: dsa: microchip: enable phy errata workaround on 9567
      USB: serial: ftdi_sio: add NovaTech OrionMX product ID

Grant Grundler (1):
      net: usb: cdc_ncm: don't spew notifications

Greg Kroah-Hartman (31):
      kgdb: fix gcc-11 warnings harder
      Revert "media: usb: gspca: add a missed check for goto_low_power"
      Revert "ALSA: sb: fix a missing check of snd_ctl_add"
      Revert "serial: max310x: pass return value of spi_register_driver"
      Revert "net: fujitsu: fix a potential NULL pointer dereference"
      Revert "net/smc: fix a NULL pointer dereference"
      Revert "char: hpet: fix a missing check of ioremap"
      Revert "ALSA: gus: add a check of the status of snd_ctl_add"
      Revert "ALSA: usx2y: Fix potential NULL pointer dereference"
      Revert "isdn: mISDNinfineon: fix potential NULL pointer dereference"
      Revert "ath6kl: return error code in ath6kl_wmi_set_roam_lrssi_cmd()"
      Revert "isdn: mISDN: Fix potential NULL pointer dereference of kzalloc"
      Revert "dmaengine: qcom_hidma: Check for driver register failure"
      Revert "libertas: add checks for the return value of sysfs_create_group"
      libertas: register sysfs groups properly
      Revert "ASoC: cs43130: fix a NULL pointer dereference"
      ASoC: cs43130: handle errors in cs43130_probe() properly
      Revert "media: dvb: Add check on sp8870_readreg"
      Revert "media: gspca: mt9m111: Check write_bridge for timeout"
      Revert "media: gspca: Check the return value of write_bridge for timeout"
      media: gspca: properly check for errors in po1030_probe()
      Revert "net: liquidio: fix a NULL pointer dereference"
      Revert "brcmfmac: add a check for the status of usb_register"
      brcmfmac: properly check for bus register errors
      i915: fix build warning in intel_dp_get_link_status()
      Revert "Revert "ALSA: usx2y: Fix potential NULL pointer dereference""
      Linux 5.4.124
      Linux 5.4.125
      Linux 5.4.126
      Linux 5.4.127
      Linux 5.4.128

Guillaume Ranquet (3):
      dmaengine: mediatek: free the proper desc in desc_free handler
      dmaengine: mediatek: do not issue a new desc if one is still current
      dmaengine: mediatek: use GFP_NOWAIT instead of GFP_ATOMIC in prep_dma

Haibo Chen (1):
      spi: spi-nxp-fspi: move the register operation after the clock enable

Hannes Reinecke (4):
      nvme-fabrics: decode host pathing error for connect
      nvme-loop: reset queue count to 1 in nvme_loop_destroy_io_queues()
      nvme-loop: clear NVME_LOOP_Q_LIVE when nvme_loop_configure_admin_queue() fails
      nvme-loop: check for NVME_LOOP_Q_LIVE in nvme_loop_destroy_admin_queue()

Hans de Goede (2):
      ASoC: Intel: bytcr_rt5640: Add quirk for the Glavey TM800A550L tablet
      ASoC: Intel: bytcr_rt5640: Add quirk for the Lenovo Miix 3-830 tablet

Heiner Kallweit (1):
      efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to be cleared

Hillf Danton (1):
      gfs2: Fix use-after-free in gfs2_glock_shrink_scan

Hoang Le (3):
      Revert "net:tipc: Fix a double free in tipc_sk_mcast_rcv"
      tipc: add extack messages for bearer/media failure
      tipc: fix unique bearer names sanity check

Hugh Dickins (16):
      mm/thp: fix __split_huge_pmd_locked() on shmem migration entry
      mm/thp: make is_huge_zero_pmd() safe and quicker
      mm/thp: try_to_unmap() use TTU_SYNC for safe splitting
      mm/thp: fix vma_address() if virtual address below file offset
      mm/thp: unmap_mapping_page() to fix THP truncate_cleanup_page()
      mm: page_vma_mapped_walk(): use page for pvmw->page
      mm: page_vma_mapped_walk(): settle PageHuge on entry
      mm: page_vma_mapped_walk(): use pmde for *pvmw->pmd
      mm: page_vma_mapped_walk(): prettify PVMW_MIGRATION block
      mm: page_vma_mapped_walk(): crossing page table boundary
      mm: page_vma_mapped_walk(): add a level of indentation
      mm: page_vma_mapped_walk(): use goto instead of while (1)
      mm: page_vma_mapped_walk(): get vma_address_end() earlier
      mm/thp: fix page_vma_mapped_walk() if THP mapped by ptes
      mm/thp: another PVMW_SYNC fix in page_vma_mapped_walk()
      mm, futex: fix shared futex pgoff on shmem huge page

Hui Wang (1):
      ALSA: hda/realtek: Headphone volume is controlled by Front mixer

Huy Nguyen (1):
      net/mlx5e: Remove dependency in IPsec initialization flows

Ido Schimmel (1):
      rtnetlink: Fix regression in bridge VLAN configuration

Jack Pham (1):
      usb: dwc3: debugfs: Add and remove endpoint dirs dynamically

Jack Yu (1):
      ASoC: rt5659: Fix the lost powers for the HDA header

Jakub Kicinski (1):
      ptp: improve max_adj check against unreasonable values

James Zhu (3):
      drm/amdgpu/vcn1: add cancel_delayed_work_sync before power gate
      drm/amdgpu/vcn2.0: add cancel_delayed_work_sync before power gate
      drm/amdgpu/vcn2.5: add cancel_delayed_work_sync before power gate

Jan Beulich (1):
      xen-pciback: redo VF placement in the virtual topology

Javed Hasan (1):
      scsi: bnx2fc: Return failure if io_req is already in ABTS processing

Jean Delvare (1):
      i2c: i801: Don't generate an interrupt on bus reset

Jeimon (1):
      net/nfc/rawsock.c: fix a permission check bug

Jesse Brandeburg (2):
      ixgbe: fix large MTU request from VF
      drivers/net/ethernet: clean up unused assignments

Jiapeng Chong (3):
      bnx2x: Fix missing error code in bnx2x_iov_init_one()
      ethernet: myri10ge: Fix missing error code in myri10ge_probe()
      rtnetlink: Fix missing error code in rtnl_bridge_notify()

Jim Ma (1):
      tls splice: check SPLICE_F_NONBLOCK instead of MSG_DONTWAIT

Jim Mattson (1):
      kvm: LAPIC: Restore guard to prevent illegal APIC register access

Jingwen Chen (1):
      drm/amd/amdgpu: fix refcount leak

Jisheng Zhang (1):
      net: stmmac: dwmac1000: Fix extended MAC address registers definition

Joakim Zhang (2):
      net: fec_ptp: fix issue caused by refactor the fec_devtype
      net: stmmac: disable clocks in stmmac_remove_config_dt()

Johan Hovold (6):
      net: hso: fix control-request directions
      USB: trancevibrator: fix control-request direction
      net: hso: bail out on interrupt URB allocation failure
      HID: magicmouse: fix NULL-deref on disconnect
      USB: serial: quatech2: fix control-request directions
      i2c: robotfuzz-osif: fix control-request directions

Johannes Berg (11):
      mac80211: drop A-MSDUs on old ciphers
      mac80211: add fragment cache to sta_info
      mac80211: check defrag PN against current frame
      mac80211: prevent attacks on TKIP/WEP as well
      mac80211: do not accept/forward invalid EAPOL frames
      bonding: init notify_work earlier to avoid uninitialized use
      netlink: disable IRQs for netlink_lock_table()
      cfg80211: make certificate generation more robust
      mac80211: remove warning in ieee80211_get_sband()
      mac80211_hwsim: drop pending frames on stop
      mac80211: drop multicast fragments

John Keeping (1):
      dm verity: fix require_signatures module_param permissions

Johnny Chuang (1):
      HID: i2c-hid: Skip ELAN power-on command after reset

Jonathan Cameron (3):
      iio: adc: ad7768-1: Fix too small buffer passed to iio_push_to_buffers_with_timestamp()
      iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
      iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers

Josef Bacik (6):
      btrfs: do not BUG_ON in link_to_fixup_dir
      btrfs: tree-checker: do not error out if extent ref hash doesn't match
      btrfs: mark ordered extent and inode with error if we fail to finish
      btrfs: fix error handling in btrfs_del_csums
      btrfs: return errors from btrfs_del_csums in cleanup_ref_head
      btrfs: fixup error handling in fixup_inode_link_counts

Josh Triplett (1):
      net: ipconfig: Don't override command-line hostnames or domains

Jue Wang (1):
      mm/thp: fix page_address_in_vma() on file THP tails

Julian Anastasov (1):
      ipvs: ignore IP_VS_SVC_F_HASHED flag when adding service

Junxiao Bi (1):
      ocfs2: fix data corruption by fallocate

Jussi Maki (1):
      bpf: Set mac_len in bpf_skb_change_head

Kai-Heng Feng (1):
      platform/x86: hp_accel: Avoid invoking _INI to speed up resume

Kamal Heib (1):
      RDMA/ipoib: Fix warning caused by destroying non-initial netns

Kees Cook (8):
      proc: Check /proc/$pid/attr/ writes against file opener
      proc: Track /proc/$pid/attr/ opener mm_struct
      mm/slub: clarify verification reporting
      mm/slub: fix redzoning for small allocations
      r8152: Avoid memcpy() over-reading of ETH_SS_STATS
      sh_eth: Avoid memcpy() over-reading of ETH_SS_STATS
      r8169: Avoid memcpy() over-reading of ETH_SS_STATS
      net: qed: Fix memcpy() overflow of qed_dcbx_params()

Khem Raj (1):
      riscv: Use -mno-relax when using lld linker

Krzysztof Kozlowski (2):
      i2c: s3c2410: fix possible NULL pointer deref on read message after write
      nfc: fix NULL ptr dereference in llcp_sock_getname() after failed connect

Kyle Tso (1):
      usb: pd: Set PD_T_SINK_WAIT_CAP to 310ms

Lang Yu (1):
      drm/amd/amdgpu: fix a potential deadlock in gpu reset

Leo Yan (1):
      perf session: Correct buffer copying when peeking events

Liangyan (1):
      tracing: Correct the length check which causes memory corruption

Lin Ma (2):
      Bluetooth: fix the erroneous flush_work() order
      Bluetooth: use correct lock to prevent UAF of hdev object

Linus Torvalds (2):
      drm/i915/display: fix compiler warning about array overrun
      proc: only require mm_struct for writing

Linyu Yuan (2):
      usb: gadget: eem: fix wrong eem header operation
      net: cdc_eem: fix tx fixup skb leak

Luben Tuikov (1):
      drm/amdgpu: Don't query CE and UE errors

Lucas Stach (1):
      arm64: dts: zii-ultra: fix 12V_MAIN voltage

Lucas Stankus (1):
      staging: iio: cdc: ad7746: avoid overwrite of num_channels

Lukas Wunner (3):
      spi: spi-geni-qcom: Fix use-after-free on unbind
      spi: Cleanup on failure of initial setup
      spi: bcm2835: Fix out-of-bounds access with more than 4 slaves

Maciej Żenczykowski (5):
      USB: f_ncm: ncm_bitrate (speed) is unsigned
      usb: f_ncm: only first packet of aggregate needs to start timer
      usb: fix various gadgets null ptr deref on 10gbps cabling.
      usb: fix various gadget panics on 10gbps cabling
      net: cdc_ncm: switch to eth%d interface naming

Magnus Karlsson (3):
      ixgbevf: add correct exception tracing for XDP
      i40e: optimize for XDP_REDIRECT in xsk path
      i40e: add correct exception tracing for XDP

Maor Gottlieb (1):
      net/mlx5: Consider RoCE cap before init RDMA resources

Marc Zyngier (1):
      KVM: arm64: Fix debug register indexing

Marcelo Ricardo Leitner (1):
      net/sched: act_ct: handle DNAT tuple collision

Marco Elver (1):
      perf: Fix data race between pin_count increment/decrement

Marco Felsch (1):
      ASoC: max98088: fix ni clock divider calculation

Marek Vasut (1):
      ARM: dts: imx6q-dhcom: Add PU,VDD1P1,VDD2P5 regulators

Marian-Cristian Rotariu (1):
      usb: dwc3: ep0: fix NULL pointer exception

Mark Bolhuis (1):
      HID: Add BUS_VIRTUAL to hid_connect logging

Mark Rutland (1):
      pid: take a reference when initializing `cad_pid`

Mathias Nyman (1):
      thunderbolt: dma_port: Fix NVM read buffer bounds and offset issue

Mathy Vanhoef (4):
      mac80211: assure all fragments are encrypted
      mac80211: prevent mixed key and fragment cache attacks
      mac80211: properly handle A-MSDUs that start with an RFC 1042 header
      cfg80211: mitigate A-MSDU aggregation attacks

Matt Wang (2):
      scsi: BusLogic: Fix 64-bit system enumeration error for Buslogic
      scsi: vmw_pvscsi: Set correct residual data length

Matthew Wilcox (Oracle) (4):
      mm: add thp_order
      XArray: add xa_get_order
      XArray: add xas_split
      mm/filemap: fix storing to a THP shadow entry

Maurizio Lombardi (1):
      scsi: target: core: Fix warning on realtime kernels

Max Gurtovoy (1):
      vfio/platform: fix module_put call in error flow

Maxim Mikityanskiy (2):
      netfilter: synproxy: Fix out of bounds when parsing TCP options
      sch_cake: Fix out of bounds when parsing TCP options and header

Mayank Rana (1):
      usb: typec: ucsi: Clear PPM capability data in ucsi_init() error path

Miaohe Lin (2):
      mm/rmap: remove unneeded semicolon in page_not_mapped()
      mm/rmap: use page_not_mapped in try_to_unmap()

Michael Chan (2):
      bnxt_en: Remove the setting of dev_port.
      bnxt_en: Rediscover PHY capabilities after firmware reset

Michael Ellerman (3):
      selftests/gpio: Use TEST_GEN_PROGS_EXTENDED
      selftests/gpio: Move include of lib.mk up
      selftests/gpio: Fix build when source tree is read only

Michael Walle (1):
      arm64: dts: ls1028a: fix memory node

Michal Vokáč (1):
      ARM: dts: imx6dl-yapp4: Fix RGMII connection to QCA8334 switch

Mikel Rychliski (1):
      PCI: Add AMD RS690 quirk to enable 64-bit DMA

Mikulas Patocka (1):
      dm snapshot: properly fix a crash when an origin has no snapshots

Mimi Zohar (1):
      module: limit enabling module.sig_enforce

Mina Almasry (1):
      mm, hugetlb: fix simple resv_huge_pages underflow on UFFDIO_COPY

Ming Lei (4):
      scsi: core: Fix error handling of scsi_host_alloc()
      scsi: core: Fix failure handling of scsi_add_host_with_dma()
      scsi: core: Put .shost_dev in failure path if host state changes to RUNNING
      scsi: core: Only put parent device if host state differs from SHOST_CREATED

Mitch Williams (1):
      ice: write register with correct offset

Nanyong Sun (1):
      net: ipv4: fix memory leak in netlbl_cipsov4_add_std

Nathan Chancellor (2):
      vmlinux.lds.h: Avoid orphan section with !SMP
      MIPS: generic: Update node names to avoid unit addresses

Nayna Jain (2):
      certs: Add wrapper function to check blacklisted binary hash
      x86/efi: move common keyring handler functions to new file

Neil Armstrong (2):
      drm/meson: fix shutdown crash when component not probed
      mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk

Nicholas Piggin (1):
      KVM: do not allow mapping valid but non-reference-counted pages

Nick Desaulniers (1):
      arm64: link with -z norelro for LLD or aarch64-elf

Nicolas Dichtel (1):
      vrf: fix maximum MTU

Nikolay Aleksandrov (2):
      net: bridge: fix vlan tunnel dst null pointer dereference
      net: bridge: fix vlan tunnel dst refcnt when egressing

Nikolay Borisov (1):
      btrfs: promote debugging asserts to full-fledged checks in validate_super

Nirenjan Krishnan (1):
      HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for Saitek X65

Nirmoy Das (1):
      drm/amdgpu: make sure we unpin the UVD BO

Norbert Slusarek (1):
      can: bcm: fix infoleak in struct bcm_msg_head

Oleksij Rempel (1):
      can: j1939: fix Use-after-Free, hold skb ref while in use

Ondrej Mosnacek (1):
      serial: core: fix suspicious security_locked_down() call

Pablo Neira Ayuso (2):
      netfilter: nft_ct: skip expectations for confirmed conntrack
      netfilter: nfnetlink_cthelper: hit EBUSY on updates if size mismatches

Pali Rohár (1):
      PCI: aardvark: Fix kernel panic during PIO transfer

Paolo Abeni (2):
      net: really orphan skbs tied to closing sk
      udp: fix race between close() and udp_abort()

Paolo Bonzini (2):
      kvm: avoid speculation-based attacks from out-of-range memslot accesses
      kvm: fix previous commit for 32-bit builds

Patrice Chotard (1):
      spi: stm32-qspi: Always wait BUSY bit to be cleared in stm32_qspi_wait_cmd()

Pavel Machek (1):
      cxgb4: fix wrong shift.

Pavel Machek (CIP) (1):
      drm/tegra: sor: Do not leak runtime PM reference

Pavel Skripkin (12):
      net: usb: fix memory leak in smsc75xx_bind
      net: caif: added cfserl_release function
      net: caif: add proper error handling
      net: caif: fix memory leak in caif_device_notify
      net: caif: fix memory leak in cfusbl_device_notify
      net: rds: fix memory leak in rds_recvmsg
      net: qrtr: fix OOB Read in qrtr_endpoint_post
      net: hamradio: fix memory leak in mkiss_close
      net: ethernet: fix potential use-after-free in ec_bhf_remove
      can: mcba_usb: fix memory leak in mcba_usb
      net: caif: fix memory leak in ldisc_open
      nilfs2: fix memory leak in nilfs_sysfs_delete_device_group

Peter Chen (1):
      usb: dwc3: core: fix kernel panic when do reboot

Peter Zijlstra (2):
      openrisc: Define memory barrier mb
      recordmcount: Correct st_shndx handling

Petr Mladek (2):
      kthread_worker: split code for canceling the delayed work timer
      kthread: prevent deadlock when kthread_mod_delayed_work() races with kthread_cancel_delayed_work_sync()

Phil Elwell (1):
      usb: dwc2: Fix build in periphal-only mode

Phillip Potter (3):
      isdn: mISDNinfineon: check/cleanup ioremap failure correctly in setup_io
      isdn: mISDN: correctly handle ph_info allocation failure in hfcsusb_ph_info
      dmaengine: qcom_hidma: comment platform_driver_register call

Pierre-Louis Bossart (1):
      ALSA: usb: update old-style static const declaration

Praneeth Bajjuri (1):
      net: phy: dp83867: perform soft reset and retain established link

Rafael J. Wysocki (1):
      Revert "PCI: PM: Do not read power state in pci_enable_device_flags()"

Raju Rangoju (1):
      cxgb4: avoid accessing registers when clearing filters

Randy Dunlap (5):
      MIPS: alchemy: xxs1500: add gpio-au1000.h header file
      MIPS: ralink: export rt_sysc_membase for rt2880_wdt.c
      vfio/pci: zap_vma_ptes() needs MMU
      dmaengine: ALTERA_MSGDMA depends on HAS_IOMEM
      dmaengine: QCOM_HIDMA_MGMT depends on HAS_IOMEM

Randy Wright (1):
      serial: 8250_pci: Add support for new HPE serial device

Rao Shoaib (1):
      RDS tcp loopback connection can hang

Rasmus Villemoes (1):
      efi: cper: fix snprintf() use in cper_dimm_err_location()

Remi Pommarel (1):
      PCI: aardvark: Don't rely on jiffies while holding spinlock

Richard Fitzgerald (1):
      ASoC: cs42l42: Regmap must use_single_read/write

Ritesh Harjani (1):
      btrfs: return value from btrfs_mark_extent_written() in case of error

Riwen Lu (1):
      hwmon: (scpi-hwmon) shows the negative temperature properly

Roja Rani Yarubandi (2):
      i2c: qcom-geni: Add shutdown callback for i2c
      i2c: qcom-geni: Suspend and resume the bus during SYSTEM_SLEEP_PM ops

Rolf Eike Beer (1):
      iommu/vt-d: Fix sysfs leak in alloc_iommu()

Rui Miguel Silva (1):
      iio: gyro: fxas21002c: balance runtime power in error path

Saeed Mirzamohammadi (1):
      HID: quirks: Add quirk for Lenovo optical mouse

Sagi Grimberg (1):
      nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME

Sami Tolvanen (1):
      kbuild: add CONFIG_LD_IS_LLD

Saravana Kannan (2):
      spi: Fix spi device unregister flow
      spi: Don't have controller clean up spi device before driver unbind

Sargun Dhillon (1):
      Documentation: seccomp: Fix user notification documentation

Sasha Levin (1):
      Linux 5.4.129

Saubhik Mukherjee (1):
      net: appletalk: cops: Fix data race in cops_probe1

Sean Christopherson (3):
      KVM: SVM: Truncate GPR value for DR and CR accesses in !64-bit mode
      KVM: x86: Ensure liveliness of nested VM-Enter fail tracepoint message
      KVM: x86: Immediately reset the MMU context when the SMM flag is cleared

Sean MacLennan (1):
      USB: serial: ti_usb_3410_5052: add startech.com device id

Sergey Senozhatsky (1):
      wq: handle VM suspension in stall detection

Sergio Paracuellos (1):
      pinctrl: ralink: rt2880: avoid to error in calls is pin is already enabled

Shakeel Butt (1):
      cgroup: disable controllers at parse time

Shanker Donthineni (1):
      PCI: Mark some NVIDIA GPUs to avoid bus reset

Shay Drory (1):
      RDMA/mlx4: Do not map the core_clock page to user space unless enabled

Shyam Sundar S K (1):
      platform/x86: hp-wireless: add AMD's hardware id to the supported list

Somnath Kotur (1):
      bnxt_en: Call bnxt_ethtool_free() in bnxt_init_one() error path

Sriharsha Basavapatna (1):
      PCI: Add ACS quirk for Broadcom BCM57414 NIC

Srinivas Pandruvada (2):
      thermal/drivers/intel: Initialize RW trip to THERMAL_TEMP_INVALID
      HID: hid-sensor-hub: Return error for hid_set_field() failure

Sriram R (1):
      ath10k: Validate first subframe of A-MSDU before processing the list

Stefan Agner (1):
      USB: serial: cp210x: fix alternate function for CP2102N QFN20

Stefan Roese (1):
      net: ethernet: mtk_eth_soc: Fix packet statistics support for MT7628/88

Steve French (1):
      SMB3: incorrect file id in requests compounded with open

Steven Rostedt (VMware) (4):
      ftrace: Do not blindly read the ip address in ftrace_bug()
      tracing: Do not stop recording cmdlines when tracing is off
      tracing: Do not stop recording comms if the trace file is being read
      tracing: Do no increment trace_clock_global() by one

Sven Eckelmann (1):
      batman-adv: Avoid WARN_ON timing related checks

Taehee Yoo (2):
      mld: fix panic in mld_newpack()
      sch_dsmark: fix a NULL deref in qdisc_reset()

Takashi Iwai (1):
      ALSA: timer: Fix master timer notification

Tao Liu (1):
      openvswitch: meter: fix race when getting now_ms.

Teava Radu (1):
      platform/x86: touchscreen_dmi: Add info for the Mediacom Winpad 7.0 W700 tablet

Tetsuo Handa (1):
      can: bcm/raw/isotp: use per module netdevice notifier

Thadeu Lima de Souza Cascardo (1):
      Bluetooth: cmtp: fix file refcount when cmtp_attach_device fails

Thinh Nguyen (1):
      usb: dwc3: gadget: Properly track pending and queued SG

Thomas Gleixner (4):
      x86/apic: Mark _all_ legacy interrupts when IO/APIC is missing
      x86/process: Check PF_KTHREAD and not current->mm for kernel threads
      x86/pkru: Write hardware init value to PKRU when xstate is init
      x86/fpu: Reset state for all signal restore failures

Thomas Petazzoni (1):
      usb: musb: fix MUSB_QUIRK_B_DISCONNECT_99 handling

Tiezhu Yang (1):
      MIPS: Fix kernel hang under FUNCTION_GRAPH_TRACER and PREEMPT_TRACER

Toke Høiland-Jørgensen (1):
      icmp: don't send out ICMP messages with a source address of 0.0.0.0

Tom Seewald (2):
      char: hpet: add checks after calling ioremap
      net: liquidio: Add missing null pointer checks

Tom Zanussi (4):
      Merge tag 'v5.4.124' into v5.4-rt
      Linux 5.4.124-rt60
      Merge tag 'v5.4.129' into v5.4-rt
      Linux 5.4.129-rt61

Tony Lindgren (4):
      bus: ti-sysc: Fix flakey idling of uarts and stop using swsup_sidle_act
      clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support
      clocksource/drivers/timer-ti-dm: Prepare to handle dra7 timer wrap issue
      clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940

Trond Myklebust (4):
      NFS: Fix an Oopsable condition in __nfs_pageio_add_request()
      NFS: Don't corrupt the value of pg_bytes_written in nfs_do_recoalesce()
      NFSv4: Fix deadlock between nfs4_evict_inode() and nfs4_opendata_get_inode()
      NFSv4: Fix second deadlock in nfs4_evict_inode()

Vincent Guittot (1):
      sched/fair: Make sure to update tg contrib for blocked load

Vineet Gupta (1):
      ARCv2: save ABI registers across signal handling

Vitaly Kuznetsov (3):
      x86/kvm: Teardown PV features on boot CPU as well
      x86/kvm: Disable kvmclock on all CPUs on shutdown
      x86/kvm: Disable all PV features on crash

Vladimir Oltean (2):
      net: dsa: sja1105: error out on unsupported PHY mode
      net: dsa: fix error code getting shifted with 4 in dsa_slave_get_sset_count

Vladyslav Tarasiuk (1):
      net/mlx4: Fix EEPROM dump support

Wei Yongjun (2):
      samples: vfio-mdev: fix error handing in mdpy_fb_probe()
      ieee802154: fix error return code in ieee802154_llsec_getparams()

Wen Gong (6):
      mac80211: extend protection against mixed key and fragment cache attacks
      ath10k: add CCMP PN replay protection for fragmented frames for PCIe
      ath10k: drop fragments with multicast DA for PCIe
      ath10k: drop fragments with multicast DA for SDIO
      ath10k: drop MPDU which has discard flag set by firmware for SDIO
      ath10k: Fix TKIP Michael MIC verification for PCIe

Wenli Looi (1):
      staging: rtl8723bs: Fix uninitialized variables

Wesley Cheng (1):
      usb: gadget: f_fs: Ensure io_completion_wq is idle during unbind

Xin Long (2):
      tipc: wait and exit until all work queues are done
      tipc: skb_linearize the head skb when reassembling msgs

Xu Yu (1):
      mm, thp: use head page in __migration_entry_wait()

Yang Shi (1):
      mm: thp: replace DEBUG_VM BUG with VM_WARN when unmap fails for split

Yang Yingliang (2):
      scsi: hisi_sas: Drop free_irq() of devm_request_irq() allocated irq
      dmaengine: stedma40: add missing iounmap() on error in d40_probe()

Ye Bin (1):
      ext4: fix bug on in ext4_es_cache_extent as ext4_split_extent_at failed

Yifan Zhang (4):
      drm/amdgpu/gfx10: enlarge CP_MEC_DOORBELL_RANGE_UPPER to cover full doorbell.
      drm/amdgpu/gfx9: fix the doorbell missing when in CGPG issue.
      Revert "drm/amdgpu/gfx9: fix the doorbell missing when in CGPG issue."
      Revert "drm/amdgpu/gfx10: enlarge CP_MEC_DOORBELL_RANGE_UPPER to cover full doorbell."

Yongqiang Liu (1):
      ARM: OMAP2+: Fix build warning when mmc_omap is not built

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: Fix a race in usb3_start_pipen()

Yu Kuai (1):
      dmaengine: zynqmp_dma: Fix PM reference leak in zynqmp_dma_alloc_chan_resourc()

YueHaibing (1):
      iio: adc: ad7793: Add missing error code in ad7793_setup()

Yunsheng Lin (4):
      net: sched: fix packet stuck problem for lockless qdisc
      net: sched: fix tx action rescheduling issue during deactivation
      net: sched: fix tx action reschedule issue with stopped queue
      net: hns3: check the return of skb_checksum_help()

Zhang Xiaoxu (1):
      NFSv4: Fix v4.0/v4.1 SEEK_DATA return -ENOTSUPP when set NFS_V4_2 config

Zhen Lei (4):
      net: bnx2: Fix error return code in bnx2_init_board()
      vfio/pci: Fix error return code in vfio_ecap_init()
      HID: pidff: fix error return code in hid_pidff_init()
      ieee802154: fix error return code in ieee802154_add_iface()

Zheng Yongjun (5):
      net/x25: Return the correct errno code
      net: Return the correct errno code
      fib: Return the correct errno code
      net: ipv4: Remove unneed BUG() function
      ping: Check return value of function 'ping_queue_rcv_skb'

Zheyu Ma (3):
      serial: rp2: use 'request_firmware' instead of 'request_firmware_nowait'
      isdn: mISDN: netjet: Fix crash in nj_probe:
      net/qla3xxx: fix schedule while atomic in ql_sem_spinlock

Zolton Jheng (1):
      USB: serial: pl2303: add device id for ADLINK ND-6530 GC

Zong Li (1):
      net: macb: ensure the device is available before accessing GEMGXL control registers

Zou Wei (3):
      gpio: cadence: Add missing MODULE_DEVICE_TABLE
      ASoC: sti-sas: add missing MODULE_DEVICE_TABLE
      dmaengine: rcar-dmac: Fix PM reference leak in rcar_dmac_probe()

afzal mohammed (1):
      ARM: OMAP: replace setup_irq() by request_irq()

kernel test robot (1):
      ALSA: usb-audio: scarlett2: snd_scarlett_gen2_controls_create() can be static

xinhui pan (1):
      drm/amdgpu: Fix a use-after-free

yangerkun (1):
      mm/memory-failure: make sure wait for page writeback in memory_failure

zhouchuangao (1):
      fs/nfs: Use fatal_signal_pending instead of signal_pending
---
Documentation/core-api/xarray.rst                  |  16 +-
 Documentation/userspace-api/seccomp_filter.rst     |  16 +-
 Documentation/vm/slub.rst                          |  10 +-
 Makefile                                           |   2 +-
 arch/arc/include/uapi/asm/sigcontext.h             |   1 +
 arch/arc/kernel/signal.c                           |  43 +++++
 arch/arm/boot/dts/dra7-l4.dtsi                     |   4 +-
 arch/arm/boot/dts/dra7.dtsi                        |  20 ++
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi         |   6 +-
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi             |  12 ++
 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi         |   2 +-
 arch/arm/boot/dts/imx7d-meerkat96.dts              |   2 +-
 arch/arm/boot/dts/imx7d-pico.dtsi                  |   2 +-
 arch/arm/kernel/setup.c                            |  16 +-
 arch/arm/mach-omap1/pm.c                           |  13 +-
 arch/arm/mach-omap1/time.c                         |  10 +-
 arch/arm/mach-omap1/timer32k.c                     |  10 +-
 arch/arm/mach-omap2/board-generic.c                |   4 +-
 arch/arm/mach-omap2/board-n8x0.c                   |   2 +-
 arch/arm/mach-omap2/timer.c                        | 181 ++++++++++++------
 arch/arm64/Makefile                                |  10 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |   4 +-
 .../arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi |   4 +-
 arch/arm64/kvm/sys_regs.c                          |  42 ++---
 arch/mips/alchemy/board-xxs1500.c                  |   1 +
 arch/mips/generic/board-boston.its.S               |  10 +-
 arch/mips/generic/board-ni169445.its.S             |  10 +-
 arch/mips/generic/board-ocelot.its.S               |  20 +-
 arch/mips/generic/board-xilfpga.its.S              |  10 +-
 arch/mips/generic/vmlinux.its.S                    |  10 +-
 arch/mips/lib/mips-atomic.c                        |  12 +-
 arch/mips/ralink/of.c                              |   2 +
 arch/openrisc/include/asm/barrier.h                |   9 +
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi        |   8 +
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  16 ++
 arch/riscv/Makefile                                |   9 +
 arch/x86/boot/setup.ld                             |   2 +-
 arch/x86/include/asm/apic.h                        |   1 +
 arch/x86/include/asm/fpu/internal.h                |  13 +-
 arch/x86/include/asm/kvm_para.h                    |  10 +-
 arch/x86/kernel/apic/apic.c                        |   1 +
 arch/x86/kernel/apic/vector.c                      |  20 ++
 arch/x86/kernel/fpu/signal.c                       |  26 +--
 arch/x86/kernel/kvm.c                              |  92 ++++++---
 arch/x86/kernel/kvmclock.c                         |  26 +--
 arch/x86/kvm/lapic.c                               |   3 +
 arch/x86/kvm/svm.c                                 |   8 +-
 arch/x86/kvm/trace.h                               |   6 +-
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/pci/fixup.c                               |  44 +++++
 certs/Kconfig                                      |   9 +
 certs/Makefile                                     |   2 +-
 certs/blacklist.c                                  |  52 ++++++
 certs/blacklist.h                                  |   2 +
 certs/common.c                                     |  57 ++++++
 certs/common.h                                     |   9 +
 certs/system_keyring.c                             |  55 +-----
 drivers/acpi/acpica/utdelete.c                     |   8 +
 drivers/bus/ti-sysc.c                              |   4 +-
 drivers/char/hpet.c                                |   2 +
 drivers/clk/ti/clk-7xx.c                           |   1 +
 drivers/dma/Kconfig                                |   1 +
 drivers/dma/mediatek/mtk-uart-apdma.c              |  27 +--
 drivers/dma/pl330.c                                |   6 +-
 drivers/dma/qcom/Kconfig                           |   1 +
 drivers/dma/qcom/hidma_mgmt.c                      |  17 +-
 drivers/dma/sh/rcar-dmac.c                         |   2 +-
 drivers/dma/ste_dma40.c                            |   3 +
 drivers/dma/xilinx/zynqmp_dma.c                    |   2 +-
 drivers/firmware/efi/cper.c                        |   4 +-
 drivers/firmware/efi/memattr.c                     |   5 -
 drivers/gpio/gpio-cadence.c                        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |  16 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |   1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |   6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  18 ++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   2 +-
 drivers/gpu/drm/drm_auth.c                         |   3 +-
 drivers/gpu/drm/drm_ioctl.c                        |   9 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  15 +-
 drivers/gpu/drm/meson/meson_drv.c                  |   9 +-
 drivers/gpu/drm/nouveau/nouveau_prime.c            |  17 +-
 drivers/gpu/drm/radeon/radeon_prime.c              |  16 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |   4 +-
 drivers/gpu/drm/tegra/sor.c                        |  14 +-
 drivers/hid/hid-core.c                             |   3 +
 drivers/hid/hid-debug.c                            |   1 +
 drivers/hid/hid-gt683r.c                           |   1 +
 drivers/hid/hid-ids.h                              |   2 +
 drivers/hid/hid-input.c                            |   3 +
 drivers/hid/hid-magicmouse.c                       |   2 +-
 drivers/hid/hid-multitouch.c                       |  18 +-
 drivers/hid/hid-quirks.c                           |   2 +
 drivers/hid/hid-sensor-hub.c                       |  13 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  13 +-
 drivers/hid/usbhid/hid-core.c                      |   2 +-
 drivers/hid/usbhid/hid-pidff.c                     |   1 +
 drivers/hwmon/dell-smm-hwmon.c                     |   4 +-
 drivers/hwmon/scpi-hwmon.c                         |   9 +
 drivers/i2c/busses/i2c-i801.c                      |   6 +-
 drivers/i2c/busses/i2c-mpc.c                       |  95 +++++++++-
 drivers/i2c/busses/i2c-qcom-geni.c                 |  21 ++-
 drivers/i2c/busses/i2c-robotfuzz-osif.c            |   4 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |   3 +
 drivers/i2c/busses/i2c-sh_mobile.c                 |   2 +-
 drivers/iio/adc/ad7124.c                           |  36 ++--
 drivers/iio/adc/ad7768-1.c                         |   8 +-
 drivers/iio/adc/ad7793.c                           |   1 +
 drivers/iio/gyro/fxas21002c_core.c                 |   2 +
 drivers/infiniband/hw/mlx4/main.c                  |   5 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   9 +-
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c       |   1 +
 drivers/iommu/dmar.c                               |   4 +-
 drivers/isdn/hardware/mISDN/hfcsusb.c              |  17 +-
 drivers/isdn/hardware/mISDN/mISDNinfineon.c        |  21 ++-
 drivers/isdn/hardware/mISDN/netjet.c               |   1 -
 drivers/md/dm-snap.c                               |   2 +-
 drivers/md/dm-verity-verify-sig.c                  |   2 +-
 drivers/media/dvb-frontends/sp8870.c               |   2 +-
 drivers/media/usb/gspca/cpia1.c                    |   6 +-
 drivers/media/usb/gspca/m5602/m5602_mt9m111.c      |  16 +-
 drivers/media/usb/gspca/m5602/m5602_po1030.c       |  14 +-
 drivers/misc/kgdbts.c                              |   3 +-
 drivers/misc/lis3lv02d/lis3lv02d.h                 |   1 +
 drivers/misc/mei/interrupt.c                       |   3 +
 drivers/mmc/host/meson-gx-mmc.c                    |  50 ++++-
 drivers/net/appletalk/cops.c                       |   4 +-
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/caif/caif_serial.c                     |   2 +-
 drivers/net/can/usb/mcba_usb.c                     |  17 +-
 drivers/net/dsa/microchip/ksz9477.c                |   1 +
 drivers/net/dsa/mt7530.c                           |   8 -
 drivers/net/dsa/sja1105/sja1105_main.c             |   1 +
 drivers/net/ethernet/atheros/alx/main.c            |   1 +
 drivers/net/ethernet/broadcom/bnx2.c               |   2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  10 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |   7 +-
 drivers/net/ethernet/cadence/macb_main.c           |   3 +
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |  27 ++-
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c |  27 ++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c  |   4 +-
 drivers/net/ethernet/dec/tulip/de4x5.c             |   4 +-
 drivers/net/ethernet/dec/tulip/media.c             |   5 -
 drivers/net/ethernet/ec_bhf.c                      |   4 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   1 +
 drivers/net/ethernet/freescale/fec_main.c          |  11 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |   8 +-
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c          |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  21 ++-
 drivers/net/ethernet/google/gve/gve_tx.c           |   8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  15 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   5 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c   |  14 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  16 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   3 +
 drivers/net/ethernet/lantiq_xrx200.c               |  17 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  67 ++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |  24 ++-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c            |   3 +
 drivers/net/ethernet/mellanox/mlx4/fw.h            |   1 +
 drivers/net/ethernet/mellanox/mlx4/main.c          |   6 +
 drivers/net/ethernet/mellanox/mlx4/port.c          | 107 ++++++++++-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   3 -
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag_mp.c   |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c     |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/transobj.c |  30 ++-
 drivers/net/ethernet/micrel/ksz884x.c              |   3 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   6 +-
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |   1 +
 drivers/net/ethernet/neterion/vxge/vxge-traffic.c  |  32 ++--
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |   2 +
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c         |   4 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |   1 +
 drivers/net/ethernet/realtek/r8169_main.c          |   2 +-
 drivers/net/ethernet/renesas/sh_eth.c              |   2 +-
 drivers/net/ethernet/sfc/falcon/farch.c            |  29 ++-
 drivers/net/ethernet/sis/sis900.c                  |   5 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |   8 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   2 +
 drivers/net/ethernet/synopsys/dwc-xlgmac-common.c  |   2 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   5 +-
 drivers/net/ethernet/ti/netcp_core.c               |   2 +-
 drivers/net/ethernet/ti/tlan.c                     |   4 +-
 drivers/net/ethernet/via/via-velocity.c            |  13 --
 drivers/net/ethernet/xilinx/ll_temac_main.c        |  27 ++-
 drivers/net/hamradio/mkiss.c                       |   1 +
 drivers/net/phy/dp83867.c                          |   6 +-
 drivers/net/phy/mdio-octeon.c                      |   2 -
 drivers/net/phy/mdio-thunder.c                     |   1 -
 drivers/net/phy/mdio_bus.c                         |   3 +-
 drivers/net/usb/cdc_eem.c                          |   2 +-
 drivers/net/usb/cdc_ncm.c                          |  14 +-
 drivers/net/usb/hso.c                              |  45 +++--
 drivers/net/usb/r8152.c                            |   2 +-
 drivers/net/usb/smsc75xx.c                         |  12 +-
 drivers/net/vrf.c                                  |   6 +-
 drivers/net/wireless/ath/ath10k/htt.h              |   1 +
 drivers/net/wireless/ath/ath10k/htt_rx.c           | 201 +++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/rx_desc.h          |  14 +-
 drivers/net/wireless/ath/ath6kl/debug.c            |   5 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |   8 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |  19 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  42 ++---
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   9 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.h    |   5 -
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |   8 +-
 drivers/net/wireless/mac80211_hwsim.c              |   5 +
 drivers/net/wireless/marvell/libertas/mesh.c       |  33 +---
 drivers/nvme/host/Kconfig                          |   3 +-
 drivers/nvme/host/fabrics.c                        |   5 +
 drivers/nvme/target/loop.c                         |   5 +-
 drivers/pci/controller/pci-aardvark.c              |  59 ++++--
 drivers/pci/pci.c                                  |  16 +-
 drivers/pci/quirks.c                               |  89 +++++++++
 drivers/pinctrl/stm32/pinctrl-stm32.c              |   9 +-
 drivers/platform/x86/hp-wireless.c                 |   2 +
 drivers/platform/x86/hp_accel.c                    |  22 ++-
 drivers/platform/x86/intel_punit_ipc.c             |   1 +
 drivers/platform/x86/touchscreen_dmi.c             |   8 +
 drivers/ptp/ptp_clock.c                            |   6 +-
 drivers/regulator/core.c                           |   6 +
 drivers/regulator/max77620-regulator.c             |   7 +
 drivers/s390/cio/vfio_ccw_cp.c                     |   4 +
 drivers/s390/cio/vfio_ccw_drv.c                    |  12 +-
 drivers/scsi/BusLogic.c                            |   6 +-
 drivers/scsi/BusLogic.h                            |   2 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |   1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   8 +-
 drivers/scsi/hosts.c                               |  47 ++---
 drivers/scsi/libsas/sas_port.c                     |   4 +-
 drivers/scsi/qedf/qedf_main.c                      |  20 +-
 drivers/scsi/qla2xxx/qla_target.c                  |   2 +
 drivers/scsi/scsi_devinfo.c                        |   1 +
 drivers/scsi/vmw_pvscsi.c                          |   8 +-
 drivers/spi/spi-bcm2835.c                          |  10 +-
 drivers/spi/spi-bitbang.c                          |  18 +-
 drivers/spi/spi-fsl-dspi.c                         |   4 +-
 drivers/spi/spi-fsl-spi.c                          |   4 +
 drivers/spi/spi-geni-qcom.c                        |   3 +-
 drivers/spi/spi-nxp-fspi.c                         |  11 +-
 drivers/spi/spi-omap-uwire.c                       |   9 +-
 drivers/spi/spi-omap2-mcspi.c                      |  39 ++--
 drivers/spi/spi-pxa2xx.c                           |   9 +-
 drivers/spi/spi-sprd.c                             |   1 +
 drivers/spi/spi-stm32-qspi.c                       |   5 +-
 drivers/spi/spi.c                                  |  20 +-
 drivers/staging/emxx_udc/emxx_udc.c                |   4 +-
 drivers/staging/iio/cdc/ad7746.c                   |   1 -
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c    |   2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   2 +-
 drivers/target/target_core_transport.c             |   4 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c   |   4 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |   2 +-
 drivers/thunderbolt/dma_port.c                     |  11 +-
 drivers/tty/serial/8250/8250_pci.c                 |  47 +++--
 drivers/tty/serial/max310x.c                       |   2 +
 drivers/tty/serial/rp2.c                           |  52 ++----
 drivers/tty/serial/serial-tegra.c                  |   2 +-
 drivers/tty/serial/serial_core.c                   |   8 +-
 drivers/tty/serial/sh-sci.c                        |   4 +-
 drivers/usb/cdns3/gadget.c                         |   4 +-
 drivers/usb/core/devio.c                           |  11 +-
 drivers/usb/core/hub.c                             |   7 +
 drivers/usb/core/hub.h                             |   6 +-
 drivers/usb/dwc2/core_intr.c                       |   4 +
 drivers/usb/dwc3/core.c                            |   2 +-
 drivers/usb/dwc3/debug.h                           |   3 +
 drivers/usb/dwc3/debugfs.c                         |  21 +--
 drivers/usb/dwc3/ep0.c                             |   3 +
 drivers/usb/dwc3/gadget.c                          |  16 +-
 drivers/usb/gadget/config.c                        |   8 +
 drivers/usb/gadget/function/f_ecm.c                |   2 +-
 drivers/usb/gadget/function/f_eem.c                |   6 +-
 drivers/usb/gadget/function/f_fs.c                 |   3 +
 drivers/usb/gadget/function/f_hid.c                |   3 +-
 drivers/usb/gadget/function/f_loopback.c           |   2 +-
 drivers/usb/gadget/function/f_ncm.c                |  10 +-
 drivers/usb/gadget/function/f_printer.c            |   3 +-
 drivers/usb/gadget/function/f_rndis.c              |   2 +-
 drivers/usb/gadget/function/f_serial.c             |   2 +-
 drivers/usb/gadget/function/f_sourcesink.c         |   3 +-
 drivers/usb/gadget/function/f_subset.c             |   2 +-
 drivers/usb/gadget/function/f_tcm.c                |   3 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   5 +-
 drivers/usb/misc/trancevibrator.c                  |   4 +-
 drivers/usb/misc/uss720.c                          |   1 +
 drivers/usb/musb/musb_core.c                       |   3 +-
 drivers/usb/serial/cp210x.c                        |  20 +-
 drivers/usb/serial/ftdi_sio.c                      |   4 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   8 +
 drivers/usb/serial/omninet.c                       |   2 +
 drivers/usb/serial/option.c                        |   4 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/quatech2.c                      |   6 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |   3 +
 drivers/usb/typec/mux.c                            |   2 +-
 drivers/usb/typec/tcpm/wcove.c                     |   2 +-
 drivers/usb/typec/ucsi/ucsi.c                      |   1 +
 drivers/vfio/pci/Kconfig                           |   1 +
 drivers/vfio/pci/vfio_pci_config.c                 |   2 +-
 drivers/vfio/platform/vfio_platform_common.c       |   2 +-
 drivers/xen/xen-pciback/vpci.c                     |  14 +-
 fs/afs/main.c                                      |   4 +-
 fs/btrfs/disk-io.c                                 |  26 ++-
 fs/btrfs/extent-tree.c                             |  12 +-
 fs/btrfs/extent_io.c                               |   7 +-
 fs/btrfs/file-item.c                               |  10 +-
 fs/btrfs/file.c                                    |   4 +-
 fs/btrfs/inode.c                                   |  12 ++
 fs/btrfs/tree-checker.c                            |  16 +-
 fs/btrfs/tree-log.c                                |  15 +-
 fs/cifs/smb2pdu.c                                  |  13 +-
 fs/ext4/extents.c                                  |  43 +++--
 fs/gfs2/file.c                                     |   5 +-
 fs/gfs2/glock.c                                    |   2 +-
 fs/nfs/client.c                                    |   2 +-
 fs/nfs/filelayout/filelayout.c                     |   2 +-
 fs/nfs/nfs4_fs.h                                   |   1 +
 fs/nfs/nfs4client.c                                |   2 +-
 fs/nfs/nfs4file.c                                  |   2 +-
 fs/nfs/nfs4proc.c                                  |  33 +++-
 fs/nfs/pagelist.c                                  |  21 +--
 fs/nfs/pnfs.c                                      |  15 +-
 fs/nilfs2/sysfs.c                                  |   1 +
 fs/ocfs2/file.c                                    |  55 +++++-
 fs/proc/base.c                                     |  13 ++
 include/asm-generic/vmlinux.lds.h                  |   1 +
 include/keys/system_keyring.h                      |  21 +++
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/hid.h                                |   3 +-
 include/linux/huge_mm.h                            |  27 ++-
 include/linux/hugetlb.h                            |  16 --
 include/linux/kvm_host.h                           |  10 +-
 include/linux/mfd/rohm-bd70528.h                   |   4 +-
 include/linux/mlx4/device.h                        |   1 +
 include/linux/mlx5/transobj.h                      |   1 +
 include/linux/mm.h                                 |   3 +
 include/linux/mmdebug.h                            |  13 ++
 include/linux/pagemap.h                            |  13 +-
 include/linux/ptp_clock_kernel.h                   |   2 +-
 include/linux/rmap.h                               |   3 +-
 include/linux/socket.h                             |   2 -
 include/linux/usb/pd.h                             |   2 +-
 include/linux/usb/usbnet.h                         |   2 +
 include/linux/xarray.h                             |  22 +++
 include/net/caif/caif_dev.h                        |   2 +-
 include/net/caif/cfcnfg.h                          |   2 +-
 include/net/caif/cfserl.h                          |   1 +
 include/net/cfg80211.h                             |   4 +-
 include/net/net_namespace.h                        |   7 +
 include/net/pkt_sched.h                            |   7 +-
 include/net/sch_generic.h                          |  35 +++-
 include/net/sock.h                                 |  14 +-
 include/uapi/linux/in.h                            |   3 +
 include/uapi/linux/input-event-codes.h             |   1 +
 init/Kconfig                                       |   3 +
 init/main.c                                        |   2 +-
 kernel/cgroup/cgroup-v1.c                          |   4 +
 kernel/cgroup/cgroup.c                             |  13 +-
 kernel/events/core.c                               |   2 +
 kernel/futex.c                                     |   2 +-
 kernel/kthread.c                                   |  77 +++++---
 kernel/module.c                                    |  14 +-
 kernel/sched/fair.c                                |   2 +-
 kernel/trace/ftrace.c                              |   8 +-
 kernel/trace/trace.c                               |  13 +-
 kernel/trace/trace_clock.c                         |   6 +-
 kernel/workqueue.c                                 |  12 +-
 lib/lz4/lz4_decompress.c                           |   6 +-
 lib/lz4/lz4defs.h                                  |   2 +
 lib/test_xarray.c                                  |  65 +++++++
 lib/xarray.c                                       | 208 ++++++++++++++++++++-
 localversion-rt                                    |   2 +-
 mm/filemap.c                                       |  37 +++-
 mm/huge_memory.c                                   |  56 +++---
 mm/hugetlb.c                                       |  19 +-
 mm/internal.h                                      |  53 ++++--
 mm/memory-failure.c                                |   7 +-
 mm/memory.c                                        |  41 ++++
 mm/migrate.c                                       |   1 +
 mm/page_vma_mapped.c                               | 160 ++++++++++------
 mm/pgtable-generic.c                               |   4 +-
 mm/rmap.c                                          |  50 +++--
 mm/slab_common.c                                   |   3 +-
 mm/slub.c                                          |  23 ++-
 mm/truncate.c                                      |  43 ++---
 net/batman-adv/bat_iv_ogm.c                        |   4 +-
 net/bluetooth/cmtp/core.c                          |   5 +
 net/bluetooth/hci_core.c                           |   7 +-
 net/bluetooth/hci_sock.c                           |   4 +-
 net/bridge/br_private.h                            |   4 +-
 net/bridge/br_vlan_tunnel.c                        |  38 ++--
 net/caif/caif_dev.c                                |  13 +-
 net/caif/caif_usb.c                                |  14 +-
 net/caif/cfcnfg.c                                  |  16 +-
 net/caif/cfserl.c                                  |   5 +
 net/can/bcm.c                                      |  62 ++++--
 net/can/j1939/transport.c                          |  54 ++++--
 net/can/raw.c                                      |  62 ++++--
 net/compat.c                                       |   2 +-
 net/core/dev.c                                     |  29 ++-
 net/core/ethtool.c                                 |  10 +-
 net/core/fib_rules.c                               |   2 +-
 net/core/filter.c                                  |   1 +
 net/core/neighbour.c                               |   5 +
 net/core/net_namespace.c                           |  12 ++
 net/core/rtnetlink.c                               |   4 +
 net/core/sock.c                                    |   8 +-
 net/dsa/master.c                                   |   5 +-
 net/dsa/slave.c                                    |  12 +-
 net/ieee802154/nl-mac.c                            |   4 +-
 net/ieee802154/nl-phy.c                            |   4 +-
 net/ieee802154/nl802154.c                          |   9 +-
 net/ipv4/cipso_ipv4.c                              |   1 +
 net/ipv4/devinet.c                                 |   2 +-
 net/ipv4/icmp.c                                    |   7 +
 net/ipv4/igmp.c                                    |   1 +
 net/ipv4/ipconfig.c                                |  13 +-
 net/ipv4/ping.c                                    |  12 +-
 net/ipv4/udp.c                                     |  10 +
 net/ipv6/addrconf.c                                |   2 +-
 net/ipv6/mcast.c                                   |   3 -
 net/ipv6/reassembly.c                              |   4 +-
 net/ipv6/route.c                                   |   8 +-
 net/ipv6/udp.c                                     |   3 +
 net/mac80211/ieee80211_i.h                         |  38 ++--
 net/mac80211/iface.c                               |  11 +-
 net/mac80211/key.c                                 |   7 +
 net/mac80211/key.h                                 |   2 +
 net/mac80211/rx.c                                  | 157 ++++++++++++----
 net/mac80211/sta_info.c                            |   6 +-
 net/mac80211/sta_info.h                            |  32 ++++
 net/mac80211/wpa.c                                 |  13 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |   2 +-
 net/netfilter/nf_conntrack_proto.c                 |   2 +-
 net/netfilter/nf_synproxy_core.c                   |   5 +
 net/netfilter/nfnetlink_cthelper.c                 |   8 +-
 net/netfilter/nft_ct.c                             |   2 +-
 net/netlink/af_netlink.c                           |   6 +-
 net/nfc/llcp_sock.c                                |   2 +
 net/nfc/rawsock.c                                  |   2 +-
 net/openvswitch/meter.c                            |   8 +
 net/packet/af_packet.c                             |  32 ++--
 net/qrtr/qrtr.c                                    |   2 +-
 net/rds/connection.c                               |  23 ++-
 net/rds/recv.c                                     |   2 +-
 net/rds/tcp.c                                      |   4 +-
 net/rds/tcp.h                                      |   3 +-
 net/rds/tcp_listen.c                               |   6 +
 net/sched/act_ct.c                                 |  24 +--
 net/sched/sch_cake.c                               |   6 +-
 net/sched/sch_dsmark.c                             |   3 +-
 net/sched/sch_generic.c                            |  50 ++++-
 net/smc/smc_ism.c                                  |   5 -
 net/socket.c                                       |  13 --
 net/tipc/bearer.c                                  |  94 +++++++---
 net/tipc/core.c                                    |   3 +
 net/tipc/core.h                                    |   2 +
 net/tipc/msg.c                                     |   9 +-
 net/tipc/socket.c                                  |   5 +-
 net/tipc/udp_media.c                               |   2 +
 net/tls/tls_sw.c                                   |  11 +-
 net/unix/af_unix.c                                 |   7 +-
 net/wireless/Makefile                              |   2 +-
 net/wireless/core.h                                |   2 +
 net/wireless/nl80211.c                             |   7 +-
 net/wireless/pmsr.c                                |  16 +-
 net/wireless/util.c                                |  49 ++++-
 net/x25/af_x25.c                                   |   2 +-
 samples/vfio-mdev/mdpy-fb.c                        |  13 +-
 scripts/recordmcount.h                             |  15 +-
 security/integrity/Makefile                        |   3 +-
 .../integrity/platform_certs/keyring_handler.c     |  91 +++++++++
 .../integrity/platform_certs/keyring_handler.h     |  32 ++++
 security/integrity/platform_certs/load_uefi.c      |  67 +------
 sound/core/timer.c                                 |   3 +-
 sound/isa/gus/gus_main.c                           |  13 +-
 sound/isa/sb/sb16_main.c                           |  10 +-
 sound/pci/hda/patch_realtek.c                      |  24 +++
 sound/soc/codecs/cs35l33.c                         |   1 +
 sound/soc/codecs/cs42l42.c                         |   3 +
 sound/soc/codecs/cs43130.c                         |  28 ++-
 sound/soc/codecs/max98088.c                        |  13 +-
 sound/soc/codecs/rt5659.c                          |  26 ++-
 sound/soc/codecs/sti-sas.c                         |   1 +
 sound/soc/intel/boards/bytcr_rt5640.c              |  25 +++
 sound/usb/mixer_quirks.c                           |   4 +-
 sound/usb/mixer_scarlett_gen2.c                    |  81 +++++---
 sound/usb/mixer_scarlett_gen2.h                    |   2 +-
 tools/include/uapi/linux/in.h                      |   3 +
 tools/perf/pmu-events/jevents.c                    |   2 +-
 tools/perf/scripts/python/exported-sql-viewer.py   |  12 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   6 +-
 tools/perf/util/intel-pt.c                         |   5 +-
 tools/perf/util/session.c                          |   1 +
 tools/testing/selftests/gpio/Makefile              |  24 +--
 tools/testing/selftests/kvm/lib/kvm_util.c         |   2 +-
 virt/kvm/arm/vgic/vgic-kvm-device.c                |   4 +-
 virt/kvm/kvm_main.c                                |  19 +-
 514 files changed, 4800 insertions(+), 1969 deletions(-)

