From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Force processes to non-realtime before mm_exit
Date: Wed, 25 May 2016 21:54:24 +0200
Message-ID: <574602F0.2070608@linutronix.de>
References: <1462903464-11448-1-git-send-email-brian@peloton-tech.com>
 <20160512085946.GB19035@linutronix.de>
 <CAGt3f4m=+yimx-wxDjH9TCzAb5F6zUbxG_RAEhTrT4cZWFKKcg@mail.gmail.com>
 <20160525163323.GB18036@linutronix.de>
 <CAGt3f4=SyBqM-7Jeitx10Tm8yTrNBpSoFNvCZNZX7A3oixzUzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Brian Silverman <brian@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41726 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbcEYTy1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 May 2016 15:54:27 -0400
In-Reply-To: <CAGt3f4=SyBqM-7Jeitx10Tm8yTrNBpSoFNvCZNZX7A3oixzUzA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/25/2016 08:00 PM, Brian Silverman wrote:
>> Why can't the application drop the RT priority before its exit? Wouldn't
>> that be appropriate?
> 
> If it crashes or gets killed, it doesn't have a chance to drop priority.

That is correct. The task with the highest priority is usually one of
the most important ones. Usually if that task crashes or gets killed by
the OOM killer while in production you have usually bigger problems
than this.

I'm neither pro nor against this patch. This patch can go actually
upstream if accepted since it is not RT specific. If you have a good
use case please submit please post it upstream and CC me. Once accepted
I would pull it in -RT as well.

> Yes, they are function traces without that patch applied. Every single
> line in the file has a preempt count of at least 1.

What I tried to figure out whether dropping RT prio alone solves the
problem or if have additionally long preempt-disable regions. Based on
your feedback you don't have long preempt-disable regions.

> Brian

Sebastian
