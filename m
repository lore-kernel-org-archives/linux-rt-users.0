From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Two questions about high resolution timers
Date: Thu, 21 Jun 2007 13:59:40 -0700
Message-ID: <200706211359.40235.dvhltc@us.ibm.com>
References: <1182438374.4726.19.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:47192 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbXFUU7m (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jun 2007 16:59:42 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l5LKsrmL014891
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Jun 2007 16:54:53 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5LKxfNg268046
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Jun 2007 14:59:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5LKxfuX031642
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Jun 2007 14:59:41 -0600
In-Reply-To: <1182438374.4726.19.camel@godzilla.tecnorama.it>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday 21 June 2007 08:06:14 you wrote:
> Hi to all,
>
> Sorry for my poor english.
>
> 1) What are reliable clocksources?
>

Depends on a lot on your architecture, chipset, SMP vs. UP, etc.  I have been 
testing mostly with the acpi_pm timer and having good results - there may be 
a better timer available on your particular system.  Can you provide the 
contents of:

/sys/devices/system/clocksource/clocksource0/available_clocksource
 
and

/sys/devices/system/clocksource/clocksource0/current_clocksource


> 2) I have a mainboard with a 500 Mhz cpu which works perfectly with RT.
> I suppose that the max resolution is 2 ns for the high resolution timers
> but a "cat /proc/timer_list" reported:

Note that timer resolution is not bound by CPU.  There is also a difference 
between resolution and accuracy :-)  So while you can set timers with 
nanosecond resolution, you will likely see expiration accuracy in something 
more like the tens of microsecond range.

Regards,

Darren Hart

>
> cpu: 0
>  clock 0:
>   .index:      0
>   .resolution: 1 nsecs <----
>
> active timers:
>  clock 1:
>   .index:      1
>   .resolution: 1 nsecs <----
>
> How it is possible that this mainboard have 1 nsecs resolution?
>
> Excuse me if it are stupid questions.
>
> Thanks in advance!
>
> Ciao,
> Alessio
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
