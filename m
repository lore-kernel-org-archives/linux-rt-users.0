From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RCU splat on boot from an idle CPU
Date: Wed, 2 Sep 2015 15:38:23 -0400
Message-ID: <20150902153823.749a9f73@gandalf.local.home>
References: <CA+0CQ216LKjL4-PVeqW3vwZhvFLhRJ2GuTOfVsEvxtoZ=xoVgQ@mail.gmail.com>
	<alpine.DEB.2.11.1509011721510.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Philipp Schrader <philipp@peloton-tech.com>,
	linux-rt-users@vger.kernel.org,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:47708 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755159AbbIBTi0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Sep 2015 15:38:26 -0400
In-Reply-To: <alpine.DEB.2.11.1509011721510.15006@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 1 Sep 2015 17:35:23 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 31 Aug 2015, Philipp Schrader wrote:
> 
> Cc'ing Paul and Steven

Not sure if we were actually Cc'd (reading this from my
linux-rt-users folder)

> 
> > Hi all,
> > 
> > I've got a real-time kernel on a DRA7 evaluation module (EVM).
> > Very early in the boot process I get the following splat.
> > 
> > [    0.055073]
> > [    0.055076] ===============================
> > [    0.055079] [ INFO: suspicious RCU usage. ]
> > [    0.055084] 4.1.6+ #2 Not tainted
> > [    0.055086] -------------------------------
> > [    0.055090] include/trace/events/hist.h:31 suspicious

Hmm, the histogram code in -rt, needs a rewrite :-/  I haven't had time
to do so. But it's definitely on my TODO list.

> > rcu_dereference_check() usage!
> > [    0.055093]
> > [    0.055093] other info that might help us debug this:
> > [    0.055093]
> > [    0.055097]
> > [    0.055097] RCU used illegally from idle CPU!
> > [    0.055097] rcu_scheduler_active = 1, debug_locks = 1
> > [    0.055100] RCU used illegally from extended quiescent state!
> > [    0.055104] no locks held by swapper/0/0.
> > [    0.055106]
> > [    0.055106] stack backtrace:
> > [    0.055112] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.1.6+ #2
> > [    0.055116] Hardware name: Generic DRA74X (Flattened Device Tree)
> > [    0.055130] [<c00196b8>] (unwind_backtrace) from [<c001515c>]
> > (show_stack+0x20/0x24)
> > [    0.055146] [<c001515c>] (show_stack) from [<c07bc408>]
> > (dump_stack+0x84/0xa0)
> > [    0.055160] [<c07bc408>] (dump_stack) from [<c009bc38>]
> > (lockdep_rcu_suspicious+0xb0/0x110)
> > [    0.055172] [<c009bc38>] (lockdep_rcu_suspicious) from [<c01246c4>]
> > (time_hardirqs_off+0x2b8/0x3c8)
> > [    0.055184] [<c01246c4>] (time_hardirqs_off) from [<c009a218>]
> > (trace_hardirqs_off_caller+0x2c/0xf4)
> > [    0.055194] [<c009a218>] (trace_hardirqs_off_caller) from
> > [<c009a2f4>] (trace_hardirqs_off+0x14/0x18)
> > [    0.055204] [<c009a2f4>] (trace_hardirqs_off) from [<c00c7ecc>]
> > (rcu_idle_enter+0x78/0xcc)
> > [    0.055213] [<c00c7ecc>] (rcu_idle_enter) from [<c0093eb0>]
> > (cpu_startup_entry+0x190/0x518)
> > [    0.055222] [<c0093eb0>] (cpu_startup_entry) from [<c07b95b4>]
> > (rest_init+0x13c/0x17c)
> > [    0.055231] [<c07b95b4>] (rest_init) from [<c0b32c74>]
> > (start_kernel+0x320/0x380)
> > [    0.055238] [<c0b32c74>] (start_kernel) from [<8000807c>] (0x8000807c)
> > 
> > I'm not sure how to debug this; I'm still reading up on RCUs. Pretty
> > nifty ideas.
> > 
> > Looking at include/trace/events/hist.h it appears line 31 is the end
> > of a TRACE_EVENT macro usage.
> > Does that mean the macro is using RCU improperly somehow?

I think this needs to be a trace_*_rcu_idle() call. That is, I bet the
tracepoint was triggered when rcu wasn't watching.

-- Steve

> > 
> > Thanks,
> > Philipp
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

