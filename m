From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: Latest PreemptRT patch error on imx35
Date: Mon, 31 Aug 2009 15:40:17 +0200
Message-ID: <200908311540.18118.tim01@vlsi.informatik.tu-darmstadt.de>
References: <200908311143.08952.tim01@vlsi.informatik.tu-darmstadt.de> <4A9BB887.1040407@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx500.hrz.tu-darmstadt.de ([130.83.156.225]:60397 "EHLO
	lnx500.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750715AbZHaNmK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2009 09:42:10 -0400
Received: from iss1.vlsi.informatik.tu-darmstadt.de (iss1.vlsi.informatik.tu-darmstadt.de [130.83.164.1])
	by lnx500.hrz.tu-darmstadt.de (8.14.2/8.14.2/HRZ/PMX) with ESMTP id n7V6rq4U012628
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2009 08:53:52 +0200
	(envelope-from tim01@vlsi.informatik.tu-darmstadt.de)
Received: from localhost (localhost [127.0.0.1])
	by iss1.vlsi.informatik.tu-darmstadt.de (Postfix) with ESMTP id 3B5C4CE0D
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2009 15:42:11 +0200 (CEST)
Received: from iss1.vlsi.informatik.tu-darmstadt.de ([127.0.0.1])
	by localhost (iss1.vlsi.informatik.tu-darmstadt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAJm3pDa1eNE for <linux-rt-users@vger.kernel.org>;
	Mon, 31 Aug 2009 15:42:11 +0200 (CEST)
Received: from fpga3.vlsi.informatik.tu-darmstadt.de (iss37.vlsi.informatik.tu-darmstadt.de [130.83.164.37])
	by iss1.vlsi.informatik.tu-darmstadt.de (Postfix) with ESMTP id 1BA66770C
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Aug 2009 15:42:11 +0200 (CEST)
In-Reply-To: <4A9BB887.1040407@osadl.org>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi  Carsten
> As a role of thumb, the -i option is normally set to twice the expected
> latency. If, for example you expect 100 us, set it to -i200. Your loop
> end is then reached 50 times faster, or - what is much better - you may
> specify 50 times more loops for a test of the same duration which
> considerably increases the quality of your assessment. Normally,
> however, you would probably wait for 100 million or even a billion loops.
Thanks for the tipps, will try more sane values once i have a booting system 
again. Just testing non patched kernels.
> With an average of 19 and a maximum of 27, the result is probably not
> very relevant. This indicates that the CPU was idle most of the time
> when the wakeup occurred - every OS can do this. The challenge of an
> RTOS is to wakeup in time also when the kernel is not idle, e.g. from
> kernel or driver code while a lock is held. Therefore, adequate stress
> tools must be running during a latency measurement.
As i mentioned i did tests on a imx31 with an older premptRT patch, and even 
Idle numbers where much worse. Probably due to the fact that arm support has
just trickled in and is now more mature?

> Please keep in mind that ftrace configured is not ftrace enabled. To
> enable it, use cyclictest's -f option or execute
>   echo function >/sys/kernel/debug/tracing/current_tracer
>   echo 1 >/sys/kernel/debug/tracing/tracing_enabled
> from command line.
Again with my older tests only enabling tracing functionality made a 
significant performance hit. But well, its all moving in the right direction
:-).

Best regards
Tim
