From: Gregory Haskins <gregory.haskins.ml@gmail.com>
Subject: Re: [PATCH [RT] 11/14] optimize the !printk fastpath through the
 lock acquisition
Date: Mon, 25 Feb 2008 00:20:14 -0500
Message-ID: <47C2500E.9080407@gmail.com>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>	 <20080221152722.4804.77478.stgit@novell1.haskins.net>	 <20080222191837.GE6060@ucw.cz> <47BF4AC5.7070507@gmail.com> <9810cff90802221643g7d993af4k33f29fb4a4663407@mail.gmail.com>
Reply-To: gregory.haskins@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregory.haskins@gmail.com, Pavel Machek <pavel@ucw.cz>,
	Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	a.p.zijlstra@chello.nl, tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, gregkh@suse.de, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com
To: "Bill Huey (hui)" <bill.huey@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754841AbYBYFVF@vger.kernel.org>
In-Reply-To: <9810cff90802221643g7d993af4k33f29fb4a4663407@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Bill Huey (hui) wrote:
> 
> The might_sleep is annotation and well as a conditional preemption
> point for the regular kernel. You might want to do a schedule check
> there, but it's the wrong function if memory serves me correctly. It's
> reserved for things that actually are design to sleep.

Note that might_sleep() already does a cond_resched() on the 
configurations that need it, so I am not sure what you are getting at 
here.  Is that not enough?


> The rt_spin*()
> function are really a method of preserving BKL semantics across real
> schedule() calls. You'd have to use something else instead for that
> purpose like cond_reschedule() instead.

I dont quite understand this part either.  From my perspective, 
rt_spin*() functions are locking constructs that might sleep (or might 
spin with the new patches), and they happen to be BKL and wakeup 
transparent.  To me, either the might_sleep() is correct for all paths 
that don't fit the in_atomic-printk exception, or none of them are.

Are you saying that the modified logic that I introduced is broken?  Or 
that the original use of the might_sleep() annotation inside this 
function is broken?

-Greg
