Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D1CC4361B
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 10:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9438A2313C
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 10:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgLPKO6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 05:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgLPKO6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Dec 2020 05:14:58 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B622DC061794
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Dec 2020 02:14:17 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n4so23423143iow.12
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Dec 2020 02:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cCXjL7d8Hsk4/+cG49z5rXDSYQeFz0z/PeAytG6sqtA=;
        b=HVWGkivs2IBKb6B5guihT6XAszSkbtPM/u7gy6FzBZIuIFqLtQxzC+xFF1KvoWjsiB
         gLW6agYCRNSDlQrYXuus404iz9Ow8nYAatepphVlwapp5Hb4iBvksMzWPcXk2g0+YQP7
         MNqAwbu2Ml7SiOEaoXQo0pHkIgSEPhEmBpzsafv367n7E3oC6buZBRsyPygBS2eWnhLN
         Z/lQE0FFjmOweuSoDMxaPr/EspmWLUGrNqZ8PS1GhbObLCAtztZOr8YQ6L6YyK6vZiAW
         iCdB8sVQegzB5zNIQbCu4SVZxnaqWuhDHyPNlRQeADjUsS1ROHkw3f/VeouZMJ89AiE+
         787g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cCXjL7d8Hsk4/+cG49z5rXDSYQeFz0z/PeAytG6sqtA=;
        b=EP72mWN5VDuJ0dF24k56b84oTmLSfLMDuwiIiU+B2tFBwEIjypa2MK6xWYfqz9CHdh
         MRcyrNSJWH2Bj+nwMBVqI8eMC9++b0PqwIpdSoG1NIV3MuZwDhf+1dj4il9jQiZKNM1N
         /dIUTkanYb5ETHcjnGorCPS4ek/1F2pvMeTFuFO8dLbvPgsXwJELkkL3N9rwG32lsqjO
         nj6WudEytNrbJXjHkJTDu2qTEFMVO7CZ/Dw50ykIkvKOxWZg7LOcKX9IQMMFULA2MqVG
         OPBjVk5j7VTuYFA+3jlaKEaoTYUpUDwRiOdfvvxf33sc1G3IEeEDIDaiIWo72+pitLWw
         i7Zg==
X-Gm-Message-State: AOAM531HsPiYBU9D8w6/BYTQDpflU6Gk4Vp96qNJLnN1roS3/8wuwIn4
        HYwSH0m9suVcGUo73CU00F4Kb1Av2PVOEDp5lnjcQM0BURU=
X-Google-Smtp-Source: ABdhPJzcnLOUXv+b4uIWEIWk8ynzMdmATNMYT9HTVXO/jafTI/ByavSqIMOqqewp+3vSMSQqKqXEisBwYru5jjTohAo=
X-Received: by 2002:a02:5581:: with SMTP id e123mr41631857jab.98.1608113656967;
 Wed, 16 Dec 2020 02:14:16 -0800 (PST)
MIME-Version: 1.0
References: <2aa26de8-1345-7e46-3628-a97a54e677b5@numalliance.com>
 <CAKXUXMwihDVrw03JehiVSQADtqwXWDNV_CJT+tzudRPHxLBdyQ@mail.gmail.com> <a5414150-efa6-3502-bd51-fe83ea7750fc@numalliance.com>
In-Reply-To: <a5414150-efa6-3502-bd51-fe83ea7750fc@numalliance.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 16 Dec 2020 11:14:06 +0100
Message-ID: <CAKXUXMwWMUb9pVCsG6CuCJRMVk0vM0u7BV5q=bbiKqQ+3=tYuQ@mail.gmail.com>
Subject: Re: enabling rt preempt
To:     Stephane ANCELOT <sancelot@numalliance.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 16, 2020 at 9:39 AM Stephane ANCELOT
<sancelot@numalliance.com> wrote:
>
>
> Le 16/12/2020 =C3=A0 09:36, Lukas Bulwahn a =C3=A9crit :
> > On Wed, Dec 16, 2020 at 9:31 AM Stephane ANCELOT
> > <sancelot@numalliance.com> wrote:
> >> Hi,
> >>
> >> I have downloaded latest LTS kernel 5.4 .
> >>
> >> For unknown reasons, I dont understand why I can't enable full rt pree=
mpt,
> >>
> > Well, PREEMPT_RT is not available on v5.4 without the PREEMPT_RT patch =
set.
> Sorry, I thought it was now part of the mainstream kernel. I have not
> understand :-\

PREEMPT_RT will be part of mainline on Christmas, we simply do not
know which Christmas yet... maybe on the next one?

If you rely on real-time Linux being in mainline, we can discuss
off-list which possibilities you have to ensure that that happens.

Lukas
