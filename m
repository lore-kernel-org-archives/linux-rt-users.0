Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74032C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 12:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED2B6139F
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 12:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhJDM4o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 08:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233382AbhJDM43 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Oct 2021 08:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633352079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDMOTTa6jEEZtotbr1EQGbUHLY12NHeNiVcv6zltgMs=;
        b=jU2ITTpXN3oKFzUNtBpvdT7pfbbbqVdR+aycL0IVCZWd9TGeRViafJwuylj1vVQNzmJvct
        9FIo79MEVb104WzrnZC3boiUV+3xrhTm1BTRL4e9fQxfaboFUNo7dZ1L+5xOsPr5iPJ6pj
        1EiOhZH7w9fKnC7pfOx8bnHM2aFDpZc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-5dL7S0juNzS1UGQWz8YPpQ-1; Mon, 04 Oct 2021 08:54:38 -0400
X-MC-Unique: 5dL7S0juNzS1UGQWz8YPpQ-1
Received: by mail-qk1-f199.google.com with SMTP id b189-20020a3799c6000000b0045eb0c29072so5107743qke.12
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Oct 2021 05:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HDMOTTa6jEEZtotbr1EQGbUHLY12NHeNiVcv6zltgMs=;
        b=bJwYksbaHDZmrxqPB1QizuICUtaUvAJQPhZinNbdjZ/9/9W6jIWEMWmG/gRDIir/Ad
         iNBY85hC38kFXjX+qocwWPexpZJX9SDV1zV7N/xCdv9YVOAI7FROwcWPXTuf+t4oOy8Q
         tOCPMACCl+M8z1i1LGWb9lnZ6UOk62uxdmOJIbpFJJbic59Vcw+pdLMpesimYeBxTcSV
         avMVgGUXWMwmhnVeSOzetcBAyzBA0M6L9aNWgNly+apxGMA8RUz2y8dFEfRMFTv2AECs
         ag+eRzDi4L96GyXI7ZlWadk8cgUMOowCBCyzv8TxjqiYfrrGIQaq7O/B3s76DAEjXriu
         Pvkg==
X-Gm-Message-State: AOAM533lQI7+SNTIe/VhV5NJJqVAmj271f696FLwKRrMaPh+/xBlTln3
        zoKNxD3lTGB3xJiWCgz/j98PT9yT1OZdSOyDBcZ4wPxtHjKFxvcwWM759j/qDCDtLcoQE4Rkqvf
        M7SJxjzpvBqlqnxoimUI+fIgNqJM=
X-Received: by 2002:ac8:4117:: with SMTP id q23mr13045219qtl.390.1633352078274;
        Mon, 04 Oct 2021 05:54:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaHW7afybJ3X1Cr47J9PI1EUVgqjzXp8kfusgSxx+UWcou/2+Nh70np7eeVT0egSY4w9s+cA==
X-Received: by 2002:ac8:4117:: with SMTP id q23mr13045193qtl.390.1633352078041;
        Mon, 04 Oct 2021 05:54:38 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id k10sm7748929qkk.124.2021.10.04.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:54:37 -0700 (PDT)
Date:   Mon, 4 Oct 2021 08:54:36 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Jack Winch <sunt.un.morcov@gmail.com>
cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Pierre FICHEUX <pierre.ficheux@smile.fr>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
In-Reply-To: <CAFhCfDa5TQaEO_ZZwa0Y4v2Uy-B6=9B767gWw3z036bxz6Wsbw@mail.gmail.com>
Message-ID: <a37b2bd4-e141-675c-cb4a-164da3bc3358@redhat.com>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com> <87y27e53a2.fsf@stealth> <20210930132319.eixnv6rb66ui6x6j@linutronix.de> <CAFc1U0uMuj1PPmxPQTTVqscYsnKfOE+sjtasK9KqadkgaUgLSg@mail.gmail.com> <20210930135145.mdlzzwp64yykixhx@linutronix.de>
 <CAFc1U0sYdJQWkeLgPjiR1Y1CnafV22zgS4AW0Yf6+h7CO03u+g@mail.gmail.com> <871r554opi.fsf@stealth> <CAFhCfDa5TQaEO_ZZwa0Y4v2Uy-B6=9B767gWw3z036bxz6Wsbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sun, 3 Oct 2021, Jack Winch wrote:

> Punit Agrawal <punitagrawal@gmail.com> writes:
> 
> > > If I remove this default we're going to get a slew of reports from people
> > > using cyclictest wondering why they aren't getting good realtime
> > > performance.
> >
> > Perhaps, this is a change best done with a major version bump. Not that
> > it'll stop users queries completely but hopefully more people will pay
> > attention to the changelog.
> 
> Regrettably, I know quite a few RT Linux users who are neither party
> to this mailing list (due to company IT policy), nor do they pay
> attention to the changelog.  Even less read the source code of the
> rt-tests suite of tools.
> 
> Regardless of these sorrowful facts, as this is such a fundamental
> matter, perhaps it would be useful to highlight this behaviour of
> cyclictest in the tool's documentation - specifically the program's
> help output, manual page, and related content on the RT Linux wiki.  I
> see additional information going into the first two forms of
> documentation as a required step.  However, I believe that adding
> information on this behaviour to the relevant pages of the RT Linux
> wiki would also be greatly beneficial.  This is because many
> developers who are new to RT Linux development, in my experience, tend
> to make use of the wiki to 'orientate' themselves when first starting
> out, etc, and the omission of information regarding this behaviour
> could lead to wrong assessments and conclusions being made when using
> this tool.
> 
> Jack
> 

Don't worry, I try to keep the help and man pages up-to-date so you don't 
need to read change logs. If you see any problems with help / man pages
either report that to the list and cc me, or send me a patch.

Thanks

John Kacur

