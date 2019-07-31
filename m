Return-Path: <SRS0=Ir0P=V4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99344C32751
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Jul 2019 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D2720679
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Jul 2019 14:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbfGaOZU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:25:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfGaOZT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Jul 2019 10:25:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5FD53082129;
        Wed, 31 Jul 2019 14:25:19 +0000 (UTC)
Received: from torg.hsv.redhat.com (ovpn-124-191.rdu2.redhat.com [10.10.124.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9769E60C4C;
        Wed, 31 Jul 2019 14:25:09 +0000 (UTC)
Date:   Wed, 31 Jul 2019 09:25:07 -0500
From:   Clark Williams <williams@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, bigeasy@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com
Subject: Re: [RT PATCH] sched/deadline: Make inactive timer run in hardirq
 context
Message-ID: <20190731092507.3c57d4db@torg.hsv.redhat.com>
In-Reply-To: <20190731103715.4047-1-juri.lelli@redhat.com>
References: <20190731103715.4047-1-juri.lelli@redhat.com>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 31 Jul 2019 14:25:19 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 31 Jul 2019 12:37:15 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> SCHED_DEADLINE inactive timer needs to run in hardirq context (as
> dl_task_timer already does).
> 
> Make it HRTIMER_MODE_REL_HARD.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
> Hi,
> 
> Both v4.19-rt and v5.2-rt need this.
> 
> Mainline "sched: Mark hrtimers to expire in hard interrupt context"
> series needs this as well (20190726185753.077004842@linutronix.de in
> particular). Do I need to send out a separate patch for it?
> 
> Best,
> 
> Juri
> ---
>  kernel/sched/deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1794e152d888..0889674b8915 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1292,7 +1292,7 @@ void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
>  {
>  	struct hrtimer *timer = &dl_se->inactive_timer;
>  
> -	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>  	timer->function = inactive_task_timer;
>  }
>  
> -- 
> 2.17.2
> 
Acked-by: Clark Williams <williams@redhat.com>

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
