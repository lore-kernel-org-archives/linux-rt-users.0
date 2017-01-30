From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHv2] x86/mm/cpa: avoid wbinvd() for PREEMPT
Date: Mon, 30 Jan 2017 13:31:28 +0100
Message-ID: <20170130123128.GJ6515@twins.programming.kicks-ass.net>
References: <87o9ypvt1q.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, fenghua.yu@intel.com, h.peter.anvin@intel.com,
        vikas.shivappa@linux.intel.com, tony.luck@intel.com,
        davidcc@google.com, dave.hansen@intel.com, eranian@google.com
To: John Ogness <john.ogness@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87o9ypvt1q.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jan 30, 2017 at 09:41:21AM +0100, John Ogness wrote:
> Although wbinvd() is faster than flushing many individual pages, it
> blocks the memory bus for "long" periods of time (>100us), thus
> directly causing unusually large latencies on all CPUs, regardless
> of any CPU isolation features that may be active.
> 
> For 1024 pages, flushing those pages individually can take up to
> 2200us, but the task remains fully preemptible during that time.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I think we need an additional patch to deal with CAT, but we can easily
do that later.

I've thought about that situation a bit and wbinvd cannot and must not
respect the CAT mask because while all the new lines brought in by the
current context are constrained, lines shared with another context, or
if the current context changed might well be outside the current mask.

In any case, this is a unprivileged interface, and therefore I feel we
need to remove the wbinvd usage entirely, esp. if CAT is enabled.

But like said, we can do that in a follow up patch.
