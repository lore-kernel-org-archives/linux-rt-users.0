Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6EEC05027
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Feb 2023 20:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjBHUT1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Feb 2023 15:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjBHUTZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Feb 2023 15:19:25 -0500
Received: from outbound-smtp22.blacknight.com (outbound-smtp22.blacknight.com [81.17.249.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D835267
        for <linux-rt-users@vger.kernel.org>; Wed,  8 Feb 2023 12:19:20 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 212CFBAB49
        for <linux-rt-users@vger.kernel.org>; Wed,  8 Feb 2023 20:19:19 +0000 (GMT)
Received: (qmail 14756 invoked from network); 8 Feb 2023 20:19:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Feb 2023 20:19:18 -0000
Date:   Wed, 8 Feb 2023 20:19:17 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] locking/rwbase: Mitigate indefinite writer starvation
Message-ID: <20230208201917.o57hd7ktzof6wkfi@techsingularity.net>
References: <20230120140847.4pjqf3oinemokcyp@techsingularity.net>
 <87ttzyyigk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87ttzyyigk.ffs@tglx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Feb 06, 2023 at 03:30:35PM +0100, Thomas Gleixner wrote:
> Mel!

Hi :)

I'm not really online for the next several weeks so further responses may
take ages. It's co-incidence that I'm online at the moment for an unrelated
matter and glancing through mail.

> 
> On Fri, Jan 20 2023 at 14:08, Mel Gorman wrote:
> > dio_truncate is not a realtime application but indefinite writer starvation
> > is undesirable. The test case has one writer appending and truncating files
> > A and B while multiple readers read file A. The readers and writer are
> > contending for one file's inode lock which never succeeds as the readers
> > keep reading until the writer is done which never happens.
> >
> > This patch records a timestamp when the first writer is blocked. DL /
> 
> git grep 'This patch' Documentation/process/
> 

I'm aware of the rule but tend to forget at times as enforcement varies
between subsystems. First sentence of the paragraph becomes;

Record a timestamp when the first writer is blocked and force all new
readers into the slow path upon expiration.

> > RT tasks can continue to take the lock for read as long as readers exist
> > indefinitely. Other readers can acquire the read lock unless a writer
> > has been blocked for a minimum of 4ms. This is sufficient to allow the
> > dio_truncate test case to complete within the 30 minutes timeout.
> 
> I'm not opposed to this, but what's the actual reason for this pulled
> out of thin air timeout?
> 

No good reason, a value had to be picked. It happens to match the rwsem
cutoff for optimistic spinning. That at least is some threshold for "a
lock failed to be acquired within a reasonable time period". It's also
arbitrary that it happened to be a value that allowed the dio_truncate
LTP test to complete in a reasonable time.

> What's the downside of actually forcing !RT readers into the slowpath
> once there is a writer waiting?
> 

I actually don't know for sure because it's application dependant but at
minimum, I believe it would be a deviation from how generic rwsems behave
where a writer optimistically spins for the same duration before forcing
the handoff. Whether that matters or not depends on the application,
the ratio between readers/writers and the number of concurrent readers.

-- 
Mel Gorman
SUSE Labs
