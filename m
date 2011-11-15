From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] Compile error with allmodconfig and
 CONFIG_PREEMPT_RT_FULL=y
Date: Tue, 15 Nov 2011 07:23:22 -0500
Message-ID: <1321359802.4181.1.camel@frodo>
References: <1321235083-21756-1-git-send-email-jkacur@redhat.com>
	 <1321235083-21756-2-git-send-email-jkacur@redhat.com>
	 <20111114165148.GB2372@linux.vnet.ibm.com>
	 <alpine.LFD.2.00.1111141837100.6707@localhost6.localdomain6>
	 <1321303871.5011.6.camel@frodo> <1321334539.6347.43.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:36688 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab1KOMX1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Nov 2011 07:23:27 -0500
In-Reply-To: <1321334539.6347.43.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2011-11-15 at 06:22 +0100, Mike Galbraith wrote:

> > If we go that route, we might as well make everything
> > EXPORT_SYMBOL_GPL(), and be damn to those that use nVidia.
> 
> EXPORT_SYMBOL_GPL(migrate_disable) alone screws nVidia users, no?
> 
> I have an RT user who has no other viable choice than nVidia.  If the
> above is true, that user will end up stuck at 2.6.33-rt until we get a
> driver that actually works... or they deem linux to be a non-solution.

Right, migrate_disable() should not have been an EXPORT_SYMBOL_GPL(), as
it is a helper functions that is also exported as EXPORT_SYMBOL(). It
shouldn't be called directly anyway, even by code in the kernel proper.

-- Steve


