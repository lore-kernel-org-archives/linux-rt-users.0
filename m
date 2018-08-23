Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37145 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeHWNw4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Aug 2018 09:52:56 -0400
Received: by mail-wm0-f44.google.com with SMTP id n11-v6so5215589wmc.2
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2018 03:23:54 -0700 (PDT)
Date: Thu, 23 Aug 2018 12:23:50 +0200
From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: SCHED_DEADLINE as user
Message-ID: <20180823102350.GB31443@localhost.localdomain>
References: <pl0fsj$ohn$1@blaine.gmane.org>
 <0ac9fabc-c316-2a59-c3dd-c7b4e4f93209@bristot.me>
 <20180817095106.GB27071@localhost.localdomain>
 <c2b1a7a4-db8c-b8bd-6623-5c66b55ee6d2@klingt.org>
 <20180817102810.GC27071@localhost.localdomain>
 <513fd544-bc51-7ea6-8b94-983d28922a66@klingt.org>
 <20180820085420.GB8866@localhost.localdomain>
 <20180823115618.5584687b@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823115618.5584687b@luca64>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: luca abeni <luca.abeni@santannapisa.it>
Cc: Tim Blechmann <tim@klingt.org>, Daniel Bristot de Oliveira <daniel@bristot.me>, linux-rt-users@vger.kernel.org, Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>

Hi,

On 23/08/18 11:56, luca abeni wrote:
> Hi Juri,
> 
> sorry for the late reply (I am just back from vacations), and thanks
> for cc-ing me.

Welcome back! :-)

> I see you opened a bug on github about this, so I am going to add more
> details there,

I use github issues to keep track of things, but I guess mailing list
discussions are to be preferred though (so that more people can
potentially follow).

> but basically I think that in order to use SCHED_DEADLINE as non-root
> we need to:
> 1) Disable the boosting mechanism (not the inheritance, just the "soft
>    enforcement behaviour" of tasks holding mutexes)

But then what is a sane inheritance mechanism? Walk the chain and find
the next potential deadline to inherit for the current boosted (still
runtime enforced) task before throttling it? Not sure it's going to be
any easier than the proxy solution. :-/

> 2) Implement some mechanism to limit the amount of dl bandwidth a user
>    can allocate to itself (I think the cgroup-based approach we
>    discussed some time ago should be OK... If I remember well, you even
>    had a patch implementing it :)

I think most (all?) distributions today run with CONFIG_RT_GROUP_SCHED
disabled, we should also think about a solution that doesn't rely on
that interface. Maybe the existing system wide sched_rt_{period,
runtime}_us are enough?

Best,

- Juri
