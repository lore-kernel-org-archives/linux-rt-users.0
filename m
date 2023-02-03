Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092B0C05027
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Feb 2023 13:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjBCNia (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Feb 2023 08:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjBCNi3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2023 08:38:29 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB871A947
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Feb 2023 05:38:25 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ml19so15569978ejb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2023 05:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBA36iPR/XUmFzuWsZMSv37apOsLOBFCr/YE3jRassU=;
        b=r4ZzxSr/gvENYQPaTXOb6WuBIawPahWdOMEJR/6Gf2NBOLYtJoB16g6NpWOKDYBmwG
         FRD0eZSVEbsqwFXYplTQyVQE4fENwPoXtG7pXE4v6YkLzEM+0MIweRgW2X29li2NQa5q
         ZNK1/aMmSHziNY3lhOSKmzubS8a0g2qUPtoBXuVn6aXUapRAUwHDeyQrXAY090sK1weE
         RxqrtW8qd0LwjmT4lzZ4rOc22EfLwx6wZO/Va/r5MeNrUBz8zqZMrbZ2ciBSNldbKWWg
         ABBdrJSwMTsh1BsQbwAIwIO2eaObxbP7Mcogwa2nsK9NrfKdGInM0oypEeJnIKRYSg3B
         wJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBA36iPR/XUmFzuWsZMSv37apOsLOBFCr/YE3jRassU=;
        b=eCFaVVVE+/Aimhl9EtxdckVfMs+FKkEQrIcGGrB4BVW2qyhXk9mc1vR9uGzwm9FGSd
         Tnsog/SU3LIX+RbH1erEfZiKZaf4GyP1WvsREhTdgRMO1udywHt5VQXYt+f2umo2Ex/7
         g6Vkb72lnsBpv6aZUDl10ei4jcHoGNqbcMoJS+9FTJsBECVk5jRMmBeiphQJjz0a4Ay+
         b+eK7MzV25bxoaSibbrn/kaGKn7uRTxu+/1iFKzCZFTDpCwyyLmNSfNwxBS1HHan0kKd
         O0DtA0skQYSJ3+zX0jFKdtIFTfKqduNMdpzRXKPcp97vNu2TXXDZzeChZJcvirOGoIcw
         ziHA==
X-Gm-Message-State: AO0yUKUTNe9qRpBAnpEGY33hzuPz4iIdKHrmu57NYg87oH6x45RiuTmY
        j2hH3UDxHePP/akkI1v7LJwekJtKg7/7RsI7wpIq6w==
X-Google-Smtp-Source: AK7set/C9a2/ura7hyWHDdk9NbDTUKwc1wYjpZ1p32LGWQRvYMWtWxJRP2Nc9uzSbydlVI9YtwbWOIOxIUavBWhlGDQ=
X-Received: by 2002:a17:906:3951:b0:88c:d17e:a3a7 with SMTP id
 g17-20020a170906395100b0088cd17ea3a7mr3253888eje.19.1675431504502; Fri, 03
 Feb 2023 05:38:24 -0800 (PST)
MIME-Version: 1.0
References: <CAKkbJ-wOuKFZzmHL8wwap7160HdeoqQwkppGFwCc3Ah5GP94oA@mail.gmail.com>
 <CAKkbJ-zUtR9xpPhsXYGfhJBqD1Ut80p4FEmPgR8nVOv7AQBL-w@mail.gmail.com> <CAFLxGvx-HhPHSuRJ=fbt6yAXRjOv_L5HfxWLEznKJQ72Mvyxjw@mail.gmail.com>
In-Reply-To: <CAFLxGvx-HhPHSuRJ=fbt6yAXRjOv_L5HfxWLEznKJQ72Mvyxjw@mail.gmail.com>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Fri, 3 Feb 2023 10:38:00 -0300
Message-ID: <CAKkbJ-zw0eSEGuTD--MsO1u1ZHH1T66rqpnTE4RX=ggB+mvyEA@mail.gmail.com>
Subject: Re: Out of Memory problem with kernel 5.16.2 and RT ptach
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

 <richard.weinberger@gmail.com> wrote:

> I guess you built with CONFIG_DEBUG_INFO=y?
> This will bloat kernel and modules a lot.
>

I had a look in the .config file and found that I built it with
CONFIG_DEBUG_INFO=y.
Shame on me. Is that a way to know how big initrd.img should be to run
without any problem? I mean
what limits its size? I have 8 GB RAM and I'm not using a swap partition.

--
Thanks,
Michel
