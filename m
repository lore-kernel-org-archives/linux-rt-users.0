From: Jan Altenberg <jan.altenberg@linutronix.de>
Subject: Re: BUG: at kernel/sched.c:4031 __schedule()
Date: Thu, 07 Jun 2007 17:58:30 +0200
Message-ID: <1181231910.3841.55.camel@bender>
References: <4668112B.4090406@gmail.com>
	 <1181230780.10408.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Oleg Kechin <okechin@gmail.com>, linux-rt-users@vger.kernel.org,
	tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:55167 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752414AbXFGP6i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 11:58:38 -0400
In-Reply-To: <1181230780.10408.0.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

> > in prepare_task_switch(rq, next); interrupts are enabled,
> 
> That's a bug.  __schedule should not have interrupts enabled.
> What's the back trace of this?

I've also seen this in the past. Interrupts are enabled in
prepare_lock_switch because ARM defines __ARCH_WANT_INTERRUPTS_ON_CTXSW.

IIRC Thomas fixed this for the current -rt release.

Cheers,
	Jan
