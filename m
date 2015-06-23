From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT][RFC] irq_work: Have non HARD_IRQ irq work just run
 from ticks
Date: Tue, 23 Jun 2015 15:09:14 -0400
Message-ID: <20150623150914.5ed3ee5d@gandalf.local.home>
References: <20150622150959.44055b32@gandalf.local.home>
	<5589694D.4040504@siemens.com>
	<CAF7YWnxZ5CA=zsBiZRrL5ZjOuXeoV-EkfH1vrLXcw=NCFEv9Mw@mail.gmail.com>
	<20150623123057.0bf8fc58@gandalf.local.home>
	<5589A94F.9010209@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Gary Robertson <gary.robertson@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:34226 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932416AbbFWTJR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Jun 2015 15:09:17 -0400
In-Reply-To: <5589A94F.9010209@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 23 Jun 2015 20:45:35 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 06/23/2015 06:30 PM, Steven Rostedt wrote:
> > I'd be sleeping better at night with a third queue. I'll write up a
> > patch and post that as an RFC as well. This will at a minimum keep with
> > the paradigm of mainline linux.
> 
> We had three queues. We are down to two and I think this is a good
> thing. We only deal with FULL_NOHZ in hardirq context (looking at
> v4.0-RT). Before that (FULL_NOHZ) everything was handled in softirq and
> nobody was concerned (saw a problem).
> 
> It would be good if we would address a regression or a bug or something
> like that.

The irq_work users may need to be audited. But I understand that it may
not be a regression. I'm still worried that something will come along
that will be affected by this with strange side effects.


-- Steve
