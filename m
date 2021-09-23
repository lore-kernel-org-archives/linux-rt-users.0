Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E93C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 10:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1EC761241
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 10:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhIWKiM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhIWKiM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Sep 2021 06:38:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E792FC061574;
        Thu, 23 Sep 2021 03:36:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632393398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTguzk40ayGOML5J09jRevoLF7bYg9lkIEwM2+6eZ0w=;
        b=0S2tAo0/F+o1g7KpAslYegb5ydfD3kdtHL/L2e8pauBb4F7wG9K5m6Irdzv0ZRoYG7Lzxx
        GOeaLpFzXByXWTABZ9QDe5O/2vYQ/KmJvUw9kmmTcEVtEfZd36LTqZ6o75mlrZLWe3WIZE
        lz3DgkJZ9xeEQ0yGMB9SlA3Mhzym72TJAZwmyhwL5wKZKYnc9808rx0PZO9dGBhRIfyBgF
        BFZrCxCwb3SuPjW3tNpyajRkjFmUANBDsFVxZ8F5M+vHEkMhy9RnjeQ8cfNJQ3eweNndMI
        AvfZIKLlGHaOH6XyPcFpOkSBL0vE9aX9pZz7rWVmbScl5oKXZpCewB92ESgQxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632393398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTguzk40ayGOML5J09jRevoLF7bYg9lkIEwM2+6eZ0w=;
        b=Wbo8ToYQV7/QtJXaqHOhAnemnyibaMe7FhJbZvj1z6S5RnOC0Rm0UgJLr6rFCer+2GQutR
        A9ebVSMk3OeKkgCQ==
To:     Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/6] mm: Remote LRU per-cpu pagevec cache/per-cpu page
 list drain support
In-Reply-To: <efb4a5e1-d64a-38de-97d8-350c3d1b0962@suse.cz>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
 <f608b4bf-aa36-b0c4-e748-4f39010f3d06@suse.cz>
 <20210922112817.GO4323@worktop.programming.kicks-ass.net>
 <87v92sgt3n.ffs@tglx> <efb4a5e1-d64a-38de-97d8-350c3d1b0962@suse.cz>
Date:   Thu, 23 Sep 2021 12:36:37 +0200
Message-ID: <878rznh93e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Vlastimil,

On Thu, Sep 23 2021 at 09:12, Vlastimil Babka wrote:
> On 9/23/21 00:09, Thomas Gleixner wrote:
>>   local_lock() 		-> preempt_disable()
>>   local_lock_irq()	-> local_irq_disable()
>>   ...
>
> Yes, to be clean, this would have to be a new primitive, not just an abused
> local lock. It would just look similar to the RT version (a percpu array of
> spinlocks), so for this patchset it would allow not to have two such locks
> side be side (local + spin) while only one is being used. For maximum
> flexibility the initialization would take a CONFIG_ (or something
> compile-time bool) that when false would make the !RT version an empty
> struct and "locking" would rely on preempt/irq disable (just as with !RT
> local_lock). If compile-time true it would take a static key to decide on
> boot whether the !RT version only does the preepmt/irq disable or actually
> takes the lock.
>
> But as you say below, it's too much complexity for questionable benefit.
>
> But maybe this can all be avoided anyway, as I recalled what we do for
> vmstat already (IIUC). See quiet_vmstat() - when cpu enters the nohz mode,
> it flushes per-cpu vmstat diffs and then there's no reason to further
> disturb the cpu to do that while it's on NOHZ mode. We could do the same for
> lru pagevecs and pcplists?

I'm not sure about this. I like the idea of being able to offload things
to housekeeping CPUs not only in the full isolation case.

A good example is RCU which allows to offload all RCU processing to some
other CPU(s), which is useful even w/o full isolation.

The synchronous quiescing on entering NOHZ full mode is a cute
workaround but for one it makes entering NOHZ full more expensive and it
does not necessarily provide good isolation guarantees under all
circumstances, while a full remote processing definitely does.

I think it's at least worthwhile to investigate.

Thanks,

        tglx
