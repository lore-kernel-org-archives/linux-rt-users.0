Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD5BC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 01:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F7B6120C
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 01:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbhI1Bst (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 21:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238479AbhI1Bss (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Sep 2021 21:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632793629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3DAL6g6GgZUmHorTtFnFN+ym37iFtZRzgp8p+oY6tM=;
        b=hZAjRTca57b7JmdMaUOb5xsscIaONAqdrgUyTd2qQSYUeGFsEPn7DS6V7yjkhTC5qAAth4
        JRpk/2opyRl3AJySBgdgvu+oZr4Vw0Lm6LWbXxqlJ3W1nS4NigXXpfiSDO9q1CBgzyt8rV
        uyXWY9hE3X4W034wk9/vpTPwuaV7U28=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-LjOyRARYNNitGP5aheQTjg-1; Mon, 27 Sep 2021 21:47:08 -0400
X-MC-Unique: LjOyRARYNNitGP5aheQTjg-1
Received: by mail-qt1-f200.google.com with SMTP id x6-20020ac81206000000b002a6e46bbd0eso40187566qti.12
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Sep 2021 18:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=h3DAL6g6GgZUmHorTtFnFN+ym37iFtZRzgp8p+oY6tM=;
        b=JSZzRSZ4/6AaZ8orWPz+1ELOQN8uz2s3Zd5z1c4Y+5IaKMTnjXBNZa8ybkAQbkE73h
         NoZpYYP4DxHZLgEcC4wgylMp63Keo2SQ5NgOz/vM/sXqYmQqwhHWPqfCiVDGnfIQdH8v
         sb/QaegsNGtYop5SInG0N1VSKpZEtfGBR1a5WFwLs/RYpp5FCREfz0Ks1T4JUJA4M062
         dMan+u2ziGPK+09mzEPCAmOw2Ha5JG55qZtO0uT3xf0z5U5rlgXT8GiKXynt3zr9srPK
         cbRWZVM4jaJAY3tqdxTkdmqsGwgQkS40fauERWLBz/VuhC+q33ymjgdNirt1mmiE0UJV
         kReQ==
X-Gm-Message-State: AOAM533e6NdnDGs3DmgWsCNoEViPEvZAT3iygulVtp/F7qyh0bdDpisg
        mVVqwm3JG/j7MM/ZULLgwFRwcq1nybZSA7Qs2DLq1p+VA7VsnwHYAzaJg46HnPqmQfI1Gsjf12K
        dimFuG0UMzqNkvY4gcW0Cecemafw=
X-Received: by 2002:ac8:5f0a:: with SMTP id x10mr3150226qta.175.1632793627912;
        Mon, 27 Sep 2021 18:47:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjuNGtctF5yMhB3QkhZSNjf0L9gDshIJ2bnhvC60FHhDpHBKSwbglG0kg5bJIJ7iyNpmxsfA==
X-Received: by 2002:ac8:5f0a:: with SMTP id x10mr3150217qta.175.1632793627745;
        Mon, 27 Sep 2021 18:47:07 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id h8sm10697157qkk.11.2021.09.27.18.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 18:47:07 -0700 (PDT)
Date:   Mon, 27 Sep 2021 21:47:06 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: Re: [PATCH v2 0/3] rteval: Fix issues with cyclictest.py module
In-Reply-To: <87k0j15vmw.fsf@stealth>
Message-ID: <fee20fc-3243-bbc5-898-5aacdd9136f1@redhat.com>
References: <20210917085343.2775300-1-punitagrawal@gmail.com> <87k0j15vmw.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 28 Sep 2021, Punit Agrawal wrote:

> Hi John,
> 
> Punit Agrawal <punitagrawal@gmail.com> writes:
> 
> > Hi,
> >
> > Here's an updated version of the cyclictest fixes previously posted at
> > [0]. The changes in this version are to address feedback received on
> > the previous version.
> >
> > v1 -> v2:
> > * Patch 1: Add an option (default off) to save cyclictest output
> > * Patch 3: Sort cpus returned by online_cpus() in cyclictest.py module
> >
> > All feedback welcome.
> 
> Ping!
> 
> Perhaps this set slipped through the cracks.
> 
> > Thanks,
> > Punit
> >
> > [0] https://lore.kernel.org/all/20210902092452.726905-1-punitagrawal@gmail.com/
> >
> > Punit Agrawal (3):
> >   rteval: cyclictest.py Enable logging cyclictest output
> >   rteval: cyclictest.py Parse max latencies from cyclictest output
> >   rteval: cyclictest.py: Sort the list of cpus
> >
> >  rteval/modules/measurement/cyclictest.py | 44 ++++++++++++++++++++----
> >  1 file changed, 37 insertions(+), 7 deletions(-)
> 

Thanks for the ping, but I haven't forgotten this, I just haven't had time 
to go through it properly yet. It's on my TODO list.

Thanks

John

