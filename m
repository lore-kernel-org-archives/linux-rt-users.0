From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] rtmutex: fix deadlock in spin_trylock
Date: Sat, 16 Nov 2013 14:12:48 +0100
Message-ID: <20131116131248.GC11518@linutronix.de>
References: <641D1EBAB8EAD046954CD69996C8FE00164297@USCHMBX003.nsn-intra.net>
 <alpine.DEB.2.02.1311061832020.23353@ionos.tec.linutronix.de>
 <527AA4FA.2000208@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ext Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Matt Cowell <matt.cowell@nsn.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44062 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3KPNMt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Nov 2013 08:12:49 -0500
Content-Disposition: inline
In-Reply-To: <527AA4FA.2000208@nsn.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Matt Cowell | 2013-11-06 14:22:18 [-0600]:

>I see two ways to fix this:
>1) The way I did in the patch to ensure that spin_trylock never can
>spin on any locks internally.
>2) Converting the timer base lock to a raw_spinlock_t so that it
>actually disables hardirqs in lock_timer_base().  I don't think this
>would be a good idea though.

A third one has been applied where the waiter lock is taken with irqs
off. The thread "CONFIG_NO_HZ_FULL + CONFIG_PREEMPT_RT_FULL = nogo" has
a patch for that.

>
>Thanks,
>-Matt

Sebastian
