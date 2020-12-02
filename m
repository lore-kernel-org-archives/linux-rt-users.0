Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB09C6369E
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Dec 2020 22:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8453217A0
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Dec 2020 22:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLBWJL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgLBWJK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Dec 2020 17:09:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAB1C0613D6;
        Wed,  2 Dec 2020 14:08:30 -0800 (PST)
Date:   Wed, 2 Dec 2020 23:08:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606946908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XxOB6F+LnujEtHB3vQmfofIYQi5z1d+MUmzfejiYNiM=;
        b=TTzAzbjQmB01rIGsn03p4Hjz+usVBRI6N5BLQ7luNfbGJV7lygU9ResZc1KTxVjtoLvHRy
        E+0qdtMAnwwCgGtZF7TL2O+9NxMfBwdiAeeR2diUCJ+vgpOXARu3LRghOsWUi8FEJbQJuN
        Jt99MxjwG7PN59jw781LoNr/akdtTMWuMH5DWGmZ918sNxqNSWFRroapUTM7lqEnFTo16R
        WtCx30tehaXsXbwRhiLLgRJ2Bpym6mHdB/aa0pxaHy1W6F7jHlThwR2ShiUSSy8vVSD274
        Mg/IDokLox1yK92rZ5wS/+XNXFo7dvT30GLhNX/LzK0nZYaKp+m1TlIqqjKoRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606946908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XxOB6F+LnujEtHB3vQmfofIYQi5z1d+MUmzfejiYNiM=;
        b=DLypuNkWd699vzfmubNfnlsuZYAc4K0+7ApG8WzQkV+Gsxlb65PGY1koqJyqI2aZMngjJN
        RM3OJ6iB9Y2zIAAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-02 03:30:27 [+0100], Mike Galbraith wrote:
> > > In an LTP install, ./runltp -f mm.  Shortly after box starts swapping
> > > insanely, it explodes quite reliably here with either z3fold or
> > > zsmalloc.. but not with zbud.
>=20
> What I'm seeing is the below.  rt_mutex_has_waiters() says yup we have
> a waiter, rt_mutex_top_waiter() emits the missing cached leftmost, and
> rt_mutex_dequeue_pi() chokes on it.  Lock is buggered.

correct. So this:

diff --git a/mm/z3fold.c b/mm/z3fold.c
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -342,7 +342,7 @@ static inline void free_handle(unsigned long handle)
=20
 	if (is_free) {
 		struct z3fold_pool *pool =3D slots_to_pool(slots);
-
+		memset(slots, 0xee, sizeof(struct z3fold_buddy_slots));
 		kmem_cache_free(pool->c_handle, slots);
 	}
 }
@@ -548,8 +549,10 @@ static void __release_z3fold_page(struct z3fold_header=
 *zhdr, bool locked)
 		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
 	read_unlock(&zhdr->slots->lock);
=20
-	if (is_free)
+	if (is_free) {
+		memset(zhdr->slots, 0xdd, sizeof(struct z3fold_buddy_slots));
 		kmem_cache_free(pool->c_handle, zhdr->slots);
+	}
=20
 	if (locked)
 		z3fold_page_unlock(zhdr);

resulted in:

|[  377.200696] Out of memory: Killed process 284358 (oom01) total-vm:15780=
488kB, anon-rss:150624kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:16760=
kB oom_score_adj:0
|[  377.205438] ------------[ cut here ]------------
|[  377.205441] pvqspinlock: lock 0xffff8880105c6828 has corrupted value 0x=
dddddddd!
|[  377.205448] WARNING: CPU: 6 PID: 72 at kernel/locking/qspinlock_paravir=
t.h:498 __pv_queued_spin_unlock_slowpath+0xb3/0xc0
|[  377.205455] Modules linked in:
|[  377.205456] CPU: 6 PID: 72 Comm: oom_reaper Not tainted 5.10.0-rc6-rt13=
-rt+ #103
|[  377.205458] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.=
14.0-1 04/01/2014
|[  377.205460] RIP: 0010:__pv_queued_spin_unlock_slowpath+0xb3/0xc0
=E2=80=A6
|[  377.205475] Call Trace:
|[  377.205477]  __raw_callee_save___pv_queued_spin_unlock_slowpath+0x11/0x=
20
|[  377.205481]  .slowpath+0x9/0xe
|[  377.205483]  _raw_spin_unlock_irqrestore+0x5/0x50
|[  377.205486]  rt_mutex_futex_unlock+0x9e/0xb0
|[  377.205488]  z3fold_free+0x2b0/0x470
|[  377.205491]  zswap_free_entry+0x7d/0xc0
|[  377.205493]  zswap_frontswap_invalidate_page+0x87/0x90
|[  377.205495]  __frontswap_invalidate_page+0x58/0x90
|[  377.205496]  swap_range_free.constprop.0+0x99/0xb0
|[  377.205499]  swapcache_free_entries+0x131/0x390
|[  377.205501]  free_swap_slot+0x99/0xc0
|[  377.205502]  __swap_entry_free+0x8a/0xa0
|[  377.205504]  free_swap_and_cache+0x36/0xd0
|[  377.205506]  zap_pte_range+0x16a/0x940
|[  377.205509]  unmap_page_range+0x1d8/0x310
|[  377.205514]  __oom_reap_task_mm+0xe7/0x190
|[  377.205520]  oom_reap_task_mm+0x5a/0x280
|[  377.205521]  oom_reaper+0x98/0x1c0
|[  377.205525]  kthread+0x18c/0x1b0
|[  377.205528]  ret_from_fork+0x22/0x30
|[  377.205531] ---[ end trace 0000000000000002 ]---

Then I reverted commit
   4a3ac9311dac3 ("mm/z3fold.c: add inter-page compaction")

and it seems to work now. Any suggestions? It looks like use-after-free.

Sebastian
