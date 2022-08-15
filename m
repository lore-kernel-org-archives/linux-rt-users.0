Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A078C00140
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Aug 2022 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244490AbiHOVns (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243789AbiHOVmG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Aug 2022 17:42:06 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EF06DAFB
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Aug 2022 12:29:34 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id mz1so1135734qvb.4
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Aug 2022 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qrAMSUBibhYzlIFJFop2b4E17UxhNQYmAmYnUmYBUns=;
        b=oiNbvQTL5EEQq1zrgjuPzQAVqnE5QEYiBIURjvs26427CykHXYhS5ExpQVU1Htv0Yb
         buPgBh7i+IovmvgP1/wq6v3pPpXVSX+qlAj/e2EURO2MiBd+EBJTqLPchO27DWbCqCZv
         AHA2uAqXREzppJ/dkSTeHz0IYc2ctfsgpIlwE9I88zTs/APiDg6IvfJi75BzoGDxwJIu
         /3QT8yODDohp9H5sn/+JPul3xW/10TG9SLrcoUWs6M0bSeDzvT9C4Mn0j+Ya7339ndZy
         uMdK4UDGg9V+WiE3T++rwHOBGDOitGWfGsn7EVUADkudXru4SRjcHt7b0ys4Ec25WB16
         mHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qrAMSUBibhYzlIFJFop2b4E17UxhNQYmAmYnUmYBUns=;
        b=00A4/1BkuN7JUa9gbTAbZmJKG9otOufQBxWmkwZ+mZGBvJOnmXVDzQScwx/h/heOD+
         Z50NYWNQExFKguifdVlj07Gh3NGvVTWQ2vYFQGSs6i7ElGXQOE2lKQglAkCo5eTAIo1v
         P/9DU6XoIUgNc3O4l6hxWfx4p0Qfpz770QoT+VNFpvF4o/mO5qNFQqaVAfiYjC1hkgrg
         x0dFmhdrVOk5THD1NdUEPFV5LX+PD/LUTqc7X13WpMK/AX0T6GzhIypJ5mcaL6/pFLGk
         LZuamEBgyhJ09qI+115ISLaurfhhYz27wOYx7iHeFlLoEPnqgwQ32WNwawZffjjvUSi2
         ++ug==
X-Gm-Message-State: ACgBeo3AbhUhIy7lmH4bcmSq+0kKAqTfAeilAWH1l0rb0U61vSQj5OeS
        TVN59Ai7T5HPtUSScasPlxMjea28VHSP+zhaXlJo9w==
X-Google-Smtp-Source: AA6agR5cumipWgboi6k1U7VP+Sq2I089zyPYm38VAsrE8NVK69MvxS/sBU3ZXKH0MMP1EU9qUL8nzh3N7Y4hXo0y+pc=
X-Received: by 2002:ad4:4ea1:0:b0:474:8090:5cd2 with SMTP id
 ed1-20020ad44ea1000000b0047480905cd2mr14692250qvb.105.1660591773415; Mon, 15
 Aug 2022 12:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJkfWY5KbJY_qD5qw88Bd9DNxrb47F+FVXnTQCsz-RDQxMujcg@mail.gmail.com>
 <98bbfc8f-ac29-fed8-7f2d-72da4a1e907e@redhat.com>
In-Reply-To: <98bbfc8f-ac29-fed8-7f2d-72da4a1e907e@redhat.com>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Mon, 15 Aug 2022 12:29:22 -0700
Message-ID: <CAJkfWY6uH4B_RVaOkJPWR6PmG+pqEHNW9LwRVWSarkFTJN8n=A@mail.gmail.com>
Subject: Re: rt-tests: cyclictest: Building cyclictest for Android
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Bart Van Assche <bvanassche@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hey John,

I made some progress by building libnuma with the Android toolchain,
then linking against that. I'm now running into issues because bionic
does not support shm_open/shm_unlink. It looks like those functions
are intentionally not supported as seen here:
https://android.googlesource.com/platform/bionic/+/8b14256/docs/status.md

Do you have any thoughts on how to proceed? I think I could add a shim
for shm_open/shm_unlink that uses memfd in src/include/bionic.h; the
memory would only be accessible through /proc, but the tool would at
least build.

Let me know what you think is best to do here.

Thanks,
Huck

On Fri, Aug 12, 2022 at 6:07 PM John Kacur <jkacur@redhat.com> wrote:
>
>
>
> On Fri, 12 Aug 2022, Nathan Huckleberry wrote:
>
> > Hello,
> >
> > I'm trying to build cyclictest for Android.
> >
> > I'm able to build cyclictest on stable/v1.0 after making some changes
> > to src/include/bionic.h. There were redefinitions of several functions
> > that have existed in bionic since Android API level 24. See:
> > https://android.googlesource.com/platform/bionic/+/e7c2fffa16eccecfd43d99516751a43776f5f609
> >
> > However, I'm unable to build cyclictest on main since support was
> > removed to build without libnuma (commit
> > 240938737e7034c0ff533ddbbfc7003b72453854). Android's toolchain does
> > not provide libnuma.
> >
> > Does cyclictest no longer support systems where libnuma is
> > unavailable? Should I just use stable/v1.0?
> >
> > Thanks,
> > Huck
> >
>
> stable/v1.0 is really old, you probably don't want to run that.
> We designed it so that you need the numa libs at build time, but not at
> run time, so you should be able to copy it to Android and run it with your
> the numa libs. However, I haven't tested this in awhile. Let me know if
> that works for you, also, I happily take patches.
>
> John
>
