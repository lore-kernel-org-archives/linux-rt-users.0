From: Daniel Walker <dwalker@mvista.com>
Subject: Re: try_module_get and friends
Date: Wed, 05 Mar 2008 13:15:02 -0800
Message-ID: <1204751702.17630.27.camel@localhost.localdomain>
References: <1204608058.11912.3.camel@perihelion>
	 <1204608506.11912.9.camel@perihelion> <1204661228.8244.15.camel@jcmlaptop>
	 <1204745455.17630.8.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0803051442330.15217@gandalf.stny.rr.com>
	 <y0mr6eo99vg.fsf@ton.toronto.redhat.com>
	 <Pine.LNX.4.58.0803051551370.15882@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Frank Ch. Eigler" <fche@redhat.com>,
	Jon Masters <jonathan@jonmasters.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:57182 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148AbYCEVPF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Mar 2008 16:15:05 -0500
In-Reply-To: <Pine.LNX.4.58.0803051551370.15882@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2008-03-05 at 15:54 -0500, Steven Rostedt wrote:

> Actually, we were simply thinking of calling an rcu_lock before checking
> the handlers, and releasing the lock when all are done. Then before doing
> the module unload, we do a rcu_sync. Note, no interrupt handler should
> ever do a rcu_sync.

There's already some smp synchronize inside free_irq, are you sure
that's not already handling this for smp? For -rt we could just enable
it for UP ..

Daniel

