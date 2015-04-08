From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Wed, 8 Apr 2015 10:50:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1504081044130.3845@nanos>
References: <1424395866-81589-1-git-send-email-tmac@hp.com> <1428369962-74723-1-git-send-email-tmac@hp.com> <1428369962-74723-2-git-send-email-tmac@hp.com> <20150406215959.4e8ad37b@grimm.local.home> <55247C96.1080707@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	linux-rt-users@vger.kernel.org, umgwanakikbuti@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55247C96.1080707@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 7 Apr 2015, Thavatchai Makphaibulchoke wrote:
> On 04/06/2015 07:59 PM, Steven Rostedt wrote:
> In this case we are not actually boosting the idle_task priority, which
> should be OK.  But the warning could be very overwhelming on some
> platforms. TO keep the warning, I decided not to boots priority.  Please
> let me know if you have any suggestion.

Don't even try to get this working. Taking the lock in idle/interrupt
context is just plain wrong.

The proper solution is to get rid of the locking requirement and that
needs some thought on the timer wheel code.

Thanks,

	tglx
