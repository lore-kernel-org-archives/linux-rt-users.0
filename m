From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 07/12] dump stack: dont disable preemption during
 trace
Date: Mon, 29 Feb 2016 10:06:23 -0500
Message-ID: <20160229100623.7c78620b@gandalf.local.home>
References: <20160226213235.253312067@goodmis.org>
	<20160226213341.100625803@goodmis.org>
	<20160227103206.GA2337@breakpoint.cc>
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
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:37039 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755324AbcB2PG3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 10:06:29 -0500
In-Reply-To: <20160227103206.GA2337@breakpoint.cc>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 27 Feb 2016 11:32:06 +0100
Sebastian Andrzej Siewior <sebastian@breakpoint.cc> wrote:

> On 2016-02-26 16:32:42 [-0500], Steven Rostedt wrote:
> > 3.18.27-rt26-rc1 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> Please merge this one along with "kernel: migrate_disable() do fastpath
> in atomic & irqs-off". Otherwise we might get recursive with lockdep and
> CPU-hotplug (if we go after hp->lock in pin_current_cpu()).

This is in 4.4-rt but not 4.1-rt. I'm currently bringing everything up
to 4.1-rt, then I'm going to pull 4.1-rt into stable, and then create a
new round with the changes that happened in 4.4-rt.

-- Steve
