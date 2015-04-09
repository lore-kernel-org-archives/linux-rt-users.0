From: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Thu, 09 Apr 2015 16:56:06 -0600
Message-ID: <55270386.4060304@hp.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com> <1428369962-74723-1-git-send-email-tmac@hp.com> <1428369962-74723-2-git-send-email-tmac@hp.com> <20150406215959.4e8ad37b@grimm.local.home> <55247C96.1080707@hp.com> <alpine.DEB.2.11.1504081044130.3845@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	linux-rt-users@vger.kernel.org, umgwanakikbuti@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1504081044130.3845@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 04/08/2015 02:50 AM, Thomas Gleixner wrote:
> 
> Don't even try to get this working. Taking the lock in idle/interrupt
> context is just plain wrong.
> 

Thanks for the comments.

Could you please confirm you meant rt_mutex as it can go to sleep.

> The proper solution is to get rid of the locking requirement and that
> needs some thought on the timer wheel code.
> 

Yes, I agree fixing the problem in the timer code is the proper
solution.  BTW, once the code is fixed, I think we should add
WARN_ON(in_irq()); to the function spin_do_trylock() to prevent any
invalid future usage.

Thanks,
Mak.

> Thanks,
> 
> 	tglx
> 
