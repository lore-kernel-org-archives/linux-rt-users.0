From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: cyclictest better values with system load than without (OMAP3530
 target)
Date: Fri, 29 Nov 2013 18:36:16 +0100
Message-ID: <5298D090.7090000@osadl.org>
References: <5294681E.10406@gmail.com> <20131126101232.21636c8f@sluggy> <20131129125623.GB31099@linutronix.de> <5298AE4B.7070806@osadl.org> <5298C292.2030502@xenomai.org> <5298C7D0.2080300@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Stefan Roese <stefan.roese@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:33751 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab3K2RmN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 12:42:13 -0500
In-Reply-To: <5298C7D0.2080300@xenomai.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Gilles,

> On 11/29/2013 05:36 PM, Gilles Chanteperdrix wrote:
>> On 11/29/2013 04:10 PM, Carsten Emde wrote:
>>> BTW: Power saving and real-time do not necessarily exclude each other.
>>> If a - still deterministic - but a little longer latency is acceptable,
>>> some light sleep states and a somewhat lower clock frequency may be
>>> allowed which still may result in considerable energy saving. If,
>>> however, the fastest possible real-time response is required, C states
>>> and P states must be disabled (or set to polling and maximum speed,
>>> respectively) and the power bill must be payed.
>> Well, I do not fully agree. To be sure that you can clock down the
>> processor for executing a task which has sufficient time to meet its
>> deadline, your system must be "time triggered", all the timer events
>> must be known in advance. Because on a fully dynamic system, you may
>> make that decision, but a new timer may be scheduled which causes the
>> system to miss its deadline whereas it would not have missed it if it
>> had run at full speed.
> And a second problem is that you must know the task WCET, which on a
> modern system:
> - depends on the task frequency;
> - depends on the IRQ load.
> Again, only a time triggered system seems to make this possible.
Hmm, I'm not sure whether I correctly got your point.

Let me try an example: A 1-GHz CPU of a given systems runs at full speed 
with frequency governor set to performance and provides the required 
real-time capabilities. When a second system with the same capabilities 
was needed, the 1-GHz CPU unfortunately was out of stock, and the 
decision was made to buy the 2-GHz variant of the processor. To save 
energy, however, the clock frequency of the second system was set to 1 
GHz using the cpufreq interface. Are you arguing that the 2-GHz 
processor that is throttled down to 1 GHz has a slower response time 
than the 1-GHz processor that always runs at full speed?

	-Carsten.
