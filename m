From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] timers: prepare for full preemption improve
Date: Fri, 7 Jun 2013 10:32:26 +0200
Message-ID: <20130607083226.GA10280@linutronix.de>
References: <516E6EF0.3080309@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de,
	rostedt@goodmis.org
To: Zhao Hongjiang <zhaohongjiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44864 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab3FGIc2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 04:32:28 -0400
Content-Disposition: inline
In-Reply-To: <516E6EF0.3080309@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Zhao Hongjiang | 2013-04-17 17:44:16 [+0800]:

>wake_up should do nothing on the nort, so we should use wakeup_timer_waiters,
>also fix a spell mistake.
>
>Signed-off-by: Zhao Hongjiang <zhaohongjiang@huawei.com>

Applied. I added CONFIG_PREEMPT_RT_FULL instead of
CONFIG_PREEMPT_RT_BASE because wakeup_timer_waiters() is defined under
CONFIG_PREEMPT_RT_FULL.

Sebastian
