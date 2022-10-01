Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBEAC433FE
	for <linux-rt-users@archiver.kernel.org>; Sat,  1 Oct 2022 01:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiJABTB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Sep 2022 21:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiJABS1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Sep 2022 21:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D43195F50
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2022 18:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664586924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5Sm+yoW8ulpfXtWT6RkcdBhM6mj/vms7W1DqXDH4q4=;
        b=jCfqCsxunj14rpr9tlW7WRL4Dq25Ao3Un2fQ61tcMWTp52obGMGcT1SGZqZhXNmucVipay
        AdYHaeN0pboZ96SwLtrRGq+DJEagaZuBfPTO3SIv61ZxWZewMHUTyHen4b727OVgPWIOZf
        PrILqGQDScsKTR1QsyjmUvOJlQJoC5w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-63-Lfz4wTX8MWqdiq1SV8jCZg-1; Fri, 30 Sep 2022 21:15:22 -0400
X-MC-Unique: Lfz4wTX8MWqdiq1SV8jCZg-1
Received: by mail-ed1-f72.google.com with SMTP id w20-20020a05640234d400b00450f24c8ca6so4617558edc.13
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2022 18:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=o5Sm+yoW8ulpfXtWT6RkcdBhM6mj/vms7W1DqXDH4q4=;
        b=1M+A5BOEVh+tOZRNB2k2NOlPJjRCq8eSO5Cm3vPOKWK8y99cv8kv2L+C8MIZBwaZxb
         Hrj75m+IZHMhc+g2iOGXFwi+yn7gRg51O8BVL3/KuNlvGLYVZra3LvsIt9ehcKyX/LIS
         A+mNO8oxRe3yYslYDAo5EiIMvw0bVsEquW+lBkv06CJw1Dkh1fibsOl/T68FJCEbeSG0
         bYw9zSPTe2MQd3bk7EA4hFg/oxaCjN1DTOyZb2t17ovyUDkdmPJ/wVLMkJTzqlkoRsmV
         lpJgmWuVExUPBl43WWahLMNLrZLPBIGEZLkTcnGLiCcZH9yVG/qzvvWq1MiJmIPjBIG3
         Yl4w==
X-Gm-Message-State: ACrzQf2zsSBz7HsQxmxdWqGecylkJbWe3UHGXpjNvpJucRetWlQ2Fvhv
        OhxJ0nxCwXCXr2KeOBk38cASTl7V/RA5pBhxkM8TR8IXHQbiC1Nzk08IYjZJ9vuHgu8MUgVEp0/
        9GwpgZtbGzuqHGUaIBF5+xl9a68QEQHpjjA86eYFQr2c=
X-Received: by 2002:a17:907:6d28:b0:782:32ad:7b64 with SMTP id sa40-20020a1709076d2800b0078232ad7b64mr8812204ejc.23.1664586921220;
        Fri, 30 Sep 2022 18:15:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6560DmY3MtvBHbgSR5QBSpzMDUkWcwMqV28BI5mHezGTKZ1zmK17tiVlJQw9fJ/khBhx3dhprOx5jXcYHFSwg=
X-Received: by 2002:a17:907:6d28:b0:782:32ad:7b64 with SMTP id
 sa40-20020a1709076d2800b0078232ad7b64mr8812196ejc.23.1664586921074; Fri, 30
 Sep 2022 18:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAEYdEeSpYW3wS=yXtsa9C0e-LmZDXNZ=AP3z33FYZKsgU7XcxQ@mail.gmail.com>
In-Reply-To: <CAEYdEeSpYW3wS=yXtsa9C0e-LmZDXNZ=AP3z33FYZKsgU7XcxQ@mail.gmail.com>
From:   Clark Williams <williams@redhat.com>
Date:   Sat, 1 Oct 2022 01:15:10 +0000
Message-ID: <CAMLffL_49B2DEgTiDPg3vwL5gR-Dagvo-OBbymrBapgBJifnkw@mail.gmail.com>
Subject: Re: Abort on boot for 5.15.7 patch RT 23
To:     Brian Wrenn <dcbrianw@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

First question is, which version of the PREEMPT_RT patch did you use?
For v5.15.7 you should be using the series released back in December
of 2021:  v5.15.7-rt23.

It looks like things went bad when booting the RT kernel while
initializing the cpuidle driver.  I'm suspicious of the nested locking
done in the genpd_* functions (and how they work with rtmutexes).  If
I get some time next week I'll see if I can make sense of the locking
done there.

Clark

On Fri, Sep 30, 2022 at 3:44 PM Brian Wrenn <dcbrianw@gmail.com> wrote:
>
> Hi,
>
> I am building a kernel from source derived from Linaro 21.12, based on
> linux kernel 5.15.7.  It runs on a Variscite DART SD410 dev board.
> When I build that kernel, it will boots successfully.  When I build
> the same kernel source with the PREEMPT-RT patch, it aborts during
> boot.  I attached console output for each case.
>
> An incompatibility between the Variscite patches and PREEMPT-RT could
> cause this abort, but just to cover all my bases, I'm try to rule out
> the PREEMPT-RT patch itself.
>
> The call trace includes RT specific routines, so I'm wondering if
> there are any known problems with routines in this call state, and if
> any fix for them exists in some way applicable to the v23 patch.
>
> Thank you for any information or leads.
>
> -Brian

