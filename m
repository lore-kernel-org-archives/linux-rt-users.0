From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.14.3-rt5: at91: Crash early at boot
Date: Tue, 17 Feb 2015 09:38:59 +0100
Message-ID: <20150217083859.GB26177@linutronix.de>
References: <20140613142506.GL3448@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42698 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919AbbBQIjD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 03:39:03 -0500
Content-Disposition: inline
In-Reply-To: <20140613142506.GL3448@lukather>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Maxime Ripard | 2014-06-13 16:25:06 [+0200]:

>Preemptible hierarchical RCU implementation.
>NR_IRQS:16 nr_irqs:16 16
>Unable to handle kernel NULL pointer dereference at virtual address 00=
000000
>pgd =3D c0004000
>[00000000] *pgd=3D00000000
>Internal error: Oops: 5 [#1] PREEMPT ARM
>Modules linked in:
>CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.3-rt4+ #11
>task: c05ecb28 ti: c05e2000 task.ti: c05e2000
>PC is at wake_up_process+0x8/0x40
>LR is at kthread_create_on_node+0xb0/0x178
=E2=80=A6
>Do you know what could be the cause of this, or is this any known issu=
e?

No. This is very early in the boot process. I upgrade the at91's timer
patches but have no HW to actually check if this is still working.

>
>Thanks,
>Maxime
>

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
