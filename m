From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] x86: Fix an RT MCE crash
Date: Thu, 30 Jun 2016 09:43:01 -0400
Message-ID: <20160630094301.22d32ec1@gandalf.local.home>
References: <1467293089-27656-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
To: minyard@acm.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:53676 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751994AbcF3NnF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Jun 2016 09:43:05 -0400
In-Reply-To: <1467293089-27656-1-git-send-email-minyard@acm.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 30 Jun 2016 08:24:49 -0500
minyard@acm.org wrote:

> From: Corey Minyard <cminyard@mvista.com>
> 
> On some x86 systems an MCE interrupt would come in before the kernel
> was ready for it.  Looking at the latest RT code, it has similar
> (but not quite the same) code, except it adds a bool that tells if
> MCE handling is initialized.  Add the same bool for older versions.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  arch/x86/kernel/cpu/mcheck/mce.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> We noticed this issue on a new Broadwell system when we booted RT
> on it.  This patch is for 3.10, I'm not sure if it applies to
> other kernel versions.

Do you mean other 'older' versions? and that this works with the
versions after 3.10 without this patch?

-- Steve

> 
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index aaf4b9b..7125584 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -1365,6 +1365,7 @@ static void __mce_notify_work(void)
>  }
>  
>  #ifdef CONFIG_PREEMPT_RT_FULL
> +static bool notify_work_ready __read_mostly;
>  struct task_struct *mce_notify_helper;
>  
>  static int mce_notify_helper_thread(void *unused)
> @@ -1386,12 +1387,14 @@ static int mce_notify_work_init(void)
>  	if (!mce_notify_helper)
>  		return -ENOMEM;
>  
> +	notify_work_ready = true;
>  	return 0;
>  }
>  
>  static void mce_notify_work(void)
>  {
> -	wake_up_process(mce_notify_helper);
> +	if (notify_work_ready)
> +		wake_up_process(mce_notify_helper);
>  }
>  #else
>  static void mce_notify_work(void)

