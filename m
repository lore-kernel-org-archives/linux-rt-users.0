From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [ANNOUNCE] 4.1.46-rt52
Date: Mon, 11 Dec 2017 15:01:39 -0600
Message-ID: <ac092a6e-baaa-9f2f-3655-fc6942d676af@mvista.com>
References: <20171129231317.GB1361@jcartwri.amer.corp.natinst.com>
 <7b0d39d5-91ab-c8f0-bfec-7e26e71395bd@mvista.com>
 <20171211202017.GA19068@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41891 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdLKVBl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Dec 2017 16:01:41 -0500
Received: by mail-ot0-f196.google.com with SMTP id b54so15945250otd.8
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Dec 2017 13:01:41 -0800 (PST)
In-Reply-To: <20171211202017.GA19068@jcartwri.amer.corp.natinst.com>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/11/2017 02:20 PM, Julia Cartwright wrote:
> On Mon, Dec 11, 2017 at 01:04:58PM -0600, Corey Minyard wrote:
>> On 11/29/2017 05:13 PM, Julia Cartwright wrote:
>>> Hello RT Folks!
>>>
>>> I'm pleased to announce the 4.1.46-rt52 stable release.
>>>
>>> You can get this release via the git tree at:
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>>>
>>>     branch: v4.1-rt
>>>     Head SHA1: 6e737a91c1ce923d4e10db831e14cfef9a2459cc
>>>
>>> Or to build 4.1.46-rt52 directly, the following patches should be applied:
>>>
>>>     https://urldefense.proofpoint.com/v2/url?u=http-3A__www.kernel.org_pub_linux_kernel_v4.x_linux-2D4.1.tar.xz&d=DwICaQ&c=I_0YwoKy7z5LMTVdyO6YCiE2uzI1jjZZuIPelcSjixA&r=cAXq_8W9Othb2h8ZcWv8Vw&m=a5KTpX9A0-pHwmQkOOLr5_xeWPavI-lgN7Z0Goes2So&s=tGmSNpZKEKvhTpeVu_ktmD4I5PIXfIJhZ79DxwbCjtQ&e=
>>>
>>>     https://urldefense.proofpoint.com/v2/url?u=http-3A__www.kernel.org_pub_linux_kernel_v4.x_patch-2D4.1.46.xz&d=DwICaQ&c=I_0YwoKy7z5LMTVdyO6YCiE2uzI1jjZZuIPelcSjixA&r=cAXq_8W9Othb2h8ZcWv8Vw&m=a5KTpX9A0-pHwmQkOOLr5_xeWPavI-lgN7Z0Goes2So&s=hx9pHgRy7tWhUeeiJhPOH0T8qdDrhtZvWxOWuIBZZgs&e=
>>>
>>>     https://urldefense.proofpoint.com/v2/url?u=http-3A__www.kernel.org_pub_linux_kernel_projects_rt_4.1_patch-2D4.1.46-2Drt52.patch.xz&d=DwICaQ&c=I_0YwoKy7z5LMTVdyO6YCiE2uzI1jjZZuIPelcSjixA&r=cAXq_8W9Othb2h8ZcWv8Vw&m=a5KTpX9A0-pHwmQkOOLr5_xeWPavI-lgN7Z0Goes2So&s=Pm8ed_xvW1drpPxNkt035bj6ILvSImuN9vvgEAt8IiM&e=
>>>
>>>
>>> You can also build from 4.1.46-rt51 by applying the incremental patch:
>>>
>>>     https://urldefense.proofpoint.com/v2/url?u=http-3A__www.kernel.org_pub_linux_kernel_projects_rt_4.1_incr_patch-2D4.1.46-2Drt51-2Drt52.patch.xz&d=DwICaQ&c=I_0YwoKy7z5LMTVdyO6YCiE2uzI1jjZZuIPelcSjixA&r=cAXq_8W9Othb2h8ZcWv8Vw&m=a5KTpX9A0-pHwmQkOOLr5_xeWPavI-lgN7Z0Goes2So&s=ZM64-JCd0WNFQgFlB3wbCfn8Jtf9rq5QyCO2-GJsC2Q&e=
>>>
>>> Enjoy!
>>>      Julia
>>>
>>> Changes from v4.1.46-rt51:
>>> ---
>>> Julia Cartwright (2):
>>>         workqueue: fixup rcu check for RT
>>>         Linux 4.1.46-rt52
>>>
>>> Sebastian Andrzej Siewior (2):
>>>         PM / CPU: replace raw_notifier with atomic_notifier (fixup)
>> This change breaks the compile of 4.1 on ARM (and other things using
>> kernel/cpu_pm.c).
>>
>> rcu_irq_enter_irqson() and friends doesn't exist in 4.1.  In fact,
>> rcu_irq_enter() doesn't even exist.
>>
>> Sorry I didn't get to testing this earlier, I've been focused on other things.
> Thanks!  My current builds apparently don't currently cover CPU_PM
> builds, so I didn't see this :(.  Thanks for the report.
>
> v4.1 does contain rcu_irq_enter(), and it looks like what we should be
> using in 4.1 instead.

Ah, it does, I looked in the wrong place.

> I'm thinking the below should be okay; I'll be standing up a proper cpu
> hotplugging test to give it some runtime.

The below should work.  You'll need an ARM64, ARM or MIPS system with 
the proper
config settings to exercise this code, though.

-corey

> Thanks,
>     Julia
>
> -- 8< --
> Subject: [PATCH] PM / CPU: replace usage of rcu_irq_{enter,exit}_irqson()
>
> Commit c50243950f97e ("PM / CPU: replace raw_notifier with
> atomic_notifier (fixup)") intended to fix up RCU usage in idle, by
> telling RCU to pay attention.
>
> However, the cherry-pick back from rt-devel included the invocation of
> the _irqson() variants of rcu_irq_{enter,exit}() API which doesn't exist
> in 4.1.
>
> For 4.1, just simply drop the _irqson() variant, and instead use
> rcu_irq_{enter,exit}() directly instead.  This is safe, because in 4.1,
> these functions internally disable interrupts.
>
> Reported-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Julia Cartwright <julia@ni.com
> ---
>   kernel/cpu_pm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index d1d1c3961553..eeff3c382793 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -33,10 +33,10 @@ static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
>   	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
>   	 * RCU know this.
>   	 */
> -	rcu_irq_enter_irqson();
> +	rcu_irq_enter();
>   	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
>   		nr_to_call, nr_calls);
> -	rcu_irq_exit_irqson();
> +	rcu_irq_exit();
>   
>   	return notifier_to_errno(ret);
>   }


