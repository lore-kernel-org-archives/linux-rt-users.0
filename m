Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F1DC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Oct 2021 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B41E60E53
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Oct 2021 15:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhJLPrq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:47:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46922 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhJLPrp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Oct 2021 11:47:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B625221B6;
        Tue, 12 Oct 2021 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634053543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGuvld8itT1JzVi5BiszW8GqTio+K8yzk1kRcbCgLho=;
        b=lPpv/XSdAFY6ky7xX7mCR6ucPKpxtWFaizhkWbVlqkteOqNwSohF5/vJGWCmQ9+Xl3olQs
        AYOruHMZJUYE7rRpBkBYrjukIfZ4ej78bHErmHy0NZbhrDltViFlevT8uO6enYIPqXBFUc
        1ftKk1lXvdiBgG2XLfONhu6Y9lbRE58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634053543;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGuvld8itT1JzVi5BiszW8GqTio+K8yzk1kRcbCgLho=;
        b=oId5psRFPMAgmG4WCetp1VXzSP7EwLfsLH7wc9LmuF9aL64S0xLI72YtZXt0fQz4xClSq7
        l7PSyUwicKrzMpCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA73313BC9;
        Tue, 12 Oct 2021 15:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K5ySNKatZWEKLwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 12 Oct 2021 15:45:42 +0000
Message-ID: <38d28332-6b15-b353-5bcb-f691455c6495@suse.cz>
Date:   Tue, 12 Oct 2021 17:45:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, cl@linux.com, paulmck@kernel.org,
        ppandit@redhat.com
References: <20211008161922.942459-1-nsaenzju@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC 0/3] mm/page_alloc: Remote per-cpu lists drain support
In-Reply-To: <20211008161922.942459-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/8/21 18:19, Nicolas Saenz Julienne wrote:
> This series replaces mm/page_alloc's per-cpu lists drain mechanism in order for
> it to be able to be run remotely. Currently, only a local CPU is permitted to
> change its per-cpu lists, and it's expected to do so, on-demand, whenever a
> process demands it (by means of queueing a drain task on the local CPU). Most
> systems will handle this promptly, but it'll cause problems for NOHZ_FULL CPUs
> that can't take any sort of interruption without breaking their functional
> guarantees (latency, bandwidth, etc...). Having a way for these processes to
> remotely drain the lists themselves will make co-existing with isolated CPUs
> possible, and comes with minimal performance[1]/memory cost to other users.
> 
> The new algorithm will atomically switch the pointer to the per-cpu lists and
> use RCU to make sure it's not being used before draining them. 
> 
> I'm interested in an sort of feedback, but especially validating that the
> approach is acceptable, and any tests/benchmarks you'd like to see run against

So let's consider the added alloc/free fast paths overhead:
- Patch 1 - __alloc_pages_bulk() used to determine pcp_list once, now it's
determined for each allocated page in __rmqueue_pcplist().
- Patch 2 - adds indirection from pcp->$foo to pcp->lp->$foo in each operation
- Patch 3
  - extra irqsave/irqrestore in free_pcppages_bulk (amortized)
  - rcu_dereference_check() in free_unref_page_commit() and __rmqueue_pcplist()

BTW - I'm not sure if the RCU usage is valid here.

The "read side" (normal operations) is using:
rcu_dereference_check(pcp->lp,
		lockdep_is_held(this_cpu_ptr(&pagesets.lock)));

where the lockdep parameter according to the comments for
rcu_dereference_check() means

"indicate to lockdep that foo->bar may only be dereferenced if either
rcu_read_lock() is held, or that the lock required to replace the bar struct
at foo->bar is held."

but you are not taking rcu_read_lock() and the "write side" (remote
draining) actually doesn't take pagesets.lock, so it's not true that the
"lock required to replace ... is held"? The write side uses
rcu_replace_pointer(...,
			mutex_is_locked(&pcpu_drain_mutex))
which is a different lock.

IOW, synchronize_rcu_expedited() AFAICS has nothing (no rcu_read_lock() to
synchronize against? Might accidentally work on !RT thanks to disabled irqs,
but not sure about with RT lock semantics of the local_lock...

So back to overhead, if I'm correct above we can assume that there would be
also rcu_read_lock() in the fast paths.

The alternative proposed by tglx was IIRC that there would be a spinlock on
each cpu, which would be mostly uncontended except when draining. Maybe an
uncontended spin lock/unlock would have lower overhead than all of the
above? It would be certainly simpler, so I would probably try that first and
see if it's acceptable?

> it. For now, I've been testing this successfully on both arm64 and x86_64
> systems while forcing high memory pressure (i.e. forcing the
> page_alloc's slow path).
> 
> Patches 1-2 serve as cleanups/preparation to make patch 3 easier to follow.
> 
> Here's my previous attempt at fixing this:
> https://lkml.org/lkml/2021/9/21/599
> 
> [1] Proper performance numbers will be provided if the approach is deemed
>     acceptable. That said, mm/page_alloc.c's fast paths only grow by an extra
>     pointer indirection and a compiler barrier, which I think is unlikely to be
>     measurable.
> 
> ---
> 
> Nicolas Saenz Julienne (3):
>   mm/page_alloc: Simplify __rmqueue_pcplist()'s arguments
>   mm/page_alloc: Access lists in 'struct per_cpu_pages' indirectly
>   mm/page_alloc: Add remote draining support to per-cpu lists
> 
>  include/linux/mmzone.h |  24 +++++-
>  mm/page_alloc.c        | 173 +++++++++++++++++++++--------------------
>  mm/vmstat.c            |   6 +-
>  3 files changed, 114 insertions(+), 89 deletions(-)
> 

