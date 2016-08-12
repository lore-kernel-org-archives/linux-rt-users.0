From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [v4.1-rt PATCH] RM: lazy-preempt: add missed
 TIF_NEED_RESCHED_LAZY to _TIF_WORK_MASK
Date: Fri, 12 Aug 2016 20:22:13 +0300
Message-ID: <43ee1070-e0f3-f0bf-f861-299e15de2505@ti.com>
References: <20160812171416.11322-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:49778 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbcHLRW0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Aug 2016 13:22:26 -0400
In-Reply-To: <20160812171416.11322-1-grygorii.strashko@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Pls, ignore this.

On 08/12/2016 08:14 PM, Grygorii Strashko wrote:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> The flag TIF_NEED_RESCHED_LAZY is missed in _TIF_WORK_MASK [1], so add it.
>
> [1] http://www.spinics.net/lists/linux-rt-users/msg14450.html
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
> ---
>  arch/arm/include/asm/thread_info.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index b5a6163..bc99bd3 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -178,7 +178,8 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
>   * Change these and you break ASM code in entry-common.S
>   */
>  #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
> -				 _TIF_NOTIFY_RESUME | _TIF_UPROBE)
> +				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
> +				 _TIF_NEED_RESCHED_LAZY)
>
>  #endif /* __KERNEL__ */
>  #endif /* __ASM_ARM_THREAD_INFO_H */
>


-- 
regards,
-grygorii
