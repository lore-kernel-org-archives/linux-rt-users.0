Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D61C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1672B2168B
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 11:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlRDfBWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKSLZI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgKSLZH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Nov 2020 06:25:07 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A5AC0613CF;
        Thu, 19 Nov 2020 03:25:07 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id j12so5694339iow.0;
        Thu, 19 Nov 2020 03:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1XffauKPhHeH3IGYJ+xDJnFKjz+/yGWp27GdHf+My8=;
        b=IlRDfBWY1oo2Ph17Aqg1d2YOCgE/rVR6ZMYtfRzNOdBm3ESRC4FAljTCOWkPH1j3Un
         9f3jLcl2HVNziP4lLHCpy2oaxhDjo72eEXlGTZS+0eA3Fj8fy9T2fwRzbXpVZzIvJpRn
         GMV3wMCJzdQbW5ggnxsfUDXJ8aPJq08Td68SqyWbMvpxUldjW2OEpm1acnW0dyFu2vLj
         rcKzcrwpamZCVMdFswAI91l4ZUmo/yEXUzZKgRaMi0LVgYUBso/VSR2hZjcmb95fa7cN
         GvTcnWmnMl5dpICs/K/ryL8GNH3RBCTmQZFF7CB1lqeYfjFLWFPJpjJ8Ffj5xvw9POFS
         kbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1XffauKPhHeH3IGYJ+xDJnFKjz+/yGWp27GdHf+My8=;
        b=M/9r9zql/qYV0MiyR6FeMmrj6yXvTw2aeUDTgqQUhoPxrke1U/4hjB/sAqYyV2qU3m
         ydetROYy6dDW3D/4iWvhwJdttE6Gf/1YdW/1yV4VCxNU0+dVBAvZydVq88HA4fSwPdlj
         9Sbr8lYeHd2wFMFpyonbe98OtxyDftB+esSg0iApX63Q0P1CwWG0QlUIrNuwWEjlruTz
         /3qQEAL/fOVI/WJl6BOKHYrl7GlU0y0VrREWudbdw5fDxSjVqAGmVi5es94r8UMaOUgs
         MV0BqA/fp/EZZb9RBtEl6vGgCV1NpVXUtSeVH8Zw3zBTYXiAKw+ly8fgYYj9U2L1akHU
         dmkw==
X-Gm-Message-State: AOAM533WQSr4x2gefNZ0YfXR8HA3h/BP4jKECw38Zp1pCgiesT/6qVET
        5bQDhboJHLoes3MOFdi4wqA0SHnMCoQToWkUmTk=
X-Google-Smtp-Source: ABdhPJzBdeWSsX2/6clBH+Rum7mNB+Xmfyxcv6aLEDBvHevBCUQmNWaUsCYmtSD5/p6No1HsnpErv8ZCmyhDUjlSk84=
X-Received: by 2002:a02:c7c1:: with SMTP id s1mr13056971jao.94.1605785107048;
 Thu, 19 Nov 2020 03:25:07 -0800 (PST)
MIME-Version: 1.0
References: <20201119035230.45330-1-laoar.shao@gmail.com> <20201119035230.45330-3-laoar.shao@gmail.com>
 <20201119074539.GE3306@suse.de>
In-Reply-To: <20201119074539.GE3306@suse.de>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 19 Nov 2020 19:24:31 +0800
Message-ID: <CALOAHbDf1V6Fo3HBvMOWYckSxjUsfpxn+aePgUtjLxKf7dTgGw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] sched: make schedstats helpers not depend on cfs_rq
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, bristot@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Nov 19, 2020 at 3:45 PM Mel Gorman <mgorman@suse.de> wrote:
>
> On Thu, Nov 19, 2020 at 11:52:28AM +0800, Yafang Shao wrote:
> > The 'cfs_rq' in these helpers is only used to get the rq_clock, so we
> > can pass the rq_clock directly. After that, these helpers can be used by
> > all sched class.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> This introduces overhead in the general case even when schedstats is
> disabled. Previously, update_stats_wait_start was a static inline so
> function call overhead was avoided and schedstat_enabled() meant the
> overhead was negligible. As it's now a function call, the cost of the
> function entry/exit will be unconditionally hit regardless of intrest
> in schedstat.
>
> Regardless of the merit of adding schedstats for RT, the overhead of
> schedstats when stats are disabled should remain the same with the
> static branch check done in an inline function.
>

Thanks for the explanation.
I will make them inline in the next version.


-- 
Thanks
Yafang
