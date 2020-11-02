Return-Path: <SRS0=ditW=EI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F7BC00A89
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781D621D91
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kbqm8VpJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5bf0G4Zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgKBRmp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:42:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60264 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBRmo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Nov 2020 12:42:44 -0500
Date:   Mon, 2 Nov 2020 18:42:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604338963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJH19nRpP86Lk5McjgUs80KhfZNb5UAyUMcYzkWlYow=;
        b=Kbqm8VpJ9NK6gsOUKpQRdACET94pZbuDMrBJ7SUEUrMNb1QsTZT6UV3kbIDQnDiOh+rIf5
        +pjlnIfq9iazBeWuIhP8+GviLAS9wsz45OFZ66jdmRMdNX85MaMEqQ4U3lvFgTOqnzR3BM
        fXbBCftnee3a0f9mFCIN+7YXQ9TyOYLNuYsgYCwyT2yTaFI5jTVgRGTdwoIM5B7ewv/YdJ
        zdwse/TToEPXWCOLP1G98mx1VrAw54akH3w7T4VIRbwaS7EVTzdILLKvOoEz3RHQvaR5oh
        z/Yo6H7hUsaaUPGRGtuYYkmWAIlc9S9AffCMjkIq8T/JRfYpXJyPUMkCYJV/6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604338963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJH19nRpP86Lk5McjgUs80KhfZNb5UAyUMcYzkWlYow=;
        b=5bf0G4ZcOG056Wg/MKayvlX1bIcdujlZTLosUiVe2jm3AHfQ5yJC+w9QKXXt6N4JRxE7CO
        2t7EGjjR+WYEOYDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201102174241.7llgokeh6cjzb7d3@linutronix.de>
References: <20201102155001.GA18313@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102155001.GA18313@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-02 16:50:01 [+0100], Oleg Nesterov wrote:
> The commit 6362e6476cd7 ("ptrace: fix ptrace vs tasklist_lock race")
> changed ptrace_freeze_traced() to take task->saved_state into account,
> but ptrace_unfreeze_traced() has the same problem and needs a similar
> fix: it should check/update both ->state and ->saved_state.

Thank you for the report.

> Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Fixes: 6362e6476cd7 ("ptrace: fix ptrace vs tasklist_lock race")
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/ptrace.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 3075006d720e..7e004f998233 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -197,8 +197,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
>  
>  static void ptrace_unfreeze_traced(struct task_struct *task)
>  {
> -	if (task->state != __TASK_TRACED)
> -		return;
> +	bool frozen = true;

Is this okay for !PREEMPT_RT or is this considered as an important
fast-path on !PREEMPT_RT?

>  	WARN_ON(!task->ptrace || task->parent != current);
>  
> @@ -207,12 +206,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	 * Recheck state under the lock to close this race.
>  	 */
>  	spin_lock_irq(&task->sighand->siglock);
> -	if (task->state == __TASK_TRACED) {
> -		if (__fatal_signal_pending(task))
> -			wake_up_state(task, __TASK_TRACED);
> -		else
> -			task->state = TASK_TRACED;
> -	}
> +
> +	raw_spin_lock(&task->pi_lock);

I think this got mentioned in the other emails but this requires irqsave
because the above (siglock) does not disable interrupts on RT.
This `saved_state' is only used for RT so it might make sense to avoid
the PI-lock on non-RT.

> +	if (task->state == __TASK_TRACED)
> +		task->state = TASK_TRACED;
> +	else if (task->saved_state == __TASK_TRACED)
> +		task->saved_state = TASK_TRACED;
> +	else
> +		frozen = false;
> +	raw_spin_unlock(&task->pi_lock);
> +
> +	if (frozen && __fatal_signal_pending(task))
> +		wake_up_state(task, __TASK_TRACED);
> +
>  	spin_unlock_irq(&task->sighand->siglock);
>  }
>  

Sebastian
