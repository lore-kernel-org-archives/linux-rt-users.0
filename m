From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [PATCH] RT: Add priority-queuing and priority-inheritance to
	workqueue infrastructure
Date: Mon, 06 Aug 2007 11:04:49 -0400
Message-ID: <1186412689.21381.91.camel@ghaskins-t60p.haskins.net>
References: <1186002783.9513.228.camel@ghaskins-t60p.haskins.net>
	 <20070801213422.GA280@tv-sign.ru>
	 <1186005598.9513.261.camel@ghaskins-t60p.haskins.net>
	 <20070801222201.GA316@tv-sign.ru>
	 <1186012439.9513.321.camel@ghaskins-t60p.haskins.net>
	 <20070802195049.GA361@tv-sign.ru> <20070806114954.GC1903@elte.hu>
	 <20070806131814.GC91@tv-sign.ru> <1186406963.7182.13.camel@twins>
	 <1186407173.7182.16.camel@twins>  <20070806144536.GA232@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Daniel Walker <dwalker@mvista.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933848AbXHFPGs@vger.kernel.org>
In-Reply-To: <20070806144536.GA232@tv-sign.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-08-06 at 18:45 +0400, Oleg Nesterov wrote:
> On 08/06, Peter Zijlstra wrote:

> > 
> > still this does not change the fundamental issue of a high prio piece of
> > work waiting on a lower prio task.
>        ^^^^^^^
> waiting. This is a "key" word, and this was my (perhaps wrong) point.

Actually, I think Peter is making a really important point here.
"Waiting" can be defined in more ways than the REQUEST/RESPONSE pattern
that I have been rambling about.

Using Peters NIC vs USB example:  What if a NIC driver is using a
workqueue as a bottom-half mechanism for its RX packet queuing.  In a
nice RT environment it would be highly ideal if we allow the deferred
work to complete with respect to the priority that was assigned to the
subsystem.

So while the submitter isn't technically blocking on the work, the
application that is receiving packets is now subject to the arbitrary
priority of the keventd as opposed to the NIC irq.  Thus there is still
"waiting" being subject to inversion, its just not in a REQUEST/RESPONSE
pattern.

-Greg
