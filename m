Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87153C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Oct 2021 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3A360C4B
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Oct 2021 12:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhJMMwQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233368AbhJMMwP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Oct 2021 08:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634129412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFAd5GBKs8q6sU3jv4SolgYmzJ1yPIC9mmOhNrvbsAE=;
        b=Hq2HKy/IULP1HbkNxiBo22FWGXIpguCarn8tR+qwBH2k5f+YItluPkRLXop0ErOvohYpC1
        cgT/lA3K4qO1FRWxYNlNoc1J561V6hC56tt3a4LcDknKHXKoSUnQyDWkC8wv8XSVI+FZr6
        C8MrVfmmVEQIeR5LLqPOlw/Aq/uYIyc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-eUC7hX-ONG-ccLN06ueaOA-1; Wed, 13 Oct 2021 08:50:11 -0400
X-MC-Unique: eUC7hX-ONG-ccLN06ueaOA-1
Received: by mail-ed1-f71.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so2105461edi.12
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Oct 2021 05:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NFAd5GBKs8q6sU3jv4SolgYmzJ1yPIC9mmOhNrvbsAE=;
        b=vkaP4HdmiLUu7ZRd3+I4dLV7X18dJPTcfxWhjZKiObO9T7JHSwWY5Pj57/Rw9zPJXO
         jFFuxIHLzTnMV5exjmXSzkzqZwBtXvlfXNqtDbZYoQhAmDZT6WZA8jQ2rwo6OiuOpmGY
         96Vf4J52sHf8Pj6IbLa9qwwrn/KyTGir/KrZjeOnndgPnLLIGtfApjRpBItOTRZvdVXo
         Ldhqz267Q7IU4PcI72fWz33xmlRZ92welOQqa7fNgvO+gBNm7t1v20oIZPi5q8cjDcLM
         dUeBqRNbnnrs0HzcFOUaNjzUdhBLnCPG+OAdwi7e4UU9omLEcKcsQB8eeiZpEf/ImfrJ
         L+fQ==
X-Gm-Message-State: AOAM530Jl8eWJoRjLwZDysEFlPhlK7rI00zTgVsaCNh4mE8bHBY4iXN9
        Wmr3z1uWwe2K1UBYN2PW8SFbY3E3xjrJ8g5wMYE3pUzJsmmnVb8GMYD+70l6we/JFerst0WvjWe
        anwyc0xrzMhSyceef1OpdOaE1QcE=
X-Received: by 2002:a17:907:1627:: with SMTP id hb39mr3810187ejc.161.1634129409638;
        Wed, 13 Oct 2021 05:50:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs0aW4WYbvyFArq9cSZU/vgva9AhCirnuFEKBRpJW/Xedns5cO6PNZ7V/VX+SAfUa1gJdiEg==
X-Received: by 2002:a17:907:1627:: with SMTP id hb39mr3810158ejc.161.1634129409398;
        Wed, 13 Oct 2021 05:50:09 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123? ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id ck9sm6638092ejb.56.2021.10.13.05.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:50:09 -0700 (PDT)
Message-ID: <06e96819a964ca4b4ba504d0da71e81d79f3a87b.camel@redhat.com>
Subject: Re: [RFC 0/3] mm/page_alloc: Remote per-cpu lists drain support
From:   nsaenzju@redhat.com
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, cl@linux.com, paulmck@kernel.org,
        ppandit@redhat.com
Date:   Wed, 13 Oct 2021 14:50:08 +0200
In-Reply-To: <38d28332-6b15-b353-5bcb-f691455c6495@suse.cz>
References: <20211008161922.942459-1-nsaenzju@redhat.com>
         <38d28332-6b15-b353-5bcb-f691455c6495@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Vlastimil, thanks for spending time on this.
Also, excuse me if I over explain things.

On Tue, 2021-10-12 at 17:45 +0200, Vlastimil Babka wrote:
> On 10/8/21 18:19, Nicolas Saenz Julienne wrote:
> > This series replaces mm/page_alloc's per-cpu lists drain mechanism in order for
> > it to be able to be run remotely. Currently, only a local CPU is permitted to
> > change its per-cpu lists, and it's expected to do so, on-demand, whenever a
> > process demands it (by means of queueing a drain task on the local CPU). Most
> > systems will handle this promptly, but it'll cause problems for NOHZ_FULL CPUs
> > that can't take any sort of interruption without breaking their functional
> > guarantees (latency, bandwidth, etc...). Having a way for these processes to
> > remotely drain the lists themselves will make co-existing with isolated CPUs
> > possible, and comes with minimal performance[1]/memory cost to other users.
> > 
> > The new algorithm will atomically switch the pointer to the per-cpu lists and
> > use RCU to make sure it's not being used before draining them. 
> > 
> > I'm interested in an sort of feedback, but especially validating that the
> > approach is acceptable, and any tests/benchmarks you'd like to see run against
> 
> So let's consider the added alloc/free fast paths overhead:
> - Patch 1 - __alloc_pages_bulk() used to determine pcp_list once, now it's
> determined for each allocated page in __rmqueue_pcplist().

This one I can avoid, I missed the performance aspect of it. I was aiming at
making the code bearable.

> - Patch 2 - adds indirection from pcp->$foo to pcp->lp->$foo in each operation
> - Patch 3
>   - extra irqsave/irqrestore in free_pcppages_bulk (amortized)
>   - rcu_dereference_check() in free_unref_page_commit() and __rmqueue_pcplist()

Yes.

> BTW - I'm not sure if the RCU usage is valid here.
>
> The "read side" (normal operations) is using:
> rcu_dereference_check(pcp->lp,
> 		lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
> 
> where the lockdep parameter according to the comments for
> rcu_dereference_check() means
> 
> "indicate to lockdep that foo->bar may only be dereferenced if either
> rcu_read_lock() is held, or that the lock required to replace the bar struct
> at foo->bar is held."

You missed the "Could be used to" at the beginning of the sentence :). That
said, I believe this is similar to what I'm doing, only that the situation is
more complex.

> but you are not taking rcu_read_lock() 

I am taking the rcu_read_lock() implicitly, it's explained in 'struct
per_cpu_pages', and in more depth below.

> and the "write side" (remote draining) actually doesn't take pagesets.lock,
> so it's not true that the "lock required to replace ... is held"? The write
> side uses rcu_replace_pointer(..., mutex_is_locked(&pcpu_drain_mutex))
> which is a different lock.

The thing 'pagesets.lock' protects against is concurrent access to pcp->lp's
content, as opposed to its address. pcp->lp is dereferenced atomically, so no
need for locking on that operation.

The drain side never accesses pcp->lp's contents concurrently, it changes
pcp->lp's address and makes sure all CPUs are in sync with the new address
before clearing the stale data.

Just for the record, I think a better representation of what 'check' in
rcu_dereference means is:

 * Do an rcu_dereference(), but check that the conditions under which the
 * dereference will take place are correct.  Typically the conditions
 * indicate the various locking conditions that should be held at that
 * point. The check should return true if the conditions are satisfied.
 * An implicit check for being in an RCU read-side critical section
 * (rcu_read_lock()) is included.

So for the read side, that is, code reading pcp->lp's address and its contents,
the conditions to be met are: being in a RCU critical section, to make sure RCU
is keeping track of it, and holding 'pagesets.lock', to avoid concurrently
accessing pcp->lp's contents. The later is achieved either by disabling local
irqs or disabling migration and getting a per-cpu rt_spinlock. Conveniently
these are actions that implicitly delimit an RCU critical section (see [1] and
[2]). So the 'pagesets.lock' check fully covers the read side locking/RCU
concerns.

On the write side, the drain has to make sure pcp->lp address change is atomic
(this is achieved through rcu_replace_pointer()) and that lp->drain is emptied
before a happens. So checking for pcpu_drain_mutex being held is good enough.

> IOW, synchronize_rcu_expedited() AFAICS has nothing (no rcu_read_lock() to
> synchronize against? Might accidentally work on !RT thanks to disabled irqs,
> but not sure about with RT lock semantics of the local_lock...
>
> So back to overhead, if I'm correct above we can assume that there would be
> also rcu_read_lock() in the fast paths.

As I explained above, no need.

> The alternative proposed by tglx was IIRC that there would be a spinlock on
> each cpu, which would be mostly uncontended except when draining. Maybe an
> uncontended spin lock/unlock would have lower overhead than all of the
> above? It would be certainly simpler, so I would probably try that first and
> see if it's acceptable?

You have a point here. I'll provide a performance rundown of both solutions.
This one is a bit more complex that's for sure.

Thanks!

[1] See rcu_read_lock()'s description: "synchronize_rcu() wait for regions of
    code with preemption disabled, including regions of code with interrupts or
    softirqs disabled."

[2] See kernel/locking/spinlock_rt.c: "The RT [spinlock] substitutions
    explicitly disable migration and take rcu_read_lock() across the lock held
    section."

-- 
Nicolás Sáenz

