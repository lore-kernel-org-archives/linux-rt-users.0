From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT v2] x86/mce: Defer mce wakeups to threads for
 PREEMPT_RT
Date: Fri, 12 Apr 2013 09:44:15 -0400
Message-ID: <1365774255.9609.82.camel@gandalf.local.home>
References: <1365705214.9609.58.camel@gandalf.local.home>
	 <20130412133846.GD2368@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130412133846.GD2368@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2013-04-12 at 15:38 +0200, Borislav Petkov wrote:

> > +static void __mce_notify_work(void)
> > +{
> > +	/* Not more than two messages every minute */
> > +	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
> > +
> > +	/* wake processes polling /dev/mcelog */
> > +	wake_up_interruptible(&mce_chrdev_wait);
> > +
> > +	/*
> > +	 * There is no risk of missing notifications because
> > +	 * work_pending is always cleared before the function is
> > +	 * executed.
> > +	 */
> 
> You must be using some tree != mainline because this comment is gone
> upstream and that whole second hunk below which moves it here doesn't
> apply.
> 

I forgot to state that I based this off of 3.6-rt, and will be
backporting it to 3.0-rt as that's the kernel that the bug was reported
on. But the problem still exists in mainline as well (for -rt).

-- Steve
