From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Tue, 12 Dec 2017 11:18:16 +0100
Message-ID: <20171212101816.ux24jdai4fftd7ro@linutronix.de>
References: <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru>
 <5A01812F.7040406@mcst.ru>
 <20171116160837.hfpnq4vb4j2osbuz@linutronix.de>
 <20171117173820.GM872@jcartwri.amer.corp.natinst.com>
 <CAJ9FNxsfHRuc+UZCPKGDJDtk5neApOb3i6thpGTy9c-oP8T4JA@mail.gmail.com>
 <20171124093724.GB2564@linutronix.de>
 <CAJ9FNxtpTqjLevwN1w037=g1eqRPf-Fht+SFqSqJS0jVhFXkLg@mail.gmail.com>
 <20171204095912.GH2255@linutronix.de>
 <CAJ9FNxsqcLjq8=jcOJz+3mwbkzuXyXCp59XVhj-xamsv6Ux0nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: Sam Kappen <skappen@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:32888 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdLLKSS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Dec 2017 05:18:18 -0500
Content-Disposition: inline
In-Reply-To: <CAJ9FNxsqcLjq8=jcOJz+3mwbkzuXyXCp59XVhj-xamsv6Ux0nA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-05 22:01:19 [+0530], Sam Kappen wrote:
> Hi,
Hi,

> Thanks for looking at my queries. Please see my answers inline.
please don't top-post. Please use a client which adds proper indention
while quoting the email.

>  1.)
> > I had derived and tried a patch based on the below analysis.
> > ( I referred below open source commit, to derive on this patch.
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v4.9.47-rt37-rebase&id=7a347757f027190c95a363a491c18156a926a370
> > )
> >
> We see this issue when there is a state change for irqs from disabled
> to enabled. During slab allocations for SCSI on bootup
> the irqs are found to be in disabled state since the system state is
> not yet in "RUNNING".
> 
> So we have added instrument code throughout the call trace and
> confirmed culprit as pi_lock()/pi_unlock for changing the irqs state.
> Basically it happens when it acquires the lock with irqs in disabled state.

but by pi_lock/pi_unlock you don't mean the futex operation, do you?

based on the fact that the system is not in state "running" yet and this
trace here:
> ------------[ cut here ]------------
> WARNING: at kernel/sched/core.c:3052 migrate_disable+0x10b/0x120()
> Modules linked in:
> CPU: 1 PID: 7 Comm: kworker/u8:0 Not tainted 3.10.107-rt120+ #49
> Hardware name: To be filled by O.E.M. To be filled by
…
> Call Trace:
…
>  [<ffffffff8105fcd5>] warn_slowpath_null+0x15/0x20
>  [<ffffffff8109569c>] migrate_enable+0x14c/0x200
>  [<ffffffff81100fb1>] get_page_from_freelist+0x9a1/0xbc0
>  [<ffffffff81101f89>] __alloc_pages_nodemask+0x179/0xa50
>  [<ffffffff81138ab1>] alloc_pages_current+0x101/0x1f0
>  [<ffffffff8113cf95>] new_slab+0x265/0x310
>  [<ffffffff816b386e>] __slab_alloc.isra.62+0x4e0/0x6ca
>  [<ffffffff8113f5d0>] kmem_cache_alloc+0x170/0x190
>  [<ffffffff810fbd0a>] mempool_alloc_slab+0x3a/0x70
>  [<ffffffff810fc0be>] mempool_alloc+0xae/0x210
>  [<ffffffff812d5ce8>] get_request+0x3a8/0x7c0
>  [<ffffffff812d619a>] blk_get_request+0x9a/0x140
>  [<ffffffff813ef02a>] scsi_execute+0x4a/0x170
…
> ---[ end trace 0000000000000001 ]---

I would that this is the same issue and the patch I posted should help.

> > 2.) With your patch during the slab allocations irqs will be in enabled state.
> 
> Thanks. I have been testing your patch, I will update once I finish the long
> run test.

Okay, so a note to myself, there is nothing outstanding for me to do so
far.

> Regards,
> Sam

Sebastian
