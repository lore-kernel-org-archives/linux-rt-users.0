From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: How to control IRQ thread priority from inside the driver
Date: Wed, 8 Aug 2007 14:09:27 -0700
Message-ID: <200708081409.28105.dvhltc@us.ibm.com>
References: <200708081514.31864.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Juergen Beisert <jbe@pengutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:43041 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759814AbXHHVJb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Aug 2007 17:09:31 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78L9UVo021781
	for <linux-rt-users@vger.kernel.org>; Wed, 8 Aug 2007 17:09:30 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l78L9TIY207108
	for <linux-rt-users@vger.kernel.org>; Wed, 8 Aug 2007 15:09:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l78L9SmN002864
	for <linux-rt-users@vger.kernel.org>; Wed, 8 Aug 2007 15:09:29 -0600
In-Reply-To: <200708081514.31864.jbe@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday 08 August 2007 06:14:31 you wrote:
> Hi,
>
> with the rt-preempt patch the IRQs are all kernelthreads started with
> priority 50. Is there a way to change this priority from inside the driver,
> after I did the request_irq() call? I need a higher priority for one
> interrupt source but I do not want to change it with chrt from userspace.
> It should be done inside the driver.

I disagree.  The point of real-time is to provide user-space with more control 
of what get's run, when, instead of something else - including system 
interrupts, etc.  For instance, if networking should take a higher priority 
than their application, but disk i/o should take a lower one, the user needs 
to be able to control that.  chrt is the correct approach for -rt in my 
opinion.

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
