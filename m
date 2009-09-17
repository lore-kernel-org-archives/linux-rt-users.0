From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: xjadeo
Date: Thu, 17 Sep 2009 23:34:46 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909172328260.2889@localhost.localdomain>
References: <20090917151902.f6676667.info@georgmill.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Georg Mill <info@georgmill.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:34642 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbZIQVer (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Sep 2009 17:34:47 -0400
In-Reply-To: <20090917151902.f6676667.info@georgmill.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 17 Sep 2009, Georg Mill wrote:

> Hi,
> 
> I found the following bug on a machine with 4 cpu's. I tried to synchronize sound and video with xjadeo and ardour and jackd and got the following error.
> This error appears also within the other cpu's. I used the last svn-sources (svn co https://xjadeo.svn.sourceforge.net/svnroot/xjadeo xjadeo). With kernel 2.6.29.6-rt23 that problem didn't appear.
> 
> ---snip---
> 
> kernel: [  199.899987] BUG: scheduling while atomic: xjadeo/0x1000020b/5117, CPU#3

Hmm, that's pretty weird. The preempt count is 0x1000020b, which means
11 nested preempt disables and 2 bh disables.

I cannot decode from the stack traces where this should happen. Can
you reproduce that w/o the binary nvidia driver ?

Thanks,

	tglx
