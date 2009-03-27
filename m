From: Robin Gareus <robin@gareus.org>
Subject: Re: 2.6.29-rt1+ irqbalance = OOPS
Date: Fri, 27 Mar 2009 18:24:17 +0100
Message-ID: <49CD0BC1.6090305@gareus.org>
References: <49CCFBCA.6050702@gareus.org> <49CD03AA.4030000@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:10416 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbZC0RYd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Mar 2009 13:24:33 -0400
In-Reply-To: <49CD03AA.4030000@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Gregory Haskins wrote:
> Robin Gareus wrote:
>> Hello,
>>
>> Starting the irqbalance daemon ( http://www.irqbalance.org/ ) on
>> 2.6.29-rt1 causes the system to OOPS and freeze. irqbalance works fine
>> with previous realtime kernels (2.6.24.7-rt27).
>>
>> The OOPS seems to be caused by the PID of the [timer] IRQ-1
> This in of itself might be part of the problem.  I didn't think the
> timer was supposed to be threaded.  Thomas?

OOPS ;) my bad. IRQ-0 is the timer and it's indeed not threaded.

IRQ-1 is i8042

The OOPS can be triggered by launching irqbalance. pressing any key.
For whatever reason the OOPS also takes place after a random amount of
time without pressing any key..

robin


