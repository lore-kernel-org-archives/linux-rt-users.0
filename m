From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: question about rcuc/X tasks
Date: Thu, 15 Dec 2016 14:47:37 +0100
Message-ID: <518a5f66-76d0-e356-b08b-bde2a7a17bb2@bristot.me>
References: <584F27B8.2090406@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Chris Friesen <chris.friesen@windriver.com>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpi-sp-238.kinghost.net ([177.185.201.238]:41411 "EHLO
        smtpi-sp-238.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757466AbcLONyy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2016 08:54:54 -0500
In-Reply-To: <584F27B8.2090406@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Chris,

On 12/12/2016 11:42 PM, Chris Friesen wrote:
> Based on the fact that Documentation/kernel-per-CPU-kthreads.txt
> describes CONFIG_RCU_NOCB_CPU_ALL=y as a solution by preventing the
> rcuc/%u kthreads from having any work to do, I had expected that the
> "rcu_nocbs=1-15" kernel parameter would have a similar effect.

As far as I recall, using CONFIG_RCU_NOCB_CPU_ALL=y will prevent the RCU
callbacks from running on rcuc/X threads (which are pinned to the CPU
X), but the rcuc/X thread is still in charge of awaking the ruco*
threads of the CPU X.

> Does anyone have any idea what's going on here, and how I can prevent
> the rcuc/<cpu> tasks from waking up?

You can try to use rcu_nocb_poll kernel parameter to unload the rcuc/X
thread of the task of awaking its respective ruco*s threads.

>From [1]:

rcu_nocb_poll	[KNL]
			Rather than requiring that offloaded CPUs
			(specified by rcu_nocbs= above) explicitly
			awaken the corresponding "rcuoN" kthreads,
			make these kthreads poll for callbacks.
			This improves the real-time response for the
			offloaded CPUs by relieving them of the need to
			wake up the corresponding kthread, but degrades
			energy efficiency by requiring that the kthreads
			periodically wake up to do the polling.

[1] https://www.kernel.org/doc/Documentation/kernel-parameters.txt

-- Daniel
