Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AAFC433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36A22072D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHGNuX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:50:23 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:61185 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgHGNt4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 09:49:56 -0400
Received: from [94.37.192.58] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 150297187; Fri, 07 Aug 2020 15:49:52 +0200
Date:   Fri, 7 Aug 2020 15:49:41 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     peterz@infradead.org
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807154941.2bb11408@nowhere>
In-Reply-To: <20200807104618.GH2674@hirez.programming.kicks-ass.net>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
        <20200807095604.GO42956@localhost.localdomain>
        <20200807104618.GH2674@hirez.programming.kicks-ass.net>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Peter,

On Fri, 7 Aug 2020 12:46:18 +0200
peterz@infradead.org wrote:

> On Fri, Aug 07, 2020 at 11:56:04AM +0200, Juri Lelli wrote:
> > Starting deadline server for lower priority classes right away when
> > first task is enqueued might break guarantees, as tasks belonging to
> > intermediate priority classes could be uselessly preempted. E.g., a
> > well behaving (non hog) FIFO task can be preempted by NORMAL tasks
> > even if there are still CPU cycles available for NORMAL tasks to
> > run, as they'll be running inside the fair deadline server for some
> > period of time.
> > 
> > To prevent this issue, implement a starvation monitor mechanism that
> > starts the deadline server only if a (fair in this case) task hasn't
> > been scheduled for some interval of time after it has been enqueued.
> > Use pick/put functions to manage starvation monitor status.  
> 
> One thing I considerd was scheduling this as a least-laxity entity --
> such that it runs late, not early

Are you thinking about scheduling both RT and non-RT tasks through
deadline servers? If yes, then I think that using something like
laxity-based scheduling for the SCHED_OTHER server can be a good idea
(but then we need to understand how to combine deadline-based
scheduling with laxity-based scheduling, etc...)

Or are you thinking about keeping the SCHED_OTHER server throttled
until its laxity is 0 (or until its laxity is lower than some small
value)? In this second case, the approach would work even if RT tasks
are not scheduled through a server (but I do not know which kind of
performance guarantee we could provide).


> -- and start the server when
> rq->nr_running != rq->cfs.h_nr_running, IOW when there's !fair tasks
> around.

Yes, this could be a good optimization.



			Luca
> 
> Not saying we should do it like that, but that's perhaps more
> deterministic than this.

