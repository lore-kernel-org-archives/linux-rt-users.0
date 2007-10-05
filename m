From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] [RFC] RT: Optionally allow IRQF_NODELAY on serial
 console
Date: Fri, 5 Oct 2007 18:41:59 +0200 (CEST)
Message-ID: <alpine.LRH.0.999.0710051831000.10191@www.tglx.de>
References: <20071005153517.24349.62653.stgit@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: mingo@elte.hu, rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:38096 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756615AbXJEQmb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Oct 2007 12:42:31 -0400
In-Reply-To: <20071005153517.24349.62653.stgit@ghaskins-t60p.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 5 Oct 2007, Gregory Haskins wrote:
> This series may help debugging certain circumstances where the serial
> console is unreponsive (e.g. RT51+ spinner, or scheduler problem).  It changes
> the serial8250 driver to use IRQF_NODELAY so that interrupts execute in irq
> context instead of a kthread.
> 
> It works pretty well on this end, though it is admitted not fully baked.  For
> instance, a few paths in sysrq can still call into non-raw spinlocks
> (sched_debug_show, for instance) which will cause subsequent errors.  Also,
> if you use KDB, be sure to convert the kdb_printf_lock to raw as well.  I may
> send a KDB related patch seperately.
> 
> I am sending this out now in case it is helpful to someone.

The simple non-patch solution is to up the priority of the serial 
console irq to maximum. That's usually sufficient to catch runnaway tasks 
etc. It does not interfere with the system in normal operation as long as 
you do not hit keys in your minicom.

I doubt that your patch has a chance to survive lockdep and anything which 
is not a sysrq.

	tglx
