Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989CBC07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 05:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7962A61441
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 05:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGIFXv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 01:23:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:58739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhGIFXv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 01:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625808065;
        bh=7nKH0GrYlNhbhuxrrfh2xRDcCzSESk1+6MX/MWaqWIo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gkanl/4qlGch7m05rnxcNMAUpNowQ8VfF60cHW1uB9bHh9s2tEeZb9jSoVrXax4rK
         Fahovukng9mIdvB5WQGJUcuM/91t8y7xiw34uqfJnKP2PtYGOKU0RIU2Vg9sGP0HVv
         74XZGCbbMZ8fIAlaw65GgXQMCJ5Dxij/pKU3iQXI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.33]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1l4Pbi2H39-016AEr; Fri, 09
 Jul 2021 07:21:05 +0200
Message-ID: <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
Subject: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Fri, 09 Jul 2021 07:21:04 +0200
In-Reply-To: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X2IAI+kOnQiDC/y7UbdJ5agqyOujLXNSMmX0WEOWAakKmyafcfi
 cRXzktX/fOvNmGks3etRbkpPEtWkw8xFTCW3rMWw62jTveOwFa6W5c0ErJ/1eNIqYtHheah
 EYOtH7mw3/MJlqRsl9SxVKYR24o4Gng6bfpo8HCfOAI9rP7Nf3r+VaDAevoSE05NfOBvGYi
 +Mdl1uhFLtdQPwGW0nB1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sIQSvC9bZvo=:hsY3gcYp1Q8/JWAj/sBYxI
 JWsCXpQc0vasw6wdU1Fwm93IhI081DAxfHDjsxbkP5MUdIVEPmoXlcibIjgPUwuQhAyXqSGf7
 nmXpaFHFZDAwWPQTBf/XPpNETJhMWQJuaccq7AKp5l4bTzSvw2vdwqs3RT+YqFf6JdB8XiRmq
 mLjBGM+Nwcu3+7AY6OdwKbFSj8im5CVuqNcgE3jv1ywTUu9B9SGKEFjeQhSusvBNoq5/Y3Kvj
 bXU57HhHCwl6AXRwQX1ZfkdqXP/RUMsskO+ZrhU0zjxmbPmjaS94jTn9nwODnf6LfOmvhkPrx
 tDtbU6CdzVjSQ71sWU8jqP0WXEGITHXDEwGncgcMdQQoK5Z+MewQKn8SrKRM19QtLysq9Mmyd
 uMnCm3jO0vcJUTZvBZDI/vk7goQf/b7x0KG6gwXKbR0B+g6lCD412QcGpnSbq4YvFedHgp858
 avuRSgBSzgbdED7f5lkdn55Cr7/t3P2NrHtIom6iawOubVbVCsXbxi/45g2Q57V9EtB8PJbQr
 7CY7o7UTqPSRMC9qIAxMmw7OTqbXeRUjo3KrQO/We8rQByg2AQC384bm0iunvmdxgAoDsFNgW
 lrmHDx9yzj/IDUasvxytbzOHHKOSXxKPLYdnlBy/W6jqEiBPXD3ftTN0ZeHHu3htNWdBW6dr7
 Ix61iW+v6Axh5Y9+fqQ/Wt3zybFvX9RWy+vrZR9G8eoCvN+f+U/8BQ9HP7hF52pR9LoBM7gvc
 yXGN++l84vhQgaomF+1vU1Kc8y1Rbqga/u1ZNB3aRzW+TaO5hpmgIAONYfjWZRQfnEBkPLtKd
 LcEJvieOLz93wVEoXSgldrUaUZuYX7ZUWH2GvJMDX7mKtOVKnGvrtqc5F7Z5hFBgwKQUHk6d9
 c8hraciFJFQb/JGP/+30PxXqRU1Wf1AQtX3+xAl2F++DjtbqywEOg1ep1707VugBFdS87r9Mn
 hDlFv7yfs38XNZWKy8//v7Xbd9mxYpPT4zVi6A7V8YM8Ey/Oyn/ak2GMI8rtLJ1iIBLm88d5S
 mY22TSAR/zPMKiRobaTeOxubCZ1EBfb9gW52BcnS0wvQhaGaMbc2051vomlWAxhBOWHdT8r3l
 yXTIMaNvcKs4WcTwnH3R4xHVBZEGbNtYxqu
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Well, bug report in patch for actually.

Empirical evidence that PREEMPT_RT exclusion around unfreeze_partials()
is buggy lies in the readily reproducable PREEMPT_RT+SLUB_CPU_PARTIAL=3Dy
explosion below, which this patch precludes.  Slub expertise required.

Dirt simple reproduction method:

terminal1:
while ! [ -f "/stop" ]; do
	./runltp -f zram; hackbench.sh; ./runltp -f controllers;
done

terminal2:
while ! [ -f "/stop" ]; do
	ccache -C; make clean; make -j8;
done

Wait for it...

[ 1321.540157] general protection fault, maybe for address 0xffffea0004624e=
a8: 0000 [#1] PREEMPT_RT SMP NOPTI
[ 1321.540162] CPU: 3 PID: 18442 Comm: dd Kdump: loaded Tainted: G         =
   E     5.13.1-rt1-rt #5
[ 1321.540165] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/=
23/2013
[ 1321.540166] RIP: 0010:___slab_alloc.constprop.95+0x102/0xb00
[ 1321.540172] Code: 18 4d 85 db 66 89 55 b8 0f 95 c2 83 e0 7f c1 e2 07 09 =
d0 88 45 bb 41 f6 45 0b 40 4c 8b 65 b8 74 19 4c 89 d8 4c 89 f2 4c 89 e1 <f0=
> 49 0f c7 4f 20 0f 84 c6 00 00 00 f3 90 eb ab 4c 89 5d 80 9c 8f
[ 1321.540174] RSP: 0018:ffff8883008b3b70 EFLAGS: 00010202
[ 1321.540176] RAX: 0000000000190015 RBX: 0000000000000000 RCX: 00000001fff=
f7fff
[ 1321.540177] RDX: 00000001ffffffff RSI: 0000000000000023 RDI: ffffffff81e=
52c48
[ 1321.540179] RBP: ffff8883008b3c50 R08: ffffffffffffffff R09: 00000000000=
00000
[ 1321.540180] R10: ffff8883008b3c70 R11: 0000000000190015 R12: 00000001fff=
f7fff
[ 1321.540181] R13: ffff88810019dd00 R14: 00000001ffffffff R15: ffffea00046=
24e88
[ 1321.540182] FS:  00007fb763c4b580(0000) GS:ffff88840ecc0000(0000) knlGS:=
0000000000000000
[ 1321.540184] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1321.540185] CR2: 00007fb763c8b000 CR3: 0000000193f2c002 CR4: 00000000001=
706e0
[ 1321.540187] Call Trace:
[ 1321.540191]  ? __alloc_file+0x26/0xe0
[ 1321.540196]  ? migrate_enable+0x9c/0x100
[ 1321.540201]  ? __alloc_file+0x26/0xe0
[ 1321.540204]  ? __slab_alloc.isra.81.constprop.94+0x3d/0x50
[ 1321.540206]  ? __alloc_file+0x26/0xe0
[ 1321.540208]  __slab_alloc.isra.81.constprop.94+0x3d/0x50
[ 1321.540210]  ? __alloc_file+0x26/0xe0
[ 1321.540212]  kmem_cache_alloc+0xba/0x450
[ 1321.540215]  __alloc_file+0x26/0xe0
[ 1321.540218]  alloc_empty_file+0x43/0xe0
[ 1321.540221]  path_openat+0x35/0xe30
[ 1321.540224]  ? ___slab_alloc.constprop.95+0x48e/0xb00
[ 1321.540227]  ? filemap_map_pages+0xf0/0x3e0
[ 1321.540230]  ? getname_flags+0x32/0x170
[ 1321.540233]  do_filp_open+0xa2/0x100
[ 1321.540237]  ? getname_flags+0x32/0x170
[ 1321.540240]  ? migrate_enable+0x9c/0x100
[ 1321.540242]  ? __slab_alloc.isra.81.constprop.94+0x45/0x50
[ 1321.540245]  ? alloc_fd+0xe2/0x1b0
[ 1321.540249]  ? do_sys_openat2+0x248/0x310
[ 1321.540250]  do_sys_openat2+0x248/0x310
[ 1321.540253]  do_sys_open+0x47/0x60
[ 1321.540255]  do_syscall_64+0x39/0x80
[ 1321.540259]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1321.540262] RIP: 0033:0x7fb76378cb41
[ 1321.540264] Code: 41 83 e2 40 48 89 54 24 30 75 3e 89 f0 25 00 00 41 00 =
3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48=
> 3d 00 f0 ff ff 77 3f 48 8b 4c 24 18 64 48 33 0c 25 28 00 00 00
[ 1321.540266] RSP: 002b:00007fff10f2ad30 EFLAGS: 00000287 ORIG_RAX: 000000=
0000000101
[ 1321.540268] RAX: ffffffffffffffda RBX: 0000563c1c09e170 RCX: 00007fb7637=
8cb41
[ 1321.540269] RDX: 0000000000080000 RSI: 0000563c1c09e140 RDI: 00000000fff=
fff9c
[ 1321.540271] RBP: 00007fff10f2ae70 R08: 0000000000000000 R09: 00007fff10f=
2ae83
[ 1321.540272] R10: 0000000000000000 R11: 0000000000000287 R12: 0000563c1c0=
9df48
[ 1321.540273] R13: 000000000000000a R14: 0000563c1c09df20 R15: 00000000000=
0000a
[ 1321.540275] Modules linked in: zram(E) sr_mod(E) cdrom(E) btrfs(E) blake=
2b_generic(E) xor(E) raid6_pq(E) xfs(E) libcrc32c(E) af_packet(E) ip6table_=
mangle(E) ip6table_raw(E) iptable_raw(E) bridge(E) stp(E) llc(E) iscsi_ibft=
(E) iscsi_boot_sysfs(E) nfnetlink(E) ebtable_filter(E) rfkill(E) ebtables(E=
) ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E) x_tables(=
E) bpfilter(E) joydev(E) usblp(E) intel_rapl_msr(E) mei_hdcp(E) at24(E) reg=
map_i2c(E) iTCO_wdt(E) intel_pmc_bxt(E) iTCO_vendor_support(E) intel_rapl_c=
ommon(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) nls_iso885=
9_1(E) nls_cp437(E) kvm_intel(E) snd_hda_codec_realtek(E) snd_hda_codec_gen=
eric(E) kvm(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) irqbypass(E) snd_hda_=
intel(E) crct10dif_pclmul(E) snd_intel_dspcfg(E) crc32_pclmul(E) ghash_clmu=
lni_intel(E) snd_hda_codec(E) aesni_intel(E) snd_hwdep(E) crypto_simd(E) sn=
d_hda_core(E) cryptd(E) r8169(E) snd_pcm(E) snd_timer(E) realtek(E) mei_me(=
E) mdio_devres(E) i2c_i801(E)
[ 1321.540320]  lpc_ich(E) snd(E) pcspkr(E) i2c_smbus(E) mfd_core(E) libphy=
(E) soundcore(E) mei(E) fan(E) thermal(E) intel_smartconnect(E) nfsd(E) aut=
h_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sch_fq_codel(E) sunrpc(E) fuse(E) =
configfs(E) hid_logitech_hidpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) =
hid_generic(E) usbhid(E) nouveau(E) wmi(E) drm_ttm_helper(E) ttm(E) i2c_alg=
o_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sy=
s_fops(E) ahci(E) cec(E) xhci_pci(E) libahci(E) rc_core(E) ehci_pci(E) xhci=
_hcd(E) ehci_hcd(E) libata(E) drm(E) usbcore(E) video(E) button(E) sd_mod(E=
) t10_pi(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_ring(E) virt=
io(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_=
multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_=
mod(E) msr(E) autofs4(E) [last unloaded: zram]
[ 1321.540366] Dumping ftrace buffer:
[ 1321.540369]    (ftrace buffer empty)

Not-signed-off-by: Mike Galbraith <efault@gmx.de>
---
 mm/slub.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2497,7 +2497,9 @@ static void put_cpu_partial(struct kmem_
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
+				local_lock(&s->cpu_slab->lock);
 				unfreeze_partials(s);
+				local_unlock(&s->cpu_slab->lock);
 				oldpage =3D NULL;
 				pobjects =3D 0;
 				pages =3D 0;
@@ -2579,7 +2581,9 @@ static void flush_cpu_slab(struct work_s
 	if (c->page)
 		flush_slab(s, c, true);
=20
+	local_lock(&s->cpu_slab->lock);
 	unfreeze_partials(s);
+	local_unlock(&s->cpu_slab->lock);
 }
=20
 static bool has_cpu_slab(int cpu, struct kmem_cache *s)
@@ -2632,8 +2636,11 @@ static int slub_cpu_dead(unsigned int cp
 	struct kmem_cache *s;
=20
 	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_caches, list)
+	list_for_each_entry(s, &slab_caches, list) {
+		local_lock(&s->cpu_slab->lock);
 		__flush_cpu_slab(s, cpu);
+		local_unlock(&s->cpu_slab->lock);
+	}
 	mutex_unlock(&slab_mutex);
 	return 0;
 }

