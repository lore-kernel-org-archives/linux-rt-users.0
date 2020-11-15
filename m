Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EACC2D0E4
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Nov 2020 22:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A71722314
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Nov 2020 22:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="d/YX2/le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgKOWk0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 15 Nov 2020 17:40:26 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:39104 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgKOWkZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 15 Nov 2020 17:40:25 -0500
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 17:40:23 EST
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A1CB989D407;
        Sun, 15 Nov 2020 23:32:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1605479567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=luTuP0A/6jYPBXLBbQU8nd7ua+PSvylopEtB1kcdIjE=;
        b=d/YX2/levx4t2vHoz/KPE6MPInwj2d7WURVcV+aQr8OBmSj2pBAVPrwi3FmOcEGnm5ktkP
        r3JFOo1tPtFavSvLZQrxTdpV8OTQOXngl6VhJEiVbE25ij+7L5R3v19VWMAzQCgZ2URaGw
        vR/5ETx/CGm0HekEUni8olqBLjQf1uI=
MIME-Version: 1.0
Date:   Sun, 15 Nov 2020 23:32:47 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, rostedt@goodmis.org
Subject: WARNING at kernel/sched/core.c:2013 migration_cpu_stop+0x2e3/0x330
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a1fd0d9c6c8cd90a74879b61467ae48d@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi.

I'm running v5.10-rc3-rt7 for some time, and I came across this splat in 
dmesg:

```
[118769.951010] ------------[ cut here ]------------
[118769.951013] WARNING: CPU: 19 PID: 146 at kernel/sched/core.c:2013 
migration_cpu_stop+0x2e3/0x330
[118769.951018] Modules linked in: uinput uas usb_storage 
blocklayoutdriver xt_mark ip6table_nat ip6table_filter ip6_tables rfcomm 
fuse rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace 
sunrpc nfs_ssc fscache iptable_nat xt_MASQUERADE nf_nat iptable_filter 
xt_comment nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 cmac 
algif_hash algif_skcipher nf_tables af_alg snd_hda_codec_realtek nct6775 
bnep tun nfnetlink hwmon_vid snd_hda_codec_generic ledtrig_audio 
snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg iwlmvm soundwire_intel 
soundwire_generic_allocation soundwire_cadence nls_iso8859_1 nls_cp437 
vfat edac_mce_amd snd_hda_codec fat eeepc_wmi snd_hda_core mac80211 
uvcvideo kvm_amd asus_wmi libarc4 soundwire_bus btusb videobuf2_vmalloc 
btrtl videobuf2_memops battery btbcm sparse_keymap wmi_bmof 
snd_usb_audio mxm_wmi videobuf2_v4l2 btintel snd_usbmidi_lib 
videobuf2_common snd_hwdep iwlwifi snd_soc_core snd_rawmidi bluetooth 
kvm videodev snd_seq_device snd_compress joydev
[118769.951047]  ecdh_generic ac97_bus irqbypass ecc snd_pcm_dmaengine 
input_leds mousedev mc crc16 r8169 rapl cfg80211 realtek sp5100_tco 
snd_pcm mdio_devres of_mdio k10temp i2c_piix4 snd_timer rfkill fixed_phy 
ipmi_devintf igb snd ipmi_msghandler libphy dca soundcore evdev tpm_crb 
mac_hid tpm_tis tpm_tis_core pinctrl_amd wmi acpi_cpufreq tcp_bbr 
vhost_vsock vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock 
msr crypto_user ip_tables x_tables xfs dm_thin_pool dm_persistent_data 
dm_bio_prison dm_bufio libcrc32c crc32c_generic dm_crypt cbc 
encrypted_keys trusted tpm hid_logitech_hidpp hid_logitech_dj 
hid_generic usbhid hid dm_mod raid10 md_mod crct10dif_pclmul 
crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd 
xhci_pci xhci_pci_renesas ccp cryptd ehci_pci glue_helper xhci_hcd 
ehci_hcd rng_core amdgpu gpu_sched ttm i2c_algo_bit drm_kms_helper 
syscopyarea sysfillrect sysimgblt fb_sys_fops cec rc_core drm agpgart
[118769.951079] CPU: 19 PID: 146 Comm: migration/19 Not tainted 
5.10.0-pf0 #1
[118769.951080] Hardware name: System manufacturer System Product 
Name/Pro WS X570-ACE, BIOS 2311 10/16/2020
[118769.951081] Stopper: migration_cpu_stop+0x0/0x330 <- 
affine_move_task+0x42f/0x620
[118769.951083] RIP: 0010:migration_cpu_stop+0x2e3/0x330
[118769.951084] Code: ff ff 31 db 45 85 ed 0f 89 65 ff ff ff 8b b5 d0 0a 
00 00 4c 89 ff e8 cc 43 ff ff 0f b6 d8 66 85 db 75 d8 0f 0b e9 f2 fd ff 
ff <0f> 0b e9 eb fd ff ff 44 89 ee 4c 89 ff e8 ab 43 ff ff 84 c0 0f 84
[118769.951085] RSP: 0018:ffffb58c806c7e50 EFLAGS: 00010046
[118769.951086] RAX: ffffa136e7a9c300 RBX: 0000000000000000 RCX: 
0000000000000000
[118769.951086] RDX: 000000000000000d RSI: 0000000000000013 RDI: 
ffffa136e7a9bf80
[118769.951087] RBP: ffffa13d0eee99c0 R08: 000000000000002f R09: 
ffffa13d0ef29af0
[118769.951087] R10: 00000000000000ec R11: 000000000000016a R12: 
ffffb58c9118fdd0
[118769.951088] R13: 00000000ffffffff R14: ffffa136e7a9c820 R15: 
ffffa136e7a9bf80
[118769.951089] FS:  0000000000000000(0000) GS:ffffa13d0eec0000(0000) 
knlGS:0000000000000000
[118769.951089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[118769.951090] CR2: 00007f687474a000 CR3: 000000021319c000 CR4: 
0000000000350ee0
[118769.951090] Call Trace:
[118769.951094]  ? set_cpus_allowed_ptr+0x10/0x10
[118769.951095]  cpu_stopper_thread+0x89/0x130
[118769.951097]  ? smpboot_register_percpu_thread+0xe0/0xe0
[118769.951099]  smpboot_thread_fn+0x1d8/0x2c0
[118769.951100]  kthread+0x190/0x1b0
[118769.951101]  ? __kthread_init_worker+0x50/0x50
[118769.951102]  ret_from_fork+0x22/0x30
[118769.951105] CPU: 19 PID: 146 Comm: migration/19 Not tainted 
5.10.0-pf0 #1
[118769.951106] Hardware name: System manufacturer System Product 
Name/Pro WS X570-ACE, BIOS 2311 10/16/2020
[118769.951106] Stopper: migration_cpu_stop+0x0/0x330 <- 
affine_move_task+0x42f/0x620
[118769.951107] Call Trace:
[118769.951108]  dump_stack+0x6d/0x88
[118769.951111]  __warn.cold+0x24/0x3d
[118769.951113]  ? migration_cpu_stop+0x2e3/0x330
[118769.951114]  report_bug+0xd1/0x100
[118769.951116]  handle_bug+0x3a/0xa0
[118769.951118]  exc_invalid_op+0x15/0xd0
[118769.951119]  asm_exc_invalid_op+0x12/0x20
[118769.951121] RIP: 0010:migration_cpu_stop+0x2e3/0x330
[118769.951122] Code: ff ff 31 db 45 85 ed 0f 89 65 ff ff ff 8b b5 d0 0a 
00 00 4c 89 ff e8 cc 43 ff ff 0f b6 d8 66 85 db 75 d8 0f 0b e9 f2 fd ff 
ff <0f> 0b e9 eb fd ff ff 44 89 ee 4c 89 ff e8 ab 43 ff ff 84 c0 0f 84
[118769.951122] RSP: 0018:ffffb58c806c7e50 EFLAGS: 00010046
[118769.951123] RAX: ffffa136e7a9c300 RBX: 0000000000000000 RCX: 
0000000000000000
[118769.951123] RDX: 000000000000000d RSI: 0000000000000013 RDI: 
ffffa136e7a9bf80
[118769.951124] RBP: ffffa13d0eee99c0 R08: 000000000000002f R09: 
ffffa13d0ef29af0
[118769.951124] R10: 00000000000000ec R11: 000000000000016a R12: 
ffffb58c9118fdd0
[118769.951124] R13: 00000000ffffffff R14: ffffa136e7a9c820 R15: 
ffffa136e7a9bf80
[118769.951126]  ? set_cpus_allowed_ptr+0x10/0x10
[118769.951127]  cpu_stopper_thread+0x89/0x130
[118769.951128]  ? smpboot_register_percpu_thread+0xe0/0xe0
[118769.951129]  smpboot_thread_fn+0x1d8/0x2c0
[118769.951130]  kthread+0x190/0x1b0
[118769.951130]  ? __kthread_init_worker+0x50/0x50
[118769.951131]  ret_from_fork+0x22/0x30
[118769.951133] ---[ end trace 0000000000000002 ]---
```

which corresponds to the following condition:

```
2007         /*
2008          * When this was migrate_enable() but we no longer have an
2009          * @pending, a concurrent SCA 'fixed' things and we should 
be
2010          * valid again. Nothing to do.
2011          */
2012         if (!pending) {
2013             WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
2014             goto out;
2015         }
```

I'm not sure what triggered this, and the system still looks usable 
afterwards. I have no idea how to trigger it again ATM, so this is just 
a heads up in case you know what could go wrong.

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
