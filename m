Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617E6C43334
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Jul 2022 12:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiGMM6Q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Jul 2022 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiGMM6P (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Jul 2022 08:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CBCE7393D
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jul 2022 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657717093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYC8Yec1GTbUtaYK7RYva4XXz/xl1ExjZYRMzojC8yQ=;
        b=L8Y2U5FFfXvBLvZ0piQufktp3doNmsC2UCEjTpIsr+X915Ip6KGs8+mi3Izz0vWY9oVht7
        URrVz3IpVGvbQtQ2/WlzEztZV87ac4MHWrEh2EpJtVirKnHt31pQNoxKmt4x0isLoa6+lV
        8GQq/UAjqE7Nj4/uRlPsl2vCx7BvVRM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-i0Ow3zw-OE6LqsAlt-VTxg-1; Wed, 13 Jul 2022 08:58:12 -0400
X-MC-Unique: i0Ow3zw-OE6LqsAlt-VTxg-1
Received: by mail-wr1-f72.google.com with SMTP id i13-20020adfaacd000000b0021d96b4da5eso2125742wrc.18
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jul 2022 05:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYC8Yec1GTbUtaYK7RYva4XXz/xl1ExjZYRMzojC8yQ=;
        b=0UWN6yHS9jkqZ2/J74AUUKtcY/0fgDMkJ/dS3zXn08M1Ao/0aau1MTc7qikeYJpaMA
         +Rf1b30+ITXxmJXcz6aQrNRlnI3yUv+fVRecvDbgFWXwBETQk/QsfZtAsieCkE05xFy2
         eTBv/GbqDpsZT5gG0oYMnHOfVGtX+JaPUI6pGVLuyanYbAlUxqNCK8hb2iez4EqbM82J
         FZ7rBVn0JGDBNfnQ+It3YIXXFOOSAyxAe1JS8+lc2cn3rpXR3YTq+mrah3JQn09EsApS
         NO7gpfFTWmVqPHRR9xM9uiJkB0HEj+j736UgqZOCzrd1gO7rJuKIfXaW6VRP80fz2Gge
         bl/A==
X-Gm-Message-State: AJIora8j86cxWVKcgNzie6LIVF1oSsz+FS+e6UwGv6KyiBYH0TpGgtq0
        bEuh/sJjFyGPgPhhcDfSpcW8EVOFNUXZvepD6g15NCIXlLHaXKVO1jC0/OCHd1Rjbv0bE2ITjB3
        znjbXbzE0YJV3ezgBFEgboMWtBt0=
X-Received: by 2002:a1c:7910:0:b0:3a2:e033:cdbc with SMTP id l16-20020a1c7910000000b003a2e033cdbcmr9660884wme.122.1657717091470;
        Wed, 13 Jul 2022 05:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sRsnqWu8rRP2FIUsaOp6/GcdlWCvwK0G1/Y1QaiEpMZI2+dk3VkUEbOS2ulOuht+mJNcB7qA==
X-Received: by 2002:a1c:7910:0:b0:3a2:e033:cdbc with SMTP id l16-20020a1c7910000000b003a2e033cdbcmr9660859wme.122.1657717091160;
        Wed, 13 Jul 2022 05:58:11 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.26])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b003a2fdde48d1sm944864wmc.25.2022.07.13.05.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 05:58:10 -0700 (PDT)
Date:   Wed, 13 Jul 2022 14:58:08 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Message-ID: <Ys7BYCvlgphAwQ+Y@localhost.localdomain>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <Ys6wgxiZbdjxyh8C@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys6wgxiZbdjxyh8C@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 13/07/22 13:46, Peter Zijlstra wrote:
> On Wed, Jul 13, 2022 at 09:50:14AM +0200, Juri Lelli wrote:
> > Tasks the are being deboosted from SCHED_DEADLINE might enter
> > enqueue_task_dl() one last time and hit an erroneous BUG_ON condition:
> > since they are not boosted anymore, the if (is_dl_boosted()) branch is
> > not taken, but the else if (!dl_prio) is and inside this one we
> > BUG_ON(!is_dl_boosted), which is of course false (BUG_ON triggered)
> > otherwise we had entered the if branch above. Long story short, the
> > current condition doesn't make sense and always leads to triggering of a
> > BUG.
> > 
> > Fix this by only checking enqueue flags, properly: ENQUEUE_REPLENISH has
> > to be present, but additional flags are not a problem.
> > 
> > Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple scheduling classes")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >  kernel/sched/deadline.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 5867e186c39a..0447d46f4718 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1703,7 +1703,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
> >  		 * the throttle.
> >  		 */
> >  		p->dl.dl_throttled = 0;
> > -		BUG_ON(!is_dl_boosted(&p->dl) || flags != ENQUEUE_REPLENISH);
> > +		BUG_ON(!(flags & ENQUEUE_REPLENISH));
> 
> While there, can we perhaps make it less fatal? 

Yep. On it. Thanks!

Juri

