Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C1EC433E1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DE620866
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpbbzAhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHGNoJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbgHGNoD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 09:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596807841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3ELIvI6TpDrr/hDE1zUqdW6bJnAxebAFwCmn25rdY8=;
        b=fpbbzAhfoW6wUdE5AtWkVt1WvWg5T4GkaRAiAWrLwcjQcPBFdijE8xew/XJa4PCUclk9Ej
        GMe/kkQ1+KMB0kOAYWxxg5Yq2qKl6mkOKFnsk+gJy7c9und+9wVQGPoxEZMl2Se5L7yXk6
        0b9g7PybgJFV6DRWrBFdLvAaxyAJdX8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-ZT7TQhAyOLOo-SwJQP3cwQ-1; Fri, 07 Aug 2020 09:43:57 -0400
X-MC-Unique: ZT7TQhAyOLOo-SwJQP3cwQ-1
Received: by mail-wr1-f70.google.com with SMTP id e12so771516wra.13
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 06:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E3ELIvI6TpDrr/hDE1zUqdW6bJnAxebAFwCmn25rdY8=;
        b=qSyd/aPX+OGqO9SE3nshXPaG+TaJAh7X661BAEoJslhJouZhn/TFaA4IYhHVc194CZ
         SF2/oMWzOIYkFh5NzJIlhfG8/FwbfH16QhDDraoCP2+1vraQcEp3JKxOWSrDEzeOmDsR
         semr0hFyq+NsBhm0uSOioXy8KAZnJv40eBd/lQKTD1AhFzuVsaGA8DS/aYpHMibWWfaK
         i9KJXaThi/NrCmHpyBG389Z+QjiMuW28IC80LtRXoXwwg1/u34sxOJl7YKw2ySSjI5lY
         HcO+WXrW7wLp7UAeVPtaoKOEH++f8gnM9L+NcyhxWy6fV3lWTGcUMuOv20oDC+L0y+Bf
         zmIA==
X-Gm-Message-State: AOAM530lGRtSVl9vbAU/G8Pfo8sDOZVvP8Zht/FShacZS5f85dGruBMp
        i/XE5FGoXnfSZstE1+OWUq9o5fw1H459ZhH6Z+DhIADaURGZaWZBm0PxYVIHKiittc7codyM8nU
        YrH6oqp9sYExSg6LhQgGSs7nm+8I=
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr13061436wrs.132.1596807836355;
        Fri, 07 Aug 2020 06:43:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5UZXlHxGMHcXSoixKUQYiEtbcK+V2fCweYqEOIb9g4sqOfVUxrdVbtco9HHswxN7U0ixwBw==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr13061415wrs.132.1596807836136;
        Fri, 07 Aug 2020 06:43:56 -0700 (PDT)
Received: from localhost.localdomain ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id j2sm11156302wrp.46.2020.08.07.06.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:43:55 -0700 (PDT)
Date:   Fri, 7 Aug 2020 15:43:53 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807134353.GR42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807152832.591f462e@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807152832.591f462e@nowhere>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 07/08/20 15:28, luca abeni wrote:
> Hi Juri,
> 
> On Fri, 7 Aug 2020 11:56:04 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > Starting deadline server for lower priority classes right away when
> > first task is enqueued might break guarantees
> 
> Which guarantees are you thinking about, here? Response times of fixed
> priority tasks?

Response time, but also wakeup latency (which, for better or worse, is
another important metric).

> If fixed priority tasks are also scheduled through deadline servers,
> then you can provide response-time guarantees to them even when
> lower-priority/non-real-time tasks are scheduled through deadline
> servers.

Right, but I fear we won't be able to keep current behavior for wakeups:
RT with highest prio always gets scheduled right away?

