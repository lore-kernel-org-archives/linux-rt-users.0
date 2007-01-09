From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] paravirt: disable Kbuild option for now
Date: Tue, 09 Jan 2007 23:05:26 +1100
Message-ID: <1168344326.19646.124.camel@localhost.localdomain>
References: <20070108163027.GD5098@localhost.localdomain>
	 <20070109084520.GA444@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	linux-rt-users@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:33536 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbXAIMFg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jan 2007 07:05:36 -0500
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20070109084520.GA444@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-01-09 at 09:45 +0100, Ingo Molnar wrote:
> * Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > In include/linux/irqflags.h safe_halt changed from a macro to a static 
> > inline function which results in tons of warnings for architectures 
> > other than x86[-64]:
> > 
> > include/linux/irqflags.h:99: warning: implicit declaration of function 
> > 'raw_safe_halt'
> 
> ok, this is still not fixed in rt2 - which is using Rusty's 
> paravirt-unexport patch.
> 
> Andrew, we need to fix this before v2.6.20 is released. Simplest 
> upstream fix is to just disable the CONFIG_PARAVIRT Kbuild option, as 
> per the patch below. Rusty's unexport patch is promising in many ways, 
> but it's v2.6.21 stuff IMO.

No.  Just drop the whole "don't export paravirt_ops" idea, and we'll
work on that for 2.6.21.

I don't see a problem with exporting paravirt_ops, I was just trying to
keep you happy.  I'm happy to remove the export in 2.6.21, but as we've
seen it's non-trivial to ensure all configs still work.

Rusty.
