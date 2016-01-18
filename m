From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 8/9] drivers/cpuidle: coupled: fix warning
 cpuidle_coupled_lock
Date: Mon, 18 Jan 2016 18:02:09 +0100
Message-ID: <20160118170209.GA12309@linutronix.de>
References: <1452885673-30891-9-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	ccross@android.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47664 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbcARRCP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 12:02:15 -0500
Content-Disposition: inline
In-Reply-To: <1452885673-30891-9-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Anders Roxell | 2016-01-15 20:21:12 [+0100]:

>Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
>warning without this fix:
>../drivers/cpuidle/coupled.c:122:21: warning: 'cpuidle_coupled_lock'
>defined but not used [-Wunused-variable]
>
>Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Could you please forward this patch upstream? The driver was introduced
in 4126c0197bc8 ("cpuidle: add support for states that affect multiple
cpus") with the cpuidle_coupled_lock variable unused. This is not -RT
specific.

>---
> drivers/cpuidle/coupled.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
>index 344058f..d5657d5 100644
>--- a/drivers/cpuidle/coupled.c
>+++ b/drivers/cpuidle/coupled.c
>@@ -119,7 +119,6 @@ struct cpuidle_coupled {
> 
> #define CPUIDLE_COUPLED_NOT_IDLE	(-1)
> 
>-static DEFINE_MUTEX(cpuidle_coupled_lock);
> static DEFINE_PER_CPU(struct call_single_data, cpuidle_coupled_poke_cb);
> 
> /*

Sebastian
