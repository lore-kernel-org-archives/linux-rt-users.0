From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] allow preemption in recursive migrate_disable call
Date: Fri, 22 Nov 2013 18:37:51 +0100
Message-ID: <20131122173750.GJ8698@linutronix.de>
References: <20131120003333.GA13545@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46436 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806Ab3KVRhv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 12:37:51 -0500
Content-Disposition: inline
In-Reply-To: <20131120003333.GA13545@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nicholas Mc Guire | 2013-11-20 01:33:33 [+0100]:

> Minor cleanup in migrate_disable/migrate_enable. The recursive case
> does not need to disable preemption as it is "pinned" to the current
> cpu any way so it is safe to preempt it.
>
> No functional change to migrate_disable/enable
applied but I dropped this line^

>
>Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>

Sebastian
