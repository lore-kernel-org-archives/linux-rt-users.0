From: Gregory Haskins <gregory.haskins.ml@gmail.com>
Subject: Re: Oops with PREEMPT-RT on 2.6.25.4
Date: Mon, 19 May 2008 15:58:20 -0400
Message-ID: <4831DBDC.8000008@gmail.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com> <4831D527.2020907@freescale.com> <DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
Reply-To: gregory.haskins@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Scott Wood <scottwood@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Rune Torgersen <runet@innovsys.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762017AbYEST7j@vger.kernel.org>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Rune Torgersen wrote:
> Scott Wood wrote:
>
>> You're recursively entering lock_timer_base, which does a
>> spin_lock_irqsave().  Either interrupts are enabled when they should
>> not be, or an interrupt was supposed to be threaded that isn't.
> 
> Sort of figured. How do I figure out which one, and how to fix it?
> I've never gotten any -rt patchsets to work on this CPU, and it always
> seems to be related to the disk driver.
> I've tried since 2.6.16 ppc.... (2.6.16, 2.6.18 on ppc, 2.6.24 and 25 on
> powerpc)
> 
> Even though this is a custom board, I'm pretty sure I can get it to fail
> on a pq2fads board with the same disk controller.

Im not sure if LOCKDEP is available for that architecture.  Have you 
tried it?  Its pretty good at flushing these kinds of issues out 
(assuming its available).

-Greg
