Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50921C43334
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Jul 2022 05:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiGLFnF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Jul 2022 01:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiGLFnE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Jul 2022 01:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBC108E1FF
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Jul 2022 22:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657604581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rr2NpSz95Nba37gHqSCQSn+4s0WDbKuM1o6GXxYrwW4=;
        b=TAVY1n+P/5h3rVGbAA3jTgTqvPoF4YA4UPCmp9ic/jmUcEU8RAiMtxfTFUitJFR4DdEEDT
        RKRl0RapkQ5Fi5pc8P4k1klLoYUmCruN5wYa6jyzl5ncoLSFhX9e5YkB6r9Mor0l4hgiNN
        F+EtjSLO5qnSj3GqJmAkedU3YTDNjcE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-2EwmARhOOxyNffH0z9u7pg-1; Tue, 12 Jul 2022 01:42:50 -0400
X-MC-Unique: 2EwmARhOOxyNffH0z9u7pg-1
Received: by mail-wm1-f70.google.com with SMTP id l22-20020a05600c089600b003a2ebd4c837so938864wmp.0
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Jul 2022 22:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rr2NpSz95Nba37gHqSCQSn+4s0WDbKuM1o6GXxYrwW4=;
        b=VDD9XjfaGI9cZG/xa261CQjAPABI118+jMQGXMtSDAnjG8Oj0NFY7BWKPHUWnAJt29
         SjPN8CmHUAptvMqVuXlRR8WN+d/PfC/KYCr4PeID5OREV/ZDXuCB2ofYVHBpiMYKkLkw
         EwhlYxWhXJIQokEdUSlNJtEctePzkxOzkCoVgyrEy/+BfYD/YnQecls9VJe1pUxkitj+
         NT3WznU1SzsLNqZJq6rhCmjYMKrhRcfSDuArU5nb3fZvgMkycbDWHxP378mlHx+H+C7V
         SxlNUwGc9Dc/U8utpsnr1VOIIDGHi1gkraORXr9ZVrJj+A8y+zmRrQ3f1I0NSn4hMCiI
         aoPg==
X-Gm-Message-State: AJIora8Ijnz9fVocjRRzYCh2fZcVhvf3gFKRdJDG77pxM5Xc3bc0UlXU
        Ct1GZMaZtrZXHTyGFA1qKH52zXzo53Q4j+6saoKUYeFdu+uR8K5ti2CrzBvsD37bskQWvMCTRXw
        Esa27avoViFz2UgZaPBJa485p0Zw=
X-Received: by 2002:adf:f64f:0:b0:21d:76c6:d98 with SMTP id x15-20020adff64f000000b0021d76c60d98mr20278230wrp.299.1657604566559;
        Mon, 11 Jul 2022 22:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slcfV//6rP054RoCRMOtQUrM5ceac5x6CadI8120dlpk6sy+CgSTzQQMO268DHEJKmzjWg2g==
X-Received: by 2002:adf:f64f:0:b0:21d:76c6:d98 with SMTP id x15-20020adff64f000000b0021d76c60d98mr20278208wrp.299.1657604566325;
        Mon, 11 Jul 2022 22:42:46 -0700 (PDT)
Received: from localhost.localdomain ([151.29.51.61])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c4c1400b003a1980d55c4sm11423288wmp.47.2022.07.11.22.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 22:42:45 -0700 (PDT)
Date:   Tue, 12 Jul 2022 07:42:43 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
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
Message-ID: <Ys0J00yyLlT2Q/vM@localhost.localdomain>
References: <20220627095051.42470-1-juri.lelli@redhat.com>
 <xhsmhtu7weytl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhtu7weytl.mognet@vschneid.remote.csb>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 05/07/22 09:41, Valentin Schneider wrote:
> On 27/06/22 11:50, Juri Lelli wrote:
> > Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper on
> > PREEMPT_RT) are not visible to hrtimer_start_range_ns, thus not
> > accounted for by hrtimer_start_expires call paths. In particular,
> > __wait_event_hrtimeout suffers from this problem as we have, for
> > example:
> >
> > fs/aio.c::read_events
> >   wait_event_interruptible_hrtimeout
> >     __wait_event_hrtimeout
> >       hrtimer_init_sleeper_on_stack <- this might "mode |= HRTIMER_MODE_HARD"
> >                                        on RT if task runs at RT/DL priority
> >         hrtimer_start_range_ns
> >           WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
> >           fires since the latter doesn't see the change of mode done by
> >           init_sleeper
> >
> > Fix it by making __wait_event_hrtimeout call hrtimer_sleeper_start_expires,
> > which is aware of the special RT/DL case, instead of hrtimer_start_range_ns.
> >
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Makes sense, that's now aligned with what e.g.
> schedule_hrtimer_range_clock() does.
> 
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Thanks!

Gentle ping to the others about this one.

Best,
Juri

