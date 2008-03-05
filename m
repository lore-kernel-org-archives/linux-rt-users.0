From: Daniel Walker <dwalker@mvista.com>
Subject: Re: try_module_get and friends
Date: Wed, 05 Mar 2008 12:28:14 -0800
Message-ID: <1204748894.17630.15.camel@localhost.localdomain>
References: <1204608058.11912.3.camel@perihelion>
	 <1204608506.11912.9.camel@perihelion> <1204661228.8244.15.camel@jcmlaptop>
	 <1204745455.17630.8.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0803051442330.15217@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jon Masters <jonathan@jonmasters.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:38578 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbYCEU2P (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Mar 2008 15:28:15 -0500
In-Reply-To: <Pine.LNX.4.58.0803051442330.15217@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2008-03-05 at 14:47 -0500, Steven Rostedt wrote:
> Some device has an interrupt handler that is called and preempted.
> At that moment the module for that device is unloaded. This calls things
> like kstop_machine that should make sure that all interrupt handlers have
> been resolved. But this does not work with -rt, since the interrupt
> handlers can now be preempted and resume after the kstop_machine and the
> moduling being unloaded.
> 
> Since the code for the interrupt handler no longer exists... KABOOM!
> 
> Enough details?

yeah, you have to assume the device is not in use, but still handling
interrupts?

Daniel

