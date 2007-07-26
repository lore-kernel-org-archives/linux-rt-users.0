From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/3] proc-interrupts-missing-vectors
Date: Thu, 26 Jul 2007 09:51:44 +0200
Message-ID: <20070726075144.GB18994@elte.hu>
References: <20070725205816.GA9032@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, sdietrich@novell.com,
	linux-rt-users@vger.kernel.org
To: Joe Korty <joe.korty@ccur.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:46064 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757495AbXGZHwS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 03:52:18 -0400
Content-Disposition: inline
In-Reply-To: <20070725205816.GA9032@tsunami.ccur.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Joe Korty <joe.korty@ccur.com> wrote:

> Add missing IRQs to /proc/interrupts.
> 
> /proc/interrupts is not truly useful unless it displays every IRQ 
> vector, not just those somebody thought would be interesting.  For 
> example, since the default /proc/interrupts setup did not display the 
> rescheduling interrupt, the occurance of rescheduling interrupt floods 
> ends up affecting latencies, yet without an entry in /proc/interrupts, 
> it is difficult to discern why latencies are being affected.
> 
> Also does a silly little expansion of the 'ERR:' display to be per 
> cpu.  This makes its layout identical to all the other display lines 
> in /proc/interrupts.

we cannot really change the format of /proc/interrupts, tools might rely 
on it - i undid previous -rt changes to the format. An acceptable 
approach would be to introduce a new /proc/irq_debug file and put all 
this (and other) information into it.

	Ingo
