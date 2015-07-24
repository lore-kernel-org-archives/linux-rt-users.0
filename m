From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
Date: Fri, 24 Jul 2015 14:38:54 +0200
Message-ID: <55B231DE.4080308@metafoo.de>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com> <1437434050-32907-1-git-send-email-xander.huff@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
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
In-Reply-To: <1437434050-32907-1-git-send-email-xander.huff-acOepvfBmUk@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

Sorry, but I don't think this patch has been sufficiently tested against a 
mainline kernel. The driver wont even probe the way it is right now.

On 07/21/2015 01:14 AM, Xander Huff wrote:
> The driver currently registers a pair of irq handlers using
> request_threaded_irq(), however the synchronization mechanism between the
> hardirq and the threadedirq handler is a regular spinlock.

If everything runs in threaded context we don't really need the spinlock 
anymore and can use the mutex throughout.

>
> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
> and is thus not able to be acquired from a hardirq handler. This patch gets
> rid of the hardirq handler and pushes all interrupt handling into the
> threaded context.

We actually might as well run everything in the hardirq handler (which will 
be threaded in PREEMPT_RT). The reason why we have the threaded handler is 
because xadc_handle_event() used to sleep, but it doesn't do this anymore.

> Signed-off-by: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>
> ---
>   drivers/iio/adc/xilinx-xadc-core.c | 37 ++++++++-----------------------------
>   1 file changed, 8 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index ce93bd8..e16afdb 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -267,40 +267,15 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
>   	xadc_zynq_update_intmsk(xadc, 0, 0);
>
>   	spin_unlock_irq(&xadc->lock);
> -
> -	/* if still pending some alarm re-trigger the timer */
> -	if (xadc->zynq_masked_alarm) {
> -		schedule_delayed_work(&xadc->zynq_unmask_work,
> -				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
> -	}
>   }
>
>   static irqreturn_t xadc_zynq_threaded_interrupt_handler(int irq, void *devid)
>   {
>   	struct iio_dev *indio_dev = devid;
>   	struct xadc *xadc = iio_priv(indio_dev);
> -	unsigned int alarm;
> -
> -	spin_lock_irq(&xadc->lock);
> -	alarm = xadc->zynq_alarm;
> -	xadc->zynq_alarm = 0;
> -	spin_unlock_irq(&xadc->lock);
> -
> -	xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(alarm));
> -
> -	/* unmask the required interrupts in timer. */
> -	schedule_delayed_work(&xadc->zynq_unmask_work,
> -			msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
> -

With nobody scheduling the unmask worker interrupts will stay disabled 
indefinitely after they fired once, that's not very useful.

> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
> -{
> -	struct iio_dev *indio_dev = devid;
> -	struct xadc *xadc = iio_priv(indio_dev);
>   	irqreturn_t ret = IRQ_HANDLED;
>   	uint32_t status;
> +	unsigned int alarm;
>
>   	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
>
> @@ -312,7 +287,6 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
>   	spin_lock(&xadc->lock);
>
>   	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
> -
>   	if (status & XADC_ZYNQ_INT_DFIFO_GTH) {
>   		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
>   			XADC_ZYNQ_INT_DFIFO_GTH);
> @@ -330,8 +304,14 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
>   		xadc_zynq_update_intmsk(xadc, 0, 0);
>   		ret = IRQ_WAKE_THREAD;
>   	}
> +
> +	alarm = xadc->zynq_alarm;
> +	xadc->zynq_alarm = 0;

With all running in the same handler we don't need those anymore.

> +
>   	spin_unlock(&xadc->lock);
>
> +	xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(alarm));
> +
>   	return ret;
>   }
>
> @@ -436,7 +416,6 @@ static const struct xadc_ops xadc_zynq_ops = {
>   	.write = xadc_zynq_write_adc_reg,
>   	.setup = xadc_zynq_setup,
>   	.get_dclk_rate = xadc_zynq_get_dclk_rate,
> -	.interrupt_handler = xadc_zynq_interrupt_handler,

The corresponding field should be removed from the xadc_ops struct and then 
you'll also notice that interrupts now don't work anymore for the AXI 
interface version.

>   	.threaded_interrupt_handler = xadc_zynq_threaded_interrupt_handler,
>   	.update_alarm = xadc_zynq_update_alarm,
>   };
> @@ -1225,7 +1204,7 @@ static int xadc_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_free_samplerate_trigger;
>
> -	ret = request_threaded_irq(irq, xadc->ops->interrupt_handler,
> +	ret = request_threaded_irq(irq, NULL,
>   				xadc->ops->threaded_interrupt_handler,
>   				0, dev_name(&pdev->dev), indio_dev);
>   	if (ret)
>
