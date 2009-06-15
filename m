From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NOHZ: local_softirq_pending
Date: Mon, 15 Jun 2009 15:19:34 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906151501200.2800@localhost.localdomain>
References: <4A35171C.9090800@albentia.com> <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Iratxo Pichel Ortiz <ipichel@albentia.com>,
	linux-rt-users@vger.kernel.org
To: Iratxo Pichel Ortiz <iratxo.pichel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:57510 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbZFONTj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Jun 2009 09:19:39 -0400
In-Reply-To: <8e6b7a710906141250m2a991ca9r5949e502b9976e39@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Iratxo,

please do not top post.

On Sun, 14 Jun 2009, Iratxo Pichel Ortiz wrote:

> > I am using 2.6.30-rt16 RT Kernel on a IXP425 system. The system is running

  2.6.29-rt16, right ?

> > an experimental comm stack that has been working quite well with 2.6.26-rt2
> > for a very long time (> 100days).
> >
> > When the system boots, every 180s aprox, I see this traces in the dmesg:
> > 42949422.930000] NOHZ: local_softirq_pending 02

Hmm, so something is marking the timer softirq pending, but does not
wake the timer softirq.

> > [42949422.940000] NOHZ: local_softirq_pending 02
> > [42949422.950000] NOHZ: local_softirq_pending 02
> > [42949422.960000] ISR HIHG LATENCY 30073
> > [42949596.920000] NOHZ: local_softirq_pending 02
> > [42949596.930000] NOHZ: local_softirq_pending 02
> > [42949596.940000] NOHZ: local_softirq_pending 02
> > [42949596.950000] NOHZ: local_softirq_pending 02

So this repeats itself roughly every 3min and stays that way for a
couple of jiffies. Does your code fiddle with timers ?

> > [42949596.960000] ISR HIHG LATENCY 40066

The latency is exaclty the number of NOHZ messages * 10ms. I assume
you have HZ=100. Looks like your code is waiting for a timer, which
does not fire due to the local_softirq_pending 02 problem.

Does it work when you disable CONFIG_NOHZ ?

Thanks,

	tglx
