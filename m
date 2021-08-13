Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38245C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Aug 2021 10:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1843961038
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Aug 2021 10:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhHMK5K (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Aug 2021 06:57:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:60597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240233AbhHMK5I (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Aug 2021 06:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628852189;
        bh=tFy8C7ulzxKErEMhEv4GUTSgUzK83sEXRnChq8wbKFg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=hdTRWBfR9jbzzkkznC7lC6qIWBCrMj073Ezt3yupI1hExf4L/L7/5pjkuTnfZKBlK
         rIRz2zq84RjYrJ/1IyhK1uYPzUAR7XxIZZTfhSB7Ty5GprXf+CpyEr5zzKITi9bpBD
         3Qs+nbP+N5DzC673Yucy/tSKA/AJclH3FhsDx4cs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XU1-1nA5Qi2qTh-014R4m; Fri, 13
 Aug 2021 12:56:29 +0200
Message-ID: <8c012c35852e98af99a6b6234a3f57ac27cd980a.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
From:   Mike Galbraith <efault@gmx.de>
To:     Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Fri, 13 Aug 2021 12:56:28 +0200
In-Reply-To: <20210812151803.52f84aaf@theseus.lan>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
         <20210812151803.52f84aaf@theseus.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3WZYACclXDOtJ4xTqk/TayiLDpwxcSWLvMtRFLdpIWWy8vhoKwK
 uGO4wlw4jF2s+J/q15npW1G3cmbFHQOAF5/hPlPXytkApHRdt45ys47UjUSNUKFtrfKSicR
 ImmUZOr2OFjQvVrTseVSsb5/5RDd+y0d9em09RVy5JjrLQnP60cZrWU0kvx0mIwUjWWL6g/
 eynhtBMUQ4saPgPEqxf5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FaBgR6FM/2U=:mJTeSUQB9iFX3bkJkgUKVs
 QiKbAzqhQoMY3gWumAIA+G0i4/7tSWmb2aES8BK0uGWmE3zyTtgtAFigVc8jEUagkgjqYyTky
 nFUIVnLZEJ9EZ0QsqrzT+HQYGjDnVYwF20ie4fqipp5VbDHbo9rBExzNKZV134bU67gX8Tk+5
 NO1inQZpg3tonvPhpUTu4/oE25M0uIoCgkDzfgvPHXiEFz1z7UVx33PMzj7XvwpntTcuAsp77
 p+rcXHeOTXogNgfADd2fY0vXb6OhM9J7eM+JfxNNpIKEzYP/YgmmTCR76ZrcXsdBLcbCpfMqe
 xY/hIxcKk1Eh9jrRTM4Ly3oIKHNJozUcMESLyVPtZVX5TcWBT1ZuXHueiAbuhqAU+lg0+/Tbb
 4lK9uUr/PyI82Diqsoddkg3tE5+erJp2rrlCmj7fIC0xRIb5ebxejBOzdTUcNM0zwwxUJWQjg
 JQz57HBFOGLZfUu5hUkNLf9OB3EnstKAcyrZzXU52NnWDGzP34czMHcmyyoVY0eLlzg5Z5TNu
 g5xZAantW5biRuSSDPGvy1stRbLITNcBd7D2T8x/4hCt30ZS+DjX70NjBDzTP/E8K7ah4pTSI
 D6gFIBGpzpxxfEA75uB4DmOtD3Q5MCJTwsCswSi3sv7cNTo3g6tss0CfQUaH4D6Hva6ZeKkr6
 BWSMVZTur2icCqRCHHE82vHsGMGgc/RUG5DP2mBEp27m1eLf18CCuBWla/QYetzIO+agtM1xs
 oTF+bCn7yofo7NxlgOr1Pf05OsGy+dT6B7TRt2vpI3vDcUq7NCeDCCd0+k5AYxnjFmXP/lL/y
 ncTHvxw4+CHLDvNzq4oeGFZn07pC9EhBFn9UDKeoZjobXI5RHsdVdLbluBCY/WpyZnPgUQXz/
 +RJk1BaRUY5cRt/3hXOJgzH5kBgDt3w8I4pPzTNpJtXSyGeR24lk1fc2KeArxb/It1azZtvS2
 ohsfKW6uh5zJ2EL6kGNQWQnqXUFDGz7a4X/hTO0m65tAJg8iuGXuV/Au62lggNlPYIbO0jI5g
 vKErLlWqeS8NhT6R1nceGUnfaWcNChW4iK0lHCLZ4/0M4D9k4we3b8fikRz7guIa6VId4krMU
 NiQ1Zka6u65A7OqaZTqje+WdpNEP0r+/7hP
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2021-08-12 at 15:18 -0500, Clark Williams wrote:
>=20
> Sebastian, et al,
>=20
> Got the following panic running v5.14-rc5-rt8:
>=20
> ...

> Config is attached.=20
>=20
> I was running the rteval script that kicks off parallel kernel builds
> and hackbench runs as loads and runs cyclictest with a thread on each
> core:
>=20
> $ sudo rteval --duration=3D10m

It took my box more than 10 minutes to explode, but with all those
debug options turned on, it did manage to do so in fairly short order.

Off to build a fixed up 5.13-rt...

[ 2081.451009] page:0000000039d9ce01 refcount:0 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0x284580
[ 2081.451015] flags: 0x17fffc00000000(node=3D0|zone=3D2|lastcpupid=3D0x1ff=
ff)
[ 2081.451019] raw: 0017fffc00000000 ffffe1ddcb109a08 ffff8abb8dff5c80 0000=
000000000000
[ 2081.451021] raw: 0000000000000000 0000000000100000 00000000ffffffff 0000=
000000000000
[ 2081.451022] page dumped because: VM_BUG_ON_PAGE(!PageSlab(page))
[ 2081.451031] ------------[ cut here ]------------
[ 2081.451032] kernel BUG at ./include/linux/page-flags.h:814!
[ 2081.674089] invalid opcode: 0000 [#1] PREEMPT_RT SMP NOPTI
[ 2081.674093] CPU: 0 PID: 32749 Comm: hackbench Kdump: loaded Tainted: G  =
          E     5.14.0.g607a4143-tip-rt_debug #5
[ 2081.674096] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 2081.674097] RIP: 0010:___slab_alloc+0x3f5/0x930
[ 2081.674102] Code: 4c 89 f8 0f 85 26 05 00 00 48 8d 65 d0 5b 41 5a 41 5c =
41 5d 41 5e 41 5f 5d 49 8d 62 f8 c3 48 c7 c6 90 2e b7 a2 e8 5b d5 f9 ff <0f=
> 0b 65 8b 05 c2 fe 69 5e 48 98 8b 8d 70 ff ff ff 48 8d 95 78 ff
[ 2081.674104] RSP: 0018:ffff97e8d2247a70 EFLAGS: 00010282
[ 2081.674107] RAX: 0000000000000034 RBX: ffff8ab880045900 RCX: 00000000000=
00001
[ 2081.674108] RDX: 0000000000000000 RSI: ffffffffa2b9ac2b RDI: 00000000fff=
fffff
[ 2081.674110] RBP: ffff97e8d2247b40 R08: 0000000000000001 R09: 00000000000=
00001
[ 2081.674111] R10: ffff97e8d2247a70 R11: 0000000000000034 R12: ffff8abb8df=
f3130
[ 2081.674112] R13: ffffffffa2c23ac0 R14: 00000000ffffffff R15: 00000000001=
f3130
[ 2081.674114] FS:  00007f8c2f1c0740(0000) GS:ffff8abb8de00000(0000) knlGS:=
0000000000000000
[ 2081.674115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2081.674117] CR2: 00007faca12850a0 CR3: 00000002c4e4c001 CR4: 00000000001=
706f0
[ 2081.674118] Call Trace:
[ 2081.674122]  ? lock_is_held_type+0xeb/0x140
[ 2081.674127]  ? __alloc_skb+0x8c/0x1b0
[ 2081.674131]  ? lock_release+0x289/0x430
[ 2081.674137]  ? __alloc_skb+0x8c/0x1b0
[ 2081.674138]  ? __alloc_skb+0x8c/0x1b0
[ 2081.674140]  ? __slab_alloc.isra.79+0x45/0x60
[ 2081.674142]  __slab_alloc.isra.79+0x45/0x60
[ 2081.674145]  __kmalloc_node_track_caller+0xca/0x1d0
[ 2081.674149]  kmalloc_reserve+0x2e/0x80
[ 2081.674153]  __alloc_skb+0x8c/0x1b0
[ 2081.674156]  alloc_skb_with_frags+0x53/0x1a0
[ 2081.674160]  ? finish_wait+0x80/0x80
[ 2081.674164]  sock_alloc_send_pskb+0x23b/0x270
[ 2081.674169]  ? wait_for_unix_gc+0x42/0xb0
[ 2081.674175]  unix_stream_sendmsg+0x209/0x3d0
[ 2081.674183]  sock_sendmsg+0x58/0x60
[ 2081.674186]  sock_write_iter+0x9a/0x100
[ 2081.674191]  new_sync_write+0x1a2/0x1c0
[ 2081.674199]  vfs_write+0x3b6/0x410
[ 2081.674204]  ksys_write+0x53/0xe0
[ 2081.674206]  ? lockdep_hardirqs_on+0x54/0x100
[ 2081.674209]  do_syscall_64+0x37/0x80
[ 2081.674214]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2081.674218] RIP: 0033:0x7f8c2ebd0e93
[ 2081.674221] Code: 75 05 48 83 c4 58 c3 e8 db 3c ff ff 66 2e 0f 1f 84 00 =
00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 55 f3 c3 0f 1f 00 41 54 55 49 89 d4 53 48 89
[ 2081.674223] RSP: 002b:00007ffe616df358 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[ 2081.674225] RAX: ffffffffffffffda RBX: 00000000000003e8 RCX: 00007f8c2eb=
d0e93
[ 2081.674226] RDX: 00000000000003e8 RSI: 00007ffe616df360 RDI: 00000000000=
00013
[ 2081.674227] RBP: 00007ffe616df790 R08: 00007ffe616df2b0 R09: 00007f8c2ed=
d9010
[ 2081.674228] R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffe616=
df360
[ 2081.674229] R13: 000000000000000b R14: 0000000001f90b30 R15: 00000000000=
00000
[ 2081.674236] Modules linked in: af_packet(E) nft_fib_inet(E) nft_fib_ipv4=
(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nft_reject(E) nft_ct(E) n=
ft_chain_nat(E) nf_tables(E) ebtable_nat(E) ebtable_broute(E) ip6table_nat(=
E) ip6table_mangle(E) ip6table_raw(E) ip6table_security(E) iptable_nat(E) n=
f_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) libcrc32c(E) i=
ptable_mangle(E) iptable_raw(E) iptable_security(E) ip_set(E) bridge(E) nfn=
etlink(E) stp(E) llc(E) ebtable_filter(E) ebtables(E) iscsi_ibft(E) iscsi_b=
oot_sysfs(E) ip6table_filter(E) ip6_tables(E) rfkill(E) iptable_filter(E) i=
p_tables(E) x_tables(E) bpfilter(E) nls_iso8859_1(E) nls_cp437(E) joydev(E)=
 hid_logitech_hidpp(E) usblp(E) intel_rapl_msr(E) intel_rapl_common(E) x86_=
pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) irq=
bypass(E) crc32_pclmul(E) ghash_clmulni_intel(E) mei_hdcp(E) at24(E) regmap=
_i2c(E) aesni_intel(E) crypto_simd(E) cryptd(E) iTCO_wdt(E) intel_pmc_bxt(E=
) iTCO_vendor_support(E)
[ 2081.674279]  snd_hda_codec_realtek(E) snd_hda_codec_generic(E) ledtrig_a=
udio(E) pcspkr(E) r8169(E) realtek(E) snd_hda_codec_hdmi(E) mdio_devres(E) =
libphy(E) thermal(E) snd_hda_intel(E) snd_intel_dspcfg(E) snd_intel_sdw_acp=
i(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) =
mei_me(E) i2c_i801(E) snd(E) lpc_ich(E) mei(E) i2c_smbus(E) intel_smartconn=
ect(E) fan(E) mfd_core(E) soundcore(E) sch_fq_codel(E) nfsd(E) auth_rpcgss(=
E) nfs_acl(E) lockd(E) grace(E) fuse(E) configfs(E) sunrpc(E) hid_logitech_=
dj(E) ums_realtek(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau=
(E) drm_ttm_helper(E) ttm(E) i2c_algo_bit(E) mxm_wmi(E) wmi(E) drm_kms_help=
er(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) xhci_pci(E)=
 cec(E) xhci_pci_renesas(E) ehci_pci(E) ahci(E) rc_core(E) ehci_hcd(E) liba=
hci(E) xhci_hcd(E) drm(E) libata(E) usbcore(E) video(E) button(E) sd_mod(E)=
 t10_pi(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) ext4(E) crc32c_intel=
(E) crc16(E) mbcache(E)
[ 2081.674328]  jbd2(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scs=
i_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) msr(E)
[ 2081.674335] Dumping ftrace buffer:
[ 2081.674340]    (ftrace buffer empty)


