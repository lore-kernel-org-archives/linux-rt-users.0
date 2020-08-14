Return-Path: <SRS0=y2gO=BY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A32C433E1
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 17:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BAA20791
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Aug 2020 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgHNRuF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:50:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:46682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgHNRuE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Aug 2020 13:50:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33FD7B69F;
        Fri, 14 Aug 2020 17:50:24 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH -RT] net: xfrm: fix compress vs decompress serialization
Date:   Fri, 14 Aug 2020 10:37:00 -0700
Message-Id: <20200814173700.1532-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The following splat was seen when running ltp's 'tcp4_ipsec06' stresser on v4.x
based RT kernels:

[   82.523064] BUG: unable to handle kernel paging request at ffffbfbec0c0bf64
[   82.523085] IP: deflate_slow+0x32/0x400
[   82.523086] PGD 3e10d067 P4D 3e10d067 PUD 3e10e067 PMD 3a5ea067 PTE 0
[   82.523091] Oops: 0000 [#1] PREEMPT SMP PTI
[   82.523101] CPU: 0 PID: 5883 Comm: netstress Not tainted 4.12.14-14.26-rt #1 SLE15-SP1
[   82.523102] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.opensuse.org 04/01/2014
[   82.523105] task: ffff9c703731cc40 task.stack: ffffbfbec0fc4000
[   82.523108] RIP: 0010:deflate_slow+0x32/0x400
[   82.523112] RSP: 0018:ffffbfbec0fc7a48 EFLAGS: 00010202
[   82.523114] RAX: 000000000008581c RBX: ffffbfbec0b85000 RCX: 0000000000000005
[   82.523115] RDX: ffffbfbec0b86748 RSI: 000000000000001a RDI: 000000000008c660
[   82.523116] RBP: 0000000000000005 R08: 0000000000000027 R09: 0000000000000027
[   82.523117] R10: ffffbfbec0b86748 R11: 0000000000000053 R12: 00000000000005c5
[   82.523118] R13: 00000000000005c5 R14: ffffbfbec0b85000 R15: 00000000000005c8
[   82.523120] FS:  00007fc9da6ec700(0000) GS:ffff9c703fc00000(0000) knlGS:0000000000000000
[   82.523121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   82.523122] CR2: ffffbfbec0c0bf64 CR3: 000000002fd16000 CR4: 00000000000006f0
[   82.523126] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   82.523127] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   82.523127] Call Trace:
[   82.523168]  zlib_deflate+0xae/0x3b0
[   82.523181]  deflate_compress+0x5d/0x90 [deflate]
[   82.523186]  ipcomp_output+0xf0/0x1b0 [xfrm_ipcomp]
[   82.523191]  xfrm_output_resume+0x391/0x480
[   82.523199]  ? skb_mac_gso_segment+0xad/0x110
[   82.523202]  xfrm_output+0xd4/0x1d0
[   82.523206]  xfrm4_output+0x2c/0xc0
[   82.523209]  ? xfrm4_udp_encap_rcv+0x1a0/0x1a0
[   82.523213]  ip_queue_xmit+0x145/0x3e0
[   82.523217]  __tcp_transmit_skb+0x513/0x9c0
[   82.523220]  tcp_write_xmit+0x1ba/0xf00
[   82.523223]  __tcp_push_pending_frames+0x31/0xd0
[   82.523225]  tcp_sendmsg_locked+0x395/0xbd0
[   82.523228]  tcp_sendmsg+0x27/0x40
[   82.523231]  sock_sendmsg+0x36/0x40
[   82.523237]  SYSC_sendto+0x10e/0x140
[   82.523240]  ? sock_setsockopt+0x2aa/0xa30
[   82.523245]  ? kvm_clock_read+0x21/0x50
[   82.523249]  ? ktime_get_ts64+0x4c/0xe0
[   82.523253]  ? SyS_poll+0x70/0x100
[   82.523257]  do_syscall_64+0x74/0x150
[   82.523267]  entry_SYSCALL_64_after_hwframe+0x59/0xbe
[   82.523279] RIP: 0033:0x7fc9db4c348a
[   82.523280] RSP: 002b:00007fc9da6cbd00 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   82.523282] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc9db4c348a
[   82.523283] RDX: 000000000000ffff RSI: 00007fc9da6dbd90 RDI: 0000000000000007
[   82.523284] RBP: 00007fc9da6dbd90 R08: 0000000000000000 R09: 0000000000000000
[   82.523285] R10: 0000000000004000 R11: 0000000000000246 R12: 000000000000ffff
[   82.523286] R13: 0000556d7d69fca4 R14: 0000000000000259 R15: 0000000000000001
[   82.523287] Code: 55 53 89 f5 8b 87 9c 00 00 00 48 89 fb 3d 05 01 00 00 0f 86 04 01 00 00 8b b3 94 00 00 00 48 8b 53 48 8d 46 02 8b 4b 78 23 73 40 <0f> b6 04 02 8b 53 68 d3 e2 31 d0 23 43 74 48 8b 53 60 89 43 68
[   82.523314] Modules linked in: ipcomp xfrm_ipcomp deflate authenc echainiv esp4 des3_ede_x86_64 des_generic xfrm4_mode_tunnel ah4 xfrm4_mode_transport ip6table_mangle ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_filter ip6_tables iptable_mangle iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c iptable_filter ip_tables x_tables xfrm_user xfrm_algo veth af_packet iscsi_ibft iscsi_boot_sysfs snd_hda_codec_generic ledtrig_audio snd_hda_intel ppdev snd_hda_codec snd_hda_core snd_hwdep pcspkr snd_pcm snd_timer joydev virtio_net snd net_failover failover parport_pc soundcore parport qemu_fw_cfg button i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace sunrpc btrfs xor zstd_decompress zstd_compress xxhash raid6_pq virtio_blk virtio_console virtio_scsi
[   82.523355]  hid_generic usbhid sr_mod cdrom ata_generic bochs_drm drm_kms_helper ata_piix ahci syscopyarea sysfillrect sysimgblt fb_sys_fops ehci_pci libahci ttm ehci_hcd drm libata serio_raw usbcore floppy virtio_pci virtio_ring virtio drm_panel_orientation_quirks sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod autofs4
[   82.523376] Supported: Yes
[   82.523379] CR2: ffffbfbec0c0bf64
[   82.582750] ---[ end trace 0000000000000002 ]---
[   82.582763] RIP: 0010:deflate_slow+0x32/0x400
[   82.582764] RSP: 0018:ffffbfbec0fc7a48 EFLAGS: 00010202
[   82.582765] RAX: 000000000008581c RBX: ffffbfbec0b85000 RCX: 0000000000000005
[   82.582765] RDX: ffffbfbec0b86748 RSI: 000000000000001a RDI: 000000000008c660
[   82.582766] RBP: 0000000000000005 R08: 0000000000000027 R09: 0000000000000027
[   82.582766] R10: ffffbfbec0b86748 R11: 0000000000000053 R12: 00000000000005c5
[   82.582767] R13: 00000000000005c5 R14: ffffbfbec0b85000 R15: 00000000000005c8
[   82.582768] FS:  00007fc9da6ec700(0000) GS:ffff9c703fc00000(0000) knlGS:0000000000000000
[   82.582769] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   82.582770] CR2: ffffbfbec0c0bf64 CR3: 000000002fd16000 CR4: 00000000000006f0
[   82.582772] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   82.582773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

ipcomp_compress() will serialize access to the ipcomp_scratches percpu buffer by
disabling BH and preventing a softirq from coming in and running ipcom_decompress(),
which is never called from process context. This of course won't work on RT and
the buffer can get corrupted; there have been similar issues with in the past with
such assumptions, ie: ebf255ed6c44 (net: add back the missing serialization in
ip_send_unicast_reply()).

Similarly, this patch addresses the issue with locallocks allowing RT to have a
percpu spinlock and do the correct serialization.

Addressing such races on an individual basis seemed like a game of whack a mole,
until afaict local_bh_enable() was reworked to use locallocks in 96fac673174
(softirq: Add preemptible softirq) which is why the BUG is not seen in newer kernels.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---

This applies on top of all v4.x based kernels -rt.

 net/xfrm/xfrm_ipcomp.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index ccfdc7115a83..f13871de6e0d 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/locallock.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -36,6 +37,7 @@ struct ipcomp_tfms {
 
 static DEFINE_MUTEX(ipcomp_resource_mutex);
 static void * __percpu *ipcomp_scratches;
+static DEFINE_LOCAL_IRQ_LOCK(ipcomp_scratches_lock);
 static int ipcomp_scratch_users;
 static LIST_HEAD(ipcomp_tfms_list);
 
@@ -45,12 +47,15 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
 	const int plen = skb->len;
 	int dlen = IPCOMP_SCRATCH_SIZE;
 	const u8 *start = skb->data;
-	const int cpu = get_cpu();
-	u8 *scratch = *per_cpu_ptr(ipcomp_scratches, cpu);
-	struct crypto_comp *tfm = *per_cpu_ptr(ipcd->tfms, cpu);
-	int err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
-	int len;
+	u8 *scratch;
+	struct crypto_comp *tfm;
+	int err, len;
+
+	local_lock(ipcomp_scratches_lock);
 
+	scratch = *this_cpu_ptr(ipcomp_scratches);
+	tfm = *this_cpu_ptr(ipcd->tfms);
+	err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
 	if (err)
 		goto out;
 
@@ -103,7 +108,7 @@ static int ipcomp_decompress(struct xfrm_state *x, struct sk_buff *skb)
 	err = 0;
 
 out:
-	put_cpu();
+	local_unlock(ipcomp_scratches_lock);
 	return err;
 }
 
@@ -146,6 +151,8 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
 	int err;
 
 	local_bh_disable();
+	local_lock(ipcomp_scratches_lock);
+
 	scratch = *this_cpu_ptr(ipcomp_scratches);
 	tfm = *this_cpu_ptr(ipcd->tfms);
 	err = crypto_comp_compress(tfm, start, plen, scratch, &dlen);
@@ -158,12 +165,14 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
 	}
 
 	memcpy(start + sizeof(struct ip_comp_hdr), scratch, dlen);
+	local_unlock(ipcomp_scratches_lock);
 	local_bh_enable();
 
 	pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
 	return 0;
 
 out:
+	local_unlock(ipcomp_scratches_lock);
 	local_bh_enable();
 	return err;
 }
-- 
2.26.2

