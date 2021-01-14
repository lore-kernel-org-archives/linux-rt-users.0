Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C4BC433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Jan 2021 14:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7110E23A5E
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Jan 2021 14:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbhANOtS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Jan 2021 09:49:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59898 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbhANOtR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Jan 2021 09:49:17 -0500
Date:   Thu, 14 Jan 2021 15:48:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610635715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRZXreU8+J6+MQ4uhgjNyj5Ae9AUlxDBhla73zzND7M=;
        b=s3Iq5G5dVZlQ2YVhG52LyLmekeDOsc84EEpaSr8INiJaOslGWV+YX9KKYAUXPiOLP/lxFl
        O/rM/+nokF/sqpbRF9yZTn1sGE2kn6VRqpARttDYN3mO8f4IY9yfEqyi86CzGNkkNqLJAU
        EVs06hwVYVHEfT/pLsZXlsuh6KVszHUoiXl+5LOPWdL3UwKjFyP9ZnN5gL7DSj9CAHnuB4
        ydstzrVTbWNcfXndPn1dexuqJyLbqEmWyqkH07/YR0iHKWBGjJJNmXLYgmCYLs9mzXeuFF
        qXrKi3Af9+Im70v5bXLOO25dhnUNhl3SBghUvtJzIAeyQukDZx+jHLXXiT7/Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610635715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRZXreU8+J6+MQ4uhgjNyj5Ae9AUlxDBhla73zzND7M=;
        b=dktaSpbp654HP4XylLH53J4+y4l2tWQn5fVNfIO6gIVk8G8Fbd2KJWl5DHjnjiatlZLZwn
        Av0D+H2LmRLChmAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     ramesh.thomas@intel.com
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        frederic@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 1/1] dynticks/preempt_rt: Fix a nohz_full entry failure
 in preempt_rt
Message-ID: <20210114144835.ok7y4s2csbfhh5eu@linutronix.de>
References: <20201223092034.528782-1-ramesh.thomas@intel.com>
 <20201223092034.528782-2-ramesh.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223092034.528782-2-ramesh.thomas@intel.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-23 04:20:36 [-0500], ramesh.thomas@intel.com wrote:
> From: Ramesh Thomas <ramesh.thomas@intel.com>
> 
> After all conditions to enter nohz_full state are met, if a timer event
> is detected in the next period, nohz_full entry is aborted in
> tick_nohz_next_event(). In the failure condition, this scenario keeps
> repeating. This has been reproduced in preempt_rt kernel, however it may
> not be limited to it.
 
Which timer is? Why does it make sense to enter NOHZ_FULL if the timer
expires shortly after (in next jiffy window if I understood it
properly).

> Not bailing out if CONFIG_NO_HZ_FULL is defined, fixes the issue. Since
> in NO_HZ_FULL mode, idle state is not entered at tick stoppage, the
> pending timer event can be handled where the next timer is programmed in
> tick_nohz_stop_tick(). This also simplifies the logic by keeping a
> common path to handle the entry/exit of nohz_full state, whether the
> tick was already stopped or not.
> 
> (The entire check for the presence of a timer event in the next period
> can possibly be skipped for NO_HZ_FULL)
> 
> Signed-off-by: Ramesh Thomas <ramesh.thomas@intel.com>
> ---
>  kernel/time/tick-sched.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 308a98c28ee8..3798dbc5f082 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -739,10 +739,12 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  		 * We've not stopped the tick yet, and there's a timer in the
>  		 * next period, so no point in stopping it either, bail.
>  		 */
> +#ifndef CONFIG_NO_HZ_FULL
>  		if (!ts->tick_stopped) {
>  			ts->timer_expires = 0;
> -			goto out;
> +			return 0;
>  		}
> +#endif
>  	}
>  
>  	/*
> @@ -763,7 +765,6 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  
>  	ts->timer_expires = min_t(u64, expires, next_tick);
>  
> -out:
>  	return ts->timer_expires;
>  }
>  
> -- 
> 2.26.2
> 

Sebastian
