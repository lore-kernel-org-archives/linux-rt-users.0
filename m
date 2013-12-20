From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v2 PATCH] rcutree/rcu_bh_qs: disable irq while calling
 rcu_preempt_qs()
Date: Fri, 20 Dec 2013 14:30:42 +0100
Message-ID: <20131220133042.GC10249@linutronix.de>
References: <1387360309-12801-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org
To: Tiejun Chen <tiejun.chen@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60983 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161017Ab3LTNap (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Dec 2013 08:30:45 -0500
Content-Disposition: inline
In-Reply-To: <1387360309-12801-1-git-send-email-tiejun.chen@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Tiejun Chen | 2013-12-18 17:51:49 [+0800]:

>Any callers to the function rcu_preempt_qs() must disable irqs in
>order to protect the assignment to ->rcu_read_unlock_special. In
>RT case, rcu_bh_qs() as the wrapper of rcu_preempt_qs() is called
>in some scenarios where irq is enabled, like this path,
>
>do_single_softirq()
>    |
>    + local_irq_enable();
>    + handle_softirq()
>    |    |
>    |    + rcu_bh_qs()
>    |        |
>    |        + rcu_preempt_qs()
>    |
>    + local_irq_disable()
>
>So here we'd better disable irq directly inside of rcu_bh_qs() to
>fix this, otherwise the kernel may be freezable sometimes as
>observed. And especially this way is also kind and safe for the
>potential rcu_bh_qs() usage elsewhere in the future.
>
>Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>Signed-off-by: Bin Jiang <bin.jiang@windriver.com>
Applied.

Sebastian
