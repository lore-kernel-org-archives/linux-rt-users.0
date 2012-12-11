From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT 3/4] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Mon, 10 Dec 2012 20:53:50 -0500
Message-ID: <1355190830.17101.280.camel@gandalf.local.home>
References: <20121207235615.206108556@goodmis.org>
	 <20121208000900.613917378@goodmis.org> <50C682F6.5030709@am.sony.com>
	 <50C68922.5030203@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9213 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab2LKBxx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Dec 2012 20:53:53 -0500
In-Reply-To: <50C68922.5030203@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-12-10 at 17:15 -0800, Frank Rowand wrote:

> I should have also mentioned some previous experience using IPIs to
> avoid runq lock contention on wake up.  Someone encountered IPI
> storms when using the TTWU_QUEUE feature, thus it defaults to off
> for CONFIG_PREEMPT_RT_FULL:
> 
>   #ifndef CONFIG_PREEMPT_RT_FULL
>   /*
>    * Queue remote wakeups on the target CPU and process them
>    * using the scheduler IPI. Reduces rq->lock contention/bounces.
>    */
>   SCHED_FEAT(TTWU_QUEUE, true)
>   #else
>   SCHED_FEAT(TTWU_QUEUE, false)
> 

Interesting, but I'm wondering if this also does it for every wakeup? If
you have 1000 tasks waking up on another CPU, this could potentially
send out 1000 IPIs. The number of IPIs here looks to be # of tasks
waking up, and perhaps more than that, as there could be multiple
instances that try to wake up the same task.

Now this patch set, the # of IPIs is limited to the # of CPUs. If you
have 4 CPUs, you'll get a storm of 3 IPIs. That's a big difference.

Now we could even add a flag, and do a test_and_set on it, and send out
an IPI iff the flag wasn't set before. Have the target CPU clear the
flag and then do the pushing. This would limit even further the IPIs
needed to be sent. I didn't add this yet, because I wanted to test the
current code first, and only add this if there is an issue with too many
IPIs.

-- Steve


