From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel
 BUG at kernel/locking/rtmutex.c:997!
Date: Fri, 20 Feb 2015 20:49:04 -0500
Message-ID: <20150220204904.4db61d19@grimm.local.home>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
	<1424395866-81589-2-git-send-email-tmac@hp.com>
	<20150219235321.0acf3c75@grimm.local.home>
	<54E782F5.8060405@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E782F5.8060405@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 20 Feb 2015 11:54:45 -0700
Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com> wrote:

> Sorry for not explaining the problem in more details.
> 
> IH here means the bottom half of interrupt handler, executing in the
> interrupt context (IC), not the preemptible interrupt kernel thread.
> interrupt.
> 
> Here is the problem we encountered.
> 
> An smp_apic_timer_interrupt comes in while task X is in the process of
> waiting for mutex A .  The IH successfully locks mutex B (in this case
> run_local_timers() gets the timer base's lock, base->lock, via
> spin_trylock()).
> 
> At the same time, task Y holding mutex A requests mutex B.
> 
> With current rtmutex code, mutex B ownership is incorrectly attributed
> to task X (using current, which is inaccurate in the IC). To task Y the
> situation effectively looks like it is holding mutex A and reuqesting B,
> which is held by task X holding mutex B and is now waiting for mutex A.
>  The deadlock detection is correct, a classic potential circular mutex
> deadlock.
> 
> In reality, it is not.  The IH the actual owner of mutex B will
> eventually completes and releases mutex B and task Y will eventually get
> mutex B and proceed and so will task X.  Actually either deleting or
> changing BUG_ON(ret) to WARN_ON(ret) in line 997 in fucntion
> rt_spin_lock_slowlock(), the test ran fine without any problem.
> 

Ah, I see the problem you have. Let me explain it in my own words to
make sure that you and I are on the same page.

Task X tries to grab rt_mutex A, but it's held by task Y. But as Y is
still running, the adaptive mutex code is in play and task X is
spinning (with it's blocked on A set). An interrupt comes in,
preempting task X and does a trylock on rt_mutex B, and succeeds. Now it
looks like task X has mutex B and is blocked on mutex A.

Task Y tries to take mutex B and sees that is held by task X which is
blocked on mutex A which Y owns. Thus you get a false deadlock detect.

I'm I correct?

Now, the question is, can we safely change the ownership of mutex B in
the interrupt context where it wont cause another side effect?


> A more detailed description of the problem could also be found at,
> 
> http://markmail.org/message/np33it233hoot4b2#query:+page:1+mid:np33it233hoot4b2+state:results
> 
> 
> Please let me know what you think or need any additional info.
> 

I haven't looked at the above link. I'll have to think about this some
more, but as I'm currently traveling, it will have to be done sometime
next week. Feel free top ping me on Monday or Tuesday. Tuesday would
probably be better, as I'm sure I'm going to be overloaded with other
work when I get back to my office on Monday.

-- Steve
