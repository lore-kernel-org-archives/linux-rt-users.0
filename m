Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A501C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 17:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55D76108B
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 17:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhIJRBX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhIJRBW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Sep 2021 13:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631293207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rj79Iw4i4QaQsJ7ltQNotIkO7keSLqd87PL9Qu9Znm4=;
        b=jMJtp7SQEDPHayYkM2AorZCvsFoRLdNWNCbu06hUe5w1vvImVvv2F1jltN/OtJAPOrs2L6
        zU0o8C+FpxoijGW/eedoSanfpijUPf5+JrdMjf/j2nO5/FE9TQHRD81k40DWGXEurXZwB1
        fxeo3cIsbb90awh8bv49ZbXQpSXHk/E=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102--cNLNfVhMVu1AJlr9IBHjQ-1; Fri, 10 Sep 2021 13:00:06 -0400
X-MC-Unique: -cNLNfVhMVu1AJlr9IBHjQ-1
Received: by mail-il1-f198.google.com with SMTP id o12-20020a92dacc000000b00224baf7b16fso4823662ilq.12
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Sep 2021 10:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rj79Iw4i4QaQsJ7ltQNotIkO7keSLqd87PL9Qu9Znm4=;
        b=Nky+g9/i94xGiqTzQkDja0no91tAbP78G8mn8FQ3x2Eqqd28GmoJuC8b7lgS77y+7s
         hemBKbkgqd9bSccvAHhdDT4IbZwTSreGGnYN6ydFRG0ykAwlG0FSTYTUsgtBZ6XUDSZU
         LzjMuwrkhtGGFULbEUCvGNjIOMQ9bmKO834KXRfU6It4XmppyLV3m/MOsG+2Q3IiM+px
         scUcf1yeByVXxa0yCEmZ/BQorsLK2z/kjHBMU6MiFVRTEeqp3eEKMhpA2N9lWR6wEYGz
         xK/gDNlCmB0ez+u9xEVNq22lKHde4DqXlfT3XWl+GPVHZWPeINUyUMciMkXcWphQak0g
         Yh1g==
X-Gm-Message-State: AOAM531a/Z3S1cZq/eNkA313zxE21KC42Ht1IGreI1ah5SOK9P2mfBPT
        t0CEx8DHgs6X80bBGcys0Ogb4ffdC7zoqAXnDoQFy5PGum+7h2CdDBNG6444SzB4z/lTdDwjPjx
        uAWIwZD1TUXpuTxMtr9ybVz15TIs=
X-Received: by 2002:a05:6e02:805:: with SMTP id u5mr7114824ilm.223.1631293204462;
        Fri, 10 Sep 2021 10:00:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMa2FsJnt7VdhGrWRUpRyvHvQl6Ja7v4IFRHIxtdb8D11o8kD1oZ4vTyqADRhABCegU7gb5A==
X-Received: by 2002:a05:6e02:805:: with SMTP id u5mr7114809ilm.223.1631293204262;
        Fri, 10 Sep 2021 10:00:04 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id c10sm2724590ilq.77.2021.09.10.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:00:03 -0700 (PDT)
Date:   Fri, 10 Sep 2021 13:00:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     nsaenzju@redhat.com
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 2/3] oslat: Add aarch64 support
Message-ID: <YTuPElzm4lwm+7iT@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
 <20210908100209.118609-2-nsaenzju@redhat.com>
 <YTj8Qgawnh1xPrDJ@t490s>
 <466f7d726df2dfec8ac83a9d3f603439e3cec1b1.camel@redhat.com>
 <YTpMe2+58YxJ0IFM@t490s>
 <6a2eba408dc4260a47c1acfe743474bb39aa93bd.camel@redhat.com>
 <YTtekExun9GoaFvc@t490s>
 <1f3916ebd3bb9d886dee56404127308a7be8098e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f3916ebd3bb9d886dee56404127308a7be8098e.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Sep 10, 2021 at 04:27:05PM +0200, nsaenzju@redhat.com wrote:
> My understanding is that can only happen when the expression to right of 'a'
> has no dependencies with t2. And at that stage, do we really care? Well, yes,
> for example if you're measuring how long it took to assign a, which is similar
> to what we do:
> 
> 	workload_fn workload = g.workload->w_fn;
> 	frc(&t1)
> 	workload()
> 	frc(&t2)
> 
> But in that case the compiler is forced to handle the indirect function call
> and IIUC there is little optimization todo, so we're safe without barriers.

Yep.

> 
> That said, I don't feel overly confident about all this, and there is little
> downside to the compiler barriers, so I'll just add them.

Yep, too.

IMHO that's the point (even I know it's trivial and I'm harsh :-D) - we don't
have a reason to drop it if it helps us to make sure there's no surprise.

Thanks,

-- 
Peter Xu

