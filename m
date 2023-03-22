Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D50EC6FD1F
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Mar 2023 09:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCVJfM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCVJfL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2023 05:35:11 -0400
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 02:35:10 PDT
Received: from outbound-smtp08.blacknight.com (outbound-smtp08.blacknight.com [46.22.139.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ECA5B5F9
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Mar 2023 02:35:08 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id D5CA31C3A51
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Mar 2023 09:28:56 +0000 (GMT)
Received: (qmail 16978 invoked from network); 22 Mar 2023 09:28:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Mar 2023 09:28:56 -0000
Date:   Wed, 22 Mar 2023 09:28:48 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] locking/rwbase: Mitigate indefinite writer starvation.
Message-ID: <20230322092848.hjlehutudsoz2hlz@techsingularity.net>
References: <20230321161140.HMcQEhHb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230321161140.HMcQEhHb@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Mar 21, 2023 at 05:11:40PM +0100, Sebastian Andrzej Siewior wrote:
> The rw_semaphore and rwlock_t locks are unfair to writers. Readers can
> indefinitely acquire the lock unless the writer fully acquired the lock.
> This can never happen if there is always a reader in the critical
> section owning the lock.
> 
> Mel Gorman reported that since LTP-20220121 the dio_truncate test case
> went from having 1 reader to having 16 reader and the number of readers
> is sufficient to prevent the down_write ever succeeding while readers
> exist. Eventually the test is killed after 30 minutes as a failure.
> 
> Mel proposed a timeout to limit how long a writer can be blocked until
> the reader is forced into the slowpath.
> Thomas argued that there is no added value by providing this timeout.
> From PREEMPT_RT point of view, there are no critical rw_semaphore or
> rwlock_t locks left where the reader must be prefer.
> 

s/prefer/preferred/

> Mitigate indefinite writer starvation by forcing the READER into the
> slowpath once the WRITER attempts to acquire the lock.
> 
> Reported-by: Mel Gorman <mgorman@techsingularity.net>
> Link: https://lore.kernel.org/877cwbq4cq.ffs@tglx
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks Sebastian and Thomas!

-- 
Mel Gorman
SUSE Labs
