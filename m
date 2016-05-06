From: Roosen Henri <Henri.Roosen@ginzinger.com>
Subject: WARNING: complate_all() with 7 waiters at system boot
Date: Fri, 6 May 2016 09:23:02 +0000
Message-ID: <FC629F1A536C6F42B960B5E32E20BD358C23F21A@exc2.buero.ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:17901 "EHLO
	mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585AbcEFJbH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 May 2016 05:31:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.ginzinger.com (Postfix) with ESMTP id 6AE633E98
	for <linux-rt-users@vger.kernel.org>; Fri,  6 May 2016 11:22:59 +0200 (CEST)
Received: from mail.ginzinger.com ([127.0.0.1])
	by localhost (mail.ginzinger.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sp4lxipK9ccL for <linux-rt-users@vger.kernel.org>;
	Fri,  6 May 2016 11:22:58 +0200 (CEST)
Received: from exc2.buero.ginzinger.com (unknown [10.1.1.201])
	by mail.ginzinger.com (Postfix) with ESMTPS id D91B73E92
	for <linux-rt-users@vger.kernel.org>; Fri,  6 May 2016 11:22:58 +0200 (CEST)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

My x86_64 development PC with kernel 4.4.7-rt16 throws the following warning during system boot:

[   12.606217] ------------[ cut here ]------------
[   12.606220] WARNING: CPU: 5 PID: 872 at kernel/sched/swait.c:48 complete_all+0x2a/0x40()
[   12.606220] complate_all() with 7 waiters
[   12.606243] Modules linked in: arc4 ecb md4 nls_utf8 cifs dns_resolver fscache ftdi_sio usbserial joydev hid_logitech_hidpp hid_logitech_dj hid_generic usbhid usb_storage hid intel_rapl iosf_mbi evdev iTCO_wdt iTCO_vendor_support intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul jitterentropy_rng sha256_ssse3 sha256_generic hmac drbg ansi_cprng aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd serio_raw pcspkr nouveau mxm_wmi tpm_infineon wmi ttm snd_hda_codec_hdmi drm_kms_helper drm i2c_i801 i2c_algo_bit i2c_core snd_hda_codec_realtek snd_hda_codec_generic battery snd_hda_intel snd_hda_codec fujitsu_laptop snd_hda_core snd_hwdep snd_pcm video snd_timer tpm_tis mei_me snd loop lpc_ich tpm soundcore mfd_core mei shpchp button processor fuse 
 parport_pc
[   12.606252]  ppdev lp parport autofs4 ext4 crc16 mbcache jbd2 sg sr_mod cdrom sd_mod ahci libahci crc32c_intel libata xhci_pci ehci_pci psmouse scsi_mod xhci_hcd e1000e ehci_hcd ptp usbcore pps_core usb_common fan thermal
[   12.606253] CPU: 5 PID: 872 Comm: cryptomgr_probe Not tainted 4.4.7-rt16 #2
[   12.606254] Hardware name: FUJITSU CELSIUS W530/D3227-A1, BIOS V4.6.5.4 R1.34.0 for D3227-A1x 01/08/2015
[   12.606256]  0000000000000000 ffffffff812e0e0e ffff88021142be30 ffffffff81731e02
[   12.606257]  ffffffff81073f81 ffff88003614fd30 ffff88021142be80 0000000000000246
[   12.606258]  ffff880212206400 0000000000000000 ffffffff8107401c ffffffff81726fb0
[   12.606258] Call Trace:
[   12.606262]  [<ffffffff812e0e0e>] ? dump_stack+0x5c/0x7e
[   12.606265]  [<ffffffff81073f81>] ? warn_slowpath_common+0x81/0xd0
[   12.606266]  [<ffffffff8107401c>] ? warn_slowpath_fmt+0x4c/0x50
[   12.606267]  [<ffffffff810b5849>] ? swake_up_all_locked+0x29/0x80
[   12.606268]  [<ffffffff810b5eca>] ? complete_all+0x2a/0x40
[   12.606279]  [<ffffffff812a3241>] ? cryptomgr_probe+0x91/0xd0
[   12.606280]  [<ffffffff812a31b0>] ? crypto_alg_put+0x20/0x20
[   12.606282]  [<ffffffff81092cbf>] ? kthread+0xcf/0xf0
[   12.606283]  [<ffffffff81092bf0>] ? kthread_worker_fn+0x190/0x190
[   12.606286]  [<ffffffff8156e38f>] ? ret_from_fork+0x3f/0x70
[   12.606287]  [<ffffffff81092bf0>] ? kthread_worker_fn+0x190/0x190
[   12.606288] ---[ end trace 0000000000000002 ]---

Thanks,
Henri
--

________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089

