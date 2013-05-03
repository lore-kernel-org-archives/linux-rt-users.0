From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Suspend resume problem (WAS Re: [ANNOUNCE] 3.8.10-rt6)
Date: Fri, 03 May 2013 11:59:32 +0200
Message-ID: <51838A84.90500@linutronix.de>
References: <20130429201202.GB7979@linutronix.de>  <20130429161925.2a6ea78a@riff.lan> <20130430170948.GB4688@linutronix.de> <1367345295.30667.68.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367345295.30667.68.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 04/30/2013 08:08 PM, Steven Rostedt wrote:
>> This NMI releated deadlock is a problem which should also trigger
>> mainline, right?
> 
> Well, yeah, as sending out a NMI stack dump is sorta the last resort,
> and is dangerous to do printks from NMI context.

So we did bad and we upgrade to bad and dangerous.

>>
>> Now, the time jump on the other hand is the real issue here and is
>> RT-only. It looks like we get a big number of timer updates via
>> tick_do_update_jiffies64() because according to ktime_get() that much
>> time really passed by.
> 
> As the NMI dump only happens because of the time jump, which as you
> said, is -rt only, I wouldn't say that the NMI deadlock is a mainline
> bug.

The reason for the NMI was a bug in the -RT tree but if something else
triggers that NMI we have a good chance to deadlock.

What about a try_lock() and leave after 50 usecs of trying and not
getting it in the in_nmi() case?

> -- Steve

Sebastian
