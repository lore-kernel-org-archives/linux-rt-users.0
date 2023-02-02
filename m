Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D6C05027
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Feb 2023 18:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjBBSpG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjBBSos (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Feb 2023 13:44:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF0E2A9B5
        for <linux-rt-users@vger.kernel.org>; Thu,  2 Feb 2023 10:44:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j17so4358670lfr.3
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Feb 2023 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F7AEA5PlzA3QShkZZHh54coszKZb9vdwmTE3Pw4ms1c=;
        b=cp10wbVTHTLh6GZtSHvORIUlirFQYKgGrki5wIYjQtOQ1a9QcCzZWeWcVkdzOF+cHw
         /btVZuKaU+5I/J8tCV27wBfnj4BQ8qEh+JDRAom1QAxNDp7aX8mPw49seDZegMGm9N8e
         cdJPARhYR9R/OL4jjF3SIsbCpZZghpWzcSgfa7al0oOnbLUWd3Z3ZRCape49WaRNCcVk
         34U46RJNnhwNvvszCXq1IStp+U/Cduh3m7QNUpGlY5sqKRGSeLwCq/bj4VRzMUQTTxiv
         1Q4bbXusZWzw2uCKnimSbycrIuzwjgCI4x3c/N4FhQ1uDsYJMSa3kPmwnEKHvhHak0oZ
         Ku9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7AEA5PlzA3QShkZZHh54coszKZb9vdwmTE3Pw4ms1c=;
        b=peVOTc0lYDEfGt3gWCzrvyfRPKwWpCT4pRO5nyQMTMNFQRnTM5XcHJtiTuP02m0dDm
         HwZU4R94EKjM0pd2ImNYCSJpmn2KoJrRJmIXR+aHYlXe+6uYXznjBJB5J9BRmFKypQe5
         9re9ISAmsnWIuovgK17Ia8U+BaXXPtqLk/GTRfEdabuaUms5rspIP0tY8EeOfl4JfUQi
         oLYgqZnJZ/IF88dyjEl35kTfWQ5f/mgCXR4TtYTSwDgMqSZNG9FP/Ta9E3+A8Qb7d3YI
         MjmIfngzRjbr4fhQE9quwqWn52UDNFQCHiQY/jXJyGbd0pymcBM/iSwPycnj2osvt9g0
         kWfQ==
X-Gm-Message-State: AO0yUKUxfmkh1A+UBiahSWE70gNcbJ7MpPT6ePQztpI5EOd1UBHzZO+t
        sc5z5kkfvETxQeNg3oCznc76NL+Tf6lqKY1XPYzzGbTBs+M=
X-Google-Smtp-Source: AK7set8c2vJ61Hgu4XTrxmjkHbA6QeDXlxOjUawBBatkXwNusW8FK94Jp1+pJe+sut9VH/Xpb20aaSYMnajUqDuF9gk=
X-Received: by 2002:a05:6512:b9f:b0:4d5:99e4:7fcb with SMTP id
 b31-20020a0565120b9f00b004d599e47fcbmr1598534lfv.259.1675363462249; Thu, 02
 Feb 2023 10:44:22 -0800 (PST)
MIME-Version: 1.0
References: <CAKkbJ-wOuKFZzmHL8wwap7160HdeoqQwkppGFwCc3Ah5GP94oA@mail.gmail.com>
 <CAKkbJ-zUtR9xpPhsXYGfhJBqD1Ut80p4FEmPgR8nVOv7AQBL-w@mail.gmail.com>
In-Reply-To: <CAKkbJ-zUtR9xpPhsXYGfhJBqD1Ut80p4FEmPgR8nVOv7AQBL-w@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 2 Feb 2023 19:44:09 +0100
Message-ID: <CAFLxGvx-HhPHSuRJ=fbt6yAXRjOv_L5HfxWLEznKJQ72Mvyxjw@mail.gmail.com>
Subject: Re: Out of Memory problem with kernel 5.16.2 and RT ptach
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Feb 2, 2023 at 4:17 PM Michel Macena Oliveira
<michel@austral-dynamics.com> wrote:
>
> I solved my problem by changing the compression method in the
> initramfs.conf file to xz ( COMPRESS=xz) ,updating initramfs  and
> updating GRUB after.
>
> Commands:
> -> sudo update-initramfs -u -k version
> in my case: sudo update-initramfs -u -k 5.15.86-rt56
>
> ->sudo update-grub
>
> Important to say that I'm using version 5.15.86-rt56 now.  Also, I
> noticed before solving the problem that the initrd.img-"version"-rt"x"
> was a big file with
> around 700 MB size, after changing the compression method and updating
> initramfs it is with 56,1 Mb now.

I guess you built with CONFIG_DEBUG_INFO=y?
This will bloat kernel and modules a lot.

-- 
Thanks,
//richard
