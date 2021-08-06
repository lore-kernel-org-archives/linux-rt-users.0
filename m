Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80527C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6388760EE7
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 15:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbhHFPkG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 11:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244736AbhHFPkF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 11:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628264389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q8+T0uhv6sxYc8Jil/Nyo0JtuUo6i8K59s1TvrD/OLk=;
        b=Heg/tR4pXdSU37c7v/CFBA7sPjru1+oKR/dk6EX8jf5A0ZnfI+lmT/lMmY+cPo/MVMRT2d
        HPfX3gEAWRDidXfFart28Dq3iAhnAeeVP/k8tSUHiwtQPWWEKpU57q+AzFNyxAj6MF6UxO
        bTUpZKYKwsnUmmZIrC+nLJjer3ceHG0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-aZJ9WnmmMuCd5eWWYhPF3g-1; Fri, 06 Aug 2021 11:39:48 -0400
X-MC-Unique: aZJ9WnmmMuCd5eWWYhPF3g-1
Received: by mail-qk1-f199.google.com with SMTP id p16-20020a05620a22b0b02903ca40d6cc81so1215488qkh.13
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Aug 2021 08:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Q8+T0uhv6sxYc8Jil/Nyo0JtuUo6i8K59s1TvrD/OLk=;
        b=TefeB+JCtk3LqRBHnJY8rF9iEa9Wc6r9TBEvpDBruiGwjiAQINbtNN1gy4g0VRF0/j
         9uPoCV5zD5hsKRzgvHTkTEyuyhhGcVxFuYEmaTZNtVvVmgU/ewAYL72LnoA42/tnFxhE
         uHmTz0oJyrJR9CNt960ClOMTe8+QjIs0pQO4OylTYYC3laDyQbxtf5HTjzxQE7u63NPW
         2PQR2Sc6J4vXEv/ybbUgJOaBpzsNfNI0O68gSooEvwo5wFS0RM7syHWkDr6q6DJCn1EI
         ztturUKtTDbtAq3WXA8uTq3Onos/OH5b0tGjXMkTigsVmU0+GneAU6dV6hHcpzw/lKHO
         yc+A==
X-Gm-Message-State: AOAM533UwiA+Gim3yQm9NG2KcO7xGYlLAlZAtVq4kDQ6jc9BSPv3U51m
        yR/hPGfMVKoFsHVdfREthZRvTGNQbpZeeKiphgD1sjYlTTkv49BMhAxQRkSdZoeEQXs9Vk4acB2
        I4kLPdU0yjBRXnOamyLwa0gQ5WWc=
X-Received: by 2002:a05:620a:1999:: with SMTP id bm25mr9442283qkb.329.1628264388216;
        Fri, 06 Aug 2021 08:39:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxyEv+7SQGgDinRcxeDWeq6ifsPyh7wbvhIu6V/945BUPoVbmiGE/3Qa3S8BbtK0a+Z2iIzg==
X-Received: by 2002:a05:620a:1999:: with SMTP id bm25mr9442269qkb.329.1628264388035;
        Fri, 06 Aug 2021 08:39:48 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id d138sm754494qkg.100.2021.08.06.08.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 08:39:47 -0700 (PDT)
Date:   Fri, 6 Aug 2021 11:39:45 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Alison Chaiken <achaiken@aurora.tech>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: hyperthreading and RT latency
In-Reply-To: <20210806070040.ryvka6lnpn24ink5@beryllium>
Message-ID: <deba8228-b739-b067-1095-bc60836e598@redhat.com>
References: <CAFzL-7sj+Y79UC-CnB+6qDRe7EgPnjb0be63CwEJOfkdCvJYVw@mail.gmail.com> <20210806070040.ryvka6lnpn24ink5@beryllium>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 6 Aug 2021, Daniel Wagner wrote:

> Hi Alison,
> 
> On Thu, Aug 05, 2021 at 01:16:17PM -0700, Alison Chaiken wrote:
> > The advice in the RT wiki
> > 
> >     https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application#Hyper_threading

Note that the above wiki is defunct, the current one to read is:
https://wiki.linuxfoundation.org/realtime/start

> > 
> > about configuring the kernel and building RT applications was written
> > in 2014, when we were on the 3.x series.   That makes one wonder how
> > relevant some of it is for the 5.x series, especially since processors
> > in common use have changed some since then.  Some of the advice,
> > notably about power management, obviously is timeless.
> > 
> > In particular, Daniel Wagner added:
> > 
> >     https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application#Hyper_threading
> > 
> >     "Hyper threading and also out of order execution of CPUs introduces
> >     'random' latencies. As mentioned in power management, it is
> >      recommended to disable these feature (if possible) or carefully
> >      benchmark the performance."
> > 
> > Is the advice still current?
> 
> I don't think the situation has changed. Though, I don't run these test
> on modern hardware on regular basis. The last time I played with it on a
> bit more modern hardware it was still measurable by cyclictest with
> hackbench as workload.
> 
> > Should we RT-users all still turn hyperthreading off?
> 
> Obviously, it depends on your use case. If your application can tolerate
> the added noise by SMT, you don't have to disable it.
> 
> > Given the security vulnerabilities associated
> > with hyperthreading, there are clearly some use cases where doing so
> > is indicated anyway.
> 
> Again it depends on your use case.
> 
> Daniel
> 

The safe answer is always to measure it.

John

