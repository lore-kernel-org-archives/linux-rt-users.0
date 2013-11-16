From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v1][PATCH] cpu_down: move migrate_enable() back
Date: Sat, 16 Nov 2013 14:05:00 +0100
Message-ID: <20131116130500.GB11518@linutronix.de>
References: <1383789967-5885-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, stable-rt@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Tiejun Chen <tiejun.chen@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44048 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab3KPNFD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Nov 2013 08:05:03 -0500
Content-Disposition: inline
In-Reply-To: <1383789967-5885-1-git-send-email-tiejun.chen@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Tiejun Chen | 2013-11-07 10:06:07 [+0800]:

>Commit 08c1ab68, "hotplug-use-migrate-disable.patch", intends to
>use migrate_enable()/migrate_disable() to replace that combination
>of preempt_enable() and preempt_disable(), but actually in
>!CONFIG_PREEMPT_RT_FULL case, migrate_enable()/migrate_disable()
>are still equal to preempt_enable()/preempt_disable(). So that
>followed cpu_hotplug_begin()/cpu_unplug_begin(cpu) would go schedule()
>to trigger schedule_debug() like this:
>
>_cpu_down()
>	|
>	+ migrate_disable() = preempt_disable()
>	|
>	+ cpu_hotplug_begin() or cpu_unplug_begin()
>		|
>		+ schedule()
>			|
>			+ __schedule()
>				|
>				+ preempt_disable();
>				|
>				+ __schedule_bug() is true!
>
>So we should move migrate_enable() as the original scheme.
>
>Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>

applied.

Sebastian
