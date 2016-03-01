From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 07/12] dump stack: dont disable preemption during
 trace
Date: Tue, 1 Mar 2016 13:25:46 -0500
Message-ID: <20160301132546.4aef9949@gandalf.local.home>
References: <20160226213235.253312067@goodmis.org>
	<20160226213341.100625803@goodmis.org>
	<20160227103206.GA2337@breakpoint.cc>
	<20160301094505.31726f5e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:53669 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750846AbcCASZu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Mar 2016 13:25:50 -0500
In-Reply-To: <20160301094505.31726f5e@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 1 Mar 2016 09:45:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 27 Feb 2016 11:32:06 +0100
> Sebastian Andrzej Siewior <sebastian@breakpoint.cc> wrote:
> 
> > On 2016-02-26 16:32:42 [-0500], Steven Rostedt wrote:  
> > > 3.18.27-rt26-rc1 stable review patch.
> > > If anyone has any objections, please let me know.    
> > 
> > Please merge this one along with "kernel: migrate_disable() do fastpath
> > in atomic & irqs-off". Otherwise we might get recursive with lockdep and
> > CPU-hotplug (if we go after hp->lock in pin_current_cpu()).  
> 
> Interesting. When I pulled this patch into 4.1-rt, it caused the system
> to lock up. I'm looking into it now.

And that's because this commit also needs:

"kernel: softirq: unlock with irqs on"

And due to the WARN_ON_ONCE() issue (that I just posted a patch to fix
mainline), it caused my system to reboot.

http://lkml.kernel.org/r/20160301110939.1b786f49@gandalf.local.home

-- Steve
