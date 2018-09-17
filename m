Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41044 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeIQOx0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Sep 2018 10:53:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so16501236wrb.8
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Sep 2018 02:26:52 -0700 (PDT)
Date: Mon, 17 Sep 2018 11:26:48 +0200
From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: yielding while running SCHED_DEADLINE
Message-ID: <20180917092648.GA4282@localhost.localdomain>
References: <1536966797.25468.109.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536966797.25468.109.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: "Patel, Vedang" <vedang.patel@intel.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, "Koppolu, Chanakya" <chanakya.koppolu@intel.com>, Peter Zijlstra <peterz@infradead.org>

Hi,

On 14/09/18 23:13, Patel, Vedang wrote:
> Hi all, 
> 
> We have been playing around with SCHED_DEADLINE and found some
> discrepancy around the calculation of nr_involuntary_switches and
> nr_voluntary_switches in /proc/${PID}/sched.
> 
> Whenever the task is done with it's work earlier and executes
> sched_yield() to voluntarily gives up the CPU this increments
> nr_involuntary_switches. It should have incremented
> nr_voluntary_switches.

Mmm, I see what you are saying.

[...]

> Looking at __schedule() in kernel/sched/core.c, the switch is counted
> as part of nr_involuntary_switches if the task has not been preempted
> and the task is TASK_RUNNING state. This does not seem to happen when
> sched_yield() is called.

Mmm,

 - nr_voluntary_switches++ if !preempt && !RUNNING
 - nr_involuntary_switches++ otherwise (yield fits this as the task is
   still RUNNING, even though throttled for DEADLINE)

Not sure this is the same as what you say above..

> Is there something we are missing over here? OR Is this a known issue
> and is planned to be fixed later?

.. however, not sure. Peter, what you say. It looks like we might indeed
want to account yield as a voluntary switch, seems to fit. In this case
I guess we could use a flag or add a sched_ bit to task_struct to handle
the case?

Best,

- Juri
