Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FCBC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 19:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F6561102
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhHTTC5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 15:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbhHTTCy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Aug 2021 15:02:54 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82520C061575
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Aug 2021 12:02:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i8so20558864ybt.7
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Aug 2021 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9+o+B6IAFsaudWZB5eaVIpCXEt3MXz5qbAsUHXJ0mT4=;
        b=ConfS8PBnHrVGcJXL7U4Uo8DEK8G5CtHUbc9lRST0rDwwGNbghyPehk5oAZfQ16f1K
         f/U+BowC5/TbFswY/FjeagTLSBj+tvujekwPpZYWaZhPtV5V7j7Av5ZAKlFMkupQpht6
         NbLAabN4zpymd/Q6ks+TnwRRQfMpeLiOQmaIEnGA3NbxoIvd0Tj0dK1VifcVgqHdZ6hA
         8QzA5O8NXydmJZxRkvbMBQDBVgBN8qNCsoeK85Pxy/StBW1zFhLEwJErYltFqk2Bt+dJ
         QW5TBvonTdZYmlBWs9bJIbj5dzZZ4TQi/gwrE4Z0TqghVuQTtPwzzEiiD9BZ9YZk+GAm
         LD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9+o+B6IAFsaudWZB5eaVIpCXEt3MXz5qbAsUHXJ0mT4=;
        b=LhhLjJWDe1Q6MvvludE9Q/xVpwVD4Po7npy/U5CGSZ9U3oLg/DJXtEClRV5HKkpAbB
         4DfA4x9RXWJD+yc04/wTuL+GyAy7xHMh1l0eH2846D4kihovyJ5RX8B48KuzfE6cxrOQ
         TKRPYxy7M8zeWdz66xqxQcjdksZEq90EM2k9t7TmGnAl/JbeAi5Z3WFlm3asoHtY429c
         jiD7LrDnxnj7yHWfmTm4EYXDWAOYWzoDt157FzeePv/1gNuF5VVn4mkm48JA4uVYmwFA
         8GBmCcQmWA6JoY8QJmQtExWIKuzTGe+9snCxxpLzvCU/oblQUzkGIhkwT2rL2crBbzko
         qr1A==
X-Gm-Message-State: AOAM532P+cs57ECOJBPLXKN77NtZHmvCF49cQvHVb6wkxsjvhDfiz9d3
        m2JvupJO/pcVj71p8MXQ1WTmg03Ak5i6h/prc3gXfDmdqK6OnQ==
X-Google-Smtp-Source: ABdhPJy7q9ZDMUsxB/5Vws6OYNpITvCq7jb9+VrBpE5umqiBPWn5wJx/xALmgNwyv6sJlKx4aSUQgs4RovPzYj1HEXA=
X-Received: by 2002:a25:40d4:: with SMTP id n203mr26540810yba.372.1629486134794;
 Fri, 20 Aug 2021 12:02:14 -0700 (PDT)
MIME-Version: 1.0
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Fri, 20 Aug 2021 12:02:04 -0700
Message-ID: <CAFzL-7vTPxWeXbd4cUBpJ--CfYj6TiRp1E_BYWHTgzJtUYWCew@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v2 0/6] sched: support schedstats for RT sched class
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     laoar.shao@gmail.com, Andrew Woods <awoods@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In https://lore.kernel.org/linux-rt-users/CALOAHbDZPo65Vc89sVCuYkJ6vr=zD-4ev=JN=j7ZAzKHzRibdA@mail.gmail.com/#t,
Yafang Shao <laoar.shao@gmail.com> proposed changes to schedstats that
would add support for RT-relevant schedulers to schedstats.  As far as
I can tell, these patches were neither merged nor explicitly rejected.
  Is that correct?    If mainline kernel has not accepted them, is
there any reason that linux-rt-devel should not?    Perhaps
linux-rt-devel wants to stop accepting patches that are not part of
mainline in preference for moving them to staging in anticipation of
becoming a pure-Kconfig option?

Thanks,
Alison Chaiken
Aurora Innovation
