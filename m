From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch] hotplug: Call mmdrop_delayed() in sched_cpu_dying()
 if PREEMPT_RT_FULL
Date: Thu, 20 Oct 2016 13:21:45 +0200
Message-ID: <20161020112145.tyz6pcoimysha3jz@linutronix.de>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
 <1476956043.18007.15.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47939 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932353AbcJTLVs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Oct 2016 07:21:48 -0400
Content-Disposition: inline
In-Reply-To: <1476956043.18007.15.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-20 11:34:03 [+0200], Mike Galbraith wrote:
> My 64 core box just passed an hour running Steven's hotplug stress
> script along with stockfish and futextests (tip-rt.today w. hotplug
> hacks you saw a while back), and seems content to just keep on grinding
> away.  Without it, box quickly becomes a doorstop.

This is new. It is v4.7-rc1 new. The hotplug rework moved the notified
around and after

e9cd8fa4fcfd ("sched/migration: Move calc_load_migrate() into CPU_DYING")
f2785ddb5367 ("sched/hotplug: Move migration CPU_DYING to sched_cpu_dying()")

we have no more CPU_DEAD, just CPU_DYING which is invoked with
interrupts off. I don't see anything wrong with pushing this over to
RCU.

Sebastian
