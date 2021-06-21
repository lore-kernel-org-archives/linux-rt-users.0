Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11517C48BE5
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Jun 2021 05:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07EF61059
	for <linux-rt-users@archiver.kernel.org>; Mon, 21 Jun 2021 05:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhFUFiS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 01:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhFUFiQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 21 Jun 2021 01:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624253762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RY9DMg40/fTZjgZ6Fij6lpyg1UQhKJ1773t8fOZ+VDA=;
        b=bY5Mfnl28dGVvXZNr8kKAjgrrErejNe+BHkNTHets1ITlOy7XcuiWKUZzMgaNzRu7ICpPh
        qh60vspnyEW58IriZbGFvPZaz+XgOSR0Pj/HywVF5wYV5Jwy0ExD+CIxcPDPbOqtOAKd4I
        CJQrDZOogG38be0V0Q9WWlYZTvS3x0Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-M8aklUbUOGa4y7s4gBPtKA-1; Mon, 21 Jun 2021 01:35:59 -0400
X-MC-Unique: M8aklUbUOGa4y7s4gBPtKA-1
Received: by mail-wm1-f72.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so3024809wmj.7
        for <linux-rt-users@vger.kernel.org>; Sun, 20 Jun 2021 22:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RY9DMg40/fTZjgZ6Fij6lpyg1UQhKJ1773t8fOZ+VDA=;
        b=SwJ26DHwq37zdgpEXovc1fhoKgmcJBZuJsO0eGws4aARoFAStB2c7jdB+AvITRCVgP
         96Aw9fkB2jV+UivF6IYVfEgv6LlPg/i6wuROWMJKBipwSA3LG4gBPAWnR24VH67/ekc1
         +EEZvzByJXMgjrg4bGD4fGK1vz/gDRFQ2tFk3qk9p5ESE4SCTAPXNH8jK711SNXYl6Y4
         hRJ5P8PhYhebVjlytDe4/ngUhtJtJ4WHg8DIDxgGOOJ/StEMqImt63I/ny5hYunZQJn5
         G3rbvwPcQjODJrgIV/o+Ae7Py0K362yZuYS8QjzSjJB90N1fLfT5wc7Q3ChXCPGt6tql
         2i3g==
X-Gm-Message-State: AOAM531WTJutY1+AMDN8jz9RgCRIJ92Uvc59rZa4IZ0oijf8/AX4ZkKS
        MkHJe1Ne+ublURwPZPp+/LSAw4C0NGcuHM7Cn+voeiIAgyngXevLQ5wRA8aLXBmka3DwdjJ/2r/
        oRx7MgQe/MMT38GURATHV4cicIUY=
X-Received: by 2002:a5d:6583:: with SMTP id q3mr11825343wru.360.1624253758476;
        Sun, 20 Jun 2021 22:35:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNVzD02BSHJ5YfAF1/SPXAwkkudd9JO9SOY1nKn8HyLYLX4v9IpbakIlVA1prWMh7+0Pf55Q==
X-Received: by 2002:a5d:6583:: with SMTP id q3mr11825334wru.360.1624253758292;
        Sun, 20 Jun 2021 22:35:58 -0700 (PDT)
Received: from localhost.localdomain ([151.29.58.33])
        by smtp.gmail.com with ESMTPSA id f19sm16229383wre.48.2021.06.20.22.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 22:35:57 -0700 (PDT)
Date:   Mon, 21 Jun 2021 07:35:55 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH RT v2 1/2] time/hrtimer: Add PINNED_HARD mode for
 realtime hrtimers
Message-ID: <YNAlO4CScpaj65HG@localhost.localdomain>
References: <20210616071705.166658-1-juri.lelli@redhat.com>
 <20210616071705.166658-2-juri.lelli@redhat.com>
 <87k0mqeofg.ffs@nanos.tec.linutronix.de>
 <87bl82e19d.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl82e19d.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On 19/06/21 09:56, Thomas Gleixner wrote:
> On Sat, Jun 19 2021 at 01:35, Thomas Gleixner wrote:
> > The wild west of anything which scratches 'my itch' based on 'my use
> > case numbers' in Linux ended many years ago and while RT was always a
> > valuable playground for unthinkable ideas we definitely tried hard not
> > to accept use case specific hacks wihtout a proper justification that it
> > makes sense in general.
> >
> > So why are you even trying to sell this to me?
> 
> I wouldn't have been that grumpy if you'd at least checked whether the
> task is pinned. Still I would have told you that you "fix" it at the
> wrong place.

Ah, indeed. Pulled the trigger too early it seems. I'll ponder more.

> Why on earth is that nohz heuristic trainwreck not even checking that?
> It's not a RT problem and it's not a problem restricted to RT tasks
> either. If a task is pinned then arming the timer on a random other CPU
> is blatant nonsense independent of the scheduling class.

Agree. Lemme look more into it.

Thanks for the comments!

Best,
Juri

