From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] net: detect recursive dev_queue_xmit() on RT properly
Date: Fri, 28 Oct 2016 16:44:12 +0200
Message-ID: <20161028144412.7mk22zboiwupfsi4@linutronix.de>
References: <1476325561-16755-1-git-send-email-brian@peloton-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, mark.beauchemin@sycamorenet.com,
        mbeauch@cox.net, mingo@kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>
To: brian@peloton-tech.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47264 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756035AbcJ1OoQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Oct 2016 10:44:16 -0400
Content-Disposition: inline
In-Reply-To: <1476325561-16755-1-git-send-email-brian@peloton-tech.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-12 22:26:01 [-0400], brian@peloton-tech.com wrote:
> From: mbeauch <mbeauch@cox.net>
> 
> Changed the real-time patch code to detect recursive calls
> to dev_queue_xmit and drop the packet when detected.
> 
> >From Brian Silverman:
> !RT is relying on rcu_read_lock_bh to disable preemption here, so it can
> rely a given smp_processor_id() only being in the call stack once.
> However, on RT, that's not true when one task preempts another one,
> which results in false warnings and dropped packets.
> 
> Without this, messages like
> "Dead loop on virtual device vcan0, fix it urgently!" show up in dmesg
> when multiple processes are sending on the same virtual device at the
> same time and sendmsg calls return ENETDOWN at random.
> 
> This also includes "543a589a00e8 net: xmit lock owner cleanup" from
> v2.6.33.9-rt31 by mingo and tglx, which was just some cleanups to the
> original patch which make porting to to current upstream easier.
> 
> Signed-off-by: Mark Beauchemin <mark.beauchemin@sycamorenet.com>
> [ ported to latest upstream ]
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [ ported to 4.8 and used struct task_struct instead of void ]
> Signed-off-by: Brian Silverman <brian@peloton-tech.com>

The signed-off-by chain suggest that Mark passed the patch to Ingo,
Thomas and to Brian. I doubt that. I can't resolve the sha1 id mentioned
here.
Do you have a testcase for this? Speaking of vcan, then this is
something that does not require real HW.
Is this still broken as of v4.8-RT? I remember fixing something similar
with bridge devices.
I suggest to not use the second the argument of __netif_tx_lock()
instead patching it away it a bunch of drivers.

Sebastian
