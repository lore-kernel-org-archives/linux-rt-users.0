From: Rolf Peukert <rolf.peukert@imms.de>
Subject: Re: [PATCH RT 0/8] Linux 3.2.53-rt76-rc1
Date: Fri, 17 Jan 2014 14:01:04 +0100
Message-ID: <52D92990.1020904@imms.de>
References: <20140116015824.201732155@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from infosrv.imms.de ([194.95.250.51]:43658 "EHLO infosrv.imms.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbaAQNQn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jan 2014 08:16:43 -0500
In-Reply-To: <20140116015824.201732155@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 16.01.2014 02:58, Steven Rostedt wrote:
...
> Please scream at me if I messed something up. Please test the patches too.
>

Hi Steven,

i just tried the incremental patch on our kernel and it applied without
problems. But when I try to build it with only "Basic RT" configured, I
get this error message:

kernel/softirq.c: In function 'invoke_softirq':
kernel/softirq.c:626:2: error: 'else' without a previous 'if'

The source code before that line currently looks like this

#ifndef CONFIG_PREEMPT_RT_FULL
	if (!force_irqthreads)
		lockdep_softirq_from_hardirq();
		__do_softirq();
	else {

Is one of the lines in the wrong place or is it just missing brackets?

Best regards
Rolf

