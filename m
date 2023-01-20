Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD3FC05027
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Jan 2023 14:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjATOHY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjATOHW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Jan 2023 09:07:22 -0500
Received: from outbound-smtp27.blacknight.com (outbound-smtp27.blacknight.com [81.17.249.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728B440C6
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Jan 2023 06:07:19 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id C59BA146014
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Jan 2023 14:07:17 +0000 (GMT)
Received: (qmail 17776 invoked from network); 20 Jan 2023 14:07:17 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Jan 2023 14:07:17 -0000
Date:   Fri, 20 Jan 2023 14:07:15 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230120140715.svqidkl3fbwz3krm@techsingularity.net>
References: <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
 <20230119110220.kphftcehehhi5l5u@techsingularity.net>
 <Y8lvwKHmmnikVDgk@linutronix.de>
 <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
 <Y8pP3CD1PQ4KWhXF@linutronix.de>
 <20230120132441.4jjke47rnpikiuf5@techsingularity.net>
 <Y8qZU33Cvbc7p7DE@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y8qZU33Cvbc7p7DE@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jan 20, 2023 at 02:38:27PM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-01-20 13:24:41 [+0000], Mel Gorman wrote:
> > --- a/kernel/locking/rwbase_rt.c
> > +++ b/kernel/locking/rwbase_rt.c
> > @@ -264,12 +291,17 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
> >  		if (__rwbase_write_trylock(rwb))
> >  			break;
> >  
> > +		/* Record timeout when reader bias is ignored. */
> > +		rwb->waiter_timeout = jiffies + RWBASE_RT_WAIT_TIMEOUT;
> 		rwb->waiter_timeout = (jiffies + RWBASE_RT_WAIT_TIMEOUT) | 1;
> 
> There is the unlikely case that (jiffies + RWBASE_RT_WAIT_TIMEOUT) = 0
> on 32bit where it is not jiffies64.
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 

Thanks very much, updated version will be posted shortly.

-- 
Mel Gorman
SUSE Labs
