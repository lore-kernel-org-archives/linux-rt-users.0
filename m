From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: 2.6.28-rt on PowerPC
Date: Fri, 30 Jan 2009 06:07:58 +0300
Message-ID: <20090130030758.GA7004@oksana.dev.rtsoft.ru>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru> <1233281510.18767.17.camel@pasglop>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Steven Rostedt <srostedt@redhat.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:34509 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752580AbZA3DIA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jan 2009 22:08:00 -0500
Content-Disposition: inline
In-Reply-To: <1233281510.18767.17.camel@pasglop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 30, 2009 at 01:11:50PM +1100, Benjamin Herrenschmidt wrote:
> 
> > This is trivially solved by converting arch/powerpc/sysdev/ipic.c
> > back to spinlocks (ipic_lock).
> > 
> > Assuming that converting-back is automatic, there are few other
> > chained interrupt controllers you might want to convert-back:
> > 
> > arch/powerpc/sysdev/i8259.c (i8259_lock)
> > arch/powerpc/sysdev/mpic.c (mpic_lock)
> > arch/powerpc/sysdev/qe_lib/qe_ic.c (qe_ic_lock)
> 
> Except that a bunch of those can be both primary and chained...

Yeah, thanks for correcting.

> It's
> simply not a solution to have to "convert" interrupt controller code to
> use a different locking scheme depending on whether they are chained or
> primary...

Actually, it doesn't matter whether a controller is a root IC or
cascaded. Just as primary handlers, chained handlers don't run in
threads, thus spinlocks should be used, not sleeping locks.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
