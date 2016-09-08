From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v3.18-RT
Date: Thu, 8 Sep 2016 15:45:09 +0200
Message-ID: <20160908134509.g22izjojzdsso4pa@linutronix.de>
References: <FCC5AC80E299464B82E1345E2C10FC9D8098CE51@S1P5DAG4C.EXCHPROD.USA.NET>
 <20160603163732.GD4496@linutronix.de>
 <FCC5AC80E299464B82E1345E2C10FC9D8099ACF6@S1P5DAG4C.EXCHPROD.USA.NET>
 <16d5e3f2-dd20-c802-37aa-86eab553fcfc@linutronix.de>
 <FCC5AC80E299464B82E1345E2C10FC9D809A150B@S1P5DAG4C.EXCHPROD.USA.NET>
 <4061065f-dd2b-0a76-299e-ce66783d85dd@linutronix.de>
 <82DB755727433D4A981ED5650C27BBEF729546A9@S1P5DAG9E.EXCHPROD.USA.NET>
 <20160729161933.GG21715@linutronix.de>
 <82DB755727433D4A981ED5650C27BBEF72A4055B@S1P5DAG9E.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        David Hauck <davidh@netacquire.com>,
        Preston Hauck <prestonh@netacquire.com>
To: Carol Wong <carolw@netacquire.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44385 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbcIHNpL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Sep 2016 09:45:11 -0400
Content-Disposition: inline
In-Reply-To: <82DB755727433D4A981ED5650C27BBEF72A4055B@S1P5DAG9E.EXCHPROD.USA.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-08-19 00:41:46 [+0000], Carol Wong wrote:
> Hi Sebastian,
Hi Carol,

> Were you able to gain any insight from the traces?

not really. T00 shows a fault in
[    2.756284] BUG: unable to handle kernel NULL pointer dereference at 00000004
[    2.756289] IP: [<c11653e7>] kmem_cache_alloc+0x87/0x230
from ida_pre_get() / create_worker(). That is quite late so I have no
idea why that would happen.
The other two are not really help full.

> If we were to proceed with reverting the kernel/sched/core.c patch in our build of 3.18.29-rt30, would the addition of the WARN_ON_ONCE(p->migrate_disable_atomic <= 0) debug check that you recommended (2016/07/29) be sufficient for detecting imbalances? We would perform extended testing on multiple systems to determine the effects of reverting the patch.

One thing on the bisect. The git tree has the patches in this order:
 (1) kernel: migrate_disable() do fastpath in atomic & irqs-off
 (2) kernel: softirq: unlock with irqs on

but you need apply Patch #2 before #1. So if you bisect and you hit
warnings due to #1 please note that need apply #2.

T01 and T02 show probably the same issue but there are too many warnings
comming in parallel. If this comes from the sched patch due #1/#2 mix up
then don't bisect here or have them both applied.
The call path itself does look special as it would violate the rule of
atomic locking / unlocking (as it was fixed in #2 for instance).
At this point I assume that your bisect went wrong due to patch #1/#2.

> Cheers,
> Carol
> 
Sebastian
