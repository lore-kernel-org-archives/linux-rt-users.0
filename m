From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: PREEMPT_RT with Full Tickless
Date: Fri, 11 Dec 2015 15:36:17 +0100
Message-ID: <1449844577.4882.5.camel@gmail.com>
References: <CANv7uPSimVG=GfQ5W_HDq0UYUokK-Y2WvSPTXc3MFd7eLXqYVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: GeHao Kang <kanghao0928@gmail.com>, tglx@linutronix.de,
	peterz@infradead.org, jason.low2@hp.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36705 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbbLKOgU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Dec 2015 09:36:20 -0500
Received: by mail-wm0-f45.google.com with SMTP id n186so32363556wmn.1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Dec 2015 06:36:19 -0800 (PST)
In-Reply-To: <CANv7uPSimVG=GfQ5W_HDq0UYUokK-Y2WvSPTXc3MFd7eLXqYVQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2015-12-11 at 19:29 +0800, GeHao Kang wrote:
> Hi Thomas, Peter, and Jason,
> 
> When I enable CONFIG_PREEMPT_RT_FULL and CONFIG_NO_HZ_FULL
> in Linux Kernel v4.1.12-rt12, I find the tick on the nohz_full cpu
> never stops.

Because the workarounds that let it work have been dropped.  I recall
Thomas mentioning that, but can't find the message in my rubble pile.

	-Mike 
