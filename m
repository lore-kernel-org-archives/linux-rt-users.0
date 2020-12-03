Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDB3C64E7A
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 12:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A166420709
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 12:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgLCMw6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 07:52:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:42715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbgLCMw5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 07:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606999875;
        bh=NQEUp1bRxGlqKZin2OKJ6eqvj0MlCE/ZrbA6kACpdGY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=GO9PhMF2KUNuYMhvjO7i5sC/AHgqAa64j1EXN+gkOt6pGlPh50bx/4AEE2Vy6zbYd
         943FW2sh9/PC+jgphCflfJX5nk7cQoiL4NCkvWdfp3UYdy7AtoSmraBwV3WZpom0qv
         hgH19DLgx/+2Flj5WIwpCDwt9omgaLBYljMGKYYo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1kTgdE3SvS-00IFmr; Thu, 03
 Dec 2020 13:51:14 +0100
Message-ID: <7d4e36c78320ec01b56a12bc14ac3ddce3e26827.camel@gmx.de>
Subject: Re: zswap explosion when using zsmalloc pool compression
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Date:   Thu, 03 Dec 2020 13:51:14 +0100
In-Reply-To: <2b297170dbf98b36526f876650a2707e59d4ae92.camel@gmx.de>
References: <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <345fdb33f5bc0046b80c6319e61e9ee33b83cac6.camel@gmx.de>
         <20201203094805.dhk3f7mlth3vm6ck@linutronix.de>
         <2b297170dbf98b36526f876650a2707e59d4ae92.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DOqgthVVjsBNP9TTTgtPtc6MAAhF0eTsrg7A9e1OfW+mY5i9JVt
 jK+Fqao5jJx8v8JiPfC4jFzv/sdajcXObo2ifWAT53keTfipSLMQ2tyTrQ1gpCjraBC/MbX
 qKPX8y+m68DeqKC7VeMrWRj2fAl24oe8g2zvzapo3FXay5v7ClsBo1AC4FBdSNUus8i9WSM
 y7IFzex0UWxvPDeTMe2+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pkf+e4meGEQ=:b6cdDCwxmJFvQ3sHOE+bUO
 2mWnWZIL0RP7V81s/ZwVdRg7F3SQ90C9Ry4uqKfg/z0RvUzlnKpJwXnmU2aYOYdvBuNv5VcV9
 VXMDKt5yMd9gnMIFy4I0fvE5fSrMD3of5pQbdvAVRrunv30NpbfvCIOMolCigCm/sN6dBWNk1
 XX2D379UEVNZn5igCEIR7Qfun0yPlGV6kn4Xvvc/NVmTfWWUShlvJx2sgv5cq0PUxluRBBUn1
 8D5IazjmAWxQKwlTQg+hLnNWEb86nY4iUV4GXEvcP/MN2mkL2I8WdeE92HnAOYonifxrFe35T
 zI8ShilvLGSyaSaVPyo0AFinFYyN0peudd0C7bYUd6kOI+UZjuq4yodhHkbm8ArK6ZmVuoug2
 AwG466jpJBBejLObfFoMFP04tjc6pzV9lwGKeLiaUk5EwqJwg23z1HPmMqtFJuuaWzHy1QWKK
 UOZ+D5Wa9n/759TulRwWbo5MqZHGFoHtRLHYfBQB5bKHlgyXDQ92R+jqDbcROZp1R0cKVoFSJ
 NVxsK0Krg2OxHsg9lFdaWO/FhDiEBTEgEORfVMqUJ+a7QuTDEpZg8MIHwWGJCSysbPpEPTm0e
 AwmbtM7uU00T4aSz4k307DVcN1vO9OiKHsdHytiyQM9wBU21tSof/q2f8OW4fOJmTeHIFBbdi
 xsyg5aIpzXygxNQ4zYVmFPc6SMKoiM1EYH1lmz5OOwvYNSOhlj94d/W9KNdc0fW59DHsyY5IH
 XHqwAJ1zaN0Xr9G2qJlgXfv1sFD7kq/iBamx+7lb20e01n70fBJKD5q5/2wSSk1VZqB8l9NbZ
 Si0JY2zbCEbqv27pB+MHvcaWEz+2uFruZsdL1MdeSYHZUxkt4mUA9EdkTJZLXMWlxGMDl/LY6
 qv9YW2VPaF/4CdO6Q7iQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-12-03 at 12:03 +0100, Mike Galbraith wrote:
> On Thu, 2020-12-03 at 10:48 +0100, Sebastian Andrzej Siewior wrote:
> > On 2020-12-03 10:40:16 [+0100], Mike Galbraith wrote:
> > > In thread "scheduling while atomic in z3fold", I mentioned that of th=
e
> > > three pool methods, only zbud did not explode.  Below is the explosio=
n
> > > encountered when zsmalloc is used in conjunction with runltp -f mm.  =
As
> > > with the z3fold explosion, this one also seems to be highly repeatabl=
e,
> > > this from one of my full distro "my box plays russian dolls [1]" KVMs=
.
> >=20
> > great.
> >=20
> > > [ 5763.720268] kernel BUG at kernel/locking/rtmutex.c:1057!
> > =E2=80=A6
> > > [ 5763.726016] RAX: 00000000ffffffdd RBX: ffff903f77c68080 RCX: 00000=
00000000001
> >=20
> > That is a deadlock. Does lockdep say anything or does it disable the bu=
g
> > from happening?
>=20
> The later, for the first time it did not explode.  However...

Bare metal both moaned and went BUG().  zswap don't like RT much.

[  493.774076] BUG: spinlock bad magic on CPU#1, oom01/9152
[  493.774081]  lock: 0xffff8a33dec69560, .magic: 00000000, .owner: <none>/=
-1, .owner_cpu: 0
[  493.774084] CPU: 1 PID: 9152 Comm: oom01 Kdump: loaded Tainted: G S     =
     E     5.9.12-rt20-rt #21
[  493.774086] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  493.774087] Call Trace:
[  493.774088]  dump_stack+0x77/0x97
[  493.774094]  do_raw_spin_lock+0x71/0xc0
[  493.774097]  _raw_spin_lock_irqsave+0x45/0x50
[  493.774100]  ? rt_spin_lock_slowlock+0x3a/0x70
[  493.774101]  rt_spin_lock_slowlock+0x3a/0x70
[  493.774104]  rt_spin_lock+0x46/0xc0
[  493.774106]  ? zswap_frontswap_store+0x26e/0xa50
[  493.774109]  zswap_frontswap_store+0x26e/0xa50
[  493.774111]  ? rt_mutex_futex_unlock+0x56/0x80
[  493.774113]  __frontswap_store+0x6e/0x100
[  493.774116]  swap_writepage+0x37/0x70
[  493.774118]  shmem_writepage+0x267/0x400
[  493.774121]  pageout+0xd2/0x400
[  493.774125]  shrink_page_list+0xa6e/0xbd0
[  493.774129]  shrink_inactive_list+0x216/0x620
[  493.774134]  shrink_lruvec+0x39f/0x5e0
[  493.774141]  ? shrink_node+0x237/0x6e0
[  493.774142]  shrink_node+0x237/0x6e0
[  493.774145]  do_try_to_free_pages+0xb9/0x400
[  493.774148]  try_to_free_pages+0xe6/0x3b0
[  493.774152]  __alloc_pages_slowpath.constprop.108+0x3f8/0x1090
[  493.774158]  __alloc_pages_nodemask+0x3f6/0x480
[  493.774161]  alloc_pages_vma+0x135/0x190
[  493.774164]  handle_mm_fault+0x87c/0x16f0
[  493.774168]  ? lockdep_hardirqs_on+0x79/0x100
[  493.774173]  exc_page_fault+0x343/0x720
[  493.774174]  ? asm_exc_page_fault+0x1e/0x30
[  493.774176]  ? asm_exc_page_fault+0x8/0x30
[  493.774178]  asm_exc_page_fault+0x1e/0x30
[  493.774180] RIP: 0033:0x414300
[  493.774181] Code: e8 d5 f5 fe ff 48 83 f8 ff 0f 84 9c 00 00 00 41 83 fd =
02 48 89 c5 74 32 41 83 fd 03 74 74 49 63 c4 48 89 ea 66 0f 1f 44 00 00 <c6=
> 02 07 48 01 c2 48 89 d1 48 29 e9 48 39 cb 7f ef 31 c0 48 83 c4
[  493.774182] RSP: 002b:00007f17eb8ccec0 EFLAGS: 00010206
[  493.774184] RAX: 0000000000001000 RBX: 00000000c0000000 RCX: 000000000f7=
c5000
[  493.774185] RDX: 00007f12b888e000 RSI: 00000000c0000000 RDI: 00000000000=
00000
[  493.774185] RBP: 00007f12a90c9000 R08: ffffffffffffffff R09: 00000000000=
00000
[  493.774186] R10: 0000000000000022 R11: 0000000000000246 R12: 00000000000=
01000
[  493.774187] R13: 0000000000000001 R14: 0000000000000001 R15: 00007fffcfa=
8d4d0
[  495.792174] ------------[ cut here ]------------
[  495.792176] kernel BUG at kernel/locking/rtmutex.c:1057!
[  495.792181] invalid opcode: 0000 [#1] PREEMPT_RT SMP NOPTI
[  495.792184] CPU: 4 PID: 3466 Comm: kwin_x11 Kdump: loaded Tainted: G S  =
        E     5.9.12-rt20-rt #21
[  495.792185] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[  495.792186] RIP: 0010:rt_spin_lock_slowlock_locked+0x29c/0x2b0
[  495.792191] Code: 88 d0 00 01 e8 a5 a5 76 ff e9 ce fe ff ff 48 8b 43 48 =
48 85 c0 74 06 48 3b 58 38 75 0f 49 39 c4 0f 85 69 ff ff ff 0f 0b 0f 0b <0f=
> 0b e8 ed 23 77 ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f
[  495.792192] RSP: 0000:ffffa2524328b598 EFLAGS: 00010086
[  495.792194] RAX: 00000000ffffffdd RBX: ffff8a33ded29d20 RCX: 00000000000=
00000
[  495.792195] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8a33ded=
29d20
[  495.792196] RBP: ffff8a337a651b40 R08: 0000000000000001 R09: 00000000000=
00000
[  495.792196] R10: ffffa2524328b4b8 R11: ffff8a33defd5000 R12: ffffa252432=
8b5e0
[  495.792197] R13: ffff8a337a651b40 R14: ffff8a337a6524d0 R15: 00000000000=
00282
[  495.792198] FS:  00007fb8d31f3d80(0000) GS:ffff8a33ded00000(0000) knlGS:=
0000000000000000
[  495.792199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  495.792200] CR2: 00007efcde0bd020 CR3: 000000010755c005 CR4: 00000000001=
706e0
[  495.792201] Call Trace:
[  495.792205]  rt_spin_lock_slowlock+0x4b/0x70
[  495.792209]  rt_spin_lock+0x46/0xc0
[  495.792211]  ? zs_map_object+0x10d/0x3d0
[  495.792215]  zs_map_object+0x10d/0x3d0
[  495.792218]  zswap_frontswap_store+0x716/0xa50
[  495.792223]  __frontswap_store+0x6e/0x100
[  495.792225]  swap_writepage+0x37/0x70
[  495.792227]  pageout+0xd2/0x400
[  495.792232]  shrink_page_list+0xa6e/0xbd0
[  495.792237]  shrink_inactive_list+0x216/0x620
[  495.792242]  shrink_lruvec+0x39f/0x5e0
[  495.792249]  ? shrink_node+0x237/0x6e0
[  495.792250]  shrink_node+0x237/0x6e0
[  495.792254]  do_try_to_free_pages+0xb9/0x400
[  495.792256]  try_to_free_pages+0xe6/0x3b0
[  495.792261]  __alloc_pages_slowpath.constprop.108+0x3f8/0x1090
[  495.792263]  ? trace_hardirqs_on+0x35/0x130
[  495.792265]  ? asm_sysvec_call_function_single+0x12/0x20
[  495.792269]  ? trace_hardirqs_on+0x35/0x130
[  495.792271]  ? lock_acquire+0x201/0x420
[  495.792273]  ? _raw_spin_unlock_irqrestore+0x34/0x80
[  495.792275]  ? xas_descend+0x2e/0x120
[  495.792278]  __alloc_pages_nodemask+0x3f6/0x480
[  495.792281]  page_cache_readahead_unbounded+0x8a/0x200
[  495.792286]  filemap_fault+0x770/0xd50
[  495.792289]  ? filemap_map_pages+0x1e5/0x4f0
[  495.792292]  ext4_filemap_fault+0x2f/0x40 [ext4]
[  495.792315]  __do_fault+0x31/0x140
[  495.792318]  handle_mm_fault+0xf37/0x16f0
[  495.792323]  exc_page_fault+0x343/0x720
[  495.792326]  ? asm_exc_page_fault+0x8/0x30
[  495.792328]  ? asm_exc_page_fault+0x8/0x30
[  495.792330]  asm_exc_page_fault+0x1e/0x30
[  495.792331] RIP: 0033:0x7fb8d27439f6
[  495.792333] Code: ff ba ff ff ff ff f2 0f 10 05 ae cd 0a 00 48 39 d0 74 =
1f 48 8b 7b 28 e8 08 97 ea ff 48 85 c0 78 13 66 0f ef c0 f2 48 0f 2a c0 <f2=
> 0f 5e 05 72 3b 0c 00 5b c3 48 89 c2 66 0f ef c0 48 d1 ea 83 e0
[  495.792334] RSP: 002b:00007ffc24b74db0 EFLAGS: 00010246
[  495.792335] RAX: 0000000000000000 RBX: 0000564b8f45af90 RCX: 00007ffc24b=
74eb0
[  495.792336] RDX: 00000000ffffffff RSI: 00007fb8b4009920 RDI: 00007fb8b40=
020f0
[  495.792337] RBP: 0000564b8f379e90 R08: 0000000000000000 R09: 00007fb8d0a=
44360
[  495.792338] R10: 0000000000000001 R11: 0000000000000000 R12: 0000564b8f4=
5af90
[  495.792338] R13: 00007ffc24b74e68 R14: 00007ffc24b74e78 R15: 00000000000=
00006
[  495.792343] Modules linked in: fuse(E) msr(E) xt_comment(E) ebtable_filt=
er(E) ebtables(E) br_netfilter(E) xt_physdev(E) nfnetlink_cthelper(E) nfnet=
link(E) af_packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs=
(E) rfkill(E) xt_pkttype(E) xt_tcpudp(E) ip6t_REJECT(E) ipt_REJECT(E) iptab=
le_filter(E) bpfilter(E) ip6table_mangle(E) ip_tables(E) xt_conntrack(E) nf=
_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) libcrc32c(E) ip6table_fil=
ter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_cp437(E) joydev(E) in=
tel_rapl_msr(E) usblp(E) intel_rapl_common(E) at24(E) x86_pkg_temp_thermal(=
E) iTCO_wdt(E) intel_powerclamp(E) iTCO_vendor_support(E) coretemp(E) mei_h=
dcp(E) kvm_intel(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) kvm(E=
) ledtrig_audio(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_c=
lmulni_intel(E) snd_hda_codec_hdmi(E) aesni_intel(E) crypto_simd(E) cryptd(=
E) glue_helper(E) snd_hda_intel(E) snd_intel_dspcfg(E) snd_hda_codec(E) snd=
_hda_core(E) snd_hwdep(E)
[  495.792378]  pcspkr(E) snd_pcm(E) r8169(E) i2c_i801(E) snd_timer(E) i2c_=
smbus(E) lpc_ich(E) realtek(E) mdio_devres(E) snd(E) mei_me(E) libphy(E) so=
undcore(E) fan(E) thermal(E) mei(E) intel_smartconnect(E) tiny_power_button=
(E) sch_fq_codel(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sun=
rpc(E) hid_logitech_hidpp(E) sr_mod(E) cdrom(E) hid_logitech_dj(E) ums_real=
tek(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) wmi(E) i2c=
_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) e=
hci_pci(E) fb_sys_fops(E) ehci_hcd(E) cec(E) xhci_pci(E) ahci(E) rc_core(E)=
 libahci(E) xhci_hcd(E) ttm(E) libata(E) drm(E) usbcore(E) video(E) button(=
E) sd_mod(E) t10_pi(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_r=
ing(E) virtio(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) loop(E=
) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_al=
ua(E) scsi_mod(E)
[  495.792420] Dumping ftrace buffer:
[  495.792423]    (ftrace buffer empty)

bad magic
0xffffffff812bcf60 is in zswap_frontswap_store (mm/zswap.c:1087).
1082                    ret =3D -EINVAL;
1083                    goto freepage;
1084            }
1085
1086            /* compress */
1087            local_lock(&zswap_comp.lock);
1088            dst =3D *this_cpu_ptr(&zswap_comp.dstmem);
1089            tfm =3D *this_cpu_ptr(entry->pool->tfm);
1090            src =3D kmap_atomic(page);
1091            ret =3D crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dle=
n);

BUG()
0xffffffff812f6e90 is in zs_map_object (mm/zsmalloc.c:1401).
1396
1397            get_zspage_mapping(zspage, &class_idx, &fg);
1398            class =3D pool->size_class[class_idx];
1399            off =3D (class->size * obj_idx) & ~PAGE_MASK;
1400
1401            local_lock(&zs_map_area.lock);
1402            area =3D this_cpu_ptr(&zs_map_area);
1403            area->vm_mm =3D mm;
1404            if (off + class->size <=3D PAGE_SIZE) {
1405                    /* this object is contained entirely within a page =
*/


