Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.santannapisa.it ([193.205.80.99]:44143 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbeHWOMy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Aug 2018 10:12:54 -0400
Date: Thu, 23 Aug 2018 12:43:40 +0200
From: luca abeni <luca.abeni@santannapisa.it>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180823124340.765632d8@luca64>
In-Reply-To: <20180823102350.GB31443@localhost.localdomain>
References: <pl0fsj$ohn$1@blaine.gmane.org>
        <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
        <20180817095106.GB27071@localhost.localdomain>
        <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
        <20180817102810.GC27071@localhost.localdomain>
        <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
        <20180820085420.GB8866@localhost.localdomain>
        <20180823115618.5584687b@luca64>
        <20180823102350.GB31443@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Tim Blechmann <tim@klingt.org>, Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>

Hi Juri,

On Thu, 23 Aug 2018 12:23:50 +0200
Juri Lelli <juri.lelli@gmail.com> wrote:
> > sorry for the late reply (I am just back from vacations), and thanks
> > for cc-ing me.  
> 
> Welcome back! :-)

Thanks :)


> > I see you opened a bug on github about this, so I am going to add
> > more details there,  
> 
> I use github issues to keep track of things, but I guess mailing list
> discussions are to be preferred though (so that more people can
> potentially follow).

Ok


> > but basically I think that in order to use SCHED_DEADLINE as
> > non-root we need to:
> > 1) Disable the boosting mechanism (not the inheritance, just the
> > "soft enforcement behaviour" of tasks holding mutexes)  
> 
> But then what is a sane inheritance mechanism?

In my understanding (please correct me if I am wrong), this is an
orthogonal issue: if I understand well, the issue preventing non-root
usage of SCHED_DEADLINE is that a task inheriting a dl entity is not
throttled (when the current runtime rrives to 0, the deadline is
postponed, but the task stays schedulable). So, I think that removing
this behaviour should allow to use SCHED_DEADLINE without starving
other tasks...

Then, there is the issue about the deadline and runtime to inherit. And
I agree that this is important (and the solution is not easy), but you
have this issue even if you use the current "dl_boosted" behaviour...
No?


> Walk the chain and find
> the next potential deadline to inherit for the current boosted (still
> runtime enforced) task before throttling it? Not sure it's going to be
> any easier than the proxy solution. :-/

Right; this is not easy... But I think it is not related with the issue
we are discussing (if I understand this email thread well). Yes, it has
to be fixed, but it does not prevent non-root usage. Or am I missing
something?


> > 2) Implement some mechanism to limit the amount of dl bandwidth a
> > user can allocate to itself (I think the cgroup-based approach we
> >    discussed some time ago should be OK... If I remember well, you
> > even had a patch implementing it :)  
> 
> I think most (all?) distributions today run with CONFIG_RT_GROUP_SCHED
> disabled, we should also think about a solution that doesn't rely on
> that interface.

I guess CONFIG_RT_GROUP_SCHED is often disabled because it ends up
changing the "traditional" SCHED_{RR/FIFO} behaviour. So, maybe the
solution is to have a different dl_{runtime,period} interface in
control groups (enabled by CONFIG_DL_GROUP_SCHED :).
CONFIG_DL_GROUP_SCHED does not change the scheduling behaviour, but
only the admission test... So, enabling it could be safer than enabling
CONFIG_RT_GROUP_SCHED.

> Maybe the existing system wide sched_rt_{period,
> runtime}_us are enough?

I do not know... A cgroup-based interface looks more powerful (and not
so difficult to implement... :), and would allow the sysadmin to decide
which users can use SCHED_DEADLINE, how much SCHED_DEADLINE bandwidth
can each user/group use, etc...


				Luca
