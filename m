From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: PREEMPT_RT with Full Tickless
Date: Sun, 13 Dec 2015 05:19:50 +0100
Message-ID: <1449980390.3271.9.camel@gmail.com>
References: <CANv7uPSimVG=GfQ5W_HDq0UYUokK-Y2WvSPTXc3MFd7eLXqYVQ@mail.gmail.com>
	 <1449844577.4882.5.camel@gmail.com> <20151211175023.GN6720@linutronix.de>
	 <CAF7YWnzyxECC=iKhVHoJXQrb_QH8pqvcm0LC9Fq43NviuSM=hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: GeHao Kang <kanghao0928@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, jason.low2@hp.com,
	RT <linux-rt-users@vger.kernel.org>
To: Gary Robertson <gary.robertson@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:32935 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbbLMETy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Dec 2015 23:19:54 -0500
Received: by mail-wm0-f42.google.com with SMTP id n186so4312868wmn.0
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Dec 2015 20:19:53 -0800 (PST)
In-Reply-To: <CAF7YWnzyxECC=iKhVHoJXQrb_QH8pqvcm0LC9Fq43NviuSM=hg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2015-12-12 at 14:11 -0600, Gary Robertson wrote:
> On Fri, Dec 11, 2015 at 11:50 AM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > * Mike Galbraith | 2015-12-11 15:36:17 [+0100]:
> > 
> > > On Fri, 2015-12-11 at 19:29 +0800, GeHao Kang wrote:
> > > > When I enable CONFIG_PREEMPT_RT_FULL and CONFIG_NO_HZ_FULL
> > > > in Linux Kernel v4.1.12-rt12, I find the tick on the nohz_full
> > > > cpu
> > > > never stops.
> > > 
> 
> 
> Also - since in RT the tick timer interrupt results in a schedulable
> thread running to handle the software interrupt work stimulated by
> the
> tick - upon exit from the interrupt handler there are always at least
> 2 runnable threads in the CPU running the tick if there was a
> runnable
> task interrupted by the tick event.

Yup, handling that was one of the hacks that was dropped.  If you look
at what all was dropped in one 'let's con NOHZ_FULL into working'
patch, you'd think twice about submitting it for review.

	-Mike

