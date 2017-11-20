From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: Real time application programming - sched_setattr() fails if I
 set CPU affinity using sched_setaffinity().
Date: Mon, 20 Nov 2017 08:18:47 +0100
Message-ID: <20171120071847.hqzvqpqqth7e6rcf@localhost.localdomain>
References: <CA+bpL9+PrYxrBVX_CQxxqqXv07QGULJfdbCx1zoSu=Bir7hy3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: bhargavb <bhargavaramudu@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33043 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdKTHSw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Nov 2017 02:18:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id g130so5200351wme.0
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Nov 2017 23:18:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+bpL9+PrYxrBVX_CQxxqqXv07QGULJfdbCx1zoSu=Bir7hy3w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Bhargav,

On 20/11/17 10:09, bhargavb wrote:
> Hello,
> 
> Working on a real time application, Getting runtime error at
> sched_setattr as "Operation Not permitted".Running on Ubuntu 16.04 LTS
> (4.4.0-97-generic kernel, x86_64 platform)
> C program code excerpt as below:
> 
> unsigned int flags = 0;
> sched_getattr(0, &attr, sizeof (struct sched_attr), 0);
> if (ret != 0)
> perror("getattr failed:");
> attr.sched_policy = SCHED_DEADLINE;
> attr.sched_runtime = 5 * 100 * 1000;
> attr.sched_deadline = 8 * 100 * 1000;
> attr.sched_period = 10 * 100 * 1000;
> attr.size = sizeof (attr);
> attr.sched_flags = 0;
> attr.sched_nice = 0;
> attr.sched_priority = 0;
> 
> if(sched_setaffinity(0,sizeof(set), &set) < 0)
> {
> perror("sched_setaffinity :");
> return 0;
> }
> ret = sched_setattr(0, &attr, flags);
> if(ret!=0)
> {
> perror("sched_setattr failed: ");
> }
> 
> But, If I comment the sched_setaffinity() call, it runs without error.
> Also, using SCHED_FIFO by calling sched_setscheduler() doesn't give me
> any error after setting CPU affinity. Only the combination of
> sched_setaffinity with sched_setattr() generates error. I am running
> in sudo mode.

Problem is that SCHED_DEADLINE tasks can't have an affinity mask smaller than
the root domain they are on [1]. You've got to use cpuset to achieve what you
want.

Best,

Juri

[1] https://elixir.free-electrons.com/linux/latest/source/Documentation/scheduler/sched-deadline.txt#L620
