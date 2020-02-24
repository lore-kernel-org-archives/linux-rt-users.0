Return-Path: <SRS0=opgi=4M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11067C35679
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67CB2080D
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Feb 2020 08:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBXIdH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:33:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXIdH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Feb 2020 03:33:07 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j69Am-00050y-Eh; Mon, 24 Feb 2020 09:33:04 +0100
Date:   Mon, 24 Feb 2020 09:33:03 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     zanussi@kernel.org, Juri Lelli <juri.lelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT 03/25] sched/deadline: Ensure inactive_timer runs in
 hardirq context
Message-ID: <20200224083303.cdj27guxfxqkbyqo@linutronix.de>
References: <cover.1582320278.git.zanussi@kernel.org>
 <11a532007a600928e64e761722da7100e19a0c5f.1582320278.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11a532007a600928e64e761722da7100e19a0c5f.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-21 15:24:31 [-0600], zanussi@kernel.org wrote:
> [ Upstream commit ba94e7aed7405c58251b1380e6e7d73aa8284b41 ]
> 
> SCHED_DEADLINE inactive timer needs to run in hardirq context (as
> dl_task_timer already does) on PREEMPT_RT

The message says "dl_task_timer already does" but this is not true for
v4.14 as it still runs in softirq context on RT. v4.19 has this either
via
  https://lkml.kernel.org/r/20190731103715.4047-1-juri.lelli@redhat.com

or the patch which got merged upstream.

Juri, I guess we want this for v4.14, too?

> Change the mode to HRTIMER_MODE_REL_HARD.
> 
> [ tglx: Fixed up the start site, so mode debugging works ]
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20190731103715.4047-1-juri.lelli@redhat.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/sched/deadline.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index eb68f7fb8a36..7b04e54bea01 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -252,7 +252,7 @@ static void task_non_contending(struct task_struct *p)
>  
>  	dl_se->dl_non_contending = 1;
>  	get_task_struct(p);
> -	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL);
> +	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL_HARD);
>  }
>  
>  static void task_contending(struct sched_dl_entity *dl_se, int flags)
> @@ -1234,7 +1234,7 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
>  {
>  	struct hrtimer *timer = &dl_se->inactive_timer;
>  
> -	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>  	timer->function = inactive_task_timer;
>  }
>  

Sebastian
