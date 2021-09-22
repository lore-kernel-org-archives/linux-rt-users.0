Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E9DC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 22:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD9460F11
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 22:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbhIVWLW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhIVWLW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 18:11:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A9C061574;
        Wed, 22 Sep 2021 15:09:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632348588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jcr9nqMVRcTDPIreBl9p4rC2xWKhXlfvzHJpL81e0+I=;
        b=VMXa/uYNrKb5uvnJrcdeyh9E/CWJcbrACf+VqRmgwbPuEVu9tzo6AIOvNen1EFSuk47C/P
        P2h1i6V4PVW4gTnBulOCrm9vx2qswgGlw5DfXsS7P9rvDmO+aa+3i7Ats38eKM0qcBobhz
        d3OgS+jjXl6AryDRnDsbY1TPo+66duYeu7SDhIf0c70MYD335o6dIuizwXuCsZOWzyelQ4
        HCCkv2Br1k8gxnyapRYE7hG21TiQs+0B0K9zvGTwuQLMSVoR8Emotr0a4+bLlGP0+EDMMb
        n4p4qxevzGMk31TnQfb8yGa1kA8pLl2dTxgAqvMbQoau5OtW9vpm+Sh4Qc7KXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632348588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jcr9nqMVRcTDPIreBl9p4rC2xWKhXlfvzHJpL81e0+I=;
        b=Ptx4wD1RkWyBNBHa+ylBtJm8AJTD0M89WnL2MhRN6MX5MHz1spvFPZkjovbERiq/dnwqDv
        CtyMO7tFBVV2pQCg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/6] mm: Remote LRU per-cpu pagevec cache/per-cpu page
 list drain support
In-Reply-To: <20210922112817.GO4323@worktop.programming.kicks-ass.net>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
 <f608b4bf-aa36-b0c4-e748-4f39010f3d06@suse.cz>
 <20210922112817.GO4323@worktop.programming.kicks-ass.net>
Date:   Thu, 23 Sep 2021 00:09:48 +0200
Message-ID: <87v92sgt3n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Sep 22 2021 at 13:28, Peter Zijlstra wrote:
> On Tue, Sep 21, 2021 at 07:59:51PM +0200, Vlastimil Babka wrote:
>
>> These days the pcplist protection is done by local_lock, which solved
>> the RT concerns. Probably a stupid/infeasible idea, but maybe what you
>> want to achieve could be more generally solved at the local_lock level?
>> That on NOHZ_FULL CPUs, local_locks could have this mode where they
>> could synchronize with remote cpus?
>
> local_lock and spinlock have different rules, local_lock for example can
> never cause an irq inversion, unlike a spinlock.

TBH, I really regret an attempt I made at some point in the RT
development to abuse local locks for this kind of cross CPU protections
because that led to yet another semantically ill defined construct.

local locks are as the name says strictly local. IOW, they do not exist
for remote access. Just look at the !RT mapping:

  local_lock() 		-> preempt_disable()
  local_lock_irq()	-> local_irq_disable()
  ...

The only thing local_lock is addressing is the opaque nature of
preempt_disable(), local*_disable/save() protected critical sections,
which have per CPU BKL, i.e. undefined protection scope, semantics.

If you really want cross CPU protection then using a regular spinlock in
a per CPU data structure is the right way to go.

That makes it a bit akward vs. the code at hand which already introduced
local locks to replace the opaque preempt/local_irq disabled critical
sections with scoped local locks which in turn allows RT to substitute
them with strict CPU local spinlocks.

But for clarity sake we really have to look at two different cases now:

   1) Strict per CPU local protection

      That's what the code does today via local lock and this includes
      RT where the locality is preserved via the local lock semantics

      I.e. for the !RT case the spinlock overhead is avoided 

   2) Global scoped per CPU protection

      That's what Nicolas is trying to achieve to be able to update
      data structures cross CPU for the sake of avoiding smp function
      calls or queuing work on remote CPUs for the NOHZ_FULL isolation
      use case.

That said, I completely understand Andrew's concerns versus these
distinctions and their test coverage.

In consequence the real interesting question here is whether any of
these use cases are sensible to the extra overhead of #2.

IOW, does it really matter whether the !RT and !NOHZ_FULL case take an
uncontended per CPU spinlock unconditionally instead of just disabling
preemption / interrupts?

The same question arises vs. the remote work queuing. Does it really
matter? I think that a proper investigation is due to figure out whether
delegated work is really superiour vs. doing the same work locked from a
remote CPU occasionally.

If you really think about it then the task which is initiating the work
is already in a slow path. So what's the tradeoff to make this path a
little bit slower due to remote access vs. scheduling work and thereby
disturbing the remote CPU which has a performance impact as well and in
the NOHZ_FULL case even a correctness impact? That's especially
questionable for situations where the initiator has to wait for
completion of the remote work.

The changelogs and the cover letter have a distinct void vs. that which
means this is just another example of 'scratch my itch' changes w/o
proper justification.

I'm well aware that the inital stuff which myself, and in consequence
Sebastian and Anna-Maria, were doing back then falls into the same
category. IOW, guilty as charged, but that does not make the current
approach more palatable than the one from years ago.

Thanks,

        tglx
