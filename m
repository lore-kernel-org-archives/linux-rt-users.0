Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF54C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Dec 2021 20:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhLPUVW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Dec 2021 15:21:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232814AbhLPUVV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Dec 2021 15:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639686081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UROZJHfxiAlJ7HASqgNbTv6n7Grg5ftbDdoCWDIq/Qw=;
        b=h+T5lKdxe7qtUbGnVt1rVrRsJvYelvZhhoqY2Qg5BJZ7Z0pWo1XEyYakVt89QUX2Cqu3O4
        wxSE7UKsIZXiPoJ89zUjDzmzN0Wtldnfs3vE/orAhEuMLGixB7P/o5+ZxHip16ctD9uXBR
        eXEO+DgMNwSrJT75QircTurKi3zx2DU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-n7TQmLMcMkWQlp7AeBvlCw-1; Thu, 16 Dec 2021 15:21:19 -0500
X-MC-Unique: n7TQmLMcMkWQlp7AeBvlCw-1
Received: by mail-ed1-f72.google.com with SMTP id n11-20020aa7c68b000000b003e7d68e9874so24282261edq.8
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Dec 2021 12:21:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UROZJHfxiAlJ7HASqgNbTv6n7Grg5ftbDdoCWDIq/Qw=;
        b=RZyRdrCjmHXwj98SozTVBEliWPpBO9vOBLi+lBLmFm0WaRG5mxYIpRL3kK3evJh9lN
         WDuqmZx7o/F63JqIwgJq90ZdEFWU1cRtVRPwxA4sdCWxcc3mq31ZWeeftATHSSZeHE57
         eE+xSaE4FU88DDB2d8rszbC2wAUHDvzQszwHcs5mb9FgeMidYPKycJfTQNwC57Duj4oZ
         ittHErLW/pBA9wOHPnaEMVv1cBsbMiyz2aDFybd69OubY6WMQ2gUDfHJBUajWGAXOdI+
         NKev6Vt9ba3wUzgX8yg8d3E6zG2w4ac9VhqEkghmAQlyF7EENC2dbF0o6LxxynNpDUpj
         lgig==
X-Gm-Message-State: AOAM5315TzWe2hL0UOKkT2ecBb8b5e6m1Q/zHA4eObPhzwmkdQTEYJvF
        9q8nANcKJwQCWxae/uTTYh7qq3+RccNoORoQVq/RgOU+YjXtHFQMvcE81KxAfluUw/T7FtbgmRn
        ro8ben39eKfwvbWXDmDXPhbPno6FUq14nWa7a9pUb+qA=
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr17124277ejc.450.1639686078664;
        Thu, 16 Dec 2021 12:21:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzl1b6zX5KpLf73/C8bWNIU7WQ2dUHtDcImZYamSAV6mETbxVK3ZyK0dBVUhGLNsZu4IC10XTg346c1J3Bk/9w=
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr17124255ejc.450.1639686078320;
 Thu, 16 Dec 2021 12:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20211213123737.9147-1-wander@redhat.com> <20211213123737.9147-2-wander@redhat.com>
 <YboeqlSsoFRbjEv2@linutronix.de>
In-Reply-To: <YboeqlSsoFRbjEv2@linutronix.de>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 16 Dec 2021 17:21:07 -0300
Message-ID: <CAAq0SUkamkGvcBWpSwuZ6brFw=7qnmiE8huX6xEE643ohBVuZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] block: Avoid sleeping function called from invalid
 context bug
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 15, 2021 at 1:58 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-12-13 09:37:36 [-0300], Wander Lairson Costa wrote:
> > ---
> >  block/blk-cgroup.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index 663aabfeba18..0a532bb3003c 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -1911,7 +1911,7 @@ void blk_cgroup_bio_start(struct bio *bio)
> >       struct blkg_iostat_set *bis;
> >       unsigned long flags;
> >
> > -     cpu = get_cpu();
> > +     cpu = get_cpu_light();
> >       bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
> >       flags = u64_stats_update_begin_irqsave(&bis->sync);
> >
> > @@ -1928,7 +1928,7 @@ void blk_cgroup_bio_start(struct bio *bio)
> >       u64_stats_update_end_irqrestore(&bis->sync, flags);
> >       if (cgroup_subsys_on_dfl(io_cgrp_subsys))
> >               cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
> > -     put_cpu();
> > +     put_cpu_light();
> >  }
>
> Are you sure patch and backtrace match? There is also
> u64_stats_update_begin_irqsave() which disables preemption on RT. So by
> doing what you are suggesting, you only avoid disabling preemption in
> cgroup_rstat_updated() which acquires a raw_spinlock_t.
>

You're right. I double-checked and noticed my tree didn't have the
call to u64_stats_update_begin_irqsave. Only patch 2 is necessary
indeed.

> Sebastian
>

