Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFCEC10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7672083E
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ55N2tL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfDHTeI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:34:08 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38747 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfDHTeI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:34:08 -0400
Received: by mail-ua1-f67.google.com with SMTP id t15so55748uao.5
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Apr 2019 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJJHvRbytKbUCzN2aUtnXjyjnuWx89VWsv0L5hecgTI=;
        b=pJ55N2tL4hh/kGPlo4TIZUJlhBze01heWgqxClEdkDSJxoO4Z1pGnNEgEytw65XmNj
         9U4oYGj5w8aj1lVGMHDaN0CL2pQuTM6TkZ/5O+RSHMik0l9ENYq3MQ9QbAQw5bWV3Pmh
         wrmcWHy0W73HMILtVcJ2Sw4Z3I1AT0vTVL80suIh4XQCZneCYAz4Pl5GydCujipR5eOO
         4X/VthbbSAji6NocQk8GJDQm5xPrGQ3konsd436Ng8eqNztBxMOYFOKiX5+MlEvvIClT
         VjXijfmuvAyUqcbR+Rl5jgs3jfM6kQjVD0+cVGJPfZNkcN/bE53piWXRCbBuSd1ZZNoj
         8sYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJJHvRbytKbUCzN2aUtnXjyjnuWx89VWsv0L5hecgTI=;
        b=g6Cn2uVDNhCG0FAAtnUXm9cShiGBYy9HbG55M29iR40YmecDgW2HauK33I2Xfph1W9
         xdwCfyqvKDM90xcmKslfQbfIC3LFiF0IdLDHWBoO+d119lQW3tc9tf9C7J0LBYBBkgR3
         /LyZu/GqCCmfztPuZlbb0zAh1h+PRkTQEHy/ZIcgfZ4bm68JCrLqwwbz4zByrG1Y+cbz
         ihh16lfq3A8KD0pB73jHlqj4+uzg31nQnL8BfKgzSnV1PthO9mR2V9x5PXxuzqI9O2RR
         ZxRymI0Eu1Ft3fUG/nisxY7m+YvrutuZErEfW1hfjbfOJzrcYoCEfEOsZYHkypR8uN54
         7l8g==
X-Gm-Message-State: APjAAAXo+mrhhAmK9/cP3Lhc4NiEScznJgyXM5nAzwy82LnanjhmooPN
        w3wlLIIrCbKLlyucEM8YKn1jSg7Tjpw4NY+0SY0=
X-Google-Smtp-Source: APXvYqxGK04P2VAfJT+GSJgd/tjx8YgcwNcW8VZLgRtqZ2ussI93s/mAvkFjEQ+pM/P/DGJekloAdkZnfDZ7HeGWNm8=
X-Received: by 2002:a9f:2c8b:: with SMTP id w11mr16524128uaj.17.1554752047147;
 Mon, 08 Apr 2019 12:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
 <20190328115559.275af3c3@archlinux> <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
 <20190328120022.bhwijbp2roizysiw@linutronix.de> <82482272-6912-c1d4-4a11-550a962f632c@manjaro.org>
 <1e1974c5-2ad3-98db-d160-577594a471e1@manjaro.org> <4ddfde7a-122b-5f18-f41a-b5e967217510@manjaro.org>
 <20190329083400.m4kx4spuvysoszlm@linutronix.de> <4f5db7b4-e129-075a-f5f7-81fc0c0a1d82@manjaro.org>
 <20190408153014.q5hnrz3dwphudeq2@linutronix.de>
In-Reply-To: <20190408153014.q5hnrz3dwphudeq2@linutronix.de>
From:   Daniel Vacek <neelx.g@gmail.com>
Date:   Mon, 8 Apr 2019 21:33:55 +0200
Message-ID: <CAA7rmPFHSgA04V3jhPgdxJOmKGBRMo6d7TUxwrfuXeW=xQUEBA@mail.gmail.com>
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Bernhard Landauer <bernhard@manjaro.org>,
        Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 8, 2019 at 7:31 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2019-03-29 09:38:33 [+0100], Bernhard Landauer wrote:
> >
> > > How do I reproduce this?
> >
> > For me this happens reliably when I launch a fresh instance of ff and it
> > automatically tries to restore tabs of the previous session.
> > Alternatively, when I select 'Restore Previous Session' from the menu.
>
> Does this help?

From an uninvolved lurker, how is this supposed to change a thing?
Moreover, I'd say the original version is better readable.

--nX

> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> index ca95ab2f4cfa3..8744d20ac1681 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -278,9 +278,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
>
>         GEM_BUG_ON(!i915_request_completed(rq));
>
> -       local_irq_disable();
> -
> -       spin_lock(&engine->timeline.lock);
> +       spin_lock_irq(&engine->timeline.lock);
>         GEM_BUG_ON(!list_is_first(&rq->link, &engine->timeline.requests));
>         list_del_init(&rq->link);
>         spin_unlock(&engine->timeline.lock);
> @@ -294,9 +292,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
>                 GEM_BUG_ON(!atomic_read(&rq->i915->gt_pm.rps.num_waiters));
>                 atomic_dec(&rq->i915->gt_pm.rps.num_waiters);
>         }
> -       spin_unlock(&rq->lock);
> -
> -       local_irq_enable();
> +       spin_unlock_irq(&rq->lock);
>
>         /*
>          * The backing object for the context is done after switching to the
>
> Sebastian
