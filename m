Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2257C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70EB20866
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHGNlq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:41:46 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:52330 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHGNll (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 09:41:41 -0400
Received: from [94.37.192.58] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 150297055; Fri, 07 Aug 2020 15:41:30 +0200
Date:   Fri, 7 Aug 2020 15:41:20 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 0/6] SCHED_DEADLINE server infrastructure
Message-ID: <20200807154120.5dc9599c@nowhere>
In-Reply-To: <20200807133041.GQ42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
        <20200807151632.36dc6200@nowhere>
        <20200807133041.GQ42956@localhost.localdomain>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Juri,

On Fri, 7 Aug 2020 15:30:41 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
> > In the meanwhile, I have some questions/comments after a first quick
> > look.
> > 
> > If I understand well, the patchset does not apply deadline servers
> > to FIFO and RR tasks, right? How does this patchset interact with RT
> > throttling?  
> 
> Well, it's something like the dual of it, in that RT Throttling
> directly throttles RT tasks to make spare CPU cycles available to
> fair tasks while this patchset introduces deadline servers to
> schedule fair tasks, thus still reserving CPU time for those (when
> needed).

Ah, OK... I was thinking about using deadline servers for both RT and
non-RT tasks. And to use them not only to throttle, but also to provide
some kind of performance guarantees (to all the scheduling classes).
Think about what can be done when combining this mechanism with
cgroups/containers :)

[...]
> > I understand this is because you do not
> > want to delay RT tasks if they are not starving other tasks. But
> > then, maybe what you want is not deadline-based scheduling. Maybe a
> > reservation-based scheduler based on fixed priorities is what you
> > want? (with SCHED_DEADLINE, you could provide exact performance
> > guarantees to SCHED_OTHER tasks, but I suspect patch 6/6 breaks
> > these guarantees?)  
> 
> I agree that we are not interested in exact guarantees in this case,
> but why not using something that it's already there and would give us
> the functionality we need (fix starvation for fair)?

Ok, if performance guarantees to non-RT tasks are not the goal, then I
agree. I was thinking that since the patchset provides a mechanism to
schedule various classes of tasks through deadline servers, then
using these servers to provide some kinds of guarantees could be
interesting ;-)



			Thanks,
				Luca

> It would also
> work well in presence of "real" deadline tasks I think, in that you
> could account for these fair servers while performing admission
> control.
> 
> Best,
> 
> Juri
> 

