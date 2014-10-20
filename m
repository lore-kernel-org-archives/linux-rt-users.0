From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/7] wait.[ch]: Introduce the simple waitqueue (swait)
 implementation
Date: Mon, 20 Oct 2014 12:47:16 -0400
Message-ID: <20141020124716.465dce45@gandalf.local.home>
References: <1413591782-23453-1-git-send-email-paul.gortmaker@windriver.com>
	<1413591782-23453-4-git-send-email-paul.gortmaker@windriver.com>
	<20141018213417.GE23531@worktop.programming.kicks-ass.net>
	<1413673519.30326.11.camel@pippen.local.home>
	<20141020152144.GF24595@windriver.com>
	<20141020114013.31e5137c@gandalf.local.home>
	<20141020160542.GG24595@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	<linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:4096 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751461AbaJTQrT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Oct 2014 12:47:19 -0400
In-Reply-To: <20141020160542.GG24595@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 20 Oct 2014 12:05:42 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
 
> > No. You move the items off the main list head and add it to the local
> > list and they never go back. Just start processing that local list.
> > Anything added to the main list after that will not get woken up by
> > that current wake_all call. It will need to be woken by another wake_up.
> 
> OK.  But we may not run all of the wakeups, because of:
> 
> +                       if (++woken == nr_exclusive)
> +                               break;
> 
> > 
> > > 
> > > What would need to be done as an unwind at the end of processing the
> > > local list head before it disappears from existence?  Anything?
> > 
> > Not sure what you mean here.
> 
> Per above -- can't there be "orphaned" entries that only exist on the
> local list head that didn't get processed?  What happens to those?
> 

Why not just take off nr_exclusive tasks off the main list and add
those to the local list, and then wake up all on the local list?

-- Steve
