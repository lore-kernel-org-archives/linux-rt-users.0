From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Priority inheritance?
Date: Tue, 30 Oct 2012 00:38:27 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1210300035500.2756@ionos>
References: <508E7DF2.1040301@meduna.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46763 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757744Ab2J2Xi3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Oct 2012 19:38:29 -0400
In-Reply-To: <508E7DF2.1040301@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 29 Oct 2012, Stanislav Meduna wrote:
> Can I leave the low-prio threads at SCHED_OTHER and rely on
> the PTHREAD_PRIO_INHERIT to boost their priority in case they
> were preempted with the lock held and the RT-thread needs
> to lock it too

That's how priority inheritance is defined. In case of contention the
lock owner inherits the scheduling class and the priority of the
(higher class/priority) contender.

Thanks,

	tglx
