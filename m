From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH v4] iio: adc: xilinx-xadc: Push interrupts into hardirq
 context
Date: Wed, 12 Aug 2015 18:33:28 +0200
Message-ID: <55CB7558.3090608@linutronix.de>
References: <55C07160.5040907@metafoo.de> <1439334049-28671-1-git-send-email-xander.huff@ni.com> <55CB6391.7060502@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org, nathan.sullivan-acOepvfBmUk@public.gmane.org,
	jaeden.amero-acOepvfBmUk@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55CB6391.7060502-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On 08/12/2015 05:17 PM, Lars-Peter Clausen wrote:
> On 08/12/2015 01:00 AM, Xander Huff wrote:
>> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
>> and is thus not able to be acquired from a hardirq handler. This patch gets
>> rid of the threaded handler and pushes all interrupt handling into the
>> hardirq context, and uses request_irq().
>>
>> To validate that this change has no impact on RT performance, here are
>> cyclictest values with no processes running:
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>

Yes, I'm fine with the rework, too.

Sebastian
