Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C28C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 16:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42987600D4
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Apr 2021 16:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhDIQLs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQLs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Apr 2021 12:11:48 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A93C061760
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Apr 2021 09:11:33 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o5so6388262qkb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Apr 2021 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=L7pLAnnhvgNJtrn8tOYxJvibHv2m6radjV/q0nv0mfg=;
        b=gLyOpdCnQY2ZvN1MHo5FvdlJM9tVHI0f5GeaLT1P3FTwSik8GAkkmXvVF7wD2vzSY9
         D0I46O6zL8i7BNdMhHFpsDmqOE8bV8ZH2kCTckGGjcJd+LbDmMeuQn+wnTqMqd7vNI5y
         28eAzkLPmO8DV6tEnlmVa2XzXTBimPdigs+AmVzgMQArHdNTSDfbDwhccpjuPiptE2pP
         S7ihNUMRc+IxBM64rnzXr1cLg/2GBKuUx8Zb4TPssKeClK9xHjo48As2hqpdl4QHH7/v
         A+wxdbFaCcn9Via87nR+W7xlgKbvmZIK6JnJpzme0RucxUS27Y9DDc5TkFLDyDWoX7PC
         wMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=L7pLAnnhvgNJtrn8tOYxJvibHv2m6radjV/q0nv0mfg=;
        b=JWnSx+9XiqXZKPzBZqdDfYA6XWloWG9/vAGDtcfYKSHvp9QX5jhSaejbK3QM5+ptgO
         U7wvcgWU7KY0o+rwBJk32+UbSLOg6lTTEOBLnjJWATf3PqNLs2Ny+qoMsVFjeh6Zdbs+
         1sQqSFq6ks0LiVzpWRn9oh/QoqUWkW6v8SRZOnve0HoVDSvFiCQ4IDuBfYuo48ZXxfqv
         6TjLli8wb0Y4kH1FsyvfFZ6SK3hu5QelEesOwup0rRCpozORfV07he7e3rKCyD65lKzp
         61U0l+ACYszEoaeo+Ye4/rZwVYiOd2xmS+O2/bNr6QO73ewUrox80fGoXGCtAD0yEf+M
         wdBQ==
X-Gm-Message-State: AOAM533r545RjfR3I2foXuu/KISWjyhqH+5HNjk9JwGdrXTmfMQt9qsN
        FXCjwoTrM47R2uCYNBrm4q4=
X-Google-Smtp-Source: ABdhPJz/b7y0PTQZ9697o833i1emiu5yfgZ1k0dTJ0Ef16IC1+JlyWXBfcxmIIhPSeyvBVv2pVgIMA==
X-Received: by 2002:a05:620a:209d:: with SMTP id e29mr14657754qka.316.1617984693019;
        Fri, 09 Apr 2021 09:11:33 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-233.dsl.bell.ca. [174.88.121.233])
        by smtp.gmail.com with ESMTPSA id b2sm2059596qtb.54.2021.04.09.09.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:11:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 9 Apr 2021 12:11:25 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Henri Roosen <henriroosen@gmail.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: rt-test not available for arm in buildroot
In-Reply-To: <CANKLDmuMdmjrHHqkPs01Xg14u-m4GrXfLFBpXdniegCg=xLn2g@mail.gmail.com>
Message-ID: <d946ec97-1794-924d-bd37-1c131ebcdfeb@redhat.com>
References: <CANKLDmuMdmjrHHqkPs01Xg14u-m4GrXfLFBpXdniegCg=xLn2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 9 Apr 2021, Henri Roosen wrote:

> Hi John,
> I was using buildroot for creating the rootfs for armv7 based systems. Previously I was able to select and include the rt-tests, however, the current buildroot-lts (2021.02.x) doesn't
> allow this anymore.
> 
> Buildroot doesn't build any NUMA stuff for arm. The rt-tests build seems to require NUMA, even though not needed for arm.
> 
> What is your suggestion / strategy to fix rt-test build without any NUMA stuff available at compile time?
> 
> Thanks,
> Henri
> 
> 

Previously numalibs (numactl-devel) was required at build time but
it was not required at runtime for the kind of situation you were describing.

There were some patches that were recently integrated that made the 
assumption that numa libs were always available. The patches had some
nice clean-ups of the numalib calls but unfortunately deleted
the equivalent routines for when numa was not available.

I tried to revert the minimum number of patches possible to go back
to the old situation, but some more work is needed to put back this old 
functionality.

I am aware of this siutation and am working on it. If you want to take a 
look at the old code before these changes and help with some patches
to fix this, that would be appreciated.

If you decide to look at this, I don't just want the old versions
of the functions, placed in the new location, but would like to retain
the improvements in the numa code as well.

Thanks

John
