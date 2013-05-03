From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Suspend resume problem (WAS Re: [ANNOUNCE] 3.8.10-rt6)
Date: Fri, 03 May 2013 11:31:02 -0400
Message-ID: <1367595062.7373.18.camel@gandalf.local.home>
References: <20130429201202.GB7979@linutronix.de>
	  <20130429161925.2a6ea78a@riff.lan> <20130430170948.GB4688@linutronix.de>
	 <1367345295.30667.68.camel@gandalf.local.home>
	 <51838A84.90500@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51838A84.90500@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2013-05-03 at 11:59 +0200, Sebastian Andrzej Siewior wrote:
>  
> > As the NMI dump only happens because of the time jump, which as you
> > said, is -rt only, I wouldn't say that the NMI deadlock is a mainline
> > bug.
> 
> The reason for the NMI was a bug in the -RT tree but if something else
> triggers that NMI we have a good chance to deadlock.

But only if the NMI does a printk(). The only reason NMIs do printks is
when a bug is detected. But usually oops_in_progress() is called and
also zap_locks() is suppose to help prevent these problems. But that
doesn't always work.

> 
> What about a try_lock() and leave after 50 usecs of trying and not
> getting it in the in_nmi() case?

I wouldn't try too hard to fix printks for NMIs. There's many things
that can go wrong with NMIs doing a printk while another printk is
active.

-- Steve
