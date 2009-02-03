From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Hard lockup with 2.6.24.7-rt26 on x86
Date: Tue, 03 Feb 2009 16:44:10 +0100
Message-ID: <4988664A.3080601@osadl.org>
References: <37144.1233608136@vtxmail.ch> <20090203090052.6a4dc4de@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: m.luescher@vtxmail.ch, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:55917 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbZBCPvN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Feb 2009 10:51:13 -0500
In-Reply-To: <20090203090052.6a4dc4de@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark,

>> On two different desktop PC (both Core 2 Duo) and on a notebook
>> (Core Duo) the kernel (2.6.24.7-rt26, CONFIG_X86_32) locks up hard
>> under a certain rt load. The failure can be reproduced reliably
>> with the following command:
>> sudo ./cyclictest -p99 -t10 -n -i250
> My guess would be that since you're running 10 threads on two 
> processors at the highest available priority, you're starving all the
> hard IRQ threads (as well as soft irq and other kernel threads).
> This is one of those power-tool moments where you can lock up the 
> system with the wrong workload/priority combination.
Hmm, I would agree immediately, if the tasks were using all of the CPU
power. But this is not the case. In the present case, running

# cyclictest -p99 -t10 -n -i250

results in about 10% CPU load. So there is plenty of time in between to
let the system respond. I can reproduce the problem here (2.6.24-rt,
2.6.26-rt, various configurations). The system does not crash every time
when cyclictest is started, only once in about 5 trials or so. If it
crashes, then it does so immediately after being started. Whenever
cyclictest survives for several seconds, then it never crashes at a
later time. I tend to believe that we have a bug here, not a regular
behavior.

	Carsten.
