From: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Thu, 9 Aug 2007 16:10:57 +0200
Message-ID: <200708091610.58134.jbe@pengutronix.de>
References: <200708081514.31864.jbe@pengutronix.de> <200708081409.28105.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:52135 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937847AbXHIOLJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Aug 2007 10:11:09 -0400
In-Reply-To: <200708081409.28105.dvhltc@us.ibm.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Darren,

On Wednesday 08 August 2007 23:09, Darren Hart wrote:
> On Wednesday 08 August 2007 06:14:31 you wrote:
> > Hi,
> >
> > with the rt-preempt patch the IRQs are all kernelthreads started with
> > priority 50. Is there a way to change this priority from inside the
> > driver, after I did the request_irq() call? I need a higher priority for
> > one interrupt source but I do not want to change it with chrt from
> > userspace. It should be done inside the driver.
>
> I disagree.  The point of real-time is to provide user-space with more
> control of what get's run, when, instead of something else - including
> system interrupts, etc.  For instance, if networking should take a higher
> priority than their application, but disk i/o should take a lower one, the
> user needs to be able to control that.  chrt is the correct approach for
> -rt in my opinion.

All I need is one IRQ at priority 51, all other can still run at 50. And I 
don't want to search at system's runtime for the right PID of driver's thread 
to set its priority via "chrt". There is no user at this system, its an 
embedded one.

Juergen
