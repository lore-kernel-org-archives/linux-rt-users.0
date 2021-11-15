Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83673C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Nov 2021 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F4060273
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Nov 2021 07:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhKOHkM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 02:40:12 -0500
Received: from mail.nearlyone.de ([46.163.114.145]:59672 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhKOHkL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Nov 2021 02:40:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35E1760F75;
        Mon, 15 Nov 2021 08:37:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1636961830; h=from:subject:date:message-id:to;
        bh=TeCk3gvJ6+Mjm04z5ffaknqpeJglYEJvIZZEjynE2oU=;
        b=ACxhieK5v4mmsorczWm0dENwTE5IqGxDVrxHbwPRuWUU0S7bk2kQRIVUmgy9znRqctI/jE
        RqbJ0x3PJX9DAu73+ZMReNpNTFZjtooAOWUecneIbFrKEk9oOtAyk+8qqIvyjb/h2ZTvXm
        ddbL7DGA3JcgglJVEwYZI7N6zM1iAdWC1o2ukSiZkBrm2VwadQM+jCSHlgvHeUgs9cT07u
        cGVlHXvtiE3V1sag/HSAuXUcC03MY3fqL30qt3Vo0xgPiVE5KFkdjdvrru0muh0nTt3XbO
        XnCrN6dYKtMnnrj91ZP6OP5D535r5zkBfS4QPckHMvPw68kdQqwv3LcwnD5Lvw==
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.292-rt228
Date:   Mon, 15 Nov 2021 07:36:01 -0000
Message-ID: <163696176156.14899.13751363449660255266@beryllium.lan>
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

I'm pleased to announce the 4.4.292-rt228 stable release.  This is
only an update to the latest stable kernel, no RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: ca03c567a938fd6ed11a786d4d43d125b0e914e1

Enjoy!
Daniel

Changes from v4.4.289-rt227:
---

Aleksander Morgado (1):
      USB: serial: qcserial: add EM9191 QDL support

Andreas Kemnade (1):
      net: hso: register netdev later to avoid a race condition

Antoine Tenart (1):
      netfilter: ipvs: make global sysctl readonly in non-init netns

Ard Biesheuvel (1):
      efi/cper: use stack buffer for error record decoding

Arnd Bergmann (4):
      cb710: avoid NULL pointer subtraction
      ethernet: s2io: fix setting mac address during resume
      ARM: 9134/1: remove duplicate memcpy() definition
      ARM: 9139/1: kprobes: fix arch_init_kprobes() prototype

Benjamin Coddington (1):
      NFSD: Keep existing listeners on portlist error

Brendan Grieve (1):
      ALSA: usb-audio: Provide quirk for Sennheiser GSP670 Headset

Cheah Kok Cheong (1):
      staging: comedi: drivers: replace le16_to_cpu() with usb_endpoint_maxp()

Christophe JAILLET (1):
      iio: adc128s052: Fix the error handling path of 'adc128_probe()'

Colin Ian King (1):
      drm/msm: Fix null pointer dereference on pointer edp

Dan Carpenter (3):
      iio: ssp_sensors: add more range checking in ssp_parse_dataframe()
      iio: ssp_sensors: fix error code in ssp_print_mcu_debug()
      pata_legacy: fix a couple uninitialized variable bugs

Daniel Wagner (2):
      Merge tag 'v4.4.292' into v4.4-rt
      Linux 4.4.292-rt228

Daniele Palmas (1):
      USB: serial: option: add Telit LE910Cx composition 0x1204

Dongliang Mu (1):
      usb: hso: fix error handling code of hso_create_net_device

Geert Uytterhoeven (1):
      usb: gadget: Mark USB_FSL_QE broken on 64-bit

Greg Kroah-Hartman (3):
      Linux 4.4.290
      Linux 4.4.291
      Linux 4.4.292

Guenter Roeck (1):
      nios2: Make NIOS2_DTB_SOURCE_BOOL depend on !COMPILE_TEST

Gustavo A. R. Silva (1):
      IB/qib: Use struct_size() helper

Herve Codina (1):
      ARM: dts: spear3xx: Fix gmac node

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: fix the finding clock sample value

James Buren (1):
      usb-storage: Add compatibility quirk flags for iODD 2531/2541

Jan Kara (1):
      isofs: Fix out of bound access for corrupted isofs image

Johan Hovold (10):
      mmc: vub300: fix control-message timeouts
      net: lan78xx: fix division by zero in send path
      comedi: dt9812: fix DMA buffers on stack
      comedi: ni_usb6501: fix NULL-deref in command paths
      comedi: vmk80xx: fix transfer-buffer overflows
      comedi: vmk80xx: fix bulk-buffer overflow
      comedi: vmk80xx: fix bulk and interrupt message timeouts
      staging: r8712u: fix control-message timeout
      staging: rtl8192u: fix control-message timeouts
      rsi: fix control-message timeout

Kai Vehmanen (1):
      ALSA: hda: avoid write to STATESTS if controller is in reset

Krzysztof Kozlowski (1):
      nfc: port100: fix using -ERRNO as command type mask

Lin Ma (1):
      nfc: nci: fix the UAF of rf_conn_info object

Lukas Bulwahn (1):
      elfcore: correct reference to CONFIG_UML

Michael Cullen (1):
      Input: xpad - add support for another USB ID of Nacon GC-100

Mike Marciniszyn (1):
      IB/qib: Protect from buffer overflow in struct qib_user_sdma_pkt fields

Ming Lei (1):
      scsi: core: Put LLD module refcnt after SCSI device is released

Nanyong Sun (1):
      net: encx24j600: check error in devm_regmap_init_encx24j600

Nathan Chancellor (1):
      ARM: 8819/1: Remove '-p' from LDFLAGS

Nick Desaulniers (2):
      ARM: 9122/1: select HAVE_FUTEX_CMPXCHG
      ARM: 9133/1: mm: proc-macros: ensure *_tlb_fns are 4B aligned

Nikolay Martynov (1):
      xhci: Enable trust tx length quirk for Fresco FL11 USB controller

Oliver Neukum (1):
      usbnet: sanity check for maxpacket

Pavel Skripkin (1):
      Revert "net: mdiobus: Fix memory leak in __mdiobus_register"

Petr Mladek (1):
      printk/console: Allow to disable console output by using console="" or console=null

Prashant Malani (1):
      platform/x86: intel_scu_ipc: Update timeout value in comment

Randy Dunlap (1):
      NIOS2: irqflags: rename a redefined register name

Roberto Sassu (1):
      s390: fix strrchr() implementation

Shawn Guo (1):
      mmc: sdhci: Map more voltage level to SDHCI_POWER_330

Stephane Grosjean (1):
      can: peak_usb: pcan_usb_fd_decode_status(): fix back to ERROR_ACTIVE state notification

Stephen Boyd (1):
      nvmem: Fix shift-out-of-bound (UBSAN) with byte size cells

Steven Rostedt (VMware) (1):
      tracing: Have all levels of checks prevent recursion

Takashi Iwai (2):
      ALSA: seq: Fix a potential UAF by wrong private_free call order
      ASoC: DAPM: Fix missing kctl change notifications

Valentin Vidic (1):
      ocfs2: mount fails with buffer overflow in strlen

Vegard Nossum (4):
      net: arc: select CRC32
      net: korina: select CRC32
      r8152: select CRC32 and CRYPTO/CRYPTO_HASH/CRYPTO_SHA256
      netfilter: Kconfig: use 'default y' instead of 'm' for bool config option

Wang Hai (1):
      usbnet: fix error return code in usbnet_probe()

Wang Kefeng (1):
      ARM: 9120/1: Revert "amba: make use of -1 IRQs warn"

Xiaolong Huang (1):
      isdn: cpai: check ctr->cnr to avoid array index out of bound

Xin Long (2):
      sctp: use init_tag from inithdr for ABORT chunk
      sctp: add vtag check in sctp_sf_violation

Yanfei Xu (1):
      net: mdiobus: Fix memory leak in __mdiobus_register

Yang Yingliang (1):
      regmap: Fix possible double-free in regcache_rbtree_exit()

Yoshihiro Shimoda (1):
      can: rcar_can: fix suspend/resume

Zheng Liang (1):
      ovl: fix missing negative dentry check in ovl_rename()

Zheyu Ma (3):
      can: peak_pci: peak_pci_remove(): fix UAF
      isdn: mISDN: Fix sleeping function called from invalid context
      ata: sata_mv: Fix the error handling of mv_chip_id()

Ziyang Xuan (3):
      nfc: fix error handling of nfc_proto_register()
      NFC: digital: fix possible memory leak in digital_tg_listen_mdaa()
      NFC: digital: fix possible memory leak in digital_in_send_sdd_req()
