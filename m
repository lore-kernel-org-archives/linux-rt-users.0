Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B9AC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 14:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B4961A10
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 14:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352036AbhI3PBg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352030AbhI3PBf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 11:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633013991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3rV1uN9c2PZhysJ6jDPgCRqzSF1NJtH2qovGl7EzLU=;
        b=ZsZO684yFBRdGFzLLEI9FtMlqnCaTxZmaWwfE/Jth613e1PdBr20sQ0qLENU47kDiGPhGd
        STPv0ANtq9kap0MWQKTyuXbHSLg1MQdNc99xrxt8IwcA5AwedB2kybs1ZprqlOkTqiH7yL
        PBSbg4anG12XgovVuA93DX6gXew5T+k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-lEy6Z83VM6eCuYivNFIHmQ-1; Thu, 30 Sep 2021 10:59:50 -0400
X-MC-Unique: lEy6Z83VM6eCuYivNFIHmQ-1
Received: by mail-qk1-f198.google.com with SMTP id s20-20020a05620a0bd400b0045e893f2ed8so1015189qki.11
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 07:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=m3rV1uN9c2PZhysJ6jDPgCRqzSF1NJtH2qovGl7EzLU=;
        b=tq2G8CqZL2dUueh0pMHEyxvsdbc3GvINKdM0qaGajzchEK6wCkp9PwqI55JcjVVpbY
         5h8FmyqdXxtc5KFidnU5pfl67h+lq23f8AKKynWiTlsSD3uYlwSgegVK+VVwa7xzeGMx
         nQ62lD4Ya0LKwivzadUDcQz2S56V4r42IStluCZmNi1DAmL+pG99QL4tmD7b9bLlCTsj
         Ahe9Mb1FAsC40WU448DiZeFOvdrscBkuOG8CBnhJbTt2hwOQBG08kLgU7tEEjxEAtO4P
         y5iBCaQx1voaTcoxPa06Nbc+G7a565f9lbyDce3WBBEv3/rj3i8+1jE1XdnoB5EWUy0Q
         IPqw==
X-Gm-Message-State: AOAM531a3A3qMXrdjRAYOlBRdbqpYi6nSDrQt8xE8hrjm4QwJOpR7M2c
        KGW6whR+Y9jtK7NMUl+6I5mM5eJ9CcyFXJ/0LP2roBZLa1rNZ3YLBXJgM2Fa5iDZsmFqe6x1UlE
        KTsaHV5HadtN5wcgmnIyNy8hyf8M=
X-Received: by 2002:a37:2714:: with SMTP id n20mr5201705qkn.221.1633013990358;
        Thu, 30 Sep 2021 07:59:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEezvj7xu1tM5pDS0meNc8KH+z9QVgHXpdf7STHKm2w5G7yq3bCggaJz3IKdUB6/hPfFmejA==
X-Received: by 2002:a37:2714:: with SMTP id n20mr5201688qkn.221.1633013990170;
        Thu, 30 Sep 2021 07:59:50 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id f13sm1748076qto.63.2021.09.30.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:59:49 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:59:48 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Clark Williams <williams@redhat.com>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
In-Reply-To: <87v92i9o5t.fsf@jogness.linutronix.de>
Message-ID: <dabf30d5-283d-72f6-6fd9-33bc1be0c87c@redhat.com>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com> <87y27e53a2.fsf@stealth> <20210930132319.eixnv6rb66ui6x6j@linutronix.de> <87v92i9o5t.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 30 Sep 2021, John Ogness wrote:

> On 2021-09-30, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >> With hackbench, the system is sufficiently busy to avoid the going
> >> into idle.
> >
> > Not just that. cyclictest's usage of /dev/cpu_dma_latency has the side
> > effect that it may disable some of the PM stuff in the system.
> > So your system appears good but then when cyclictest is gone, the
> > numbers go up.
> >
> > Maybe we should drop that so we observe a system without altering its
> > behaviour?
> 
> +1
> 
> Developers wanting to explicitly cause this behavior can use --latency=
> to enable it. Having it on as a default is misleading.
> 
> John Ogness
> 

If you pass "--laptop" to cyclictest then it won't use the trick of 
writing to /dev/cpu_dma_latency in order to save battery power.
It doesn't matter whether you are really running on a laptop or not.

John Kacur

