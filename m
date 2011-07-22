From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] rtc-tegra: properly initialize spinlock
Date: Fri, 22 Jul 2011 15:13:38 -0700
Message-ID: <20110722151338.9b1e9594.akpm@linux-foundation.org>
References: <1311323756-18013-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andrew Chew <achew@nvidia.com>, linux-rt-users@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, jkastner@redhat.com
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44994 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750956Ab1GVWOT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jul 2011 18:14:19 -0400
In-Reply-To: <1311323756-18013-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 22 Jul 2011 10:35:56 +0200
Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:

> Using __SPIN_LOCK_UNLOCKED for a dynamically allocated lock is wrong and
> breaks with PREEMPT_RT_FULL.

Please define "breaks".  Lockdep warnings?  Deadlocks?

> diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
> index 2fc31aa..75259fe 100644
> --- a/drivers/rtc/rtc-tegra.c
> +++ b/drivers/rtc/rtc-tegra.c
> @@ -343,7 +343,7 @@ static int __devinit tegra_rtc_probe(struct platform_device *pdev)
>  
>  	/* set context info. */
>  	info->pdev = pdev;
> -	info->tegra_rtc_lock = __SPIN_LOCK_UNLOCKED(info->tegra_rtc_lock);
> +	spin_lock_init(&info->tegra_rtc_lock);
>  
>  	platform_set_drvdata(pdev, info);
>  
> -- 
> 1.7.5.4
