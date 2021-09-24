Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A0C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Sep 2021 05:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB0260F39
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Sep 2021 05:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbhIXFYS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 01:24:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:39785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242549AbhIXFYR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Sep 2021 01:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632460953;
        bh=tQ2aoEvoVViV3t3B1dMExwIp1b+ImbzG6l1oNm3lCTw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Umpx8JIBgTpBIxQvxUTDIFZi6NUdL1FPvREZoj9kQJEQLoEirJwRYkccYUUlrkXID
         QDvG8hJoFrL9uhjOfe5biwy0Ke+GHXcD7EleJBUAJ3VsjR1lLrnm9RCbDRh8ne+wm3
         UayQT20a+h1H6OAvFFaLITwY3NNpzZPc2uG7fPFg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1mUBtj0YhG-000ZOA; Fri, 24
 Sep 2021 07:22:33 +0200
Message-ID: <e903e245a501d230e90e32d00460ec0d19cc8878.camel@gmx.de>
Subject: v5.15-rc2-rt3:  WARNING: CPU: 0 PID: 12 at
 ./include/linux/seqlock.h:271
From:   Mike Galbraith <efault@gmx.de>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 24 Sep 2021 07:22:32 +0200
In-Reply-To: <20210922210006.rmfpkps6hguyo5ll@linutronix.de>
References: <20210922210006.rmfpkps6hguyo5ll@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p6bvqaKthcG7J++5HzwwICeoboeDWRmHPh5rNgBW/3qrM6IsF1D
 f+HMjbNwX69+nHREljyiXrjurNO5UEihbI75SMc8bu6HcVNZbRCxrtoduEVNOYpdmIa0JCM
 krBoeKN8n7q1lH7ThJoNFW2TKpO2MGFfCdEwJhhWfou3PGdvk0a811XG0gqNDdDdK499dRx
 fLmdFCOGeUVjWyz/3QwSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hlHK10gMaIs=:dQ0qZswLhcMm1dZaBorZHY
 o0CTa33FMbw2pbEmGPVArYl7TXNksh69zai8vDU5sRxx+t1usVe655pjDvCXJ9mcZiJUYTYLn
 KwuwWGKHbmsZIj0EocChk8LiqgRy1syJwr9bv+/7d0HVp88qVyuNvCvT7OGdS9UwPMgzVRn//
 Wa72T1vRQDWKxbdSARk/87W/QhpFMEtObbmIeQow27Vyvh5wbuskqJwwBpUXomdh08oQjkdLq
 A+Ow6nWUrjM5ZNpMDNgIDv+JdDSBwCwoRAMPiKwgdu8NeJN87yG6BXolH7aEoFFmNmTdcQcuR
 Hq/XxfbIvHbmLbiXoORsZEtGr+U9ouJGQ0s5CrWKXrOvfwdQB2bPtvvT9nmxggA3GlHOxGdkv
 aQsilXF3vlrpO5QTY+9VQ0urmZf4HOQpqquLWrtH9ScW66J//ykHUOgVk0CRqDCFsd8CIVEF3
 K9UZvNTHrV0/uvne8HUVed08Q0MbfTeL5nglmMmFEIN6nmHfNSusv8oYC2VO9c8epgaYP/sv9
 tfKWQRJ3Psk1EOnyG5x0rUfnLLZiCJgj5GdmIpC3z2Y+llbKwRPtoyXXRI8QvAdLniAc3/8Oi
 qW72RJOTIp3eVkGykWkrCATawe8riR2NnuHwH3qHQ7YVNOmO6D68N35wyMN01Qiu0wHuvafG0
 pT8/DQ7EVgZJ8vvXW7/sBCK54nFFzeKB6EjBtGCaHElFhAbLhUao5wcMJfJhXBw0xRqOKKTjH
 UES7prwYxspMwyuBt4APoic7hdUBMhP6WWluNIMUBxkPQz7nDNDV2rejnl3SVDi+Zyap/bzRL
 g1KcYGOwIXSmdWx8CCcI/e2XhtOyqdKEz9gx88j3oNoDenXPmauSz8tc8r1cblmvTFXdUvP1B
 M9jZfLee3pgrmVNfwAJ+e8Mz0AFGrMHOk6f+3ApPYbOqkbxbeXjzsFQpfJNcCoBrFkgb2l1NY
 GG8hwd5ap3d4U4VlaqbJ7ebjEmqyqN2/1r+nT0ldMftbFoJaA+ZTJhVb2mKR2/cvBUJEl+I92
 jUkin4H94PTW7bji++ubwbiDjlFGW9+sQuxh1KWfqjhngsg9bDLtCiVMt0CDR1fRVHBK+uEEb
 mvHFU202mWbDlM=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Greetings,

I met this lockdep_assert_preemption_disabled() gripe when starting ltp
zram tests.

[   69.508019] WARNING: CPU: 0 PID: 12 at ./include/linux/seqlock.h:271 br_=
multicast_update_querier.isra.61+0xd9/0xf0 [bridge]
[   69.508037] Modules linked in: af_packet(E) ip6table_mangle(E) ip6table_=
raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysf=
s(E) nfnetlink(E) ebtable_filter(E) rfkill(E) ebtables(E) ip6table_filter(E=
) ip6_tables(E) iptable_filter(E) ip_tables(E) x_tables(E) bpfilter(E) usbl=
p(E) joydev(E) intel_rapl_msr(E) intel_rapl_common(E) nls_iso8859_1(E) nls_=
cp437(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(=
E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) snd_hda_codec_hdmi(E) =
ledtrig_audio(E) at24(E) regmap_i2c(E) iTCO_wdt(E) snd_hda_intel(E) snd_int=
el_dspcfg(E) mei_hdcp(E) kvm(E) intel_pmc_bxt(E) iTCO_vendor_support(E) snd=
_hda_codec(E) snd_hwdep(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E)=
 snd_hda_core(E) ghash_clmulni_intel(E) aesni_intel(E) r8169(E) crypto_simd=
(E) realtek(E) cryptd(E) i2c_i801(E) mdio_devres(E) snd_pcm(E) snd_timer(E)=
 pcspkr(E) i2c_smbus(E) mei_me(E) libphy(E) snd(E) lpc_ich(E) mei(E) soundc=
ore(E) mfd_core(E) fan(E)
[   69.508069]  thermal(E) intel_smartconnect(E) sch_fq_codel(E) nfsd(E) au=
th_rpcgss(E) nfs_acl(E) lockd(E) grace(E) fuse(E) sunrpc(E) configfs(E) hid=
_logitech_hidpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) =
usbhid(E) nouveau(E) wmi(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) drm_km=
s_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) ahci(=
E) cec(E) libahci(E) rc_core(E) xhci_pci(E) ehci_pci(E) drm(E) libata(E) eh=
ci_hcd(E) xhci_hcd(E) usbcore(E) video(E) button(E) sd_mod(E) t10_pi(E) vfa=
t(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_ring(E) virtio(E) ext4(E) c=
rc32c_intel(E) crc16(E) mbcache(E) jbd2(E) sg(E) dm_multipath(E) dm_mod(E) =
scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) msr(E) autofs4(E=
)
[   69.508098] CPU: 0 PID: 12 Comm: ksoftirqd/0 Kdump: loaded Tainted: G   =
         E     5.15.0.g3839cbc-rt3-master-rt-lockdep #12
[   69.508100] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[   69.508101] RIP: 0010:br_multicast_update_querier.isra.61+0xd9/0xf0 [bri=
dge]
[   69.508109] Code: 5f 85 c0 0f 85 66 ff ff ff 65 8b 05 11 5a 1b 5f a9 ff =
ff ff 7f 0f 85 54 ff ff ff 65 8b 05 d3 61 1b 5f 85 c0 0f 84 45 ff ff ff <0f=
> 0b e9 3e ff ff ff 0f 0b eb b7 66 66 2e 0f 1f 84 00 00 00 00 00
[   69.508111] RSP: 0018:ffff8881008ab9c0 EFLAGS: 00010202
[   69.508112] RAX: 0000000000000001 RBX: ffff8881076f12a0 RCX: 00000000000=
00001
[   69.508113] RDX: 0000000000000001 RSI: ffffffff8204d9a5 RDI: ffffffff820=
9ee5e
[   69.508114] RBP: ffff8881008aba70 R08: 0000000000000000 R09: 00000000000=
00000
[   69.508115] R10: ffff8881c56aa266 R11: 0000000000000005 R12: 00000000000=
00002
[   69.508115] R13: 0000000000000002 R14: 0000000000000008 R15: ffff8881076=
f1148
[   69.508116] FS:  0000000000000000(0000) GS:ffff88840ec00000(0000) knlGS:=
0000000000000000
[   69.508117] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.508118] CR2: 000055809b1fe000 CR3: 0000000004a3e002 CR4: 00000000001=
706f0
[   69.508119] Call Trace:
[   69.508125]  br_multicast_select_querier+0x85/0xd0 [bridge]
[   69.508135]  br_multicast_rcv+0x933/0x1c30 [bridge]
[   69.508159]  ? br_fdb_update+0x61/0x480 [bridge]
[   69.508171]  ? br_handle_frame_finish+0x1a8/0x510 [bridge]
[   69.508178]  br_handle_frame_finish+0x1a8/0x510 [bridge]
[   69.508191]  br_handle_frame+0x23a/0x500 [bridge]
[   69.508199]  ? lock_is_held_type+0xdf/0x130
[   69.508203]  ? br_handle_frame_finish+0x510/0x510 [bridge]
[   69.508210]  ? br_handle_frame_finish+0x510/0x510 [bridge]
[   69.508219]  __netif_receive_skb_core+0x23f/0x1200
[   69.508221]  ? __lock_acquire+0x49b/0x1ab0
[   69.508237]  ? __netif_receive_skb_list_core+0xf8/0x260
[   69.508238]  __netif_receive_skb_list_core+0xf8/0x260
[   69.508249]  netif_receive_skb_list_internal+0x19b/0x340
[   69.508257]  napi_complete_done+0x100/0x1a0
[   69.508262]  rtl8169_poll+0x48f/0x550 [r8169]
[   69.508272]  __napi_poll+0x2a/0x290
[   69.508276]  net_rx_action+0x228/0x280
[   69.508286]  __do_softirq+0xb5/0x516
[   69.508292]  ? smpboot_thread_fn+0x23/0x340
[   69.508297]  run_ksoftirqd+0x79/0xd0
[   69.508299]  smpboot_thread_fn+0x25d/0x340
[   69.508303]  ? smpboot_register_percpu_thread+0xe0/0xe0
[   69.508306]  kthread+0x193/0x1c0
[   69.508310]  ? set_kthread_struct+0x40/0x40
[   69.508315]  ret_from_fork+0x1f/0x30
[   69.508332] irq event stamp: 169818
[   69.508332] hardirqs last  enabled at (169820): [<ffffffff810f35ea>] vpr=
intk_store+0x33a/0x590
[   69.508334] hardirqs last disabled at (169821): [<ffffffff810f3634>] vpr=
intk_store+0x384/0x590
[   69.508335] softirqs last  enabled at (169444): [<ffffffff8107fd28>] run=
_ksoftirqd+0x88/0xd0
[   69.508337] softirqs last disabled at (169450): [<ffffffff810aaaad>] smp=
boot_thread_fn+0x25d/0x340

