From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.9-rt13
Date: Fri, 7 Feb 2014 11:41:07 +0100
Message-ID: <20140207104107.GC23668@linutronix.de>
References: <20140203194841.GA17108@linutronix.de>
 <20140205092657.GA21590@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140205092657.GA21590@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Nicholas Mc Guire | 2014-02-05 10:26:57 [+0100]:

>Sorry - this one causes a build failure with PREEMPT_RT_BASE=y and 
>PREEMPT_RT_FULL not set.

At some point we are going to drop PREEMPT_RT_BASE because it was only
meant for debugging in the beginning. However I don't know when this
will be.

>The patch below fixes this build failure for 3.12.9-rt13.
>
>Not sure what the clean way of resolving this is - this patch proposes to
>move the spin_*_local into linux/locallock.h and map to spin_*lock for
>the "CONFIG_PREEMPT_RT_FULL not set" case.
>
>This was build tested with Preempt none,voluntary,low-lat,base,full and 
>otherweise got only limited testing.
>
>I'm also not sure if putting the rt specific locks into locallock.h in 
>this way is the proper way to deal with this #include dependency.

I think I keep it that way. However I split into two patches and add the
spin_lock_local => rt_spin_lock mapping in the rt-add-rt-locks.patch
where the locks are introduced.

Sebastian
