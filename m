Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C67DC64E7B
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 09:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2730621527
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 09:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbgLCJl7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:41:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:38415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388596AbgLCJl6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 04:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606988417;
        bh=Mc4gwxTOeYf91zVWSwrD9Acr7AxzYetqx/E/+RkqZCs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=PiKImslo4r3fdlNY4PNBQ8m/+PPl/29B2Go8lsaLtPtjYfgjJId7bzOQ+NGyYRHWl
         XVxIJa2y8FxtF0KQnUihFuxV6EMJ7JDipl2Y7PmUv6nS1XYm+BR+agvvexvCmCal4G
         ITIVWPVWcpowVj84ZL/mTmZ9TYUcWIvn+SP+swPM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1kXbxx0AoC-00M12u; Thu, 03
 Dec 2020 10:40:17 +0100
Message-ID: <345fdb33f5bc0046b80c6319e61e9ee33b83cac6.camel@gmx.de>
Subject: zswap explosion when using zsmalloc pool compression
From:   Mike Galbraith <efault@gmx.de>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu, 03 Dec 2020 10:40:16 +0100
In-Reply-To: <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
References: <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
         <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
         <20201129112922.db53kmtpu76xxukj@spock.localdomain>
         <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
         <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:w0/C/VjqxaI5FFVcbu1mM5i3OjlbEtvzlQAYP5JCjFshar7UPK/
 ras7H6opXEqs1ZyZ6QCOfuQKe0kv2UoIYM9fyT2+kHfR15XFmO6Q6R4+9cxyMl8pXGDPgsl
 KodUlZC6frwbss3b9xg7L75Je5YCfFRBrIfp6t6LpZyYwIu5Pnl5ULiMOu0ZIME6gLG7BtQ
 rhlEYdiLYdwITyHZ6hfjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:reQeE4NlxEo=:cW7xuaOqr5nYiAMcC8XSRN
 cIsZ1OmKtMwWIjt2lgFYIAO8Q7G/+pK45Q1WQeuLUj3/6z4iwxcxUTRyiWVT6MPWGv5GRyerv
 7l0vtS+OFulrJZhLHsCOIllvWOVSreb06d/8DbkZCrSEfuGXk6LAW9DfXv9kGTfHM3j2iR/ju
 rsWFpO4Oh/Ai2aXCh10G3MepxCvzrKutZ9F0itMZNWv12NT5Hk9olSItu1VWKJdGkKW1eK3+2
 MyPr+0z9bzLkuLiZsfPIFgSoUQomTMEOqk7GbgwSWtsvLZpx+DdUzvtLuydQt2jvyWxh3/gbA
 FGjpCmMfjfhDoaTGx/gMqCSIOOSiHUEFud+UEM5Zu812Vmhtmy4eIqAR5blASuMZfH4oUPGsx
 J5ZRsY3wU4YJNlML/m77XAkY8+ZKQe31LGuLjTFdQmpWS13ABdujsnPSREpKKoFEx+SKyrvIu
 8endgQuJGtoFb51nlAqgq3PyQV9QUomOWt8wUVDaMAevC6nT1RvpgtBagLy2raEnhjOJDPgrR
 86FFIneJ5Ft0fhC8c3SsU+VgbEi03z3RJiZg1eE97v4loju77+fJI53caqbCq0nRbGG5Sc+YF
 jjGHaALJLGnrMCeZZeofObzT3cJtfoas1qqw3hoYpkY90JeOUy/HZmIv4EtNEmR4lMeTqdPk4
 H/welTxUZGauWR6FzemUkR9BHVXv8Fh21b59rNcD7F3D/+HqNurzgieqvE4Bz2Fc2aDcD6Rxn
 Ql4gMHMsabtNpMA3wxe27GjtA82Zl6YAT9N6ZhNuEu7Zw4AVDe9KFAqX3wMqNVQQaulMx89Yq
 S5yKaWmE/cIfaBVekpIgWlgX2hB7gVrF3hvsCYd0d3lsHH7VTuVT28P8lR3G7qefBUOsNuAVA
 TUkw9Me7eHRJ947j01hQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In thread "scheduling while atomic in z3fold", I mentioned that of the
three pool methods, only zbud did not explode.  Below is the explosion
encountered when zsmalloc is used in conjunction with runltp -f mm.  As
with the z3fold explosion, this one also seems to be highly repeatable,
this from one of my full distro "my box plays russian dolls [1]" KVMs.

[ 5763.720268] kernel BUG at kernel/locking/rtmutex.c:1057!
[ 5763.720273] invalid opcode: 0000 [#1] PREEMPT_RT SMP NOPTI
[ 5763.721831] CPU: 1 PID: 25163 Comm: AudioIPC0 Kdump: loaded Tainted: G            E     5.9.12-rt20-rt #18
[ 5763.722619] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 5763.723545] RIP: 0010:rt_spin_lock_slowlock_locked+0x29b/0x2d0
[ 5763.724027] Code: 7f 0f 85 23 ff ff ff 41 8b 46 0c 85 c0 0f 85 17 ff ff ff 49 8b 06 a9 00 00 08 00 0f 84 09 ff ff ff e9 ff fe ff ff 0f 0b 0f 0b <0f> 0b 48 89 df e8 fb 00 84 ff e9 fe fe ff ff 48 8b 43 10 48 85 c0
[ 5763.725587] RSP: 0000:ffff9e5a41b1faa8 EFLAGS: 00010086
[ 5763.726016] RAX: 00000000ffffffdd RBX: ffff903f77c68080 RCX: 0000000000000001
[ 5763.726592] RDX: 0000000000000001 RSI: 0000000000000400 RDI: 0000000000000000
[ 5763.727166] RBP: ffff903eadc919a8 R08: 0000000000000000 R09: 00000000000217e9
[ 5763.727820] R10: ffff9e5a41b1f910 R11: 00000000000003f0 R12: ffff903eadc91100
[ 5763.728500] R13: ffff9e5a41b1fae8 R14: ffff903f76189480 R15: 0000000000000286
[ 5763.729090] FS:  00007fbd86074700(0000) GS:ffff903f77c40000(0000) knlGS:0000000000000000
[ 5763.729985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5763.730435] CR2: 00007fbd6d844000 CR3: 000000021dcbc005 CR4: 00000000001706e0
[ 5763.731028] Call Trace:
[ 5763.731243]  rt_spin_lock_slowlock+0x40/0x60
[ 5763.731603]  rt_spin_lock+0x45/0x50
[ 5763.731901]  zs_map_object+0x103/0x3a0
[ 5763.732224]  zswap_frontswap_load+0x10c/0x390
[ 5763.732596]  __frontswap_load+0x6e/0xd0
[ 5763.732933]  swap_readpage+0x88/0x240
[ 5763.733233]  read_swap_cache_async+0x2e/0x40
[ 5763.733579]  swap_cluster_readahead+0x202/0x290
[ 5763.733961]  ? swapin_readahead+0x85/0x480
[ 5763.734307]  swapin_readahead+0x85/0x480
[ 5763.734686]  ? find_get_entry+0xab/0x130
[ 5763.735018]  ? pagecache_get_page+0x30/0x2e0
[ 5763.735386]  ? do_swap_page+0x390/0xb00
[ 5763.735712]  do_swap_page+0x390/0xb00
[ 5763.736027]  handle_mm_fault+0x8db/0x13b0
[ 5763.736370]  exc_page_fault+0x335/0x630
[ 5763.736745]  ? asm_exc_page_fault+0x8/0x30
[ 5763.737237]  asm_exc_page_fault+0x1e/0x30
[ 5763.737594] RIP: 0033:0x7fbdae932e1f
[ 5763.737901] Code: 17 e0 c5 f8 77 c3 48 3b 15 26 c3 25 00 0f 83 25 01 00 00 48 39 f7 72 0f 74 12 4c 8d 0c 16 4c 39 cf 0f 82 c5 01 00 00 48 89 d1 <f3> a4 c3 80 fa 10 73 17 80 fa 08 73 27 80 fa 04 73 33 80 fa 01 77
[ 5763.739533] RSP: 002b:00007fbd86072dd8 EFLAGS: 00010287
[ 5763.739980] RAX: 00007fbd6ca00dc0 RBX: 00007fbd86072fa0 RCX: 0000000000000040
[ 5763.740571] RDX: 0000000000001040 RSI: 00007fbd6d844000 RDI: 00007fbd6ca01dc0
[ 5763.741421] RBP: 00007fbd87ae9fc0 R08: 0000000000000000 R09: 0000000000000000
[ 5763.742031] R10: 0000000000000001 R11: 00007fbd6ca00000 R12: 00007fbd86072de8
[ 5763.742615] R13: 00007fbd86072df0 R14: 0000000000000208 R15: 00007fbd86073100
[ 5763.743204] Modules linked in: ebtable_filter(E) ebtables(E) uinput(E) fuse(E) xt_comment(E) nf_log_ipv6(E) nf_log_ipv4(E) nf_log_common(E) xt_LOG(E) xt_limit(E) rpcsec_gss_krb5(E) nfsv4(E) dns_resolver(E) nfs(E) nfs_ssc(E) fscache(E) nfnetlink_cthelper(E) nfnetlink(E) af_packet(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) xt_pkttype(E) xt_tcpudp(E) ip6t_REJECT(E) ipt_REJECT(E) iptable_filter(E) bpfilter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) libcrc32c(E) ip6table_filter(E) ip6_tables(E) x_tables(E) joydev(E) intel_rapl_msr(E) intel_rapl_common(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) aesni_intel(E) crypto_simd(E) snd_hda_codec_generic(E) cryptd(E) ledtrig_audio(E) glue_helper(E) virtio_balloon(E) snd_hda_intel(E) snd_intel_dspcfg(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) tiny_power_button(E) snd_timer(E) snd(E) 8139too(E)
[ 5763.743239]  soundcore(E) i2c_piix4(E) button(E) pcspkr(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sch_fq_codel(E) sunrpc(E) ext4(E) crc16(E) mbcache(E) jbd2(E) ata_generic(E) hid_generic(E) usbhid(E) ata_piix(E) virtio_console(E) virtio_blk(E) virtio_rng(E) qxl(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) cec(E) crc32c_intel(E) uhci_hcd(E) ehci_pci(E) ahci(E) rc_core(E) ehci_hcd(E) virtio_pci(E) libahci(E) virtio_ring(E) serio_raw(E) 8139cp(E) drm(E) virtio(E) usbcore(E) mii(E) libata(E) floppy(E) qemu_fw_cfg(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E)

1. box in box in box is cute, but not all that useful :)

