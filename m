From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: cyclictest better values with system load than without
 (OMAP3530 target)
Date: Fri, 29 Nov 2013 13:56:23 +0100
Message-ID: <20131129125623.GB31099@linutronix.de>
References: <5294681E.10406@gmail.com>
 <20131126101232.21636c8f@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Roese <stefan.roese@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33685 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3K2M4Z (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 07:56:25 -0500
Content-Disposition: inline
In-Reply-To: <20131126101232.21636c8f@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Clark Williams | 2013-11-26 10:12:32 [-0600]:

>In my experience (on x86_64 mainly), that behavior (worse times when
>not under load) is due to the overhead of coming out of power-save/idle
>states. When you've got a big load on the system and all the cores are
>active, then the power-save logic and/or the idle logic doesn't kick in
>and devices aren't being powered down.
This is the case here, too. The overhead comming out of a deep power
state plus the invalidated caches.

>Do you know if your OMAP has power-save logic available? Alternatively
>do you know how expensive the idle mechanism is? Have you tried booting
>with idle=poll then measuring without a load?

idle=pull is x86 only. Disable the complete PM stuff should solve the
issue. You could go via arch_cpu_idle() to check what is used.
The idle routine should come either via cpuidle_idle_call() or arm_pm_idle().

>Clark

Sebastian
