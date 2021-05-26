Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8F7C2B9F7
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 May 2021 06:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0BC613F4
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 May 2021 06:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhEZGMH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 May 2021 02:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhEZGMD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 May 2021 02:12:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6179C061574
        for <linux-rt-users@vger.kernel.org>; Tue, 25 May 2021 23:10:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so4941808wmk.1
        for <linux-rt-users@vger.kernel.org>; Tue, 25 May 2021 23:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ac3TmGJ66wWplbsjUDKQVKPnaga5KY3Hyy8FIu/YLrM=;
        b=p3DK8jqX459CdgNcieRWp2EUbqpFQryNuRgb4OgiG1M+pENUpq/TrGv6td2UXagIMs
         Gl4dDwzJh+VMhhx1832LCECM62wuxPIWNoL/ocBmn0LKk0MRfjZ1tTXaGeUgjjfv0Akz
         J+tLP/Z+y+evbtc4uY41tJKSLTBcvsriVutXHQjGN+mnRmGguADHNnzzf0+hw7V7TvCU
         kSohTvzzOVaLhgWMR09tspas15xnRVrRE5s5dagAa3lELLhf3HQwiEtbWHrlkdY2lnmu
         udXwNHbYI7/gxVqi8QDdeZ2NS9eC6ChGo8dJyEiLIWXT+wNQ73YJ01ip9nnZYVKYt3qp
         4UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ac3TmGJ66wWplbsjUDKQVKPnaga5KY3Hyy8FIu/YLrM=;
        b=bRZTj3dY4y7+ZbjnVs2XmF6px3HGY9nQKy9+m86e5WFXTJGl0wbV3/J0yXm/CQD5uD
         VCR6iLytND32BvWHnVn7fkLbBbgoF1Mhwq2+v0rnSA6e3+MT/h5D0NxkJ6GLkYXkPNTA
         /5nJy5o4+bKSpRfRaTA8B0U3hD9KUPWOaGMZFXLp6e5+LsQ/c49i1xaXq//uhdZCJk/E
         xj7+MXlyJ5Mt5x5qLFFhGEoJ2OvDnr4QxAAEZDw8Isup8HanmN2MFEzj/9Aghr4BeSLh
         mBTWD73km8LCzmxH8p64L10JlBzBHcIEqkFNmplGHJAHpBvZtHJlK+JEmuBK6j3Na+s0
         nW0g==
X-Gm-Message-State: AOAM533Ty09hdA5Yw+miTDc10BVTGABQeTMEihBt2+ZnYffmQn2RkSmN
        Fn3mRi3EskkQxzH4CUFcLwl7nsGPClAVX8ZioWk=
X-Google-Smtp-Source: ABdhPJy/FVJQJ7cWYFO9uN3G8mL3axfvnVID0tZsxeQq9TJt1gjCxSttPy1ofCSBsnKsfZtovELIsAePAflXjrRrPZ8=
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr27809623wmg.184.1622009430318;
 Tue, 25 May 2021 23:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <6aa61bb9-0443-6da3-0902-9fe700c24017@gmail.com>
 <7e7394a6-cec6-e3c6-b5a8-e1cb6627a96d@gmail.com> <c856e656-24a0-a3ef-d023-197bffd19b4e@189.cn>
In-Reply-To: <c856e656-24a0-a3ef-d023-197bffd19b4e@189.cn>
From:   Christoph Mathys <eraserix@gmail.com>
Date:   Wed, 26 May 2021 08:10:19 +0200
Message-ID: <CALqGcGoHiyeNta5=WBq6txk-ykMBfYof5g3c2Yh+KL8Oii+_sQ@mail.gmail.com>
Subject: Re: Network latency on 5.4 and 5.10
To:     chensong_2000@189.cn
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Song,

> what's your command to get this log? it seems to have better information
> than mine.

I just do old-school tracing:

# enable all available events
echo 1 > /sys/kernel/debug/tracing/events/enable
# start tracing
echo 1 > /sys/kernel/debug/tracing/tracing_on

Then I run cyclictest with -b and --tracemark to stop tracing when a
latency hits and write a mark to the file.
The trace can then be obtained by:
cat /sys/kernel/debug/tracing/trace

HTH
Christoph
