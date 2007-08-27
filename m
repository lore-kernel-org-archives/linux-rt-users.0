From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: How to talk to DAQ Hardware?
Date: Mon, 27 Aug 2007 10:26:07 +0200
Message-ID: <46D28A9F.1050008@osadl.org>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com> <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Calin Culianu <cculianu@yahoo.com>,
	Daniel Walker <dwalker@mvista.com>,
	linux-rt-users@vger.kernel.org
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:48767 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbXH0KPZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Aug 2007 06:15:25 -0400
In-Reply-To: <Pine.LNX.4.63.0708270954340.8578@pcgl.dsa-ac.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Guennadi Liakhovetski wrote:
> On Sat, 25 Aug 2007, Calin Culianu wrote:
>> Now, there is no way to raise the priority of particular driver's ISRs is
>> there?  So that a specific ISR can preempt anything including a hard realtime
>> process?
> It's the second time you say "hard" real-time, so, just wanted to warn - 
> it is not hard. It is still only soft real time, but a pretty good one, I 
> think.
I don't know what exactly "soft real-time" is, and I don't think there 
is an exact definition of it. The term "hard real-time", however, is 
well defined. It is the same as "real-time". It means that a system 
never ever exceeds a previously defined maximum latency. If, for 
example, you define 100 microseconds as such, you run your system over a 
long time period (several days), and you observe several billions of 
single external events that trigger a user space process at real-time 
priority, then there must be no single event that fails to do so within 
100 microseconds. We did this constantly and successfully with an -rt 
kernel. So why are we not allowed to call this "hard real-time"?

If you are aware of a situation where this is not the case, then this 
may be a specific problem related to a specific situation. Please help 
us to improve the -rt patches further and submit a bug report. I am 
confident that it will be fixed as soon as possible.

	--cbe
