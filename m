From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 07/12] dump stack: dont disable preemption during
 trace
Date: Tue, 1 Mar 2016 09:45:05 -0500
Message-ID: <20160301094505.31726f5e@gandalf.local.home>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160227103206.GA2337@breakpoint.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 27 Feb 2016 11:32:06 +0100
Sebastian Andrzej Siewior <sebastian@breakpoint.cc> wrote:

> On 2016-02-26 16:32:42 [-0500], Steven Rostedt wrote:
> > 3.18.27-rt26-rc1 stable review patch.
> > If anyone has any objections, please let me know.  
> 
> Please merge this one along with "kernel: migrate_disable() do fastpath
> in atomic & irqs-off". Otherwise we might get recursive with lockdep and
> CPU-hotplug (if we go after hp->lock in pin_current_cpu()).

Interesting. When I pulled this patch into 4.1-rt, it caused the system
to lock up. I'm looking into it now.

-- Steve
