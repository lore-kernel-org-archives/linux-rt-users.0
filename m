Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51820 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeHWQHS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Aug 2018 12:07:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so5098305wma.1
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2018 05:37:45 -0700 (PDT)
Date: Thu, 23 Aug 2018 14:37:39 +0200
From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180823123739.GC31443@localhost.localdomain>
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <20180823115618.5584687b@luca64>
 <20180823102350.GB31443@localhost.localdomain>
 <20180823124340.765632d8@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823124340.765632d8@luca64>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: luca abeni <luca.abeni@santannapisa.it>
Cc: Tim Blechmann <tim@klingt.org>, Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>

On 23/08/18 12:43, luca abeni wrote:
> On Thu, 23 Aug 2018 12:23:50 +0200
> Juri Lelli <juri.lelli@gmail.com> wrote:

[...]

> > But then what is a sane inheritance mechanism?
> 
> In my understanding (please correct me if I am wrong), this is an
> orthogonal issue: if I understand well, the issue preventing non-root
> usage of SCHED_DEADLINE is that a task inheriting a dl entity is not
> throttled (when the current runtime rrives to 0, the deadline is
> postponed, but the task stays schedulable). So, I think that removing
> this behaviour should allow to use SCHED_DEADLINE without starving
> other tasks...

Right, potential starvation would be gone...

> Then, there is the issue about the deadline and runtime to inherit. And
> I agree that this is important (and the solution is not easy), but you
> have this issue even if you use the current "dl_boosted" behaviour...
> No?

... but, while it's true that current inheritance has problems w/ o w/o
boosting behaviour, I wonder if the problem might be more painful for a
normal user that it's still under runtime enforcement. Disabling
enforcement seems to hide a bit the fact that we need proper
inheritance. :-(

> > Walk the chain and find
> > the next potential deadline to inherit for the current boosted (still
> > runtime enforced) task before throttling it? Not sure it's going to be
> > any easier than the proxy solution. :-/
> 
> Right; this is not easy... But I think it is not related with the issue
> we are discussing (if I understand this email thread well). Yes, it has
> to be fixed, but it does not prevent non-root usage. Or am I missing
> something?

It depends on how bad we think it's what I said above I guess.

> > > 2) Implement some mechanism to limit the amount of dl bandwidth a
> > > user can allocate to itself (I think the cgroup-based approach we
> > >    discussed some time ago should be OK... If I remember well, you
> > > even had a patch implementing it :)  
> > 
> > I think most (all?) distributions today run with CONFIG_RT_GROUP_SCHED
> > disabled, we should also think about a solution that doesn't rely on
> > that interface.
> 
> I guess CONFIG_RT_GROUP_SCHED is often disabled because it ends up
> changing the "traditional" SCHED_{RR/FIFO} behaviour. So, maybe the
> solution is to have a different dl_{runtime,period} interface in
> control groups (enabled by CONFIG_DL_GROUP_SCHED :).
> CONFIG_DL_GROUP_SCHED does not change the scheduling behaviour, but
> only the admission test... So, enabling it could be safer than enabling
> CONFIG_RT_GROUP_SCHED.

Not sure if adding yet another config switch is acceptable. FWIW, I'd
prefer not to add it, also looking back at all the problems RT_GROUP_
SCHED seems to pose/have posed, but if turns to be the only option..

> > Maybe the existing system wide sched_rt_{period,
> > runtime}_us are enough?
> 
> I do not know... A cgroup-based interface looks more powerful (and not
> so difficult to implement... :), and would allow the sysadmin to decide
> which users can use SCHED_DEADLINE, how much SCHED_DEADLINE bandwidth
> can each user/group use, etc...

How about extending PAM limits instead? It looks like it's what (e.g.)
audio users rely on already [1]. It is maybe possible to add dlruntime,
dlperiod, dldeadline parameters in there?

1 - https://fedoraproject.org/wiki/JACK_Audio_Connection_Kit#Running_Jack_in_Realtime_mode
