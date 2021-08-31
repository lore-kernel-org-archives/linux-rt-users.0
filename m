Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D070DC432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE6E60FE6
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 13:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhHaN3c (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbhHaN3b (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 09:29:31 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E1FC061575;
        Tue, 31 Aug 2021 06:28:36 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b200so24734318iof.13;
        Tue, 31 Aug 2021 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JteJgmJ7TKB+IV4kzfEq5TxJ8GRQQk3aer0scCZatA=;
        b=nfF761u89YVrdWGrn/NHDrZAQh6OnOvEq0VNBTzGO6VS/UPXNP04HBntgLo+ke6rTG
         HCuarkcn3w4Q9xXuKIqI/8+5ujNfoUN9txwXomfHP6H3sRbQDA+Vbtj5q9basadryKqd
         GtdRJNDshmmqeSID9vQHMZz0fc9y7xVVYrKb7uzG4VzFwGTZFDvasRenukfMArUGyayR
         6NObt5OT5fS7fHOO1vSFCdMf06LAFs1qEV09x1hCDt7Z7y/N7WqzG8Oi3iIx0xNtyemI
         0X8UAOE1FNl9t5Tln71wsopXLmHuuXp4tXgiA7xT7kTxcV745wy82rpIJEPvyF176HaS
         GQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JteJgmJ7TKB+IV4kzfEq5TxJ8GRQQk3aer0scCZatA=;
        b=UVQOTjEnr3HNB1u4TRaxnK2yjWfDa55cVTZSKdSLew0V50LKy3XHJeiQNxeUFSRODF
         TmmKe+lvBDVRtD9jBv5E1tniwEXpp5apzOgVUKMPada/shyZiuEHlgvK69fKqR+820sa
         bxzJrWyUh+treLnRDbkQjR5tlSfM/RuXk0DMJsju2W5S4RZmOMDE6Y0xjIgm2LDmtPbM
         uvuY8NpSN8QQX65MTuRkcPJ6aF3GV4FXdoH5Telk32IF5XU4ZbyjIF3xKAfBkUYvRtkR
         6hU9OxLRXqf27ORj8wS9xeut2/FKxZ7TnNjxtaHuH+TXtSVIKajRyFixHklDrqjOIQSz
         jwvw==
X-Gm-Message-State: AOAM5310hxZokrAm8NLGh9u9oGxlJLNlvfDe6/Sj2nFVQWpoYz7ejp/J
        Zpqfq+QTw+Toix6RSKNCT9o4QA9lZw9zrZPir50=
X-Google-Smtp-Source: ABdhPJwN/QMzxM+/WzHEzDEe3UaGAXo5qc0AJAKY0J4OrXj4jPqMIAF40FyesWrSQrWNr8i7YJnhwKZxWEefCxKB/RQ=
X-Received: by 2002:a05:6638:5b5:: with SMTP id b21mr2945619jar.109.1630416515898;
 Tue, 31 Aug 2021 06:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210824112946.9324-1-laoar.shao@gmail.com> <20210824112946.9324-5-laoar.shao@gmail.com>
 <YS4Nu6LJwwxfcTr1@hirez.programming.kicks-ass.net>
In-Reply-To: <YS4Nu6LJwwxfcTr1@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 31 Aug 2021 21:27:59 +0800
Message-ID: <CALOAHbAG4v+ZnTohLDP6EFp50N0i=i-KTRvwhVhgmA8bZZX11Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] sched: make the output of schedstats independent
 of fair sched class
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alison Chaiken <achaiken@aurora.tech>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 31, 2021 at 7:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 24, 2021 at 11:29:43AM +0000, Yafang Shao wrote:
> > The per cpu stats can be show with /proc/sched_debug, which includes the
> > per cpu schedstats of each task group. Currently these per cpu
> > schedstats only show for the fair sched class. If we want to support
> > other sched classes, we have to make these output independent of fair
> > sched class.
>
> Arguably the whole rt group stuff needs to die, please don't enable it
> further.

Sure.

-- 
Thanks
Yafang
