From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] iio: adc: xilinx-xadc: Push interrupts into hardirq
 context
Date: Sat, 15 Aug 2015 20:55:22 +0100
Message-ID: <55CF992A.5040505@kernel.org>
References: <55C07160.5040907@metafoo.de>
 <1439334049-28671-1-git-send-email-xander.huff@ni.com>
 <55CB6391.7060502@metafoo.de> <55CB7558.3090608@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org, nathan.sullivan-acOepvfBmUk@public.gmane.org,
	jaeden.amero-acOepvfBmUk@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55CB7558.3090608-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On 12/08/15 17:33, Sebastian Andrzej Siewior wrote:
> On 08/12/2015 05:17 PM, Lars-Peter Clausen wrote:
>> On 08/12/2015 01:00 AM, Xander Huff wrote:
>>> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
>>> and is thus not able to be acquired from a hardirq handler. This patch gets
>>> rid of the threaded handler and pushes all interrupt handling into the
>>> hardirq context, and uses request_irq().
>>>
>>> To validate that this change has no impact on RT performance, here are
>>> cyclictest values with no processes running:
>>
>> Looks good, thanks.
>>
>> Acked-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> 
> Yes, I'm fine with the rework, too.
Formal Acked-by would be good but I'll take this on the basis of Lars' one
and that the code clearly should work from a read through.

Applied to the togreg branch of iio.git.  Thanks for following through
the various twists of this one. Will initially be pushed out as testing.
Note this has almost certainly (unless Linus announces a delay) missed the
upcoming merge window so will be lined up for the 4.4 one.

Jonathan
> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
