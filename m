From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 07/12] dump stack: dont disable preemption during
 trace
Date: Mon, 29 Feb 2016 16:07:36 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602291606580.3638@nanos>
References: <20160226213235.253312067@goodmis.org> <20160226213341.100625803@goodmis.org> <20160227103206.GA2337@breakpoint.cc> <20160229100623.7c78620b@gandalf.local.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40986 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbcB2PI7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 10:08:59 -0500
In-Reply-To: <20160229100623.7c78620b@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 29 Feb 2016, Steven Rostedt wrote:

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
> This is in 4.4-rt but not 4.1-rt. I'm currently bringing everything up
> to 4.1-rt, then I'm going to pull 4.1-rt into stable, and then create a
> new round with the changes that happened in 4.4-rt.

Oh nice, I was trying to dig out a time slot to bring 4.1 back up to date ...
