From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCHv2] drivers: i2c: exynos5: irq spinlock rt-safe
Date: Thu, 3 Sep 2015 23:31:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509032319570.15006@nanos>
References: <1440489125-20082-1-git-send-email-anders.roxell@linaro.org> <1441314363-9836-1-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org,
	ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441314363-9836-1-git-send-email-anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 3 Sep 2015, Anders Roxell wrote:

> The current spin_lock_irqsave() protects the enabling of the device
> interrupt.  In order to prevent recursion in the case of sleeping
> spinlocks (e.g. with RT patch, stacktrace below), convert the spin lock
> to a raw spin lock. No change for !RT kernels.
> 
> [   10.992238] kernel BUG at ../kernel/locking/rtmutex.c:998!
> [   10.992243] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> [   10.992250] Modules linked in:
> [   10.992258] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.1.5-rt5
> [   10.992263] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   10.992268] task: ed880000 ti: ed888000 task.ti: ed888000
> [   10.992281] PC is at rt_spin_lock_slowlock+0xa4/0x2ec
> [   10.992288] LR is at rt_spin_lock_slowlock+0x54/0x2ec
> [   10.992296] pc : [<c099e1bc>]    lr : [<c099e16c>]    psr: 60000193
> [   10.992296] sp : ed889a28  ip : ed880001  fp : 00000089
> [   10.992300] r10: ed889a28  r9 : c0f55654  r8 : 00000060
> [   10.992305] r7 : ed880000  r6 : 00000000  r5 : 00000001  r4 : ed9f7288
> [   10.992310] r3 : ed880000  r2 : 00000000  r1 : ed880000  r0 : 00000000
> [   10.992316] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> Segment kernel
> ...
> ...
> [   10.992662] [<c099e1bc>] (rt_spin_lock_slowlock) from [<c07bc794>]
> (exynos5_i2c_irq+0x20/0x2b0)
> [   10.992678] [<c07bc794>] (exynos5_i2c_irq) from [<c028c8b4>]
> (handle_irq_event_percpu+0x68/0x158)
> [   10.992690] [<c028c8b4>] (handle_irq_event_percpu) from [<c028ca0c>]
> (handle_irq_event+0x68/0xa8)
> [   10.992702] [<c028ca0c>] (handle_irq_event) from [<c028f9c4>]
> (handle_fasteoi_irq+0x11c/0x1d4)
> [   10.992713] [<c028f9c4>] (handle_fasteoi_irq) from [<c028c17c>]
> (generic_handle_irq+0x20/0x30)
> [   10.992724] [<c028c17c>] (generic_handle_irq) from [<c028c290>]
> (__handle_domain_irq+0x6c/0xe4)
> [   10.992734] [<c028c290>] (__handle_domain_irq) from [<c020a71c>]
> (gic_handle_irq+0x2c/0x68)
> [   10.992744] [<c020a71c>] (gic_handle_irq) from [<c0214140>]
> (__irq_svc+0x40/0x88)
> [   10.992749] Exception stack(0xed889b28 to 0xed889b70)

What you completely fail to explain how this can happen at all.

On RT the interrupt of that device is force threaded, but the handler
is called in hard interrupt context, which is wrong to begin with.

While the interrupt request in this driver is bogus:

        ret = devm_request_irq(&pdev->dev, i2c->irq, exynos5_i2c_irq,
                                IRQF_NO_SUSPEND | IRQF_ONESHOT,
                                dev_name(&pdev->dev), i2c);

because it sets the ONESHOT flag for no reason, it does not set the
NOTRHEAD flag which would prevent force threading.

Hmm?

	tglx
