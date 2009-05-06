From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: idle task starvation with rt patch
Date: Wed, 06 May 2009 14:04:30 -0700
Message-ID: <4A01FB5E.1000006@us.ibm.com>
References: <b79371120905061247o72198a1ak6b4527ebfb60098a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: David L <idht4n@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:51597 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbZEFVE2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 May 2009 17:04:28 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n46L1Cm3001127
	for <linux-rt-users@vger.kernel.org>; Wed, 6 May 2009 15:01:12 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n46L4SjZ226066
	for <linux-rt-users@vger.kernel.org>; Wed, 6 May 2009 15:04:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n46L4QoS024062
	for <linux-rt-users@vger.kernel.org>; Wed, 6 May 2009 15:04:26 -0600
In-Reply-To: <b79371120905061247o72198a1ak6b4527ebfb60098a@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

David L wrote:
> Hi,
> 
> I'm a newbie trying to see if the rt patch will improve
> the performance of a PPC Linux receiver.  We need
> to read data from an FGPA correlator about every msec
> although we can tolerate 5-10 msecs from time to time.
> 
> Without the real-time patches, we find that we sometimes
> miss our timing deadlines especially when we have multiple
> processes with "real-time" (SCHED_FIFO) threads.  I tried

I take it you weren't seeing crashes on mainline?

> to use the 2.6.29.2-rt11 patch to see if it helped, but things
> got much worse.  We have about 30-60 percent idle CPU
> without the patches... after applying the patches, I found
> that we had essentially no idle time.  Below are excepts
> from the kernel sched_switch trace file while our process
> is running with and without the real-time patches applied.

What priority are you running your real time tasks at?

> I notice there are IRQ-related processes with the real-time
> patches that don't exist in without the patches.  But the main
> thing to notice is that there is no idle time which eventually
> causes the process to crash because low priority threads

Which process crashed? 

> are starved for too long.  Am I doing something wrong or
> is it expected overhead of the real-time patches will cause
> problems like this under this kind of interrupt load?

Making sure your priorities are set right so you don't
starve essential processes is important...rt makes it
easy to shoot yourself in the foot...

thanks,
Nivedita
