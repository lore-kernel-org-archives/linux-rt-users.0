Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3364CC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  5 Jul 2022 08:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiGEIlc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 5 Jul 2022 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiGEIlb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Jul 2022 04:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B4347661
        for <linux-rt-users@vger.kernel.org>; Tue,  5 Jul 2022 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657010490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PBMOa/d2tjfgeB/QHIx1dN7myWa507lkje9vgtYdk1M=;
        b=ZSU4vBrkQnG2v2F7S3ZWcrhPvt8+1UEsLv8NXj7wfAGfOHNCZfGNyRgGOjpZ6sqbTH6a8e
        +UGmgQtKxCI6tSfkrP50esH6omfMs5jesLVXcNIShMb37024RFBEcNbsq9mQfEegNGLp+k
        uB8tsJ/HjVwIOrodArTIf0JVGAVcM2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-yeyLKEM4NGCG8TMSF25ugg-1; Tue, 05 Jul 2022 04:41:28 -0400
X-MC-Unique: yeyLKEM4NGCG8TMSF25ugg-1
Received: by mail-wr1-f71.google.com with SMTP id t13-20020adfe10d000000b0021bae3def1eso1722382wrz.3
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jul 2022 01:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PBMOa/d2tjfgeB/QHIx1dN7myWa507lkje9vgtYdk1M=;
        b=5xtx/Xpe1Eka7BBRAlMGutAkle2cRhods8pfRasWO1rdUK3hLO2q8rgP40kJl1QnVR
         wKdDbQaoBbPgAPYUAf29N1mF8mPCL09KFb4fI4A08CujidLsqtQ9Y3lz2o0w0kBI51C1
         Rgw1LICXN6ALHEbYWaBHok8q17tcqIyM9q3UvbVTarQuyyGLYpN86Aq6hK7H1L7VN6jU
         97XtbR6SRnBxEuYTwLAqW01eBTLvbBba8yPpgNODy8ysIIJFX5IvSrpR7A6Je22XLjl0
         1evGJDpzN51WUMtENUl8zDdTS2U2WflHLTzepklDSBlJaGDc2pkOVf7oHA9KnHCwgQka
         zs6Q==
X-Gm-Message-State: AJIora+6n4k/GJ/8rsOyrYOMleg/0yuISJm2gy1DfT+xaTY57tzavG2S
        yszpAo227UCUbYIiaNQ6dnHEr6x6Od3AP3dSmgkjC8EPa67mdXAs5Z/+RXGE8sOtUqC21Dlih/g
        rLEV1O/cvoEStgDd/DHKa0mZal4o=
X-Received: by 2002:a05:600c:4282:b0:3a0:2ddf:4df3 with SMTP id v2-20020a05600c428200b003a02ddf4df3mr35291745wmc.45.1657010487756;
        Tue, 05 Jul 2022 01:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sGnHWLme//B+hbcAQKsKiJmsBsmUMTZFJ9LGNlyeIvIOH67tTiyDoMStTGpwMudz/TipXL+Q==
X-Received: by 2002:a05:600c:4282:b0:3a0:2ddf:4df3 with SMTP id v2-20020a05600c428200b003a02ddf4df3mr35291729wmc.45.1657010487581;
        Tue, 05 Jul 2022 01:41:27 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d510e000000b0021d60994b0asm8522281wrt.100.2022.07.05.01.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 01:41:27 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] linux/wait: Fix __wait_event_hrtimeout for RT/DL tasks
In-Reply-To: <20220627095051.42470-1-juri.lelli@redhat.com>
References: <20220627095051.42470-1-juri.lelli@redhat.com>
Date:   Tue, 05 Jul 2022 09:41:26 +0100
Message-ID: <xhsmhtu7weytl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 27/06/22 11:50, Juri Lelli wrote:
> Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper on
> PREEMPT_RT) are not visible to hrtimer_start_range_ns, thus not
> accounted for by hrtimer_start_expires call paths. In particular,
> __wait_event_hrtimeout suffers from this problem as we have, for
> example:
>
> fs/aio.c::read_events
>   wait_event_interruptible_hrtimeout
>     __wait_event_hrtimeout
>       hrtimer_init_sleeper_on_stack <- this might "mode |= HRTIMER_MODE_HARD"
>                                        on RT if task runs at RT/DL priority
>         hrtimer_start_range_ns
>           WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
>           fires since the latter doesn't see the change of mode done by
>           init_sleeper
>
> Fix it by making __wait_event_hrtimeout call hrtimer_sleeper_start_expires,
> which is aware of the special RT/DL case, instead of hrtimer_start_range_ns.
>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Makes sense, that's now aligned with what e.g.
schedule_hrtimer_range_clock() does.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

