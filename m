From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [3.4-rt] backport of completion-use-simple-wait-queues.patch
Date: Fri, 29 Nov 2013 13:49:31 +0100
Message-ID: <20131129124931.GA31099@linutronix.de>
References: <20131128201029.GA28966@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33635 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab3K2Mtg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 07:49:36 -0500
Content-Disposition: inline
In-Reply-To: <20131128201029.GA28966@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Paul Gortmaker | 2013-11-28 15:10:29 [-0500]:

>Hi Steve,
Hi Paul,

>Someone tripped over this with usb console:
>
>    in_atomic(): 0, irqs_disabled(): 1, pid: 36, name: kworker/1:1
>    Pid: 36, comm: kworker/1:1 Tainted: G           O 3.4.34-rt40_preempt-rt #1
>    Call Trace:
>     [<c105461e>] __might_sleep+0xce/0xf0
>     [<c14fe24c>] rt_spin_lock+0x1c/0x40
>     [<c1056f65>] complete+0x25/0x60
>     [<c14fde10>] ? rt_mutex_lock+0x20/0x50
>     [<c135e1b0>] usb_stor_blocking_completion+0x10/0x20
>     [<c13317b7>] usb_poll_irq_flush_helper+0x67/0xf0
>     [<c1056ad4>] ? migrate_enable+0x74/0x170
>     [<c10427f7>] process_one_work+0x107/0x410

 git grep usb_poll_irq_flush_helper
shows no results in 3.4.61-rt77 and 3.6.11.9-rt42. 
The function seems to disable interrups and it completes a usb-storage
request. This would works on mainline but in -RT those things run in thread
context (usb-hcd-use-local-irq-nort.patch).

Depending on what urbs you complete via usb_poll_irq_flush_helper() you
could deadlock if the urb-complete handler grabs a lock.

>Thanks,
>Paul.

Sebastian
