From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: spin locks and migrate_disable()
Date: Fri, 13 Apr 2012 09:52:59 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204130950190.2542@ionos>
References: <4F762C59.4050008@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39966 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871Ab2DMHxB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Apr 2012 03:53:01 -0400
In-Reply-To: <4F762C59.4050008@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 30 Mar 2012, Frank Rowand wrote:

> Hi Thomas,
> 
> Two questions about spin_lock() in include/linux/spinlock_rt.h.
> 
> (1) spin_lock() and related functions invoke migrate_disable() and
> migrate_enable().  These functions are created by your patch,
> sched-migrate-disable.patch, and are EXPORT_SYMBOL_GPL().  Would
> you be willing to change these to EXPORT_SYMBOL()?

Sigh. Yes.
 
> (2) What is the purpose of the migrate_disable() in the spin lock?
> Is it a correctness issue, or a performance issue, or something else?

Correctness. spinlocks disable preemption in mainline and therefor
migration. So you can access per cpu data in a spinlocked section. Now
with RT the section becomes preemptible. The lock prevents reentrancy,
but we could be migrated away so the task might access parts of the
per cpu data on one and then on the other cpu. Not really a good
idea. Therefor we disable migration.

Thanks,

	tglx
