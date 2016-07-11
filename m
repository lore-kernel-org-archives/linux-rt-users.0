From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] x86: Fix an RT MCE crash
Date: Mon, 11 Jul 2016 13:34:00 -0400
Message-ID: <20160711133400.4ded6fc9@gandalf.local.home>
References: <1467831301-17233-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Borislav Petkov <bp@alien8.de>, Luck@minyard.net,
	Tony <tony.luck@intel.com>, linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Corey Minyard <cminyard@mvista.com>
To: minyard@acm.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:49467 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1031077AbcGKReE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jul 2016 13:34:04 -0400
In-Reply-To: <1467831301-17233-1-git-send-email-minyard@acm.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed,  6 Jul 2016 13:55:01 -0500
minyard@acm.org wrote:

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
>  arch/x86/kernel/cpu/mcheck/mce.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index aaf4b9b..cc70d98 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -1391,7 +1391,8 @@ static int mce_notify_work_init(void)
>  
>  static void mce_notify_work(void)
>  {
> -	wake_up_process(mce_notify_helper);
> +	if (mce_notify_helper)
> +		wake_up_process(mce_notify_helper);
>  }
>  #else
>  static void mce_notify_work(void)


Wait, is this all that's needed?

Also, Boris should be credited here somewhere.

-- Steve
