Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C792CC07E95
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Jul 2021 08:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9246120E
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Jul 2021 08:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhGTIRB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 04:17:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36388 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbhGTIQl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Jul 2021 04:16:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45C46223CA;
        Tue, 20 Jul 2021 08:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626771439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grb/S/RuW6nH3wzieOihi6TkPMlwKA81EGgqAxwLsbU=;
        b=oxZQplEgMpxobDgOO5Y7CDHKSifDgMCTz/0EYm3auTRZiIPUnIswdwqoNeUepOxlBn+UtD
        2VuvtYxYFX8D0I5kjLUxSiSdQLpOZQTSezIHUfF4fqvetvJOWpNpPpODuSq++VzK8gUSMf
        v5MaEXEUtucBmHa5pFydNjdmhOqDc5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626771439;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grb/S/RuW6nH3wzieOihi6TkPMlwKA81EGgqAxwLsbU=;
        b=psKMihqSG2BYvHx1wrR+jxr9ulT5W7r6Lp0XbwOEzvCp+a262kJEHI2TiBG+T+b1cEn8u2
        BSXD2FsoWe8+mOCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2447713A2E;
        Tue, 20 Jul 2021 08:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 9A8fCO+P9mDvEgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 20 Jul 2021 08:57:19 +0000
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
To:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
 <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
 <878s2fnv79.ffs@nanos.tec.linutronix.de>
 <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
 <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
Date:   Tue, 20 Jul 2021 10:56:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/15/21 6:34 PM, Mike Galbraith wrote:
> Greetings crickets,
> 
> Methinks he problem is the hole these patches opened only for RT.
> 
> static void put_cpu_partial(struct kmem_cache *s, struct page *page,
> int drain)
> {
> #ifdef CONFIG_SLUB_CPU_PARTIAL
> 	struct page *oldpage;
> 	int pages;
> 	int pobjects;
> 
> 	slub_get_cpu_ptr(s->cpu_slab);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> That is an assertion that the stuff under it is preempt safe for RT and
> ONLY RT.  My box says the RT portion of that assertion is horse pookey.
> What it does is let kmem_cache_free()/kfree() blast straight through
> ___slab_alloc() critical sections, swapping out ->partial underneath
> it.  Sprinkling percpu fingerprint power about, I saw lots of
> ___slab_alloc() preempts put_cpu_partial().. and vice versa.  I don't
> think it's a coincidence that ___slab_alloc() and __unfreeze_partials()
> both explode trying to access page->freelist.  You've seen the former,
> here's one of the later.
> 
> crash> bt -sx
> PID: 18761  TASK: ffff88812fff0000  CPU: 0   COMMAND: "hackbench"
>  #0 [ffff88818f8ff980] machine_kexec+0x14f at ffffffff81051c8f
>  #1 [ffff88818f8ff9c8] __crash_kexec+0xd2 at ffffffff8111ef72
>  #2 [ffff88818f8ffa88] crash_kexec+0x30 at ffffffff8111fd10
>  #3 [ffff88818f8ffa98] oops_end+0xd3 at ffffffff810267e3
>  #4 [ffff88818f8ffab8] exc_general_protection+0x195 at ffffffff8179fdb5
>  #5 [ffff88818f8ffb50] asm_exc_general_protection+0x1e at ffffffff81800a0e
>     [exception RIP: __unfreeze_partials+156]

Hm going back to this report, if that's a direct result of __slab_alloc
preempting (interrupting) put_cpu_partial() then I think that's
something that could happen even on !RT as all we do in the
put_cpu_partial() there is disable preemption, and the allocation could
come in irq handler.
It would mean the whole idea of "mm, slub: detach percpu partial list in
unfreeze_partials() using this_cpu_cmpxchg()" isn't safe. I'll have to
ponder it.
But we didn't see crashes on !RT yet. So could it be that it was still
put_cpu_partial() preempting __slab_alloc() messing the partial list,
but for some reason the put_cpu_partial() side crashed this time?

>     RIP: ffffffff81248bac  RSP: ffff88818f8ffc00  RFLAGS: 00010202
>     RAX: 0000000000200002  RBX: 0000000000200002  RCX: 000000017fffffff
>     RDX: 00000001ffffffff  RSI: 0000000000000202  RDI: ffff888100040b80
>     RBP: ffff88818f8ffca0   R8: ffff88818f9cba30   R9: 0000000000000001
>     R10: ffff88818f8ffcc0  R11: 0000000000000000  R12: ffff888100043700
>     R13: ffff888100040b80  R14: 00000001ffffffff  R15: ffffea00046c0808
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #6 [ffff88818f8ffcb8] put_cpu_partial+0x8e at ffffffff81248ece
>  #7 [ffff88818f8ffcd8] consume_skb+0x2b at ffffffff815eddeb
>  #8 [ffff88818f8ffce8] unix_stream_read_generic+0x788 at ffffffff8170b238
>  #9 [ffff88818f8ffdc0] unix_stream_recvmsg+0x43 at ffffffff8170b433
> #10 [ffff88818f8ffdf8] sock_read_iter+0x104 at ffffffff815dd554
> #11 [ffff88818f8ffe68] new_sync_read+0x16a at ffffffff812674fa
> #12 [ffff88818f8ffee8] vfs_read+0x1ae at ffffffff81269c8e
> #13 [ffff88818f8fff00] ksys_read+0x40 at ffffffff8126a070
> #14 [ffff88818f8fff38] do_syscall_64+0x37 at ffffffff8179f5e7
> #15 [ffff88818f8fff50] entry_SYSCALL_64_after_hwframe+0x44 at ffffffff8180007c
>     RIP: 00007fbda4438f2e  RSP: 00007fff3bf9d798  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 00007fff3bf9e7a0  RCX: 00007fbda4438f2e
>     RDX: 0000000000001000  RSI: 00007fff3bf9d7a0  RDI: 0000000000000007
>     RBP: 00007fff3bf9e800   R8: 00007fff3bf9e6e0   R9: 00007fbda4641010
>     R10: 00007fbda4428028  R11: 0000000000000246  R12: 0000000000001000
> crash> dis __unfreeze_partials+156
> 0xffffffff81248bac <__unfreeze_partials+156>:   lock cmpxchg16b 0x20(%r15)
> crash> gdb list *__unfreeze_partials+156
> 0xffffffff81248bac is in __unfreeze_partials (mm/slub.c:475).
> 470             if (!disable_irqs)
> 471                     lockdep_assert_irqs_disabled();
> 472     #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
> 473         defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
> 474             if (s->flags & __CMPXCHG_DOUBLE) {
> 475                     if (cmpxchg_double(&page->freelist, &page->counters,
> 476                                        freelist_old, counters_old,
> 477                                        freelist_new, counters_new))
> 478                             return true;
> 479             } else
> crash> kmem ffffea00046c0808
>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
> ffffea00104b3000 412cc0000                0        c  2 8000000000003000 reserved,private
> crash
> 
> Regarding $subject, Lockdep thinks my hole plugging skills suck rocks
> (shrug, I've given it plentiful cause) but that's ok, I sometimes think
> the same of its bug reporting skills :)
> 
> [    2.459456] ============================================
> [    2.459456] WARNING: possible recursive locking detected
> [    2.459457] 5.14.0.g79e92006-tip-rt #83 Tainted: G            E
> [    2.459458] --------------------------------------------
> [    2.459458] rcuc/7/56 is trying to acquire lock:
> [    2.459459] ffff88840edf01c0 (&(&c->lock)->lock){+.+.}-{0:0}, at: kfree+0x280/0x670
> [    2.459466]
>                but task is already holding lock:
> [    2.459466] ffff88840edf4d60 (&(&c->lock)->lock){+.+.}-{0:0}, at: __slab_free+0x4d6/0x600
> [    2.459469]
> 
> live kernel snooping....
> 
> crash> ps | grep UN
> crash> bt -sx 56
> PID: 56     TASK: ffff888100c19a40  CPU: 7   COMMAND: "rcuc/7"
>  #0 [ffff888100c63e40] __schedule+0x2eb at ffffffff818969fb
>  #1 [ffff888100c63ec8] schedule+0x3b at ffffffff8189723b
>  #2 [ffff888100c63ee0] smpboot_thread_fn+0x18c at ffffffff810a90dc
>  #3 [ffff888100c63f18] kthread+0x1af at ffffffff810a27bf
>  #4 [ffff888100c63f50] ret_from_fork+0x1f at ffffffff81001cbf
> crash> task_struct ffff888100c19a40 | grep __state
>   __state = 1,
> crash> gdb list *__slab_free+0x4d6
> 0xffffffff812923c6 is in __slab_free (mm/slub.c:2568).
> 2563                                    /*
> 2564                                     * partial array is full. Move the existing
> 2565                                     * set to the per node partial list.
> 2566                                     */
> 2567                                    local_lock(&s->cpu_slab->lock);
> 2568                                    unfreeze_partials(s);
> 2569                                    local_unlock(&s->cpu_slab->lock);
> 2570                                    oldpage = NULL;
> 2571                                    pobjects = 0;
> 2572                                    pages = 0;
> crash> gdb list *kfree+0x280
> 0xffffffff81292770 is in kfree (mm/slub.c:3442).
> 3437                     * __slab_free() as that wouldn't use the cpu freelist at all.
> 3438                     */
> 3439                    void **freelist;
> 3440
> 3441                    local_lock(&s->cpu_slab->lock);
> 3442                    c = this_cpu_ptr(s->cpu_slab);
> 3443                    if (unlikely(page != c->page)) {
> 3444                            local_unlock(&s->cpu_slab->lock);
> 3445                            goto redo;
> 3446                    }
> crash>
> 
> Check, those are what's in the stacktrace below... but the allegedly
> deadlocked for real task is very much alive, as is the rest of box.
> 
>                other info that might help us debug this:
> [    2.459470]  Possible unsafe locking scenario:
> 
> [    2.459470]        CPU0
> [    2.459470]        ----
> [    2.459471]   lock(&(&c->lock)->lock);
> [    2.459471]   lock(&(&c->lock)->lock);
> [    2.459472]
>                 *** DEADLOCK ***
> 
> [    2.459472]  May be due to missing lock nesting notation
> 
> [    2.459472] 6 locks held by rcuc/7/56:
> [    2.459473]  #0: ffff88840edd9820 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip+0xc3/0x190
> [    2.459479]  #1: ffffffff82382b80 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xd0
> [    2.459484]  #2: ffffffff82382b80 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip+0xa0/0x190
> [    2.459487]  #3: ffffffff82382ac0 (rcu_callback){....}-{0:0}, at: rcu_do_batch+0x195/0x520
> [    2.459490]  #4: ffff88840edf4d60 (&(&c->lock)->lock){+.+.}-{0:0}, at: __slab_free+0x4d6/0x600
> [    2.459493]  #5: ffffffff82382b80 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xd0
> [    2.459496]
>                stack backtrace:
> [    2.459497] CPU: 7 PID: 56 Comm: rcuc/7 Tainted: G            E     5.14.0.g79e92006-tip-rt #83
> [    2.459498] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [    2.459499] Call Trace:
> [    2.459501]  dump_stack_lvl+0x44/0x57
> [    2.459504]  __lock_acquire+0xb7f/0x1ab0
> [    2.459508]  lock_acquire+0x2a6/0x340
> [    2.459510]  ? kfree+0x280/0x670
> [    2.459513]  ? __free_slab+0xa4/0x1b0
> [    2.459515]  rt_spin_lock+0x2a/0xd0
> [    2.459516]  ? kfree+0x280/0x670                   somewhere in the multiverse lies a dead rcuc/7
> [    2.459518]  kfree+0x280/0x670                 <== local_lock(&s->cpu_slab->lock); #2
> [    2.459521]  __free_slab+0xa4/0x1b0            ==> kfree(page_objcgs(page))
> [    2.459523]  __unfreeze_partials+0x1d8/0x330   ==> discard_slab(s, page);
> [    2.459526]  ? _raw_spin_unlock_irqrestore+0x30/0x80
> [    2.459530]  ? __slab_free+0x4de/0x600
> [    2.459532]  __slab_free+0x4de/0x600           <== local_lock(&s->cpu_slab->lock); #1
> [    2.459534]  ? find_held_lock+0x2d/0x90
> [    2.459536]  ? kmem_cache_free+0x276/0x630
> [    2.459539]  ? rcu_do_batch+0x1c3/0x520
> [    2.459540]  ? kmem_cache_free+0x364/0x630
> [    2.459542]  kmem_cache_free+0x364/0x630
> [    2.459544]  ? rcu_do_batch+0x195/0x520
> [    2.459546]  rcu_do_batch+0x1c3/0x520
> [    2.459547]  ? rcu_do_batch+0x195/0x520
> [    2.459550]  ? rcu_cpu_kthread+0x7e/0x4b0
> [    2.459552]  ? rcu_cpu_kthread+0x57/0x4b0
> [    2.459553]  rcu_core+0x2c3/0x590
> [    2.459555]  ? rcu_cpu_kthread+0x78/0x4b0
> [    2.459557]  ? rcu_cpu_kthread+0x7e/0x4b0
> [    2.459558]  ? rcu_cpu_kthread+0x57/0x4b0
> [    2.459560]  rcu_cpu_kthread+0xc2/0x4b0
> [    2.459562]  ? smpboot_thread_fn+0x23/0x300
> [    2.459565]  smpboot_thread_fn+0x249/0x300
> [    2.459567]  ? smpboot_register_percpu_thread+0xe0/0xe0
> [    2.459569]  kthread+0x1af/0x1d0
> [    2.459571]  ? set_kthread_struct+0x40/0x40
> [    2.459574]  ret_from_fork+0x1f/0x30
> 

