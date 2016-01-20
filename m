From: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 8/9] drivers/cpuidle: coupled: fix warning cpuidle_coupled_lock
Date: Wed, 20 Jan 2016 22:28:30 +0100
Message-ID: <CAK--WWNA5kXNyf4048wRhqDVSO-9jkR2Ko25Wvtr3Ns3R65Mmg@mail.gmail.com>
References: <1452885673-30891-9-git-send-email-anders.roxell@linaro.org>
	<20160118170209.GA12309@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
	ccross@android.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34262 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbcATV2b (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2016 16:28:31 -0500
Received: by mail-io0-f178.google.com with SMTP id 1so33932932ion.1
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jan 2016 13:28:31 -0800 (PST)
In-Reply-To: <20160118170209.GA12309@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 18 January 2016 at 18:02, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Anders Roxell | 2016-01-15 20:21:12 [+0100]:
>
>>Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
>>warning without this fix:
>>../drivers/cpuidle/coupled.c:122:21: warning: 'cpuidle_coupled_lock'
>>defined but not used [-Wunused-variable]
>>
>>Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> Could you please forward this patch upstream? The driver was introduced
> in 4126c0197bc8 ("cpuidle: add support for states that affect multiple
> cpus") with the cpuidle_coupled_lock variable unused. This is not -RT
> specific.

Yes, I'll do that.

Cheers,
Anders

>
>>---
>> drivers/cpuidle/coupled.c | 1 -
>> 1 file changed, 1 deletion(-)
>>
>>diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
>>index 344058f..d5657d5 100644
>>--- a/drivers/cpuidle/coupled.c
>>+++ b/drivers/cpuidle/coupled.c
>>@@ -119,7 +119,6 @@ struct cpuidle_coupled {
>>
>> #define CPUIDLE_COUPLED_NOT_IDLE      (-1)
>>
>>-static DEFINE_MUTEX(cpuidle_coupled_lock);
>> static DEFINE_PER_CPU(struct call_single_data, cpuidle_coupled_poke_cb);
>>
>> /*
>
> Sebastian
