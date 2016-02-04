From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.1.15-rt17
Date: Thu, 4 Feb 2016 14:22:29 +0100
Message-ID: <20160204132229.GA3381@linutronix.de>
References: <20151222165601.GG27274@linutronix.de>
 <CALqGcGqpZRwv1RbXwyYxsbGOJg8u7HYM_8VTHbjfi4fUkDmHtQ@mail.gmail.com>
 <20160201205157.GA25777@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>, tglx@linutronix.de,
	rostedt@goodmis.org, C.Emde@osadl.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38167 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757703AbcBDNWf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Feb 2016 08:22:35 -0500
Content-Disposition: inline
In-Reply-To: <20160201205157.GA25777@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Sebastian Andrzej Siewior | 2016-02-01 21:51:57 [+0100]:

>I don't why int3 is invoked here at all but it seems to happen and it
>seems to do something with the jump_labels.
Now I know and go with this:

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -53,6 +53,7 @@ config KPROBES
 config JUMP_LABEL
        bool "Optimize very unlikely/likely branches"
        depends on HAVE_ARCH_JUMP_LABEL
+       depends on (!INTERRUPT_OFF_HIST && !PREEMPT_OFF_HIST && !WAKEUP_LATENCY_HIST && !MISSED_TIMER_OFFSETS_HIST)
        help
          This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch

Sebastian
