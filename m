From: "Phil K." <binutz@gmail.com>
Subject: Re: Problems with cyclictest and ps
Date: Thu, 06 Dec 2007 11:23:06 +0100
Message-ID: <4757CD8A.10909@gmail.com>
References: <47570B50.9060502@gmail.com> <475735D2.3070003@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Florian Boelstler l <euphoria@arcor.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:62166 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbXLFKZR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Dec 2007 05:25:17 -0500
Received: by nf-out-0910.google.com with SMTP id g13so59405nfb
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Dec 2007 02:25:16 -0800 (PST)
In-Reply-To: <475735D2.3070003@arcor.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Florian Boelstler wrote:
> Hi,
> 
> Phil K. wrote:
>> I tried cyclictest under Debian Lenny with Kernel-2.6.23.8-hrt3 and
>> Kernel-2.6.22 as user root. As decribed on the cyclictest-wikipage all
>> cyclictest-tasks run with the scheduler class SCHED_FIFO. I controlled
>> the scheduler class with "ps -ce" and ps showed me SCHED_OTHER for the
>> cyclictest-task.
> 
> I had the same problem using 2.6.23.9-rt12 on Debian Etch
> (schedutils-1.5.0-1) today. When checking the current state of
> cyclictest with chrt (chrt -p <pid of cyclictest), it always reported
> SCHED_OTHER and priority 0.
> When I tried to change the scheduling policy and/or priority with chrt
> it seemed to fail as well (not sure whether it tells the truth though).
> On the other hand starting cyclictest via chrt did the trick:
> "chrt -f 80 cyclictest..."
> 
> I can provide further details, when I am closer to the machine in
> question tomorrow.
> 
> Cheers,
> 
>   Florian

I posted the solution for that problem and described it in the
RTWiki(http://rt.wiki.kernel.org/index.php/Cyclictest#FAQ).

Greetings,

Phil
