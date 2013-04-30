From: Borislav Petkov <bp@alien8.de>
Subject: Re: Suspend resume problem (WAS Re: [ANNOUNCE] 3.8.10-rt6)
Date: Wed, 1 May 2013 00:31:05 +0200
Message-ID: <20130430223105.GA12385@pd.tnic>
References: <20130429201202.GB7979@linutronix.de>
 <20130429161925.2a6ea78a@riff.lan>
 <20130430170948.GB4688@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, rostedt@goodmis.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:58708 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933738Ab3D3WbS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Apr 2013 18:31:18 -0400
Content-Disposition: inline
In-Reply-To: <20130430170948.GB4688@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 30, 2013 at 07:09:48PM +0200, Sebastian Andrzej Siewior wrote:
> Now, the time jump on the other hand is the real issue here and is
> RT-only. It looks like we get a big number of timer updates via
> tick_do_update_jiffies64() because according to ktime_get() that much
> time really passed by.
> 
> The sollution seems as simple as
> 
> From c27eb2e0ab0b5acd96a4b62288976f1b72789b3e Mon Sep 17 00:00:00 2001
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Tue, 30 Apr 2013 18:53:55 +0200
> Subject: [PATCH] time/timekeeping: shadow tk->cycle_last together with
>  clock->cycle_last
> 
> Commit ("timekeeping: Store cycle_last value in timekeeper struct as
> well") introduced a tk-> based cycle_last values which needs to be reset
> on resume path as well or else ktime_get() will think that time
> increased a lot.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/time/timekeeping.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 99f943b..688817f 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -777,6 +777,7 @@ static void timekeeping_resume(void)
>  	}
>  	/* re-base the last cycle value */
>  	tk->clock->cycle_last = tk->clock->read(tk->clock);
> +	tk->cycle_last = tk->clock->cycle_last;
>  	tk->ntp_error = 0;
>  	timekeeping_suspended = 0;
>  	timekeeping_update(tk, false, true);

Didn't tlgx fix a similar issue upstream already?

77c675ba18836.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
