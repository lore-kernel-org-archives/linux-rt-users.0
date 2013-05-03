From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] x86/mce: Defer mce wakeups to threads for PREEMPT_RT
Date: Fri, 03 May 2013 11:31:39 +0200
Message-ID: <518383FB.8020004@linutronix.de>
References: <1365705214.9609.58.camel@gandalf.local.home>  <20130426084137.GC20927@linutronix.de> <1367505199.30667.132.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367505199.30667.132.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 05/02/2013 04:33 PM, Steven Rostedt wrote:
>> mce_notify_irq() can use simple_waitqueue, no?
> 
> Yeah, and I went down that path.
> 
> But it also schedules work, which has the issue.

Hmm, okay.

>> The other issue is that mce_report_event() is scheduling a per-cpu
>> workqueue (mce_schedule_work) in case of a memory fault. This has the
>> same issue.
> 
> Yeah, that looks like it can be an issue too. I wonder if we can use the
> same thread and use flags check what to do. Atomically set the flag for
> the function to perform, and then have the thread clear it before doing
> the function and only go to sleep when all flags are cleared.

This should work. It uses per-cpu workthreads, not sure why. Maybe to
avoid locking issues when invoked from NMI.

> 
> -- Steve

Sebastian
