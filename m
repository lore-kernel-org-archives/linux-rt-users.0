From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH][RFC] kernel/cpu: do not change the cpus_allowed of the
 current task when unplugging cpus
Date: Fri, 7 Jun 2013 11:05:43 +0200
Message-ID: <20130607090543.GD10280@linutronix.de>
References: <1368699439-13034-1-git-send-email-chenhui.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, leoli@freescale.com, scottwood@freescale.com,
	Priyanka.Jain@freescale.com
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45122 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3FGJFo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Jun 2013 05:05:44 -0400
Content-Disposition: inline
In-Reply-To: <1368699439-13034-1-git-send-email-chenhui.zhao@freescale.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Zhao Chenhui | 2013-05-16 18:17:19 [+0800]:

>We found a problem. When a cpu is brought down using _cpu_down(),
>the corresponding cpu bit in the cpus_allowed of the current task is
>cleared. But this bit will not be set when the same cpu is online again.
>Then, the current task and its child processes will not be allowed to
>run on this cpu.

Isn't this what should happen? This also happens on mainline if you
leave the RT bits out, right? You should be able to put the task back on
the CPU once the CPU is up again.

Sebastian
