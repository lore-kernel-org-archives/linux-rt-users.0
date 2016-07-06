From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v2] x86: Fix an RT MCE crash
Date: Wed, 6 Jul 2016 15:30:34 -0500
Message-ID: <577D6A6A.6060709@acm.org>
References: <1467831301-17233-1-git-send-email-minyard@acm.org>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Corey Minyard <cminyard@mvista.com>
To: Borislav Petkov <bp@alien8.de>, Luck@minyard.net,
	Tony <tony.luck@intel.com>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34645 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbcGFUbH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Jul 2016 16:31:07 -0400
Received: by mail-pa0-f66.google.com with SMTP id us13so21830829pab.1
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Jul 2016 13:30:38 -0700 (PDT)
In-Reply-To: <1467831301-17233-1-git-send-email-minyard@acm.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I forgot to mention that this applies to v3.2-rt, v3.4-rt,
v3.10-rt, v3.12-rt, and v3.14-rt.  I didn't see a v3.16-rt.

-corey

On 07/06/2016 01:55 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> On some x86 systems an MCE interrupt would come in before the kernel
> was ready for it.  Looking at the latest RT code, it has similar
> (but not quite the same) code, except it adds a bool that tells if
> MCE handling is initialized.  That was required because they had
> switched to use swork instead of a kernel thread.  Here, just
> checking to see if the thread is NULL is good enough to see if
> MCE handling is initialized.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>   arch/x86/kernel/cpu/mcheck/mce.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index aaf4b9b..cc70d98 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -1391,7 +1391,8 @@ static int mce_notify_work_init(void)
>   
>   static void mce_notify_work(void)
>   {
> -	wake_up_process(mce_notify_helper);
> +	if (mce_notify_helper)
> +		wake_up_process(mce_notify_helper);
>   }
>   #else
>   static void mce_notify_work(void)

