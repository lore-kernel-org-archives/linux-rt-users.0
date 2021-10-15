Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FEDC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BCD60E0C
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 16:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhJOQjZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbhJOQjY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Oct 2021 12:39:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7F6C061570
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Oct 2021 09:37:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so2804143wmg.0
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Oct 2021 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8I+UDV7Bp0z0KGrxH0Ct8FwMEPgk8n8OMPUk6O4w3Q=;
        b=Pif4W6rnIiy0wr8g1dl/sXgjSYx5RsUE2ZIgZBpsGjYCU6Rw9VeiNdYfeurDjE4rXs
         +FIT3RVZX6UJEOIyiTFBmptMFkJ1jLUj9Mphemfeh4t8MPCb1pGN7sEIwVDqT1Z/YbAJ
         OfpRWjQjtCrUXQCV9wc9Q/3RNiL+qDVpJ/7rCIYu86lpWQH1dD3H6gJxPuQQWs3NWuFT
         sG66rZspGTDVtwZGwsOI8bO5m2bTE9A/aDUknuyou38POrdrwsYZT8p9NTDmj/aK+37k
         U3BzlsgeIH319vyM3RC5MSKQLilf6mC8+E1Up+u4o2bMnsMYnz/XnEX3qnY2Wu2x2qSk
         iMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8I+UDV7Bp0z0KGrxH0Ct8FwMEPgk8n8OMPUk6O4w3Q=;
        b=LG93znK/096ByB6urT1TzqDhSzKRDtZq+03E6fOSFUIIdLUxvdmdErxeI35fQHyhUn
         zlwAxlwM901Hjx9QG4JYfXKZ1oF9fthSnrmWq4TJE+YOMZ9lxXJkE/hfZ+EP8J86lACh
         CtrUGw1D1gnCEAQYTBzdAxViUCJBa5xjUSoAp82vUTtXdZ3NIHTwIAwaEPQ4qhm7ODo4
         d2OeV2yZkBKl+C1zdAe5RV/3a5mDO9N7Zal6TtrIEQPpOFkoa9qXM/dEfVQrHl5DaYU3
         DfF94u6540S8a/lBz4EKOdmhY8opx8x9HP/xO0RgagfZt25SC2u/w+pELQow3/eRYlnR
         LOVA==
X-Gm-Message-State: AOAM531u/1A4oE4pgntFCCJfYgO826Ry/ZY+qrfeuzGLLdWGrSLMfH6e
        sjnKwaHEpOp8pN4tU1q0UgqfneOMCLQbctHRw1UPSPbSKnU3XA==
X-Google-Smtp-Source: ABdhPJzGrfO1WZ1tpqU+ds3uVLBuoVnoU/Rg0I4GO7xQOF5xbD9Ipa9xUOdAiIqidjlqp6JLD/D7ByClA6l2DtVx4UI=
X-Received: by 2002:a7b:cb10:: with SMTP id u16mr9902991wmj.65.1634315836645;
 Fri, 15 Oct 2021 09:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
In-Reply-To: <20211014071247.4165329-1-punitagrawal@gmail.com>
From:   Joseph Salisbury <josephtsalisbury@gmail.com>
Date:   Fri, 15 Oct 2021 12:37:05 -0400
Message-ID: <CAGHUO11me7hStnYpXTWs5DmDqKg8Y_sXAKFYaCToU5WZvfDm=g@mail.gmail.com>
Subject: Re: [RFC 0/7] rt-tests: cyclictest: Add support to report standard deviation
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     jkacur@redhat.com, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Oct 14, 2021 at 3:13 AM Punit Agrawal <punitagrawal@gmail.com> wrote:
>
> Hi,
>
> Standard deviation is an important measure to evaluate the latency
> response of a real time system. It is calculated by downstream tools
> such as rteval but the value cannot be correctly calculated when the
> latency value exceeds the range of histogram.
>
> This series adds support to report the streaming standard deviation of
> latencies to cyclictest. This approach avoids having to track all
> latency values and adds minimal overhead (two additional doubles and
> compute steps) to each iteration.
>
> In terms of patch organization, the first 5 patches are clean-ups that
> were noticed in the course of developing the support for standard
> deviation. It should be possible to apply them indepndently.
>
> Patch 6 converts the existing average calculation to a streaming
> version. This running average value is needed for the standard
> deviation.
>
> Patch 7 finally adds support for calculating standard deviation.
>
> The changes were verified by capturing the latency samples and
> verifying the average and standard deviation with manual calculation.
>
> All feedback welcome.
>
> Thanks,
> Punit
>
> Punit Agrawal (7):
>   rt-tests: cyclictest: Drop unused defines
>   rt-tests: cyclictest: Simplify duplicate initialization of "stop"
>   rt-tests: cyclictest: Drop unnecessary variable "stopped"
>   rt-tests: cyclictest: Drop unnecessary variable "bufsize"
>   rt-tests: cyclictest: Move signal handler to avoid function
>     declaration
>   rt-tests: cyclictest: Use streaming algorithm to calculate averages
>   rt-tests: cyclictest: Add support to report standard deviation
>
>  Makefile                    |   2 +-
>  src/cyclictest/cyclictest.c | 149 +++++++++++++++++++++---------------
>  2 files changed, 87 insertions(+), 64 deletions(-)
>
> --
> 2.32.0
>

Hi Punit,

Thanks for your contributions!

I noticed there were no commit messages for patches 1 and 5.

Would it be possible to add commit messages to all patches in the
future?  Commit messages help those trying to learn (Me :-) ) and
understand the purpose of the patch.

Thanks,

Joe
