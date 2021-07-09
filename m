Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A34C07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AE2613D3
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 18:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGISLu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhGISLu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625854146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xuN5427iu8r2KmYxzTEJNRzFWaytg2fM0WT7qMSpuM=;
        b=iPWjGQnvkg2j1arHWKubGXHYTf+q3kOqCpyzDO6yCDo7BKTLGBI2WsZAfLvu07J81o7Pju
        ULEUMP9pegZGkdLqzqyCsMD7IeQBtmkB/9Q2lue4c8FKrhf2GSoChBqmmkmr4BMY73rMuM
        l6zPubLaFZlmZJhFV8lBV+Ya7so9HN0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-d5QpPmi7NTyNdgNGeYOa_A-1; Fri, 09 Jul 2021 14:09:04 -0400
X-MC-Unique: d5QpPmi7NTyNdgNGeYOa_A-1
Received: by mail-qv1-f69.google.com with SMTP id u40-20020a0cb9280000b0290290c3a9f6f1so6905290qvf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 11:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1xuN5427iu8r2KmYxzTEJNRzFWaytg2fM0WT7qMSpuM=;
        b=poTAd9fubJhC7gIFNVbmgftRS0ziyjtUzufgIdwEKKgUplQRStS0lOxbCJCUs5ULgv
         NqrmAqoDvkuO2B27E9Rcte8T/l29r8zJiLhNzbnSjfkniR5gsLEeL+hMNaFdq84YMc2u
         dJYoKn1+6jC3YhVeWFoGHdFMPQVvoRAUwQB29bJQRCCAWr0PmLm/ArMRmOFvQjHXC9nk
         JSgvUOF5q4TP+ZWwb0zmyvuQFdHtTaTPEOtkMwchELp5xCDHSM0ZMuMQopv9gzSATAf/
         jc8S6dnCmkWQQXNrLoWDuem80rY+re3oyfSFd9Zgs/uIvumhr7U6Cmkgx+UrUAoG0yXh
         WNJg==
X-Gm-Message-State: AOAM533Rf/uQm/Hj0RV1ioSmtgstzeJgHcRm2c0xmKbjFq3o5NypKX3V
        jk57NUHBhruvygj7mukVPLe7/XKnbVwhBPj2GXLSyVWXKiu42fip8yg1llFcczqh0jvie4krox5
        NMHulf7PAN5XJhE66AWG5PzM62TI=
X-Received: by 2002:a05:620a:a1d:: with SMTP id i29mr38439975qka.311.1625854144427;
        Fri, 09 Jul 2021 11:09:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ2kUuDJmMvCQtP8pZXP3IVFEgLu+zJtqVDj/mFrA/n+tJEn0feDOjq/DKYOpigURDpvMAzQ==
X-Received: by 2002:a05:620a:a1d:: with SMTP id i29mr38439961qka.311.1625854144315;
        Fri, 09 Jul 2021 11:09:04 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id 67sm2432928qtf.83.2021.07.09.11.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:09:03 -0700 (PDT)
Date:   Fri, 9 Jul 2021 14:09:02 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Peter Xu <peterx@redhat.com>
cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH 2/2] oslat: Don't take trace_threshold into account during
 preheat
In-Reply-To: <YOXoHTxdH2kxM95u@t490s>
Message-ID: <20336e4b-424-d5b5-1245-6812c4e751c3@redhat.com>
References: <20210707084849.304329-1-nsaenzju@redhat.com> <20210707084849.304329-2-nsaenzju@redhat.com> <YOXoHTxdH2kxM95u@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Jul 2021, Peter Xu wrote:

> On Wed, Jul 07, 2021 at 10:48:49AM +0200, Nicolas Saenz Julienne wrote:
> > The point of preheat is to make sure CPUs are out of idle and running at
> > max frequency by the time the real test starts. So it's expected to
> > incur into extra latencies we don't really mean to measure. With this in
> > mind, it doesn't make sense to take into account the trace threshold
> > during that run. So don't do it.
> > 
> > Note that this has been observed in practice. The threshold would be hit
> > during preheat but not during the real test.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> -- 
> Peter Xu
> 
> 
Thanks, added

