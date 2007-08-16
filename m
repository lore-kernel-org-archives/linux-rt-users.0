From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: preemption issue
Date: Thu, 16 Aug 2007 09:15:40 -0700
Message-ID: <200708160915.40449.dvhltc@us.ibm.com>
References: <725A29F6B5035C45A40BDE230A5B92190E693977@TRISTK010MSX.tr001.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Kaya, Sinan" <sinan.kaya@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:38887 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366AbXHPQPo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Aug 2007 12:15:44 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7GGFhgT026021
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Aug 2007 12:15:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7GGFhSL232580
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Aug 2007 10:15:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7GGFhQA013480
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Aug 2007 10:15:43 -0600
In-Reply-To: <725A29F6B5035C45A40BDE230A5B92190E693977@TRISTK010MSX.tr001.siemens.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Monday 13 August 2007 05:54:24 you wrote:
> Hello All,
> I have got an interesting lock up situation using 2.6.21.5 kernel
> together with rt15 patch. I'll try also with 22.1 before that i wanted
> to check if anybody else has faced it.
>
> I have one application communicating with a kernel driver. A character
> driver has been implemented as an interface. The situation is a classic
> provider-consumer case. Kernel driver provides data and application
> consumes it. I have difficulties with triggering the application.
>
>
> The provider receives a frame from the network and feeds this into the
> application. The proiroities are configured with the following script:
>
> So hrtimer has the highest priority with 99 and net-rx and net-tx is
> configured with 55. The application is configured for 70.
>
> The application runs smoothly for a while and then, the computer
> completely locks up. I am unable to enter any keyboard data. When i
> unplug the network cable, i see the message that it has been
> disconnected. So, the kernel driver is still alive.

You can try to get more visibility by what is going on by dropping hrtimer to 
98 and using chrt to boost your shell to 99.  You should then be able to see 
what is hogging the cpu, and even use sysrq to get a task dump, or even force 
a crash if you have kdump setup for analysis with crash.

--Darren

>
> What could be the reason for this lock up. I also tried with round robin
> policy. It has been much more stable but it also locks up after a while.
>
> Thanks and regards,
> Sinan.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
