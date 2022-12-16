Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9AAC4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Dec 2022 10:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiLPKcH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiLPKbt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Dec 2022 05:31:49 -0500
Received: from outbound-smtp27.blacknight.com (outbound-smtp27.blacknight.com [81.17.249.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98FD205EE
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Dec 2022 02:31:48 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 91D25CACDC
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Dec 2022 10:31:46 +0000 (GMT)
Received: (qmail 9659 invoked from network); 16 Dec 2022 10:31:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Dec 2022 10:31:45 -0000
Date:   Fri, 16 Dec 2022 10:31:41 +0000
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
Message-ID: <20221216103141.6qxxmlzuqznp54qu@techsingularity.net>
References: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
 <Y4nfopZfBxR4lJ6G@linutronix.de>
 <20221202150158.xzgovoy7wuic6vvk@techsingularity.net>
 <Y48q9/G2B6aMdJ1w@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y48q9/G2B6aMdJ1w@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 06, 2022 at 12:43:51PM +0100, Sebastian Andrzej Siewior wrote:
> > > Before that, it did cmpxchg() which should be fine.
> > > 
> > > Regarding mark_rt_mutex_waiters(). Isn't acquire semantic required in
> > > order for the lock-owner not perform the fastpath but go to the slowpath
> > > instead?
> > > 
> > 
> > Good spot, it does. While the most straight-forward solution is to use
> > cmpxchg_acquire, I think it is overkill because it could incur back-to-back
> > ACQUIRE operations in the event of contention. There could be a smp_wmb
> > after the cmpxchg_relaxed but that impacts all arches and a non-paired
> > smp_wmb is generally frowned upon.
> 
> but in general, it should succeed on the first iteration. It can only
> fail (and retry) if the owner was able to unlock it first. A second
> locker will spin on the wait_lock so.
> 

Sure, generally it would be fine but it also costs us nothing
to avoid additional overhead in the contended case. The pattern of
atomic_relaxed+smp_mb__after_atomic is unusual but I think the comment is
sufficient to explain why it's structured like that.

-- 
Mel Gorman
SUSE Labs
