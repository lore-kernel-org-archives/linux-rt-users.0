From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] pin_current_cpu: move preempt_enable() outside
Date: Wed, 6 Nov 2013 22:53:40 -0500
Message-ID: <20131106225340.3f01a55b@gandalf.local.home>
References: <1383793650-7839-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <tglx@linutronix.de>, <stable-rt@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:61291 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752902Ab3KGDxp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Nov 2013 22:53:45 -0500
In-Reply-To: <1383793650-7839-1-git-send-email-tiejun.chen@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 7 Nov 2013 11:07:30 +0800
Tiejun Chen <tiejun.chen@windriver.com> wrote:

> It should make better sense than before.

But this change log makes no sense.


> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  kernel/cpu.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index da6e128..7b1853f 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -124,12 +124,11 @@ retry:
>  		return;
>  	}
>  
> +	preempt_enable();
>  	if (hp->grab_lock) {
> -		preempt_enable();

Just because we may enable preemption in both if branches, the decision
for which branch to take must still be determined under preempt
disable, otherwise things may no longer apply.

That said, I'm not sure if it matters if we do enable preemption before
the check or not. But I rather not blindly do so without looking at how
that affects things. There's some subtle races between setting
grab_lock and running the sync_task. It may not matter if we enabled
preemption before the check, but it will take a bit of thought before
that can be decided.


-- Steve

>  		hotplug_lock(hp);
>  		hotplug_unlock(hp);
>  	} else {
> -		preempt_enable();
>  		/*
>  		 * Try to push this task off of this CPU.
>  		 */

