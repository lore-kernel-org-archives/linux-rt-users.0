Return-Path: <SRS0=DAnd=UK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3EEC43218
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jun 2019 02:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2B62086D
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jun 2019 02:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3pASlrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390755AbfFKCqw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Jun 2019 22:46:52 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:34824 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390244AbfFKCqv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jun 2019 22:46:51 -0400
Received: by mail-ot1-f44.google.com with SMTP id j19so10386917otq.2
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jun 2019 19:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/LaNcJtkeOmPcx/2OoFnUjHpXgZxrP1B8EcwW0XeMa8=;
        b=m3pASlrnOIAaiZnENoC0b0Nfdb0lC6SaL029LydmXo9k8ne1ppy+Fi2MPDuUaCWnhw
         /9D4xNFkQPeaqW1U9MkwWP/YUSQAxoAmvkikpyy9JuEbSNpiSIPFQ9My3h6f7UK73gpC
         BzIaotKeQB86eO/aV9Wsl/rEOwVDjEs4hxMt5DOSsaOS2+A4p2yi3uADHdn6QqcdkUga
         OnTm7+7a3GnIl4s1kr31+HUuPPar+A/FNbSi9X3cEF9CcDERMUyn/JXUSB3B3rpX1L6j
         FgAJ8TuEHgdrx9yJF5jhb6TKGPO5ef0vTKhA+rgy8REfOBgr3MtlByrKp475rTP5IhxY
         jo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/LaNcJtkeOmPcx/2OoFnUjHpXgZxrP1B8EcwW0XeMa8=;
        b=GSObJO6eYrSKKfKs0vDUsJLpvA7OLj8bbwabkuELAfhI9Y5FDpw7f+slUHwCItKsYQ
         w0BXvXi5H1cb8mef8yQYvPP/fZUEg6wCPNLIvU87kxG2ym/lFHSCe41WEluRnYRq+M9O
         cFAXlyHbOrW8GoEc9mAj1dtbxebk2mc+j11ElWJYBdrfRxBIn0wG3BYj9NOFKu2Mip8I
         htAiBIpBTS0SW9VRjyJbbgId2SFcOFW6QDg8K0qZKHzOOwPDA2qd7rpumj4G0v/Z6vAh
         w76wZLI5ihEcDGHQ3+iInVXL42UGC/bFHaJQ9LXkHyZjCa0TUuGjsWYnGkHzMbKZ6jLR
         /1XQ==
X-Gm-Message-State: APjAAAXPAorQ2w58glRSvYGQpE76KfRgd2YxBEGUaaPvwpn6la9jZLFW
        REWPM2bDV/R0MbreIncIJMROBFZv2df2kgRVpGg=
X-Google-Smtp-Source: APXvYqyLTUgf1daxQ5c2G4RvavKld+xhS7vNVsfmHa89465H/4zdOj0h9lcUTPr+3arocc57aAsGJgt9lgqtQFNO+wE=
X-Received: by 2002:a05:6830:1009:: with SMTP id a9mr19260346otp.331.1560221211187;
 Mon, 10 Jun 2019 19:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
 <70303817695c0f986d0f109ba5dd803699ee6aa5.camel@redhat.com>
In-Reply-To: <70303817695c0f986d0f109ba5dd803699ee6aa5.camel@redhat.com>
From:   Alec Ari <neotheuser@gmail.com>
Date:   Mon, 10 Jun 2019 21:47:10 -0500
Message-ID: <CAM5Ud7O2OtDLdJPArAAfw7A1xBm89dBSXk64vYsb-KY9N5RXUw@mail.gmail.com>
Subject: Re: EFI_STUB doesn't work if PREEMPT_RT
To:     Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Thank you, Scott! That explains everything, appreciate it! I wanted to
do latency testing with PREEMPT_RT under EFI and couldn't figure out
what I was doing wrong.

Alec
