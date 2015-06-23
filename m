From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT][RFC] irq_work: Have non HARD_IRQ irq work just run
 from ticks
Date: Tue, 23 Jun 2015 12:30:57 -0400
Message-ID: <20150623123057.0bf8fc58@gandalf.local.home>
References: <20150622150959.44055b32@gandalf.local.home>
	<5589694D.4040504@siemens.com>
	<CAF7YWnxZ5CA=zsBiZRrL5ZjOuXeoV-EkfH1vrLXcw=NCFEv9Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Gary Robertson <gary.robertson@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:40252 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932629AbbFWQbB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Jun 2015 12:31:01 -0400
In-Reply-To: <CAF7YWnxZ5CA=zsBiZRrL5ZjOuXeoV-EkfH1vrLXcw=NCFEv9Mw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 23 Jun 2015 11:20:38 -0500
Gary Robertson <gary.robertson@linaro.org> wrote:

> I am concerned about interactions with the evolving 'full tickless' operations.

I'm concerned about more than just full tickless. But like you, I don't
currently have any concrete examples to show there's a possible issue.

> 
> While I have no concrete use cases to show, I can conceive that
> an I/O data processing application running on an isolated core
> operating in 'full tickless' mode might benefit from allowing interrupts
> on that same core so long as they service hardware involved with
> the data flow being processed by the application.
> Let's further assume that for hardware-related reasons we still want
> to run the irq work from a softirq context rather than a hardirq context.
> 
> In such circumstances we obviously don't want the irq work done from a
> timer tick -
> so adding another irq work queue independent of the lazy flag and
> unconditionally raising a softirq on the first addition to that queue
> would seem to be the most flexible and compatible answer.
> Irq work queued with the lazy bit set could be deferred until the next
> tick interrupt
> for efficiency and compatibility, and 'normal' irq work
> would no longer be potentially stalled
> by being enqueued with 'lazy' work.

I'd be sleeping better at night with a third queue. I'll write up a
patch and post that as an RFC as well. This will at a minimum keep with
the paradigm of mainline linux.

-- Steve
