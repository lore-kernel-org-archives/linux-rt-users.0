From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/8] rtmutex: use a trylock for waiter lock in trylock
Date: Fri, 31 Jan 2014 23:07:37 +0100
Message-ID: <20140131220737.GF21238@linutronix.de>
References: <20140116015824.201732155@goodmis.org>
 <20140116020324.637491369@goodmis.org>
 <1389841737.5418.14.camel@marge.simpson.net>
 <20140116232228.0f3cfb89@gandalf.local.home>
 <1389935832.5449.23.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389935832.5449.23.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2014-01-17 06:17:12 [+0100]:

>On Thu, 2014-01-16 at 23:22 -0500, Steven Rostedt wrote: 
>> On Thu, 16 Jan 2014 04:08:57 +0100
>> Mike Galbraith <bitbucket@online.de> wrote:
>> 
>> > On Wed, 2014-01-15 at 20:58 -0500, Steven Rostedt wrote:
>> > 
>> > 
>> > > 3.2.53-rt76-rc1 stable review patch.
>> > > If anyone has any objections, please let me know.
>> > 
>> > Not sure this is needed without the tglx don't unconditionally raise
>> > timer softirq patch, and with that patch applied in the form it exists
>> > in 3.12-rt9, as well as this one, you'll still eventually deadlock.
>> 
>> Hmm, I'll have to take a look. This sounds to be missing from all the
>> stable -rt kernels. I'll be pulling in the latest updates from 3.12-rt
>> soon.
>
>Below are the two deadlocks I encountered with 3.12-rt9, which has both
>$subject and timers-do-not-raise-softirq-unconditionally.patch applied.

This patch was introduced because we had a deadlock in
run_local_timers() which took a sleeping lock in hardirq context. This
seem not to be the case in v3.2 therefore I would suggest not to take
this patch here because it does not fix anything.

Mike, do you see these deadlocks with 3.12.*-rt11 as well?

Sebastian
