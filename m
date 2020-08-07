Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D6AC433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 10:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48A620866
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 10:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FFasNe26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgHGKqj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgHGKqh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 06:46:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AEFC061574;
        Fri,  7 Aug 2020 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aDAlqG4CAxqLl7h0ghsndP8u7Js90/fuXrq6EN1A+rg=; b=FFasNe26eiqE66rrR8vnluFd27
        myOFROvlOycua+sg+fGFi3UdLHO7qgWvKI2dowqebZ2BjkPzWUu/kPe6rrpB9MMDi7VBg344QDnb4
        /t4SKQOFOpJtO9XcGWEU2f0dBcHiAfeXW/MyfxiKJ9sFsvOPCQnoo5Krvwzztzugq+snSgH7PJjSI
        ZFWvyHGv7O9Tm1AsiguHbdXpwrZQ02mZ4yp/9xacDr4j15QiJVB+Fy/K0Zdz+f/DxtqPZj7EyBFxf
        RzTabsagq6A9WW4I+2OxlONoZ2kB49FHqPGGDLZ+5pI3Vz/kUgj8ZdSYLvYNrHAvdDu+yWwZcBQ4g
        4e6LhTvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3ztG-0005iP-Cy; Fri, 07 Aug 2020 10:46:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A94233012DC;
        Fri,  7 Aug 2020 12:46:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CF612C8B1E2E; Fri,  7 Aug 2020 12:46:18 +0200 (CEST)
Date:   Fri, 7 Aug 2020 12:46:18 +0200
From:   peterz@infradead.org
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807104618.GH2674@hirez.programming.kicks-ass.net>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807095604.GO42956@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Aug 07, 2020 at 11:56:04AM +0200, Juri Lelli wrote:
> Starting deadline server for lower priority classes right away when
> first task is enqueued might break guarantees, as tasks belonging to
> intermediate priority classes could be uselessly preempted. E.g., a well
> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
> there are still CPU cycles available for NORMAL tasks to run, as they'll
> be running inside the fair deadline server for some period of time.
> 
> To prevent this issue, implement a starvation monitor mechanism that
> starts the deadline server only if a (fair in this case) task hasn't
> been scheduled for some interval of time after it has been enqueued.
> Use pick/put functions to manage starvation monitor status.

One thing I considerd was scheduling this as a least-laxity entity --
such that it runs late, not early -- and start the server when
rq->nr_running != rq->cfs.h_nr_running, IOW when there's !fair tasks
around.

Not saying we should do it like that, but that's perhaps more
deterministic than this.
