Return-Path: <SRS0=5zTk=6F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F320C54FC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Apr 2020 05:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C922071E
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Apr 2020 05:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MKbEljrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgDUFJp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:09:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:46391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgDUFJo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Apr 2020 01:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587445748;
        bh=JUi3S70GrV/YPRpERcXUnGaPZ+ORzavjQxhmW6acJBo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=MKbEljrb3626eltcTYGz1r6Y97RKayEKeaQ+b1atUXq2k+mZtH78xGgVciKp3ymVo
         uwjXm5jOoAVgJ4Jn2NIq21kyolpRQkU4/0QJ3Q1x+0692bP04dbD0ykN3odeJWNlCP
         VwQIxism9jC/KDV76+y6SJycbidgqJc8x+dF6eoQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([212.114.172.182]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1jehND2K4N-00Lmm8; Tue, 21
 Apr 2020 07:09:08 +0200
Message-ID: <1587445747.24545.9.camel@gmx.de>
Subject: v5.6.4-rt3 suspend time allocation gripe
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 21 Apr 2020 07:09:07 +0200
In-Reply-To: <20200416164510.kbrklqahdng5uhij@linutronix.de>
References: <20200416164510.kbrklqahdng5uhij@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VwUQCpmLFDHEeWwOmELbEM/jQ509FIqUVT2oPG4Oal32wVbfbTH
 ada16MuiYseJZ3uyZ9zwPV9uvH9I1oy5di+VZThjqWl2h82SEIgLaaPxX/T/QmIfvYY453/
 CE5AwP04HPo7lb/z5RlFuAQdioaQunezf3nJ0v4dcHHvcTTKsttmFbcDL9eHRTKolSMEU60
 KDllcCN0d4Y7EE8M98PPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cbzVRFNX8WI=:X2AK7jgCFfHLHh7JzIgbCE
 gIWkZ+inEfxLjfOkoQLLCsLbXMlDZ8laVZcTWQkGoLsjlvKdGfvPnJ8t8aj7NkuBuH365cfST
 1arweti2iqPeY04/7Zk+ep3wMQ0E+Y/k9dAwMMc83LNWaag6pure57/j976tUHfPs5UTQFuCf
 hxDVpja0cQppNiNFXmSfP8pGQQOJb/lDlf5iXtVMO4WRtjRfdg5O3Mt0hy2EpPE/5YPyX4V/R
 mlNTETa7QrHZxblFJ7SCPcvjVOchkShWlU5r/zmaYnC45+aL52ugjw9B22gkuqD/2wRcA6A0A
 l1gCdTBBSXdayLpOycahMwNczbTp+WOtn3dR7f20HOtHVeG/IrwP8Aa5t6dwM8a50GFJ6AZ+B
 P2sZJpwQQzWgjMRqzuLsT9rr0x9QriTKjLEn7M5HE59J/de5OYJGR/evjFY8vOf11+BMM//JQ
 a1o1DMnehmxeR84i0dNKJ8zGFrexw176CH7fKYvJvvw6hHaLaCdbQ16VJPuJ+Bl79udIADMXx
 R0eFW3pU33eBdU40z2Mc3C6XMjsv3AGt5ET0dxGbF8sMymLs9UhGnP/nSt6nlfPxzl6U0wFwf
 vRkjnYZ9yFfhJ+afYQRytvS47KCLhM8ME+AmX3/ewj/vhPY9QYz+MVgen5QGVd8SQRVn3TSV4
 PvqFFNQ5G/nrqV1Ug5l4S0dzzYpl0boBVkO5klgHCmaABf60vkByGpR2iMvy/+sWzX43k6FIP
 CP+UIA9xSxvYgPqCDJDR94bjKJmzfSL8w61ipFlHnSHpzE+d4K2CKp7DrcipF6t382BSevj/B
 vnKRxlhMlZKH80En60Sd6DCwA6LN5DTJHgiAiFJx0q0hOcnH9tg26QZL3wtUwcCvQbk0Tv3W7
 G8MTcRVdNrjJijr4yk8wgxUVuN7XNUSA1O/wuX1RJ2Ehmlbnm3jRXq+wCicmv2TMMX1SpW0Wf
 a+As9HI97d2qVCYkydoxSdU/swXvoxi5dgeQl+EtfYUqyavLmsecnxZCyTpU6x5MHpFzJbKBS
 5tbLTnFZINHRBsO4bKJhyhww9z+wfrgWFs5oiFDpsNynV3UTxKjYL39GUonyAorZ6Ze1RlYLP
 LY8OF3QpBtXnoFGYtwjEj6YJTb+1xGsYY1x2KAqf/lXmK8cdvmQp2bBGSTn9w2cdhs3e3Zt6m
 ko6pZqjKNB6tvlKrvvZYacl9oVEE3DX4HRHcMnZd9ARLV7OSeULBoCz9ILaRRCLhCwqE/nGQR
 5/c6IFZfV9+/nDq8R
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The below happens ever since the warning was invented in 5.4-rt.  I
haven't managed to find my round-tuit to even look at it for long
enough now that I guess I should at least report it.

[  106.619915] WARNING: CPU: 0 PID: 4906 at mm/slub.c:2774 kmem_cache_alloc_trace+0x16d/0x3a0
[  106.619921] Modules linked in: fuse(E) msr(E) xt_comment(E) xt_physdev(E) ebtable_filter(E) ebtables(E) nfnetlink_cthelper(E) nfnetlink(E) af_packet(E) br_netfilter(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) ip6t_REJECT(E) ipt_REJECT(E) xt_pkttype(E) xt_tcpudp(E) iptable_filter(E) bpfilter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) libcrc32c(E) ip6table_filter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_cp437(E) intel_rapl_msr(E) joydev(E) usblp(E) intel_rapl_common(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) irqbypass(E) iTCO_wdt(E) crct10dif_pclmul(E) iTCO_vendor_support(E) mei_hdcp(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) ledtrig_audio(E) aesni_intel(E) crypto_simd(E) cryptd(E) glue_helper(E) snd_hda_codec_hdmi(E) snd_hda_intel(E)
[  106.619955]  snd_intel_dspcfg(E) pcspkr(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) r8169(E) snd_pcm(E) realtek(E) snd_timer(E) libphy(E) snd(E) lpc_ich(E) mei_me(E) soundcore(E) i2c_i801(E) mfd_core(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs_acl(E) nfs(E) lockd(E) grace(E) sch_fq_codel(E) sunrpc(E) fscache(E) hid_logitech_hidpp(E) sr_mod(E) cdrom(E) hid_logitech_dj(E) ums_realtek(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) wmi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) cec(E) rc_core(E) ehci_pci(E) xhci_pci(E) ahci(E) ttm(E) libahci(E) ehci_hcd(E) xhci_hcd(E) drm(E) libata(E) usbcore(E) video(E) button(E) sd_mod(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_pci(E) virtio_ring(E) virtio(E) ext4(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E)
[  106.619998] CPU: 0 PID: 4906 Comm: systemd-sleep Kdump: loaded Tainted: G            E     5.6.4-rt3-rt #1
[  106.620000] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  106.620000] RIP: 0010:kmem_cache_alloc_trace+0x16d/0x3a0
[  106.620002] Code: 48 0f a3 05 b5 bc 2d 01 72 27 48 83 c4 08 4c 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 8b 35 3f 6c 2d 01 85 f6 0f 84 d1 fe ff ff <0f> 0b e9 ca fe ff ff 65 ff 05 ed 28 d4 52 48 8b 05 be d4 2b 01 e8
[  106.620004] RSP: 0018:ffffa449433e7cf8 EFLAGS: 00010006
[  106.620005] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000002
[  106.620005] RDX: 0000000000000058 RSI: 0000000000000006 RDI: ffff98eb87c07400
[  106.620006] RBP: ffff98eb87c07400 R08: 0000000000000000 R09: 0000000000000001
[  106.620007] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000b20
[  106.620008] R13: 0000000000000058 R14: ffffffffad5c2705 R15: 0000000000000000
[  106.620008] FS:  00007f2d481991c0(0000) GS:ffff98ee9ec00000(0000) knlGS:0000000000000000
[  106.620009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  106.620010] CR2: 0000556650f2ad30 CR3: 000000036b60a001 CR4: 00000000001606f0
[  106.620011] Call Trace:
[  106.620018]  acpi_get_sleep_type_data+0xa2/0x206
[  106.620024]  acpi_hw_legacy_wake_prep+0x3c/0xd7
[  106.620029]  acpi_leave_sleep_state_prep+0x37/0x69
[  106.620032]  acpi_suspend_enter+0x94/0x400
[  106.620039]  suspend_devices_and_enter+0xa0c/0xed0
[  106.620044]  ? rcu_read_lock_sched_held+0x32/0x60
[  106.620051]  pm_suspend+0x324/0x390
[  106.620055]  state_store+0x7d/0xe0
[  106.620062]  kernfs_fop_write+0x113/0x1b0
[  106.620069]  vfs_write+0xc1/0x1d0
[  106.620075]  ksys_write+0x87/0xc0
[  106.620081]  do_syscall_64+0x6c/0x2c0
[  106.620085]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  106.620087] RIP: 0033:0x7f2d476a6244
[  106.620089] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 00 00 00 00 8b 05 6a d1 2c 00 48 63 ff 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3 48 83
[  106.620091] RSP: 002b:00007ffe5bc2d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  106.620092] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f2d476a6244
[  106.620093] RDX: 0000000000000004 RSI: 00005630e5c6f0f0 RDI: 0000000000000004
[  106.620093] RBP: 00005630e5c6f0f0 R08: 00005630e5c6d390 R09: 00007f2d481991c0
[  106.620094] R10: 000000000000000a R11: 0000000000000246 R12: 0000000000000004
[  106.620095] R13: 0000000000000001 R14: 00005630e5c6d2b0 R15: 0000000000000004
[  106.620111] irq event stamp: 129084
[  106.620112] hardirqs last  enabled at (129083): [<ffffffffad96a475>] _raw_spin_unlock_irqrestore+0x75/0x80
[  106.620114] hardirqs last disabled at (129084): [<ffffffffad10ccdf>] suspend_devices_and_enter+0x25f/0xed0
[  106.620116] softirqs last  enabled at (128266): [<ffffffffad149854>] hrtimers_dead_cpu+0x254/0x2e0
[  106.620119] softirqs last disabled at (128261): [<ffffffffad149623>] hrtimers_dead_cpu+0x23/0x2e0
