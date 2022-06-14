Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A2AC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jun 2022 10:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbiFNKgC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356022AbiFNKfw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jun 2022 06:35:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520749698
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jun 2022 03:35:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so3651350wml.2
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jun 2022 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=blbkbpOSCUWCzMvnWvpj2eZHCxranKKGhS/EQ2fvDjk=;
        b=p5kEGpuz6IoHQJU1SRu6Jha1OyN4cLq0tkyVIOSEa1b2UQEWVqXmj/HmTmta/931DB
         dcsKeux8VsP2SJmvdUtHfxWSiYVGV+dn6vrFWIus99STSXrNEhqg/v3Zm97WDPx5Ip/b
         cC8616TyzRx9lUVW3JERD0SkMQYYrcFzUAETgB9TYCIUSDtkYFlPjn2TLr2NbNx/YhIY
         akSNRpTH7NkFUkuwPcmQcXnQKYQKpJDFYQ3aOSXxUX1TJRBk/oDliaynegN5W51Lj9GP
         +D7kHFDPkLqjwiPhdXMVsfw9nOEkDe3ujcu0zCXQ5fAopc1bzYssy3ICDmQdXKu2KlGn
         oBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=blbkbpOSCUWCzMvnWvpj2eZHCxranKKGhS/EQ2fvDjk=;
        b=UHQ9L1aL3tad2wBNdIhhuQnmJdTc8P6vL4+SqQIi0aLzNQ1msm45noKStbuxjG2qyd
         W38LEsS1jPJ9TLzr0ZbB+xpPH5IDzOOsVOvW3o5cyJmOjJKpCnjwz9+b/xzypEzRWxRZ
         Lp3hTZJaaiMbOGmVGw5rXNPP0LiZznFyuOTi3qS0oJmJdcxPxrdKdpcLj9jOj2JkgGSG
         h/zW8ufcz0MOc6yLVT5RjIXRXKip+cRh3qgZX9bWgaWWuFmd0rWtxQotj83KUAMnStKS
         yKr2P0rK4WFBmAq8uRgvFGSgkhOjoZVMb14TFp27jX03QVXpBIbHpgv6qM5AyB2/w7LK
         b73Q==
X-Gm-Message-State: AOAM531DY4c1RH4MZpN5NJtkTlazyYYcNDzDYytuTWeO26cSecBBQ7DD
        wdV4K2wzSP1ECXJCr2xYAnTYTA==
X-Google-Smtp-Source: ABdhPJy289yZqi559mHtRpuEgvHMyK90SmdnTwmltEFIzJvdFbRHB9vngHUtB57MJR06CtZMK4Rq3Q==
X-Received: by 2002:a05:600c:35c2:b0:39b:fa1f:4f38 with SMTP id r2-20020a05600c35c200b0039bfa1f4f38mr3468698wmq.22.1655202930818;
        Tue, 14 Jun 2022 03:35:30 -0700 (PDT)
Received: from localhost ([109.180.234.132])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6503000000b002103136623esm11275345wru.85.2022.06.14.03.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 03:35:28 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     "Willett, Tony" <st20214513@outlook.cardiffmet.ac.uk>
Cc:     "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Subject: Re: Problems installing a real time kernel.
References: <CWXP265MB501198E1F104B6044E93E188A5A59@CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM>
Date:   Tue, 14 Jun 2022 11:35:26 +0100
In-Reply-To: <CWXP265MB501198E1F104B6044E93E188A5A59@CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM>
        (Tony Willett's message of "Tue, 7 Jun 2022 13:24:06 +0000")
Message-ID: <87sfo7pm6p.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

"Willett, Tony" <st20214513@outlook.cardiffmet.ac.uk> writes:

> Hello.
>
> I am trying to work with a Franka Emika Panda Robot Arm and to do so I need to run a real time kernel on my Linux PC.
> This tutorial/walkthrough is my primary source of information-
> https://frankaemika.github.io/docs/installation_linux.html#setting-up-the-real-time-kernel

Debian provides RT kernel images[0] - if you don't require any changes,
installing the packaged kernel maybe easier.

[0] https://packages.debian.org/search?keywords=linux-image-rt
