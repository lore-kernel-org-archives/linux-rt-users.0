Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A086C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B026126A
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Sep 2021 14:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349090AbhI3O0w (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348704AbhI3O0v (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Sep 2021 10:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633011908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5J2i1+Tns155iDTwCFKymj+YK2kxhhJ9HJuNojxRrQ8=;
        b=GIGAcYjiAaxj5kS4ytkSe0AlSMZsuZz+ieAwy/MN9+aMKlm7CJjZGv13mKwuhCeE/P5vgY
        9Lh3/bC8LkQ7r3Qjh5wL4IfXM1Oklr36HMQI8xHf+aVJuDXr+XQCHDjZXTXVo+H1WG2cEF
        YL8cZdPaPbxxrDoIJbGRPSDD7ffxboM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-LKTbxxnWMvmDOyCGfBvhrg-1; Thu, 30 Sep 2021 10:25:07 -0400
X-MC-Unique: LKTbxxnWMvmDOyCGfBvhrg-1
Received: by mail-qk1-f198.google.com with SMTP id m6-20020a05620a24c600b004338e8a5a3cso13472937qkn.10
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Sep 2021 07:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=5J2i1+Tns155iDTwCFKymj+YK2kxhhJ9HJuNojxRrQ8=;
        b=BJDkWUyO5hy0LzXWwlxdHP2uR2vR6s+Nr7ejc+vpAsoqTsSc53oDXPPlieenVgEJGN
         vRWd7v2oGQBnnk0PXmnEThRLwp5zt92wNO1E7vadKj9IhFZ+vQU6HSZ3XK2w+qqaRGel
         LTkVdjnvWVJOJD24POZJuQQJfFOUZOmjfDRA4S/o5DH1w40z30a9YSZYwNsqUzbCmnwr
         a9n4eXT/m6k/4xxgjM6sThhkxcA8EgjACVW4NU3qUNze0jbDjFIYKcOZRJ6NuNm999I1
         9A64PM95O48V+QJ1QmAJkkjIhtP5rJTHTjTGC9habh2p6qSpV4zRe+nf6z7xppeuymba
         mDkg==
X-Gm-Message-State: AOAM5318hUQykm0K0n010S+Gka7xezhngASOZK7GSz764CzToLYSwTUD
        6NIQ5n+6m7dDAbwoOFg50GOgSpBMPAxdjvfMD/uUy23Q6fm77ZORfV64R39wRbfa+Af8cwiw4jA
        5NEyvk0dnM/uw6dkSe80d4y624A4=
X-Received: by 2002:ac8:4e8d:: with SMTP id 13mr6673733qtp.2.1633011906587;
        Thu, 30 Sep 2021 07:25:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB3sZEHfoGl2OoYlBtq47k04dWWiHPZSQROTgkmHMKfJUd7KnJfQS3wSASBrpmbYBZuZvZiQ==
X-Received: by 2002:ac8:4e8d:: with SMTP id 13mr6673713qtp.2.1633011906392;
        Thu, 30 Sep 2021 07:25:06 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id l1sm1692168qti.94.2021.09.30.07.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:25:05 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:25:04 -0400 (EDT)
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
Message-ID: <6034cc70-fb69-d9d-ce31-673d4d42adc@redhat.com>
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

Where does this "--latency=" option apply to?

John

