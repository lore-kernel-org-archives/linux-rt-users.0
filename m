From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: problems with chained IRQ handlers
Date: Fri, 11 Dec 2015 17:23:46 +0100
Message-ID: <20151211162346.GC6720@linutronix.de>
References: <CAGt3f4k=-TW2qVhqMFk7U22NGZToZ5bxi1qVuUqcVRKqjhBbMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Brian Silverman <brian@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47049 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbbLKQXr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 11:23:47 -0500
Content-Disposition: inline
In-Reply-To: <CAGt3f4k=-TW2qVhqMFk7U22NGZToZ5bxi1qVuUqcVRKqjhBbMw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Brian Silverman | 2015-08-17 18:41:55 [-0700]:

>Chained IRQ handlers are always marked IRQ_NOTHREAD, which means
>forced threading doesn't apply to them. I think this means they can't
>safely use non-raw spinlocks under CONFIG_PREEMPT_RT_FULL. Is this
>correct?
yes,

>I have an ARM system with a CONFIG_PREEMPT_RT_FULL kernel which prints
>lockdep warnings from many places because of this. It also locks up
>under moderate load, which I think is related to this issue. Any
>suggestions?

Use raw locks there. The chain handler usually implement a irq chip
something like gpio controller which can also act as an interrupt
controller. If this is the case then the lock should be a raw-lock.
You should not do anything time consuming while holding the lock. It is
usually just held while masking/unmasking bits in the registers.

>Thanks,
>Brian Silverman

Sebastia
