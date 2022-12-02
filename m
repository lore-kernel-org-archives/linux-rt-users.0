Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AEAC4321E
	for <linux-rt-users@archiver.kernel.org>; Fri,  2 Dec 2022 15:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiLBPC0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiLBPCZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Dec 2022 10:02:25 -0500
Received: from outbound-smtp03.blacknight.com (outbound-smtp03.blacknight.com [81.17.249.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107F83E84
        for <linux-rt-users@vger.kernel.org>; Fri,  2 Dec 2022 07:02:21 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id A2A11C0E97
        for <linux-rt-users@vger.kernel.org>; Fri,  2 Dec 2022 15:02:20 +0000 (GMT)
Received: (qmail 20000 invoked from network); 2 Dec 2022 15:02:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Dec 2022 15:02:20 -0000
Date:   Fri, 2 Dec 2022 15:01:58 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rtmutex: Add acquire semantics for rtmutex lock
 acquisition
Message-ID: <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
References: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
 <Y4nfopZfBxR4lJ6G@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y4nfopZfBxR4lJ6G@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Dec 02, 2022 at 12:21:06PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-12-02 10:02:23 [+0000], Mel Gorman wrote:
> > The lock owner is updated with an IRQ-safe raw spinlock held but the
> > spin_unlock does not provide acquire semantics which are needed when
> > acquiring a mutex. This patch adds the necessary acquire semantics for a
> > lock operation when the lock owner is updated. It successfully completed
> > 10 iterations of the dbench workload while the vanilla kernel fails on
> > the first iteration.
> 
> I *think* it is
> 
> Fixes: 700318d1d7b38 ("locking/rtmutex: Use acquire/release semantics")
> 

Adding Davidlohr to cc.

It might have made the problem worse but even then rt_mutex_set_owner was
just a plain assignment and while I didn't check carefully, at a glance
try_to_take_rt_mutex didn't look like it guaranteed ACQUIRE semantics.

> Before that, it did cmpxchg() which should be fine.
> 
> Regarding mark_rt_mutex_waiters(). Isn't acquire semantic required in
> order for the lock-owner not perform the fastpath but go to the slowpath
> instead?
> 

Good spot, it does. While the most straight-forward solution is to use
cmpxchg_acquire, I think it is overkill because it could incur back-to-back
ACQUIRE operations in the event of contention. There could be a smp_wmb
after the cmpxchg_relaxed but that impacts all arches and a non-paired
smp_wmb is generally frowned upon.

I'm thinking this on top of the patch should be sufficient even though
it's a heavier operation than is necesary for ACQUIRE as well as being
"not typical" according to Documentation/atomic_t.txt. Will, as this
affects ARM primarily do you have any preference?

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 35212f260148..af0dbe4d5e97 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -238,6 +238,13 @@ static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
 		owner = *p;
 	} while (cmpxchg_relaxed(p, owner,
 				 owner | RT_MUTEX_HAS_WAITERS) != owner);
+
+	/*
+	 * The cmpxchg loop above is relaxed to avoid back-to-back ACQUIRE
+	 * operations in the event of contention. Ensure the successful
+	 * cmpxchg is visible.
+	 */
+	smp_mb__after_atomic();
 }
 
 /*
