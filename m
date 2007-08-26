From: Daniel Walker <dwalker@mvista.com>
Subject: Re: How to talk to DAQ Hardware?
Date: Sat, 25 Aug 2007 18:46:11 -0700
Message-ID: <1188092771.2435.170.camel@dhcp193.mvista.com>
References: <664539.31533.qm@web36101.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Calin Culianu <cculianu@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:58026 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765401AbXHZBxY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Aug 2007 21:53:24 -0400
In-Reply-To: <664539.31533.qm@web36101.mail.mud.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-08-25 at 12:49 -0700, Calin Culianu wrote:

> Cool!  That's what I figured but I wanted to double-check.
> 
> Now, there is no way to raise the priority of particular driver's ISRs is
> there?  So that a specific ISR can preempt anything including a hard realtime
> process?

ISR's are kernel threads, and you can change the priority of them .. If
you look 'ps' or 'top' you'll notice some processes that looks like,

m0nster-mash ~ # ps alx | grep IRQ
5     0   119     2 -51   -      0     0 irqd   S<   ?          0:00 [IRQ-20]
5     0   898     2 -51   -      0     0 irqd   S<   ?          0:00 [IRQ-8]
5     0   930     2 -51   -      0     0 irqd   S<   ?          0:00 [IRQ-14]
5     0   948     2 -51   -      0     0 irqd   S<   ?          0:00 [IRQ-18]
5     0   957     2 -51   -      0     0 irqd   S<   ?          0:00 [IRQ-16]
5     0   964     2 -51   -      0     0 irqd   S<   ?          0:00 [IRQ-19]
5     0   974     2 -51   -      0     0 irqd   S<   ?          0:00 [IRQ-12]
5     0   975     2 -51   -      0     0 irqd   S<   ?          0:00 [IRQ-1]
5     0  1002     2 -51   -      0     0 irqd   S<   ?          0:00 [IRQ-4]
m0nster-mash ~ #

So you change the priority just like with any process.. Using chrt from
sched utils ..

> I know in the shared IRQ situation it would introduce lots of jitter but having
> really high priority interrupts would be nice.  Is that possible?

yeah, if they're shared then both handlers will get the same priority .

> Anyway thanks for answering my question -- this basically means I can throw
> away rtlinux and use the latest 2.6 kernels with the RT_PREEMPT patches!  :)

Yeah, hopefully it works out for you..

Daniel
