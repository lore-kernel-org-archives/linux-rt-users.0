From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ARMv7 futex latency spike
Date: Fri, 4 Sep 2015 14:34:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509041430340.15006@nanos>
References: <55E950B1.4070603@ni.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Ioan-Adrian Ratiu <adrian.ratiu@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48010 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758680AbbIDMfE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Sep 2015 08:35:04 -0400
In-Reply-To: <55E950B1.4070603@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 4 Sep 2015, Ioan-Adrian Ratiu wrote:

> Hello
> 
> I wrote a C program to check jitter levels in userspace (source attached), ran
> it on various kernels (3.14.19-rt9, 3.18.9-rt5 and 4.1.5-rt5) and on multiple
> machines.

<snip>

> At .412321, "Low-prio******"'s priority is raised by "High-prio******" again,
> as if "High-prio******" is waiting for something, but then why was it woken up
> before?
> * did "Low-prio******" acquire the lock again? How could it manage this feat
> since it is already in the unlock system call?

That looks like highprio is trying to acquire a kernel internal lock
held by lowprio. The only lock which can cause this is the futex
hashbucket lock.

Now, I can see why that happens in 3.14.19-rt9, 3.18.9-rt5, but
4.1.5-rt5 has a fix for that. Are you sure that you that this happens
on 4.1.5-rt5 as well?

Thanks,

	tglx
