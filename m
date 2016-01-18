From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 9/9] driver/gpio: gpio-omap: fix incompatible pointer type
Date: Mon, 18 Jan 2016 16:29:21 +0200
Message-ID: <569CF6C1.5010106@ti.com>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
 <1452885673-30891-10-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <khilman@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39980 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755267AbcARO3c (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 09:29:32 -0500
In-Reply-To: <1452885673-30891-10-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/15/2016 09:21 PM, Anders Roxell wrote:
> Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
> warning without this fix:
> ../drivers/gpio/gpio-omap.c: In function 'omap_gpio_runtime_resume':
> ../drivers/gpio/gpio-omap.c:1398:4: warning: passing argument 1 of
>      'rt_spin_unlock' from incompatible pointer type [enabled by default]
> In file included from ../include/linux/spinlock.h:290:0,
>                   from ../include/linux/seqlock.h:35,
>                   from ../include/linux/time.h:5,
>                   from ../include/linux/stat.h:18,
>                   from ../include/linux/module.h:10,
>                   from ../drivers/gpio/gpio-omap.c:16:
> ../include/linux/spinlock_rt.h:24:56: note: expected
>      'struct spinlock_t *' but argument is of type 'struct raw_spinlock_t *'
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   drivers/gpio/gpio-omap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 004888b..f3028e7 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1395,7 +1395,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
>   		if (c != bank->context_loss_count) {
>   			omap_gpio_restore_context(bank);
>   		} else {
> -			spin_unlock_irqrestore(&bank->lock, flags);
> +			raw_spin_unlock_irqrestore(&bank->lock, flags);
>   			return 0;
>   		}
>   	}
> 

This patch is not required since I've asked Sebastian to revert patch
caused this warning.

-- 
regards,
-grygorii
