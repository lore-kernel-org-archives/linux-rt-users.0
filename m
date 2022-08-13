Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDAEC00140
	for <linux-rt-users@archiver.kernel.org>; Sat, 13 Aug 2022 01:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiHMBHv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 21:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMBHu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Aug 2022 21:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D6D572EC4
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Aug 2022 18:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660352868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p44glM6rJRryD9uhNJTFcvD4pZ2HQN22tmjs8qfL+R8=;
        b=N6ZKrvmnide3Rw4FB8ghq3+GL63a7/BbWIE5R3KASKmmSfwLqeVqDem1tE0yQxeEZf0G7t
        GxNKSXC/CtYk/DMSeT1JGXAueN0tBFxI5bLBke5OvjsPXlLk0UJLb+TlnrAGt2LhMJ+4uv
        ItoWFGi2QVWZhNhm0TbHSdtEV9XlQt0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-83NOpzgQPZSs5TCJwhBd6A-1; Fri, 12 Aug 2022 21:07:47 -0400
X-MC-Unique: 83NOpzgQPZSs5TCJwhBd6A-1
Received: by mail-qk1-f199.google.com with SMTP id j19-20020a05620a289300b006b949aff6ddso2032856qkp.0
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Aug 2022 18:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=p44glM6rJRryD9uhNJTFcvD4pZ2HQN22tmjs8qfL+R8=;
        b=n6Xo/EouBk+oS8bHnJMg2vMENb6hzceGPVatXDeEFpKVrusRKi8I/qBNHaW1gfrwUm
         zED2KBSEmiEKxJV54eY+S+dlSW7OjSRN+ShlVA617Gmz2Cj+wGhDGpM7S1ypCT/XKB0c
         WccpjFGgKFI9WFfd1ahDPnL0GrLw9dqVyzCMO4Mlp0akpvFoag+74XqKUCfowC+m3Ukn
         f2MJQ/PL2qcemELyLsyaBsyhz5ClbgINjM0shmYdZdCx+KB+p47rix4KzNqvD62H0TSK
         G/YndGU8QV2z6Hoc96H8VGLDC3uXhSoccpAfGLpetAP/MT14Nyh7ZFUWcjQp1FIGtPEx
         em7w==
X-Gm-Message-State: ACgBeo3llqiIy4hT7gH/wPnxobifMEc0GK2y5eAcX+Ld4nq95RZLuHAW
        TdvJrhdsQE0xZtS4e4owmLkPIZODy1eqBr8KCVT3XWOsdvrdrNXqqr2r4zoSXIK9Pokm/VQ8m+O
        BkeiJ3cnEyEoFKK3HZtmGOBCogTo=
X-Received: by 2002:a05:622a:315:b0:31e:e250:c5f with SMTP id q21-20020a05622a031500b0031ee2500c5fmr5811411qtw.206.1660352866920;
        Fri, 12 Aug 2022 18:07:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR78GsiJ3PZ/yOEj9/tbWfiEZ+aukP12VxR3Vo4PA6JYPOg5GIF0AbyxXzF5aYwcfnwGV4cskA==
X-Received: by 2002:a05:622a:315:b0:31e:e250:c5f with SMTP id q21-20020a05622a031500b0031ee2500c5fmr5811398qtw.206.1660352866726;
        Fri, 12 Aug 2022 18:07:46 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a0f8600b006a6d7c3a82esm2783063qkn.15.2022.08.12.18.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 18:07:46 -0700 (PDT)
Date:   Fri, 12 Aug 2022 21:07:30 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Nathan Huckleberry <nhuck@google.com>
cc:     linux-rt-users@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Bart Van Assche <bvanassche@google.com>
Subject: Re: rt-tests: cyclictest: Building cyclictest for Android
In-Reply-To: <CAJkfWY5KbJY_qD5qw88Bd9DNxrb47F+FVXnTQCsz-RDQxMujcg@mail.gmail.com>
Message-ID: <98bbfc8f-ac29-fed8-7f2d-72da4a1e907e@redhat.com>
References: <CAJkfWY5KbJY_qD5qw88Bd9DNxrb47F+FVXnTQCsz-RDQxMujcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 12 Aug 2022, Nathan Huckleberry wrote:

> Hello,
> 
> I'm trying to build cyclictest for Android.
> 
> I'm able to build cyclictest on stable/v1.0 after making some changes
> to src/include/bionic.h. There were redefinitions of several functions
> that have existed in bionic since Android API level 24. See:
> https://android.googlesource.com/platform/bionic/+/e7c2fffa16eccecfd43d99516751a43776f5f609
> 
> However, I'm unable to build cyclictest on main since support was
> removed to build without libnuma (commit
> 240938737e7034c0ff533ddbbfc7003b72453854). Android's toolchain does
> not provide libnuma.
> 
> Does cyclictest no longer support systems where libnuma is
> unavailable? Should I just use stable/v1.0?
> 
> Thanks,
> Huck
> 

stable/v1.0 is really old, you probably don't want to run that.
We designed it so that you need the numa libs at build time, but not at 
run time, so you should be able to copy it to Android and run it with your 
the numa libs. However, I haven't tested this in awhile. Let me know if 
that works for you, also, I happily take patches.

John

