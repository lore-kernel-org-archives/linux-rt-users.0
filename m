From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: Kernel thread's CPU affinity with isolcpus
 kernel boot argument
Date: Thu, 25 Feb 2016 12:13:46 -0300
Message-ID: <56CF1A2A.1050203@bristot.me>
References: <5698D4D0.3020907@etas.com>
 <20160225141806.GB16161@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mathias Koehrer <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpi-sp-245.kinghost.net ([177.185.201.245]:50945 "EHLO
	smtpi-sp-245.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbcBYPVs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 10:21:48 -0500
In-Reply-To: <20160225141806.GB16161@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 02/25/2016 11:18 AM, Sebastian Andrzej Siewior wrote:
> not that I am aware of. There are a few per-CPU threads which have to
> stay the way they are. I would have expected that others like kworker/u*
> respect the isol CPUs and stay away.

Isolcpus is applied only for user-space threads. For instance, you
still need to move rcu offload callbacks away from isolated CPUs, and
all other kernel threads as well.

In the special case of kworker/u* threads, you need to use a special
interface to do it. The interface is the following file:

/sys/devices/virtual/workqueue/cpumask

It was implemented on the following commit:

042f7df workqueue: Allow modifying low level unbound workqueue cpumask

But the default CPU mask is the "cpu_possible_mask".

Sometime ago I sent a patch to modify the default mask of the kworker/u*
threads, to avoid them on isolated CPUs by default, but it was not
acked. It was not explicitly nacked, though.

http://www.gossamer-threads.com/lists/linux/kernel/2218495

Should I try it again?

-- Daniel
