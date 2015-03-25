From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Wed, 25 Mar 2015 03:33:53 +0100
Message-ID: <1427250833.3459.4.camel@gmail.com>
References: <20150317163541.080310081@goodmis.org>
	 <20150317163617.218582800@goodmis.org>
	 <20150317163551.3093b6c2@gandalf.local.home>
	 <1426753029.4168.80.camel@gmail.com>
	 <20150319122611.0d002d48@gandalf.local.home>
	 <20150324181034.GD1321@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35076 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbbCYCd4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Mar 2015 22:33:56 -0400
In-Reply-To: <20150324181034.GD1321@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2015-03-24 at 19:10 +0100, Sebastian Andrzej Siewior wrote:
> * Steven Rostedt | 2015-03-19 12:26:11 [-0400]:
> 
> >On Thu, 19 Mar 2015 09:17:09 +0100
> >Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
> >
> >
> >> (aw crap, let's go shopping)... so why is the one in timer.c ok?
> >
> >It's not. Sebastian, you said there were no other cases of rt_mutexes
> >being taken in hard irq context. Looks like timer.c has one.
> 
> If you refer to switch_timer_base() then this one is not taken in
> hard-irq context. The callchain is:
> 
> lock_timer_base() (with spin_lock_irqsave(&base->lock, *flags) which
>                    makes it a sleeping lock or lockdep would scream)
>   -> switch_timer_base()
>      -> spin_trylock() (not in hardirq conteyt)

Nah, I was referring to get_next_timer_interrupt() because I saw that
rt_spin_unlock_after_trylock_in_irq(&base->lock) sitting there.

	-Mike

