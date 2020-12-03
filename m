Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83884C64E7C
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 02:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25558221EB
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 02:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgLCCSc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Dec 2020 21:18:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:57811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLCCSc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Dec 2020 21:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606961774;
        bh=2skB8aCmzq6dDMF6IK8Lo93lDruUxEaD4jrfymHSWYI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gogmm6l7roQjuQsJuE25Siqr8BvuY0N9sf6/PsU57Ngn+BLIGkDKvsvibqBnGFeo3
         q5cTmxXq9jKRB9achhymSg4Xos6GGzRnUXmnCouzszqEmhTjDgkHKfxj9/rRWaEgvi
         U83JiQEnl0giIJ7dzK4HO5UIR+gAl+udJxV2wQDI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1kqRat3AX7-005mkW; Thu, 03
 Dec 2020 03:16:14 +0100
Message-ID: <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
Subject: Re: scheduling while atomic in z3fold
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Date:   Thu, 03 Dec 2020 03:16:12 +0100
In-Reply-To: <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gzCigAg9onWa1Aqoc6zWJqyVUF3JkkH2Dk64Hun2h5p+wwryf7t
 wfKUwmppG/nyTXUQ9c9caw6za5jHhQHxJMjYTgOygZPwalxvCFjKbGWQmb6SR1h+TqDdS5c
 8YHWZivhGYS1k8/oXJowLGn7zoVN28DGoifNt8lmQek18IzkPQwdkMMIrkhXAn4vcWh7ocu
 iHtyysyQJw8SdbdEyEqQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6jyZYoie4Uk=:HUuO4gxdrQ0umfsbQ/Y48v
 ei4+2554XhixiiE1bFZhzZnzLdniSDVa6pVX1cQOv3leG+qtAb5YNbeYS+/1Ex/OtShB47sBz
 bqg3W0m0Y4XhLSVisFL1LGFWti2eEPj6E4vBCscXtdHPowQqjyzl9YMbBfB+BGi+LOrUkq/so
 FsUSPeyGBKYKOGQrXYVMN41/w26Tytj7VrjJAlbFM2rMx+TVWXBBkrKsgK/mPXHfgm/CYvxZk
 /9SqSDqEp9f1dn/19azrFJ+YcxQSjCEZ/6bOjq/ldYBcjLiQezDFCU74r39S4LU+G+Xs8OkrA
 9Oiz3gTWiYc4DzhHuzClcW4KSbQGaPxJnzbz9rfyWX0rE3TmV4x1Sk9ebtLEYJy+SG0eBdro6
 FvSSn5CT6CYhQrr86UcC6d5PgY4o9ocK+ewOO4e4+rCjdouecua463LSEnmmdlGBeJrABHhPm
 IZhuCZFTGR6aBSePL5Qj3182ZAi53RcrxcsLjWFQSdaRdhttCp2LR6NTQ8fL+oJzKtPRbeUEM
 vCEl9CqIkzfN8G/jZj18L6TdRrc6hpF2+6A1nwwrhxB2+96Yiqg8VaHO5QOUrrAVHQpxhMWtW
 dk7XmKzGb29MtFJ68MH2eQ78e06QUc4wyf/j/jZPRC28IWc+ITMSs+7hjgFfAzEsZpE1xB4II
 XxnvJoN/hYhWZb2uKmQq9hARfqH2hj3hScYr0EbChCzDhY8dKlgv35J7JXLbmvD5jLxv4xpGe
 GXV0MnqdTtSwLki8dI/blDRurwTTguSDvfwU2rPzbPeq/RURFvFGryqenZGRFwhzYF787odRg
 xzWG53Pa+/CW4bnEDr9+sK5uUd8er1UgUe3zO+tj5BIMqxNSi6Ug40H463lUp3vXjvW+C17G3
 NRm+lx3r9mHUDHdOxaqQ==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2020-12-02 at 23:08 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-02 03:30:27 [+0100], Mike Galbraith wrote:
>
> > What I'm seeing is the below.  rt_mutex_has_waiters() says yup we have
> > a waiter, rt_mutex_top_waiter() emits the missing cached leftmost, and
> > rt_mutex_dequeue_pi() chokes on it.  Lock is buggered.
>
> correct. So this:
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -342,7 +342,7 @@ static inline void free_handle(unsigned long handle)
>
>  	if (is_free) {
>  		struct z3fold_pool *pool =3D slots_to_pool(slots);
> -
> +		memset(slots, 0xee, sizeof(struct z3fold_buddy_slots));
>  		kmem_cache_free(pool->c_handle, slots);
>  	}
>  }
> @@ -548,8 +549,10 @@ static void __release_z3fold_page(struct z3fold_hea=
der *zhdr, bool locked)
>  		set_bit(HANDLES_ORPHANED, &zhdr->slots->pool);
>  	read_unlock(&zhdr->slots->lock);
>
> -	if (is_free)
> +	if (is_free) {
> +		memset(zhdr->slots, 0xdd, sizeof(struct z3fold_buddy_slots));
>  		kmem_cache_free(pool->c_handle, zhdr->slots);
> +	}
>
>  	if (locked)
>  		z3fold_page_unlock(zhdr);
>
> resulted in:
>
> |[  377.200696] Out of memory: Killed process 284358 (oom01) total-vm:15=
780488kB, anon-rss:150624kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:1=
6760kB oom_score_adj:0
> |[  377.205438] ------------[ cut here ]------------
> |[  377.205441] pvqspinlock: lock 0xffff8880105c6828 has corrupted value=
 0xdddddddd!
> |[  377.205448] WARNING: CPU: 6 PID: 72 at kernel/locking/qspinlock_para=
virt.h:498 __pv_queued_spin_unlock_slowpath+0xb3/0xc0
> |[  377.205455] Modules linked in:
> |[  377.205456] CPU: 6 PID: 72 Comm: oom_reaper Not tainted 5.10.0-rc6-r=
t13-rt+ #103
> |[  377.205458] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.14.0-1 04/01/2014
> |[  377.205460] RIP: 0010:__pv_queued_spin_unlock_slowpath+0xb3/0xc0
> =E2=80=A6
> |[  377.205475] Call Trace:
> |[  377.205477]  __raw_callee_save___pv_queued_spin_unlock_slowpath+0x11=
/0x20
> |[  377.205481]  .slowpath+0x9/0xe
> |[  377.205483]  _raw_spin_unlock_irqrestore+0x5/0x50
> |[  377.205486]  rt_mutex_futex_unlock+0x9e/0xb0
> |[  377.205488]  z3fold_free+0x2b0/0x470
> |[  377.205491]  zswap_free_entry+0x7d/0xc0
> |[  377.205493]  zswap_frontswap_invalidate_page+0x87/0x90
> |[  377.205495]  __frontswap_invalidate_page+0x58/0x90
> |[  377.205496]  swap_range_free.constprop.0+0x99/0xb0
> |[  377.205499]  swapcache_free_entries+0x131/0x390
> |[  377.205501]  free_swap_slot+0x99/0xc0
> |[  377.205502]  __swap_entry_free+0x8a/0xa0
> |[  377.205504]  free_swap_and_cache+0x36/0xd0
> |[  377.205506]  zap_pte_range+0x16a/0x940
> |[  377.205509]  unmap_page_range+0x1d8/0x310
> |[  377.205514]  __oom_reap_task_mm+0xe7/0x190
> |[  377.205520]  oom_reap_task_mm+0x5a/0x280
> |[  377.205521]  oom_reaper+0x98/0x1c0
> |[  377.205525]  kthread+0x18c/0x1b0
> |[  377.205528]  ret_from_fork+0x22/0x30
> |[  377.205531] ---[ end trace 0000000000000002 ]---
>
> Then I reverted commit
>    4a3ac9311dac3 ("mm/z3fold.c: add inter-page compaction")
>
> and it seems to work now. Any suggestions? It looks like use-after-free.

Looks like...

d8f117abb380 z3fold: fix use-after-free when freeing handles

...wasn't completely effective.  write_unlock() in handle_free() is
where I see explosions.  Only trouble is that 4a3ac9311dac3 arrived in
5.5, and my 5.[5-7]-rt refuse to reproduce (d8f117abb380 applied),
whereas 5.9 and 5.10 do so quite reliably.  There is a heisenbug aspect
though, one trace_printk() in handle_free() made bug go hide, so the
heisen-fairies in earlier trees were probably just messing with me..
because they can, being the twisted little freaks they are ;-)

	-Mike

