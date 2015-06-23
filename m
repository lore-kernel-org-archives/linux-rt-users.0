From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH][RT][RFC] irq_work: Have non HARD_IRQ irq work just run
 from ticks
Date: Tue, 23 Jun 2015 20:45:35 +0200
Message-ID: <5589A94F.9010209@linutronix.de>
References: <20150622150959.44055b32@gandalf.local.home>	<5589694D.4040504@siemens.com>	<CAF7YWnxZ5CA=zsBiZRrL5ZjOuXeoV-EkfH1vrLXcw=NCFEv9Mw@mail.gmail.com> <20150623123057.0bf8fc58@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gary Robertson <gary.robertson@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41649 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbbFWSpj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Jun 2015 14:45:39 -0400
In-Reply-To: <20150623123057.0bf8fc58@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/23/2015 06:30 PM, Steven Rostedt wrote:
> I'd be sleeping better at night with a third queue. I'll write up a
> patch and post that as an RFC as well. This will at a minimum keep with
> the paradigm of mainline linux.

We had three queues. We are down to two and I think this is a good
thing. We only deal with FULL_NOHZ in hardirq context (looking at
v4.0-RT). Before that (FULL_NOHZ) everything was handled in softirq and
nobody was concerned (saw a problem).

It would be good if we would address a regression or a bug or something
like that.

> 
> -- Steve

Sebastian
