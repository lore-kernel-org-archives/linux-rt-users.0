Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DA2C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Oct 2021 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B675F60041
	for <linux-rt-users@archiver.kernel.org>; Thu, 21 Oct 2021 08:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhJUI3T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:29:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50380 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhJUI3T (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 21 Oct 2021 04:29:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 896451FDAF;
        Thu, 21 Oct 2021 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634804822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPlvFBknNx5Rvt2Xom4sEyQcQrKjPFKmTkUyWHqk6xs=;
        b=KE8DuvBMWupszs4XD7dZgx/6DgybMF7vT1ncYk+1VxUd+vpZdA8rakzIVPBZQ3voE9eoit
        kht8USBQbDCBTK5O5BQWl49IgRMLxpDvaCEcHLxJtFjepm+Q7ByMmVGer/sf50KfBf/SbU
        uTteXN4ko4Wi15EPLyxxarCMz2Z0WWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634804822;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPlvFBknNx5Rvt2Xom4sEyQcQrKjPFKmTkUyWHqk6xs=;
        b=YNu3+u1JJKpWrmCb605Frq2tQXFIgtwiuWpR91B95MQhsIHSaQKUWODJbs1bLdq+ADZau2
        I1y+k0O/FZNIeHBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E10A13BDA;
        Thu, 21 Oct 2021 08:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mPJFElYkcWEpGAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 21 Oct 2021 08:27:02 +0000
Message-ID: <9c6c0840-a37d-c6fb-78a8-f2c49df2380c@suse.cz>
Date:   Thu, 21 Oct 2021 10:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 0/3] mm/page_alloc: Remote per-cpu lists drain support
Content-Language: en-US
To:     nsaenzju@redhat.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, cl@linux.com, paulmck@kernel.org,
        ppandit@redhat.com
References: <20211008161922.942459-1-nsaenzju@redhat.com>
 <38d28332-6b15-b353-5bcb-f691455c6495@suse.cz>
 <06e96819a964ca4b4ba504d0da71e81d79f3a87b.camel@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <06e96819a964ca4b4ba504d0da71e81d79f3a87b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/13/21 14:50, nsaenzju@redhat.com wrote:
> Hi Vlastimil, thanks for spending time on this.
> Also, excuse me if I over explain things.

Hi, thanks for spending time on the explanation :) It was very useful.

...

> 
>> and the "write side" (remote draining) actually doesn't take pagesets.lock,
>> so it's not true that the "lock required to replace ... is held"? The write
>> side uses rcu_replace_pointer(..., mutex_is_locked(&pcpu_drain_mutex))
>> which is a different lock.
> 
> The thing 'pagesets.lock' protects against is concurrent access to pcp->lp's
> content, as opposed to its address. pcp->lp is dereferenced atomically, so no
> need for locking on that operation.
> 
> The drain side never accesses pcp->lp's contents concurrently, it changes
> pcp->lp's address and makes sure all CPUs are in sync with the new address
> before clearing the stale data.
> 
> Just for the record, I think a better representation of what 'check' in
> rcu_dereference means is:
> 
>  * Do an rcu_dereference(), but check that the conditions under which the
>  * dereference will take place are correct.  Typically the conditions
>  * indicate the various locking conditions that should be held at that
>  * point. The check should return true if the conditions are satisfied.
>  * An implicit check for being in an RCU read-side critical section
>  * (rcu_read_lock()) is included.
> 
> So for the read side, that is, code reading pcp->lp's address and its contents,
> the conditions to be met are: being in a RCU critical section, to make sure RCU
> is keeping track of it, and holding 'pagesets.lock', to avoid concurrently
> accessing pcp->lp's contents. The later is achieved either by disabling local
> irqs or disabling migration and getting a per-cpu rt_spinlock. Conveniently
> these are actions that implicitly delimit an RCU critical section (see [1] and
> [2]). So the 'pagesets.lock' check fully covers the read side locking/RCU
> concerns.

Yeah, I wasn't aware of [2] especially. It makes sense that RT locks provide
the same guarantees for RCU as non-RT.

> On the write side, the drain has to make sure pcp->lp address change is atomic
> (this is achieved through rcu_replace_pointer()) and that lp->drain is emptied
> before a happens. So checking for pcpu_drain_mutex being held is good enough.
> 
>> IOW, synchronize_rcu_expedited() AFAICS has nothing (no rcu_read_lock() to
>> synchronize against? Might accidentally work on !RT thanks to disabled irqs,
>> but not sure about with RT lock semantics of the local_lock...
>>
>> So back to overhead, if I'm correct above we can assume that there would be
>> also rcu_read_lock() in the fast paths.
> 
> As I explained above, no need.
> 
>> The alternative proposed by tglx was IIRC that there would be a spinlock on
>> each cpu, which would be mostly uncontended except when draining. Maybe an
>> uncontended spin lock/unlock would have lower overhead than all of the
>> above? It would be certainly simpler, so I would probably try that first and
>> see if it's acceptable?
> 
> You have a point here. I'll provide a performance rundown of both solutions.
> This one is a bit more complex that's for sure.

Great, thanks!

> Thanks!
> 
> [1] See rcu_read_lock()'s description: "synchronize_rcu() wait for regions of
>     code with preemption disabled, including regions of code with interrupts or
>     softirqs disabled."
> 
> [2] See kernel/locking/spinlock_rt.c: "The RT [spinlock] substitutions
>     explicitly disable migration and take rcu_read_lock() across the lock held
>     section."
> 

