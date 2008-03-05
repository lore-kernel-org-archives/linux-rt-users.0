From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: try_module_get and friends
Date: Wed, 05 Mar 2008 15:46:59 -0500
Message-ID: <y0mr6eo99vg.fsf@ton.toronto.redhat.com>
References: <1204608058.11912.3.camel@perihelion>
	<1204608506.11912.9.camel@perihelion>
	<1204661228.8244.15.camel@jcmlaptop>
	<1204745455.17630.8.camel@localhost.localdomain>
	<Pine.LNX.4.58.0803051442330.15217@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Walker <dwalker@mvista.com>,
	Jon Masters <jonathan@jonmasters.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758459AbYCEUwr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Mar 2008 15:52:47 -0500
In-Reply-To: <Pine.LNX.4.58.0803051442330.15217@gandalf.stny.rr.com> (Steven Rostedt's message of "Wed, 5 Mar 2008 14:47:28 -0500 (EST)")
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Steven Rostedt <rostedt@goodmis.org> writes:

> [...]
> There's a theoretical potential for the system to crash in -rt when
> unloading a module. Simply because interrupts are threads.
>
> Some device has an interrupt handler that is called and preempted.
> At that moment the module for that device is unloaded. [...]
> Since the code for the interrupt handler no longer exists... KABOOM!

Perhaps you can identify those modules that have asked for interrupts,
and block only them from unloading.  Or, would it be outrageously
expensive to increment the module refcount while one of its interrupt
handlers is running?

- FChE
