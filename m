Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21251C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE707611C6
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 07:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbhIWHNn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 03:13:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36546 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbhIWHNl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Sep 2021 03:13:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0E4622307;
        Thu, 23 Sep 2021 07:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632381129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmBOGVhFBxLxi8U95qA0irvUWd9BKBad4ey/QHF4OLA=;
        b=wrogAHCKAfbCKEVzuRb+fVH0a/fcySAs4mGvGXKmz5+zd+NIKCB05mD+xyfeDze1fOLeTx
        4eZ4yCj5esduI3FmuhopejyyqvSDHZrbSyIBd9oxLO/e5Y7VPUzkywWd3FYiVxCa5nzMrm
        vMGCstL8ZncY7TnPdo3+aiITtbjQqJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632381129;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmBOGVhFBxLxi8U95qA0irvUWd9BKBad4ey/QHF4OLA=;
        b=ZSYP82rm/oDJjiyKo9rlW2b2VZJoezlrrkQbWMh6Zt4uZ4QpatSCAdq622p2lRz8hrvUuM
        l8RL90ZAExVrS3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6307413DC4;
        Thu, 23 Sep 2021 07:12:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7EpiF8koTGH5cwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 23 Sep 2021 07:12:09 +0000
Message-ID: <efb4a5e1-d64a-38de-97d8-350c3d1b0962@suse.cz>
Date:   Thu, 23 Sep 2021 09:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org
References: <20210921161323.607817-1-nsaenzju@redhat.com>
 <f608b4bf-aa36-b0c4-e748-4f39010f3d06@suse.cz>
 <20210922112817.GO4323@worktop.programming.kicks-ass.net>
 <87v92sgt3n.ffs@tglx>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 0/6] mm: Remote LRU per-cpu pagevec cache/per-cpu page
 list drain support
In-Reply-To: <87v92sgt3n.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 9/23/21 00:09, Thomas Gleixner wrote:
> On Wed, Sep 22 2021 at 13:28, Peter Zijlstra wrote:
>> On Tue, Sep 21, 2021 at 07:59:51PM +0200, Vlastimil Babka wrote:
>>
>>> These days the pcplist protection is done by local_lock, which solved
>>> the RT concerns. Probably a stupid/infeasible idea, but maybe what you
>>> want to achieve could be more generally solved at the local_lock level?
>>> That on NOHZ_FULL CPUs, local_locks could have this mode where they
>>> could synchronize with remote cpus?
>>
>> local_lock and spinlock have different rules, local_lock for example can
>> never cause an irq inversion, unlike a spinlock.
> 
> TBH, I really regret an attempt I made at some point in the RT
> development to abuse local locks for this kind of cross CPU protections
> because that led to yet another semantically ill defined construct.
> 
> local locks are as the name says strictly local. IOW, they do not exist
> for remote access. Just look at the !RT mapping:
> 
>   local_lock() 		-> preempt_disable()
>   local_lock_irq()	-> local_irq_disable()
>   ...

Yes, to be clean, this would have to be a new primitive, not just an abused
local lock. It would just look similar to the RT version (a percpu array of
spinlocks), so for this patchset it would allow not to have two such locks
side be side (local + spin) while only one is being used. For maximum
flexibility the initialization would take a CONFIG_ (or something
compile-time bool) that when false would make the !RT version an empty
struct and "locking" would rely on preempt/irq disable (just as with !RT
local_lock). If compile-time true it would take a static key to decide on
boot whether the !RT version only does the preepmt/irq disable or actually
takes the lock.

But as you say below, it's too much complexity for questionable benefit.

But maybe this can all be avoided anyway, as I recalled what we do for
vmstat already (IIUC). See quiet_vmstat() - when cpu enters the nohz mode,
it flushes per-cpu vmstat diffs and then there's no reason to further
disturb the cpu to do that while it's on NOHZ mode. We could do the same for
lru pagevecs and pcplists?

> The only thing local_lock is addressing is the opaque nature of
> preempt_disable(), local*_disable/save() protected critical sections,
> which have per CPU BKL, i.e. undefined protection scope, semantics.
> 
> If you really want cross CPU protection then using a regular spinlock in
> a per CPU data structure is the right way to go.
> 
> That makes it a bit akward vs. the code at hand which already introduced
> local locks to replace the opaque preempt/local_irq disabled critical
> sections with scoped local locks which in turn allows RT to substitute
> them with strict CPU local spinlocks.
> 
> But for clarity sake we really have to look at two different cases now:
> 
>    1) Strict per CPU local protection
> 
>       That's what the code does today via local lock and this includes
>       RT where the locality is preserved via the local lock semantics
> 
>       I.e. for the !RT case the spinlock overhead is avoided 
> 
>    2) Global scoped per CPU protection
> 
>       That's what Nicolas is trying to achieve to be able to update
>       data structures cross CPU for the sake of avoiding smp function
>       calls or queuing work on remote CPUs for the NOHZ_FULL isolation
>       use case.
> 
> That said, I completely understand Andrew's concerns versus these
> distinctions and their test coverage.
> 
> In consequence the real interesting question here is whether any of
> these use cases are sensible to the extra overhead of #2.
> 
> IOW, does it really matter whether the !RT and !NOHZ_FULL case take an
> uncontended per CPU spinlock unconditionally instead of just disabling
> preemption / interrupts?
> 
> The same question arises vs. the remote work queuing. Does it really
> matter? I think that a proper investigation is due to figure out whether
> delegated work is really superiour vs. doing the same work locked from a
> remote CPU occasionally.
> 
> If you really think about it then the task which is initiating the work
> is already in a slow path. So what's the tradeoff to make this path a
> little bit slower due to remote access vs. scheduling work and thereby
> disturbing the remote CPU which has a performance impact as well and in
> the NOHZ_FULL case even a correctness impact? That's especially
> questionable for situations where the initiator has to wait for
> completion of the remote work.
> 
> The changelogs and the cover letter have a distinct void vs. that which
> means this is just another example of 'scratch my itch' changes w/o
> proper justification.
> 
> I'm well aware that the inital stuff which myself, and in consequence
> Sebastian and Anna-Maria, were doing back then falls into the same
> category. IOW, guilty as charged, but that does not make the current
> approach more palatable than the one from years ago.
> 
> Thanks,
> 
>         tglx
> 

