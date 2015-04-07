From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 7 Apr 2015 14:54:16 +0200
Message-ID: <20150407125416.GO21418@twins.programming.kicks-ass.net>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
 <1428369962-74723-1-git-send-email-tmac@hp.com>
 <1428369962-74723-2-git-send-email-tmac@hp.com>
 <alpine.DEB.2.11.1504071255410.3845@nanos>
 <1428407236.3152.81.camel@gmail.com>
 <20150407120403.GN21418@twins.programming.kicks-ass.net>
 <20150407084154.74c01a6c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150407084154.74c01a6c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Apr 07, 2015 at 08:41:54AM -0400, Steven Rostedt wrote:
> Ideally, we don't want to take mutexes in hard interrupt context.

Nothing ideal about it. Hard requirement, anything else is plain
insanity.
