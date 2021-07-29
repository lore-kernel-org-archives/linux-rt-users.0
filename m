Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1230CC4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E845D60F46
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 23:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhG2XKq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 19:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhG2XKp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jul 2021 19:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627600241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VyAxazkmKYT28IMnKO5Q3AuhS9T+A5TCD2yNJ2AK/oA=;
        b=BBZl3Rwbyt470EvNjMP/uzkwlEtpjvBqdlrpOOlJdPn0Lswfv8ZK2U3iRD642VOFkgext1
        cswxCHOeQxWP//8/hRCuzpkClezeGnndSs4l3v30V1MLb5r6KpgneVS9CJ9a83pF4SaRhG
        I9rv2wY1yBsD0pYdMk3LdVlF8XX++b0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-1USwpx1IPbmoVZevyIqpmA-1; Thu, 29 Jul 2021 19:10:40 -0400
X-MC-Unique: 1USwpx1IPbmoVZevyIqpmA-1
Received: by mail-qv1-f69.google.com with SMTP id o32-20020a0c85a30000b0290328f91ede2bso4801168qva.1
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jul 2021 16:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=VyAxazkmKYT28IMnKO5Q3AuhS9T+A5TCD2yNJ2AK/oA=;
        b=qsowZKsIKKUHsOeoSgtP4/+V4UUHMpQbVbllfDWzsRoyXs25jRwaJO4aXQWbVS1jeC
         9sb8d40G9vZRRtcujGVkVbEc9C3g+JF/k8pirLyGr+fvZcHPnY6IYEiRDfZ4IrCmfwa1
         2z3jhTZrNMcKdTjlC7zMvfszFd86f6WsKZJaihf8oiQwtY+MlINO7YnPkz2D0sOJwbFe
         RaHj8TONwJU0FRFKaVKD9O4S/Bm8UB6wPWg49z0tway663XNEtGm1r4zGhkzP8gBOfZQ
         dIpnTpfCoznCyVZrTKTwS6IFVTz6/a6ogP8ylTpoE9M3lKT7Af4JPXcvNh5LTIMgoJ9T
         zfBQ==
X-Gm-Message-State: AOAM5332gyU74TwJMi0Q6OxDvkrY6DNTmWt311U9aWeJdqUQi9Gl7PQa
        cHe+tTl3DUe38S4rL996TqO0CITOtkkJwGF+OKjvvctnPUJBcV3MZrC+DWucX/+nGKIyrPLJWuM
        kKeEkImjTV3hTsduQbCPhDFjXBEo=
X-Received: by 2002:a05:622a:1810:: with SMTP id t16mr6396881qtc.272.1627600239588;
        Thu, 29 Jul 2021 16:10:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymGzqbIzR3kKk3nzwede0wHUPRO5OhrygPS09qxSUeAuDDQo+aNXtP5aEaBsVZ/dFzuzRPEg==
X-Received: by 2002:a05:622a:1810:: with SMTP id t16mr6396867qtc.272.1627600239406;
        Thu, 29 Jul 2021 16:10:39 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id a5sm2558036qkk.92.2021.07.29.16.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:10:38 -0700 (PDT)
Date:   Thu, 29 Jul 2021 19:10:37 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [rteval PATCH] rteval: stressng.py: Fix argument passing to
 Popen
In-Reply-To: <20210729.092328.1410316616346703094.atsushi.nemoto@sord.co.jp>
Message-ID: <f3f2dd4-733-2bcf-1c4a-5d7cfb2b6fbf@redhat.com>
References: <20210728.201927.2141210326291227293.atsushi.nemoto@sord.co.jp> <1643d3d2-250-5a9d-731f-fecf8f2f2b17@redhat.com> <20210729.092328.1410316616346703094.atsushi.nemoto@sord.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 29 Jul 2021, Atsushi Nemoto wrote:

> On Wed, 28 Jul 2021 17:38:05 -0400 (EDT), John Kacur <jkacur@redhat.com> wrote:
> >> -            self.process = subprocess.Popen(self.args,
> >> +            self.process = subprocess.Popen(" ".join(self.args), shell=True,
> >>                                              stdout=self.__out,
> >>                                              stderr=self.__err,
> >>                                              stdin=self.__in)
> >> -- 
> >> 2.11.0
> >> 
> > 
> > I don't see the need to do this here and in fact there are some security 
> > implications to using shell=True. Is there a reason you want to do this?
> 
> I want to pass multiple options using --stressng-arg.
> 
> And also, there are elements with spaces in self.args already:
> "--timeout %s" and "--taskset %s".
> 
> ---
> Atsushi Nemoto
> 

Running stress-ng as a load in rteval is fairly new and purposely 
contrained so far. So, you can't run multiple tests right now.
However most of what you want to do is already possible.

stress-ng is like any other load so you can specify the taskset like this
--loads-cpulist='0-4'

If you want for example to run the stress-ng memcpy test with an argument 
of N=8 for 8 workers with a timeout of ten seconds you do this

rteval -d1m --loads-cpulist='0-4' --stressng-option=memcpy 
--stressng-arg=8 --stressng-timeout=10

which will result in rteval running the following command
stress-ng --memcpy 8 --timeout 10 --taskset 0,1,2,3,4

John

