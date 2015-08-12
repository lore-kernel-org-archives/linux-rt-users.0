From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v4] iio: adc: xilinx-xadc: Push interrupts into hardirq
 context
Date: Wed, 12 Aug 2015 17:17:37 +0200
Message-ID: <55CB6391.7060502@metafoo.de>
References: <55C07160.5040907@metafoo.de> <1439334049-28671-1-git-send-email-xander.huff@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org, nathan.sullivan-acOepvfBmUk@public.gmane.org,
	jaeden.amero-acOepvfBmUk@public.gmane.org
To: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439334049-28671-1-git-send-email-xander.huff-acOepvfBmUk@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On 08/12/2015 01:00 AM, Xander Huff wrote:
> The driver currently registers a pair of irq handlers using
> request_threaded_irq(), however the synchronization mechanism between the
> hardirq and the threadedirq handler is a regular spinlock.
> 
> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
> and is thus not able to be acquired from a hardirq handler. This patch gets
> rid of the threaded handler and pushes all interrupt handling into the
> hardirq context, and uses request_irq().
> 
> To validate that this change has no impact on RT performance, here are
> cyclictest values with no processes running:
> 
> $ sudo cyclictest -S -m -p 98
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.00 0.01 0.05 1/174 2539
> T: 0 ( 1405) P:98 I:1000 C:167010520 Min: 9 Act: 12 Avg: 12 Max: 75
> T: 1 ( 1862) P:98 I:1500 C:111340339 Min: 9 Act: 12 Avg: 12 Max: 73
> 
> Then, all xadc raw handles were accessed in a continuous loop via
> /sys/bus/iio/devices/iio:device0:
> 
> $ sudo cyclictest -S -m -p 98
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 7.84 7.70 7.63 3/182 4260
> T: 0 ( 2559) P:98 I:1000 C:241557018 Min: 11 Act: 18 Avg: 21 Max: 74
> T: 1 ( 2560) P:98 I:1500 C:161038006 Min: 10 Act: 21 Avg: 20 Max: 73
> 
> Signed-off-by: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
