From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Thu, 9 Aug 2007 11:28:43 -0700
Message-ID: <200708091128.44043.dvhltc@us.ibm.com>
References: <200708081514.31864.jbe@pengutronix.de> <200708081409.28105.dvhltc@us.ibm.com> <200708091610.58134.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:47037 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbXHIS2r (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Aug 2007 14:28:47 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l79ISkSK030581
	for <linux-rt-users@vger.kernel.org>; Thu, 9 Aug 2007 14:28:46 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l79ISjXx214774
	for <linux-rt-users@vger.kernel.org>; Thu, 9 Aug 2007 12:28:45 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l79ISiR4032741
	for <linux-rt-users@vger.kernel.org>; Thu, 9 Aug 2007 12:28:44 -0600
In-Reply-To: <200708091610.58134.jbe@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday 09 August 2007 07:10:57 Juergen Beisert wrote:
> Darren,
>
> On Wednesday 08 August 2007 23:09, Darren Hart wrote:
> > On Wednesday 08 August 2007 06:14:31 you wrote:
> > > Hi,
> > >
> > > with the rt-preempt patch the IRQs are all kernelthreads started with
> > > priority 50. Is there a way to change this priority from inside the
> > > driver, after I did the request_irq() call? I need a higher priority
> > > for one interrupt source but I do not want to change it with chrt from
> > > userspace. It should be done inside the driver.
> >
> > I disagree.  The point of real-time is to provide user-space with more
> > control of what get's run, when, instead of something else - including
> > system interrupts, etc.  For instance, if networking should take a higher
> > priority than their application, but disk i/o should take a lower one,
> > the user needs to be able to control that.  chrt is the correct approach
> > for -rt in my opinion.
>
> All I need is one IRQ at priority 51, all other can still run at 50. And I
> don't want to search at system's runtime for the right PID of driver's
> thread to set its priority via "chrt". There is no user at this system, its
> an embedded one.

It seems reasonable then, for such a specialized case, to consider Remy's 
reply to my previous mail:

"To suit my needs, I did this by just patching the kernel thread
priorities at the places where they are started. (And I am still happy
with my solution. Note that because it is very application specific, I
never expect a patch like this to get to the mainline)"

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
