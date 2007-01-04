From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: cyclictest hangs with posix interval timers !?
Date: Thu, 04 Jan 2007 14:27:37 +0100
Message-ID: <1167917257.23138.17.camel@localhost.localdomain>
References: <459CE84F.8000009@imc-berlin.de>
	 <20070104115215.GN29495@pengutronix.de>  <459CFDF1.80807@imc-berlin.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:38498 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964858AbXADNWO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jan 2007 08:22:14 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
In-Reply-To: <459CFDF1.80807@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-01-04 at 14:15 +0100, Steven Scholz wrote:
> Robert Schwebel wrote:
> > On Thu, Jan 04, 2007 at 12:43:11PM +0100, Steven Scholz wrote:
> >> Will I need a special version of glibc or libpthread? NTPL?
> >> I am using a cross tool chain gcc-3.4.4-glibc-2.3.5 for i686 built with
> >> "crosstool".
> > 
> > You usually need NPTL, and if I remember correctly you also needed the
> > hrtimer-support lib for older glibcs.
> Any pointers where I could find this hrtimer-support?

cyclictest does not need any extra functionality. You only need a new
glibc if you want to use priority inheritance mutexes.

	tglx
