From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: thread load balancing on dual CPU Multicore AMD64 system
Date: Wed, 24 Oct 2007 21:26:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710242126070.13877@gandalf.stny.rr.com>
References: <47179170.7030802@siemens.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Gernot Hillier <gernot.hillier@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:58280 "EHLO
	ms-smtp-02.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbXJYB0x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2007 21:26:53 -0400
In-Reply-To: <47179170.7030802@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--

On Thu, 18 Oct 2007, Gernot Hillier wrote:

> Hi!
>
> We're currently evaluating whether PREEMPT_RT will work for a certain
> use case combining realtime and performance requirements running on a
> lot of CPUs and using a bunch of RAM.
>
> For first tests, we're running a "small" AMD64 test system with 2x2
> cores (2 CPUs with 2 cores each) with 8 GB of RAM.
>
> We wrote a small testcase which basically has one SCHED_FIFO "realtime"
> thread which does nothing but sleeping and checking if it wakes up at
> the right time. In addition, it spawns 20 low-prio "load threads"
> introducing a lot of malloc/memory access/free load on some GB of RAM.
>
> We can see, that the realtime requirements are fulfilled quite well (if
> using the current glibc with private futexes, but that's another story).
> The "rt thread" reacts within the expected timeframe with 2.6.22.1-rt9
> as well as with 2.6.23-rt1.
>
> However, what causes problems is the load balancing of the 20 threads
> over the available CPU cores:
>

The latest 2.6.23-rt3 (as well as -rt2) has new RT balancing code. Could
you try that to see if it solves you issues.

Thanks,

-- Steve
