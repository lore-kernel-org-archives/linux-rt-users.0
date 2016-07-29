From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: INFO: rcu_preempt detected stalls on CPUs/tasks
Date: Fri, 29 Jul 2016 18:46:58 +0200
Message-ID: <20160729164658.GH21715@linutronix.de>
References: <FC629F1A536C6F42B960B5E32E20BD358C2466E3@exc2.buero.ginzinger.com>
 <20160714152703.GA12152@linutronix.de>
 <150d1d1f-b427-50be-524d-dbe80dd5523e@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Henri Roosen <henri.roosen@ginzinger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:52007 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbcG2QrA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2016 12:47:00 -0400
Content-Disposition: inline
In-Reply-To: <150d1d1f-b427-50be-524d-dbe80dd5523e@ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Henri Roosen | 2016-07-15 12:54:25 [+0200]:

>The problem is easily triggered, but only after starting a flood-ping to
>the PREEMPT_RT-system under test. This also results in huge latency,
>much bigger than on a 'normal' PREEMPT-system, which seems to be
>resistant against the flood-ping.
>
>Any suggestions how to best trace this down?

Hmm. 4.1.27-rt30 has
 softirq: split timer softirqs out of ksoftirqd
 net: provide a way to delegate processing a softirq to ksoftirqd

I would suggest using those two but you should have them.
Your ksoftirqd runs as SCHED_OTHER, right? And you do have
CONFIG_RCU_BOOST enabled? Your do_hell script which starts hackbench
does not run with higher priority?
>From the backtrace it is hackbench "doing things" and this one should be
preempted by RCU and ethernet networking napi code should be preempted /
moved to ksoftirqd during the flood-ping. Can you check this happens?

>Thanks,
>Henri

Sebastian
