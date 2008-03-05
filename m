From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: try_module_get and friends
Date: Wed, 5 Mar 2008 14:47:28 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0803051442330.15217@gandalf.stny.rr.com>
References: <1204608058.11912.3.camel@perihelion>  <1204608506.11912.9.camel@perihelion>
  <1204661228.8244.15.camel@jcmlaptop> <1204745455.17630.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Masters <jonathan@jonmasters.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:41126 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077AbYCETrg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Mar 2008 14:47:36 -0500
In-Reply-To: <1204745455.17630.8.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 5 Mar 2008, Daniel Walker wrote:
>
> Could you give a different of better example of the problem with
> modules? This thread has been fairly scant on details ..

There's a theoretical potential for the system to crash in -rt when
unloading a module. Simply because interrupts are threads.

Some device has an interrupt handler that is called and preempted.
At that moment the module for that device is unloaded. This calls things
like kstop_machine that should make sure that all interrupt handlers have
been resolved. But this does not work with -rt, since the interrupt
handlers can now be preempted and resume after the kstop_machine and the
moduling being unloaded.

Since the code for the interrupt handler no longer exists... KABOOM!

Enough details?

-- Steve

