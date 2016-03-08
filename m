From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH] sc16is7xx: drop bogus use of IRQF_ONESHOT
Date: Tue, 8 Mar 2016 13:43:27 +0100
Message-ID: <56DEC8EF.2060904@prevas.dk>
References: <20160218084634.017c3ab4@laptop>
 <1455816372-13989-1-git-send-email-joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-serial@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: Josh Cartwright <joshc@ni.com>, Jakub Kicinski <moorray3@wp.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455816372-13989-1-git-send-email-joshc@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 2016-02-18 18:26, Josh Cartwright wrote:
> The use of IRQF_ONESHOT when registering an interrupt handler with
> request_irq() is non-sensical.
>
> Not only that, it also prevents the handler from being threaded when it
> otherwise should be w/ IRQ_FORCED_THREADING is enabled.  This causes the
> following deadlock observed by Sean Nyekjaer on -rt:
>
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> [..]
>     rt_spin_lock_slowlock from (queue_kthread_work+0x18/0x74)
>     queue_kthread_work) from (sc16is7xx_irq+0x10/0x18 [sc16is7xx])
>     sc16is7xx_irq [sc16is7xx]) from (handle_irq_event_percpu+0x70/0x158)
>     handle_irq_event_percpu) from (handle_irq_event+0x68/0xa8)
>     handle_irq_event) from (handle_level_irq+0x10c/0x184)
>     handle_level_irq) from (generic_handle_irq+0x2c/0x3c)
>     generic_handle_irq) from (mxc_gpio_irq_handler+0x3c/0x108)
>     mxc_gpio_irq_handler) from (mx3_gpio_irq_handler+0x80/0xcc)
>     mx3_gpio_irq_handler) from (generic_handle_irq+0x2c/0x3c)
>     generic_handle_irq) from (__handle_domain_irq+0x7c/0xe8)
>     __handle_domain_irq) from (gic_handle_irq+0x24/0x5c)
>     gic_handle_irq) from (__irq_svc+0x40/0x88)
>     (__irq_svc) from (rt_spin_unlock+0x1c/0x68)
>     (rt_spin_unlock) from (kthread_worker_fn+0x104/0x17c)
>     (kthread_worker_fn) from (kthread+0xd0/0xe8)
>     (kthread) from (ret_from_fork+0x14/0x2c)
>
> Reported-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Fixes: 9e6f4ca3e567 ("sc16is7xx: use kthread_worker for tx_work and irq")
> Cc: stable@vger.kernel.org # v4.1+
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>   drivers/tty/serial/sc16is7xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index e78fa99..1bb5c0e 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1257,7 +1257,7 @@ static int sc16is7xx_probe(struct device *dev,
>   
>   	/* Setup interrupt */
>   	ret = devm_request_irq(dev, irq, sc16is7xx_irq,
> -			       IRQF_ONESHOT | flags, dev_name(dev), s);
> +			       flags, dev_name(dev), s);
>   	if (!ret)
>   		return 0;
>   
Is PATCH this dropped?
It clearly fixes the irq when running with RT patches :-)

/Sean
