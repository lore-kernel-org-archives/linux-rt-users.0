From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 5/8] sched: Remove TASK_ALL
Date: Tue, 21 Nov 2017 18:26:20 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711211825430.2399@nanos>
References: <20171121160654.493640386@goodmis.org> <20171121160706.405135518@goodmis.org> <20171121161907.ovg4ye7czrqlqkx2@hirez.programming.kicks-ass.net> <20171121112732.503a0a32@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdKUR1w (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Nov 2017 12:27:52 -0500
In-Reply-To: <20171121112732.503a0a32@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 21 Nov 2017, Steven Rostedt wrote:

> On Tue, 21 Nov 2017 17:19:07 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Nov 21, 2017 at 11:06:59AM -0500, Steven Rostedt wrote:
> > > 4.4.97-rt111-rc1 stable review patch.
> > > If anyone has any objections, please let me know.  
> > 
> > No real objection, just curious as to why its -stable material.
> 
> Good question ;-) But it was marked with the stable-rt tag, Thomas
> said it was dangerous, and it applied nicely.

Yes, it's dangerous and I wanted to make sure that it does not get reused
by chance.

Thanks,

	tglx
