From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: PREEMPT_RT with Full Tickless
Date: Fri, 11 Dec 2015 18:50:23 +0100
Message-ID: <20151211175023.GN6720@linutronix.de>
References: <CANv7uPSimVG=GfQ5W_HDq0UYUokK-Y2WvSPTXc3MFd7eLXqYVQ@mail.gmail.com>
 <1449844577.4882.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GeHao Kang <kanghao0928@gmail.com>, tglx@linutronix.de,
	peterz@infradead.org, jason.low2@hp.com,
	linux-rt-users@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49200 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbbLKRud (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 12:50:33 -0500
Content-Disposition: inline
In-Reply-To: <1449844577.4882.5.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2015-12-11 15:36:17 [+0100]:

>On Fri, 2015-12-11 at 19:29 +0800, GeHao Kang wrote:
>> When I enable CONFIG_PREEMPT_RT_FULL and CONFIG_NO_HZ_FULL
>> in Linux Kernel v4.1.12-rt12, I find the tick on the nohz_full cpu
>> never stops.
>
>Because the workarounds that let it work have been dropped.  I recall
>Thomas mentioning that, but can't find the message in my rubble pile.

Right. This was the case on the first v4.0 or v4.1 release. The longterm
plan is to bring it back once the timers have been re-done so we don't
need any hacks.

>	-Mike 

Sebastian
