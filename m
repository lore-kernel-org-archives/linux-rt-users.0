From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Oops with spin_lock() in an IRQF_NO_THREAD interrupt
Date: Fri, 4 Oct 2013 14:42:58 +0200
Message-ID: <20131004124258.GE19953@linutronix.de>
References: <em8d903d65-1a3e-4973-9012-be50c5713bd5@nb-mak>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53638 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab3JDMm7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 08:42:59 -0400
Content-Disposition: inline
In-Reply-To: <em8d903d65-1a3e-4973-9012-be50c5713bd5@nb-mak>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Matthias Klein | 2013-10-02 14:54:00 [+0000]:

>Hello,
Hi,

>i am writing a kernel module on a rt kernel where I have an
>IRQF_NO_THREAD interrupt.
I hope you know what you are doing with this.

>For sharing a "write index" between that interrupt and the process
>context (ioctl() etc.) I use a spin_lock for locking.
>
>In the IRQ I use spin_lock() & spin_unlock(), and in the process
>context I use spin_lock_irq() & spin_unlock_irq().
>
>Basically the driver and the test application are working, but after
>some time I get an oops message.
>
>Do I use the right functions for locking ? Do you have a tip why I
>get that oops message ?

You should use a the raw_spinlock here if you _really_ need
IRQF_NO_THREAD.

>Best regards,
>
>Matthias

Sebastian
