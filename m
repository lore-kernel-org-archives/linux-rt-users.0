From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: About "error mounting as ext3" when using 2.6.29-rt2 on
 Fedora.
Date: Thu, 9 Apr 2009 21:03:18 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904092102470.21577@localhost.localdomain>
References: <49b7c2350904021920o1fbffeffn22b9fa7ea1365db1@mail.gmail.com>  <49b7c2350904031904w7fd63cc9o2c0f700a879e217@mail.gmail.com>  <alpine.LFD.2.00.0904040637480.12916@localhost.localdomain>  <49b7c2350904041951i2d984221qca33229dff6f0df4@mail.gmail.com>
  <alpine.LFD.2.00.0904051606170.747@localhost.localdomain>  <49b7c2350904080611s35947c65q87baa8183c69ec7c@mail.gmail.com> <49b7c2350904090036h7182d547u952c52b94c2e18c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: GeunSik Lim <leemgs1@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:47307 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbZDITDY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 15:03:24 -0400
In-Reply-To: <49b7c2350904090036h7182d547u952c52b94c2e18c0@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 9 Apr 2009, GeunSik Lim wrote:

> Below is test result about Quad CPU Q8200.
> When I boot with linux-2.6.29-rt2 on Intel Core2 Quad CPU Q8200, I
> still meet below error.
> (http://leemgs1.googlecode.com/files/kernel-error-2.6.29-rt2-core2quad-q8200.PNG)
> --------------------------------------------------
> Process IRQ-25 (pid: 309, ti=f73d6000 task=f73d4530 task.ti=f73d6000)
> Stack:
> F73d6f68 c016fa99 00000001 c016fa7c f7af97c0 00000019 f73d6f74 c0125ab1
> 00000000 f73d6f9c c017f17f 00000019 00000000 00000000 00000000 00000000
> 00000000 c0a25740 00000019 f73d6fd0 c017fc9d c0a257b0 c0a2579c 00000246
> Call Trace:
> [<c016fa99>] ? tick_handle_periodic+0x1d/0x98
> [<c016fa7c>] ? tick_handle_peroidic+0x0/0x98
> [<c0125ab1>] ? hpet_interrupt_handler+0x3d/0x47
> [<c017f17f>] ? handle_IRQ_event+0x136/0x2bb
> [<c017fc9d>] ? do_irqd+0x247/0x3ee
> [<c017fa56>] ? do_irqd+0x0/0x3ee
> [<c017fa56>] ? do_irqd+0x0/0x3ee
> [<c01620a4>] ? kthread+0x56/0x92
> [<c016204e>] ? kthread+0x0/0x92
> [<c010434f>] ? kthread_thread_helper+0x7/0x10
> Code: 01 00 00 00 8b 15 d0 d9 b0 c0 11 15 c8 d9 b0 c0 e8 99 50 fe ff b8 44 42 a2
> c0 ff 05 40 42 a2 c0 e8 b5 25 47 00 64 a1 0c 40 ab c0 <8b> 40 34 83 e0 03 83 f8
> 03 0f 94 c0 0f b6 c0 e8 aa 50 fe ff 5d
> EIP: [<c016fa66>] tick_perioidic+0x6d/0x83 SS:ESP 0068:f73d6f50
> CR2: 0000000000000034

Bug is fixed in -rt6.

Thanks,

	tglx
