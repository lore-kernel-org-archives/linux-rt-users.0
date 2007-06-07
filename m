From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: at kernel/sched.c:4031 __schedule()
Date: Thu, 07 Jun 2007 12:13:03 -0400
Message-ID: <1181232783.10408.8.camel@localhost.localdomain>
References: <4668112B.4090406@gmail.com>
	 <1181230780.10408.0.camel@localhost.localdomain>
	 <1181231910.3841.55.camel@bender>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Oleg Kechin <okechin@gmail.com>, linux-rt-users@vger.kernel.org,
	tglx@linutronix.de
To: Jan Altenberg <jan.altenberg@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:35213 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbXFGQNh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Jun 2007 12:13:37 -0400
In-Reply-To: <1181231910.3841.55.camel@bender>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-06-07 at 17:58 +0200, Jan Altenberg wrote:
> Hi,
> 
> > > in prepare_task_switch(rq, next); interrupts are enabled,
> > 
> > That's a bug.  __schedule should not have interrupts enabled.
> > What's the back trace of this?
> 
> I've also seen this in the past. Interrupts are enabled in
> prepare_lock_switch because ARM defines __ARCH_WANT_INTERRUPTS_ON_CTXSW.
> 

Heh, silly me.  I've been focused so much on x86 that I forgot what
other archs do.

> IIRC Thomas fixed this for the current -rt release.

Thomas, perhaps you want to post the fix.

What arch is innovator1510 (OMAP5910 cpu) anyway?

/me has been away from embedded systems for some time.

-- Steve
