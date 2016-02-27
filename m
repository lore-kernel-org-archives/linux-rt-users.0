From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] rt,workqueue: Fix blocking call when !TASK_RUNNING splat
 in rescuer_thread()
Date: Sat, 27 Feb 2016 10:14:49 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602271013340.3638@nanos>
References: <1456556755.3759.4.camel@gmail.com> <alpine.DEB.2.11.1602271003220.3638@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35457 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0JQJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 04:16:09 -0500
In-Reply-To: <alpine.DEB.2.11.1602271003220.3638@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 27 Feb 2016, Thomas Gleixner wrote:
> > [    0.221298]  [<ffffffff810794ef>] __might_sleep+0x7f/0x90

How do you end up here?

rt_spin_lock()
    might_sleep_no_state_check()
      ___might_sleep()

Can you spot the subtle difference?

Thanks,

	tglx
