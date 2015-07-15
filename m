From: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
Date: Wed, 15 Jul 2015 10:57:44 -0500
Message-ID: <55A682F8.3090001@ni.com>
References: <5574633F.7090004@kernel.org>	<1436391502-2604-1-git-send-email-xander.huff@ni.com> <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org,
	nathan.sullivan-acOepvfBmUk@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jaeden.amero-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org,
	michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On 7/9/2015 12:03 AM, Shubhrajyoti Datta wrote:
>     @@ -330,8 +310,18 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq,
>     void *devid)
>                      xadc_zynq_update_intmsk(xadc, 0, 0);
>                      ret = IRQ_WAKE_THREAD;
>              }
>     +
>     +       alarm = xadc->zynq_alarm;
>     +       xadc->zynq_alarm = 0;
>     +
>              spin_unlock(&xadc->lock);
>
>     +       xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(alarm));
>     +
>     +       /* unmask the required interrupts in timer. */
>     +       schedule_delayed_work(&xadc->zynq_unmask_work,
>     +                       msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
>     +
>
> Now that we are in the threaded context do we need the  work queue stuff.
Seems reasonable to try to remove it. I'll do some testing and send out a v3 if 
it works, thanks.

-- 
Xander Huff
Staff Software Engineer
National Instruments
