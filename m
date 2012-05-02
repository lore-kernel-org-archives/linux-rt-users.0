From: "Harald Stocker" <Harald.Stocker@berghof.com>
Subject: Re: Linux 3.2.16-rt27 - BUG: scheduling while atomic
Date: Wed, 2 May 2012 10:09:43 +0200
Message-ID: <OFCB11243E.5ED6CAD9-ONC12579F2.002B6657-C12579F2.002CD5E8@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.34]:30146 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752482Ab2EBIJp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2012 04:09:45 -0400
Received: from zhsrv03.be-int.local (zhsrv03.be-int [10.255.255.245])
	by pegasus.berghof.com (8.13.8/8.13.8) with ESMTP id q4289hHC016516
	for <linux-rt-users@vger.kernel.org>; Wed, 2 May 2012 10:09:43 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> 
> The problem occurs in overload situations only. So previously we also 
got 
> the message that rt throttling is getting enabled.
> 
> The problem seems to be dependent on the realtime patch because with a 
> untouched kernel 3.2.16 we cant reproduce it. 
> To locate the problem, additionally  we try to disable switching to 
> "throttling mode" by uncommenting "rt_rq->rt_throttled = 1;" in 
sched_rt.c
> but it still occurs.
> 
> If the kernel is configured to be tickless the problem occurs less 
often.
> 


hi,

if anyone has a similar problem with 3.2.16-rt27 on a single core ppc:

a workaround is to activate the SMP option in the kernel configuration
regardless that only one core is available.

it would be nice if someone who is familiar with the hrtimer and 
ppc/timer-irq 
can catch the problem.

regards,
Harald





______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud service.
For more information please visit http://www.symanteccloud.com
______________________________________________________________________
