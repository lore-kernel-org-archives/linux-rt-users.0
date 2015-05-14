From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH] iio: adc: xilinx-xadc: Convert to raw spinlock
Date: Thu, 14 May 2015 19:10:38 +0200
Message-ID: <20150514171038.GG13442@linutronix.de>
References: <1431013090-18996-1-git-send-email-xander.huff@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org,
	pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben.shelton-acOepvfBmUk@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org
To: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431013090-18996-1-git-send-email-xander.huff-acOepvfBmUk@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

* Xander Huff | 2015-05-07 10:38:10 [-0500]:

>The driver currently registers a pair of irq handlers using
>request_threaded_irq(), however the synchronization mechanism
>between the hardirq and the threadedirq handler is a regular spinlock.
>
>Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can
>sleep, and is thus not able to be acquired from a hardirq handler.
>Because the set of operations performed under the spinlock is already
>minimal and bounded, it is a suitable candidate for being a raw_spinlock.
>
>This patch should not impact behavior on !PREEMPT_RT builds.
>
>Signed-off-by: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>
>Reviewed-by: Joe Hershberger <joe.hershberger-acOepvfBmUk@public.gmane.org>
>Reviewed-by: Ben Shelton <ben.shelton-acOepvfBmUk@public.gmane.org>
>Reviewed-by: Josh Cartwright <joshc-acOepvfBmUk@public.gmane.org>

Do you have any cyclictest numbers how much the latency increases on
heavy iio usage? Traditionally the primary handler should be very quick
/ short.

Sebastian
