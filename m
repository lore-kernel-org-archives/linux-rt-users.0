From: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Mon, 22 Oct 2012 23:05:08 +0200
Message-ID: <op.wmll6ue46426ze@localhost.localdomain>
References: <alpine.LFD.2.02.1210202133470.2719@ionos>
 <op.wmk8f6m96426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210222029480.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.getmail.no ([84.208.15.66]:54642 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282Ab2JVVFU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2012 17:05:20 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCB001KYBWVMN70@get-mta-out01.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Mon, 22 Oct 2012 23:05:19 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 31AC31F46C55_85B88DB	for <linux-rt-users@vger.kernel.org>; Mon,
 22 Oct 2012 21:20:13 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 0AC8B1F46C38_85B88DF	for <linux-rt-users@vger.kernel.org>; Mon,
 22 Oct 2012 21:20:13 +0000 (GMT)
Received: from localhost.localdomain ([84.211.57.6])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCB00NX3BWK2Q10@get-mta-in03.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Mon, 22 Oct 2012 23:05:18 +0200 (MEST)
In-reply-to: <alpine.LFD.2.02.1210222029480.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 22 Oct 2012 20:33:25 +0200, Thomas Gleixner <tglx@linutronix.de>  
wrote:

> On Mon, 22 Oct 2012, Uwaysi Bin Kareem wrote:
>
>> I tried it. Just low-latency desktop, seems slighty of less jitter, than
>> mainline.
>> Unfortunately the problem of threadedirqs continue, they never worked  
>> on my
>> machine.
>
> What does not work?
>

When enabling threaded irqs in mainline kernel, booting does not proceed,  
but stops quite soon after a few messages, and drops to shell.

This is the same thing that happens on rt patch also, when enabling higher  
preemption that "low latency desktop".

Peace Be With You.
