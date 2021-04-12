Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1909C433B4
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Apr 2021 20:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC896121D
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Apr 2021 20:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbhDLUHO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Apr 2021 16:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237396AbhDLUHN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Apr 2021 16:07:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48AD66101B;
        Mon, 12 Apr 2021 20:06:55 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.185-rt76
Date:   Mon, 12 Apr 2021 20:05:40 -0000
Message-ID: <161825794018.173665.10893912675823420178@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.185-rt76 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: d69a50f6a6e4cb5618b2b433fa88d392904f2fa6

Or to build 4.19.185-rt76 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.185.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.185-rt76.patch.xz


You can also build from 4.19.184-rt75 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.184-rt75-rt76.patch.xz

Enjoy!
Clark

Changes from v4.19.184-rt75:
---

Adrian Hunter (2):
      PM: runtime: Fix race getting/putting suppliers at probe
      PM: runtime: Fix ordering in pm_runtime_get_suppliers()

Alexander Ovechkin (1):
      tcp: relookup sock for RST+ACK packets handled by obsolete req sock

Alexey Dobriyan (1):
      scsi: qla2xxx: Fix broken #endif placement

Artur Petrosyan (1):
      usb: dwc2: Fix HPRT0.PrtSusp bit setting for HiKey 960 board.

Atul Gopinathan (2):
      staging: rtl8192e: Fix incorrect source in memcpy()
      staging: rtl8192e: Change state information from u16 to u8

Benjamin Rood (1):
      ASoC: sgtl5000: set DAP_AVC_CTRL register to correct default value on probe

Chunfeng Yun (1):
      usb: xhci-mtk: fix broken streams issue on 0.96 xHCI

Clark Williams (2):
      Merge tag 'v4.19.185' into v4.19-rt
      Linux 4.19.185-rt76

David Brazdil (1):
      selinux: vsock: Set SID for socket returned by accept()

Dinghao Liu (1):
      extcon: Fix error handling in extcon_dev_register

Doug Brown (1):
      appletalk: Fix skb allocation size in loopback case

Du Cheng (1):
      drivers: video: fbcon: fix NULL dereference in fbcon_cursor()

Greg Kroah-Hartman (1):
      Linux 4.19.185

Hans de Goede (3):
      ASoC: rt5640: Fix dac- and adc- vol-tlv values being off by a factor of 10
      ASoC: rt5651: Fix dac- and adc- vol-tlv values being off by a factor of 10
      ASoC: es8316: Simplify adc_pga_gain_tlv table

Hui Wang (2):
      ALSA: hda/realtek: fix a determine_headset_type issue for a Dell AIO
      ALSA: hda/realtek: call alc_update_headset_mode() in hp_automute_hook

Ikjoon Jang (1):
      ALSA: usb-audio: Apply sample rate quirk to Logitech Connect

Ilya Lipnitskiy (1):
      mm: fix race by making init_zero_pfn() early_initcall

J. Bruce Fields (1):
      rpc: fix NULL dereference on kmalloc failure

Jakub Kicinski (1):
      ipv6: weaken the v4mapped source check

Jesper Dangaard Brouer (1):
      bpf: Remove MTU check in __bpf_skb_max_len

Johan Hovold (2):
      USB: cdc-acm: fix double free on probe failure
      USB: cdc-acm: fix use-after-free after probe failure

Krzysztof Kozlowski (1):
      extcon: Add stubs for extcon_register_notifier_all() functions

Laurent Vivier (1):
      vhost: Fix vhost_vq_reset()

Luca Pesce (1):
      brcmfmac: clear EAP/association status bits on linkdown events

Lucas Tanure (4):
      ASoC: cs42l42: Fix Bitclock polarity inversion
      ASoC: cs42l42: Fix channel width support
      ASoC: cs42l42: Fix mixer volume control
      ASoC: cs42l42: Always wait at least 3ms after reset

Lv Yunlong (1):
      scsi: st: Fix a use after free in st_open()

Manaf Meethalavalappu Pallikunhi (1):
      thermal/core: Add NULL pointer check before using cooling device stats

Nathan Rossi (1):
      net: ethernet: aquantia: Handle error cleanup of start on open

Nirmoy Das (1):
      drm/amdgpu: fix offset calculation in amdgpu_vm_bo_clear_mappings()

Oliver Neukum (3):
      cdc-acm: fix BREAK rx code path adding necessary calls
      USB: cdc-acm: untangle a circular dependency between callback and softint
      USB: cdc-acm: downgrade message to debug

Sameer Pujar (1):
      ASoC: rt5659: Update MCLK rate in set_sysclk()

Shuah Khan (2):
      ath10k: hold RCU lock when calling ieee80211_find_sta_by_ifaddr()
      usbip: vhci_hcd fix shift out-of-bounds in vhci_hub_control()

Steven Rostedt (VMware) (1):
      tracing: Fix stack trace event size

Tetsuo Handa (1):
      reiserfs: update reiserfs_xattrs_initialized() condition

Tong Zhang (4):
      staging: comedi: cb_pcidas: fix request_irq() warn
      staging: comedi: cb_pcidas64: fix request_irq() warn
      net: wan/lmc: unregister device when no matching device is found
      usb: gadget: udc: amd5536udc_pci fix null-ptr-dereference

Tony Lindgren (1):
      usb: musb: Fix suspend with devices connected for a64

Vincent Palatin (1):
      USB: quirks: ignore remote wake-up on Fibocom L850-GL LTE modem

Waiman Long (1):
      locking/ww_mutex: Simplify use_ww_ctx & ww_ctx handling

Wang Panzhenzhuan (1):
      pinctrl: rockchip: fix restore error in resume

Xℹ Ruoyao (1):
      drm/amdgpu: check alignment on CPU page for bo map

Zhaolong Zhang (1):
      ext4: fix bh ref count on error paths

Zheyu Ma (1):
      firewire: nosy: Fix a use-after-free bug in nosy_ioctl()

zhangyi (F) (1):
      ext4: do not iput inode under running transaction in ext4_rename()
---
Makefile                                           |  2 +-
 drivers/base/power/runtime.c                       | 10 ++-
 drivers/extcon/extcon.c                            |  1 +
 drivers/firewire/nosy.c                            |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 10 +--
 drivers/net/ethernet/aquantia/atlantic/aq_main.c   |  4 +-
 drivers/net/wan/lmc/lmc_main.c                     |  2 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |  7 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  7 +-
 drivers/pinctrl/pinctrl-rockchip.c                 | 13 ++--
 drivers/scsi/qla2xxx/qla_target.h                  |  2 +-
 drivers/scsi/st.c                                  |  2 +-
 drivers/staging/comedi/drivers/cb_pcidas.c         |  2 +-
 drivers/staging/comedi/drivers/cb_pcidas64.c       |  2 +-
 drivers/staging/rtl8192e/rtllib.h                  |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |  2 +-
 drivers/thermal/thermal_sysfs.c                    |  3 +
 drivers/usb/class/cdc-acm.c                        | 61 ++++++++++++------
 drivers/usb/core/quirks.c                          |  4 ++
 drivers/usb/dwc2/hcd.c                             |  2 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c            | 10 +--
 drivers/usb/host/xhci-mtk.c                        | 10 ++-
 drivers/usb/musb/musb_core.c                       | 12 ++--
 drivers/usb/usbip/vhci_hcd.c                       |  2 +
 drivers/vhost/vhost.c                              |  2 +-
 drivers/video/fbdev/core/fbcon.c                   |  3 +
 fs/ext4/inode.c                                    |  6 +-
 fs/ext4/namei.c                                    | 18 +++---
 fs/reiserfs/xattr.h                                |  2 +-
 include/linux/extcon.h                             | 23 +++++++
 include/net/inet_connection_sock.h                 |  2 +-
 kernel/locking/mutex.c                             | 25 ++++----
 kernel/trace/trace.c                               |  3 +-
 localversion-rt                                    |  2 +-
 mm/memory.c                                        |  2 +-
 net/appletalk/ddp.c                                | 33 ++++++----
 net/core/filter.c                                  | 12 ++--
 net/dccp/ipv6.c                                    |  5 ++
 net/ipv4/inet_connection_sock.c                    |  7 +-
 net/ipv4/tcp_minisocks.c                           |  7 +-
 net/ipv6/ip6_input.c                               | 10 ---
 net/ipv6/tcp_ipv6.c                                |  5 ++
 net/sunrpc/auth_gss/svcauth_gss.c                  | 11 ++--
 net/vmw_vsock/af_vsock.c                           |  1 +
 sound/pci/hda/patch_realtek.c                      |  3 +-
 sound/soc/codecs/cs42l42.c                         | 74 ++++++++++------------
 sound/soc/codecs/cs42l42.h                         | 13 ++--
 sound/soc/codecs/es8316.c                          |  9 +--
 sound/soc/codecs/rt5640.c                          |  4 +-
 sound/soc/codecs/rt5651.c                          |  4 +-
 sound/soc/codecs/rt5659.c                          |  5 ++
 sound/soc/codecs/sgtl5000.c                        |  2 +-
 sound/usb/quirks.c                                 |  1 +
 53 files changed, 293 insertions(+), 182 deletions(-)
