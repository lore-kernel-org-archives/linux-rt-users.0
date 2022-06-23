Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1481C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jun 2022 13:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiFWNr1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jun 2022 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiFWNrV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jun 2022 09:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BA843E5F2
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655992037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VjGZUuw+pcJYSTHXZzUCFNh3CtV1nbgC2Xpfor/4J9g=;
        b=CZVrttM1INXdlqfUFgLvwQVHo/XJCUJeIZvvACDZbrZngXrNJgtVs47MPbgGCYpYmnPpmI
        X/Gg9Q5iwYIx0Lh29Q0AjMxP+ju0jXi9/kd4P7DFBw/ckz0eSegBJmXFGtx5dLh32h9WJl
        TQAA8TswITPPigo2GcIoCJ/+33IMyH4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-8EUaSXyzN_Gzkp_z3PQfZw-1; Thu, 23 Jun 2022 09:47:15 -0400
X-MC-Unique: 8EUaSXyzN_Gzkp_z3PQfZw-1
Received: by mail-qk1-f200.google.com with SMTP id i16-20020a05620a249000b006aedb25493cso5646464qkn.15
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 06:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VjGZUuw+pcJYSTHXZzUCFNh3CtV1nbgC2Xpfor/4J9g=;
        b=uEdUlDHJk2W8f1SoBVQ74f7tnsCQKZDUkjo5PT8zdJFNCra8xWWUzL9iQ3sjsAlEXM
         GTCDHHGlrRGhXTgXS4rR0cIdfEKFw/KBJKDY/eCgd6hL71Tm8WGJD9j+I7Eig6zYnWTd
         3cJ5qW+tbg29CnFVK+McqLzylNtvhGThfOUmAoqzHuty89MiDtOznez+uvsbwcBWNekZ
         Y0OzkF4FCO/a3wwN6PDyck84wSBhODd5ejrwWdRFE/nR5oQrSmMibz9Pwh6VF7W11TIG
         gd+4kvuONyFjFoO9L8cWt3i6F+1pAej/ut7tiony5u7W78YKpT5knq4i3dz2banXm9oo
         v8dg==
X-Gm-Message-State: AJIora9ZjcgfYT4kq+npTV52w0Jroc5e+GcxGczW2b1MOjP4juVnyQUE
        NJrsAwZ3F3QBIKcMSdsbjnzBbrw4tNG5IxgxEq04iWRJO7v7rvyS+R9Dtkrse1TdIt3aOcPtKP1
        hhxag0y7y9qzOvkx3ynDsXBOYRuM=
X-Received: by 2002:a05:622a:1889:b0:304:f656:6b09 with SMTP id v9-20020a05622a188900b00304f6566b09mr8088901qtc.287.1655992035262;
        Thu, 23 Jun 2022 06:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s23k76Jd3jD8OiHkTJh2nRU1bM9lpRHRRbI578EkPkQhi7hDABN6ZV9dgbVebpzX12d8XyLw==
X-Received: by 2002:a05:622a:1889:b0:304:f656:6b09 with SMTP id v9-20020a05622a188900b00304f6566b09mr8088873qtc.287.1655992034932;
        Thu, 23 Jun 2022 06:47:14 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.194])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a0bcc00b006a68fdc2d18sm17822971qki.130.2022.06.23.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 06:47:14 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:47:10 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] WARNING at hrtimer_start_range_ns
Message-ID: <YrRu3qnXT95HQhRh@localhost.localdomain>
References: <YqnygxNWOztakt8+@localhost.localdomain>
 <YrREi3qSDfNek9S1@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrREi3qSDfNek9S1@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 23/06/22 12:46, Sebastian Andrzej Siewior wrote:
> On 2022-06-15 16:53:55 [+0200], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > My understanding is that we have
> > 
> > fs/aio.c::read_events
> >   wait_event_interruptible_hrtimeout
> >     __wait_event_hrtimeout
> >       hrtimer_init_sleeper_on_stack <- this might mode |=HRTIMER_MODE_HARD on RT
> 
> will set HRTIMER_MODE_HARD  of might set HRTIMER_MODE_HARD if the task has elevated priority
> (RT/DL).
> 
> >         hrtimer_start_range_ns
> > 	  WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
> > 	  fires since the latter doesn't see the change of mode done by
> > 	  init_sleeper
> 
> correct.
> 
> > The attached patch seems to cure the problem, although I'm not entirely
> > sure it's the cleanest fix (if I'm right at all about it :).
> 
> The problem seems to be that __wait_event_hrtimeout() does
> hrtimer_start_range_ns() instead of hrtimer_sleeper_start_expires(). So
> if you switch that, then it should go away.

Ah, indeed. That looks simpler. :)

Will test and put a v2 together.

Thanks!
Juri

