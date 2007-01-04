From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Thu, 04 Jan 2007 14:47:31 +0100
Message-ID: <1167918451.23138.31.camel@localhost.localdomain>
References: <459CE84F.8000009@imc-berlin.de>
	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>
	 <1167917257.23138.17.camel@localhost.localdomain>
	 <459D019E.1070906@imc-berlin.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:49206 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964828AbXADNmI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jan 2007 08:42:08 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
In-Reply-To: <459D019E.1070906@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-01-04 at 14:31 +0100, Steven Scholz wrote:
> > cyclictest does not need any extra functionality. You only need a new
> > glibc if you want to use priority inheritance mutexes.
> 
> Ok. Then any idea how I could find out why sigwait() is blocking?

Can you strace cyclictest and send me the output ?

# strace -f cyclictest -t 1 -p 80 -i 10000 -l 10 -q

	tglx
