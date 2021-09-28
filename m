Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90544C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 23:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7343D613B1
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 23:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbhI1X1e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243188AbhI1X1e (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Sep 2021 19:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632871553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QV13MBjdua14rMb9BnnEUDYgeP7XOHnJl7L3vYJ7QPI=;
        b=WBaVazHc6RAIYmgBRltLpqZGw82JPA12nmwHtOzSs59o3iG4FsPi4tJilFFkxO03s9l28W
        bnZ7vzzmHLahhvQvAd3k9oYOcU7TOus9PnufcF6qMvWlt4km82fD4AR1IirdydrcSND+Oj
        Mp+q1uNTs/qWW+Pu5mRTNOxGf1ZMj6o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-5Hipu9WuOkCwfeoGZC7hlg-1; Tue, 28 Sep 2021 19:25:52 -0400
X-MC-Unique: 5Hipu9WuOkCwfeoGZC7hlg-1
Received: by mail-qv1-f69.google.com with SMTP id h25-20020a0cab19000000b0037a49d15c93so2134526qvb.22
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 16:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QV13MBjdua14rMb9BnnEUDYgeP7XOHnJl7L3vYJ7QPI=;
        b=VKy2Gjp4/huAKToDqQEbwhiBhsRy/dvyKuixEs7MFDKMZ0FaOPA28swcV1bTQoKG37
         pXfBaeWGMiZSvjoZUBPfrQD60JGAIgDHWsuDSDmaIJhmtFXqad8C2FaljLwguLGjQY0i
         r4o4kdwTZAjidNxjKQdOYmRE9WfwamJJHRaMCwCBA3D8vw0xtrdSg00h2d/Td1HhQ7/i
         TpuXJfTwhpQKF/oCqo0/W/H8YQrS6AkZomndnRwnYYLWwyLdHNoPutJ8ouxQs7X2FZMg
         o0W9FauIt8fQ3jHR0gfU+Is6sgJwp8HrQj1HF1TN1osoBFxb1Nxd46J5DSgueiTMLXdF
         Ma4g==
X-Gm-Message-State: AOAM530gIRgqcdjDmSAlyzQZeesetcBVOFk2vSjP6j5P/F7UHPu+d7pS
        ZlHmSGhWPiRrkx07dC+4WJhiEyAj9dICVMb0N5btMUMUcmGMDxKGR/tmzmEjXWk86jF4g244haX
        uhCkreNPXCA9RACniV6SC37ei2VY=
X-Received: by 2002:ac8:7548:: with SMTP id b8mr8718261qtr.79.1632871552015;
        Tue, 28 Sep 2021 16:25:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKrbxLOZ8lj7t8ZN8ecbCieI6TtpjK3yVcVox9PNoiqBn5Jztq7OX0jHJA1eWAjFc2/CAi1w==
X-Received: by 2002:ac8:7548:: with SMTP id b8mr8718247qtr.79.1632871551817;
        Tue, 28 Sep 2021 16:25:51 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id j15sm476242qth.3.2021.09.28.16.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:25:51 -0700 (PDT)
Date:   Tue, 28 Sep 2021 19:25:50 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org, daniel.sangorrin@toshiba.co.jp,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Suresh Hegde <suresh.c11@toshiba-tsip.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Gracefully handle lack of
 /dev/cpu_dma_latency
In-Reply-To: <87fsto5nbm.fsf@stealth>
Message-ID: <d150ec8a-73ba-53e7-4854-36eb82404c7@redhat.com>
References: <20210928081716.3421463-1-punitagrawal@gmail.com> <20210928085900.3422085-1-punitagrawal@gmail.com> <748d14f-a32e-961-8581-f58be77ca419@redhat.com> <87fsto5nbm.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 29 Sep 2021, Punit Agrawal wrote:

> Hi John,
> 
> Thanks for having a look.
> 
> John Kacur <jkacur@redhat.com> writes:
> 
> > On Tue, 28 Sep 2021, Punit Agrawal wrote:
> >
> >> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> 
> >> On systems where cpu idle is disabled to reduce latencies,
> >> "/dev/cpu_dma_latency" does not exist and leads to the following
> >> exception report from python when using hwlatdetect.py -
> >> 
> >>     FileNotFoundError: [Errno 2] No such file or directory: '/dev/cpu_dma_latency
> >> 
> >> Update hwlatdetect to check whether the file exists before attemping
> >> to write values to it.
> >> 
> >> Reported-by: Suresh Hegde <suresh.c11@toshiba-tsip.com>
> >> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> ---
> >> v1 -> v2:
> >> * Correct Suresh's email
> >> 
> >>  src/hwlatdetect/hwlatdetect.py | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> >> index 12228f45f852..89537a6e371f 100755
> >> --- a/src/hwlatdetect/hwlatdetect.py
> >> +++ b/src/hwlatdetect/hwlatdetect.py
> >> @@ -216,8 +216,11 @@ class Detector(object):
> >>      # use c_states_on() to close the file descriptor and re-enable c-states
> >>      #
> >>      def c_states_off(self):
> >> -        self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
> >> -        os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
> >> +        if os.path.exists("/dev/cpu_dma_latency"):
> >> +            self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
> >> +            os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
> >> +        else:
> >> +            self.dma_latency_handle = None
> >>          debug("c-states disabled")
> >>  
> >>      def c_states_on(self):
> >> -- 
> >> 2.32.0
> >> 
> >> 
> >
> > Thanks! I have a couple of nit-picky suggestions.
> >
> > If you initialize self.dma_latency_handle = None in the init method of 
> > class Detector, then you can drop the else part of your check to see if 
> > the file exists.
> 
> I can do that - but then I wonder if there is any harm in initialising
> the file handle in the init method itself too. That way
> c_states_[off|on]() can focus on doing their thing after checking the
> handle is not null.

I mean I suppose it would work, but I wouldn't consider it great style, 
I think of the init as a place for basic declarations and initializations.

Anyway, I'll have a look at whatever way you decide to go.

> 
> I'll send a patch in sometime addressing this and below comments.
> 
> >
> > Also, in the situation you describe, the debug messages should probably be 
> > hoisted up under the "if" part, and that goes for method c_states_on() 
> > too, as they are not relevant.
> >
> > You might as well fix the comments above the code too,
> > openinging -> opening
> > writeing -> writing
> > And edit that one line not to over flow 80 chars.
> >
> > Thanks!
> >
> > John
> 

