Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B4BC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 11:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973E861994
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Oct 2021 11:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353081AbhJALTa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 Oct 2021 07:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhJALT1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Oct 2021 07:19:27 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0EFC061775
        for <linux-rt-users@vger.kernel.org>; Fri,  1 Oct 2021 04:17:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g6so2594139ybb.3
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Oct 2021 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=sergg2GSwSZFaHuoTs/OYVo2E5K1OvZuj8k+iHpnq/g=;
        b=dzeMSTpC+T/2x8qGmqOfUQJcxZRc9l1HNJdoUykHAcU5aJgLPS1t7aTsKidWl4YP2a
         RzUnxQaWNsOrxPr/mv1duysxlBcQhqxvjqczPGU1dVq480MYePBQU30TpRQbt1iumqDW
         Nzu4EABCY/UT3jMdCXQ3U7/lDdTx3MltXwt8pCkkPqBeSalSK9e2pxXwFgmlsObLCj+r
         39/CKTIDtcWS58blK3Cr76bRXrd0RMd0rfUkq8jb5efK+sYnG/68efAP/nAn5VzLoXn8
         MwtWscEZZaJk2Tx4YXz+IZebPX3iGQKK1MZJzF9MbwX37CQ/RFCVh2dLyXYSCHvG1NTQ
         VPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sergg2GSwSZFaHuoTs/OYVo2E5K1OvZuj8k+iHpnq/g=;
        b=iSEQ6kdneDeSF33OZnF43b6NlTDMHeIv5H0/VKqofw/78QCzTK/nL6ckUKE9IfMqS9
         ixYD6Tu8WB9lgvGs7eDmPqakt258B5haFEs0TzxG6n4l7mR7HKNCupLFYIHrfVl7OeYn
         eAJutZ8rJY9FA+AyXk2j7qJI/3mwYhZePrkzjh70mLMSDj55i1qBV7pQdrwW9BYWP7cT
         IIt3TD1H4O3YGes2I50vhMLuGGsIZtQuQwlCQW2NoH9VIjFSsU5qARlFZ8HoWTcS/opy
         sYs1Sfwj8ditRetQ25AiQPC0IAkoAFDEiwxJV/VfclnmPuJhqyH54q6/lTQ706rzJhdI
         Cmvw==
X-Gm-Message-State: AOAM531DiwBUJV4a9wRX/XPY2rs2o6d5+DMAydSMobqS7V5QWUEz77vE
        CipczsyxcKgoJ/fmvFZHi54dQZHv7Gshi5KVew90a8/NBxw=
X-Google-Smtp-Source: ABdhPJwwPLHzXwTKfRjhhYlee5SMa3bcL/OoDn9/6+haR5AXGEwulB6nAIojqDWeQWos8Kwgu6Hevu30u/Up0i3LSss=
X-Received: by 2002:a25:accb:: with SMTP id x11mr4902245ybd.154.1633087062111;
 Fri, 01 Oct 2021 04:17:42 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 1 Oct 2021 13:17:31 +0200
Message-ID: <CAKXUXMy39ojQQjEVN+7uucg3et7v14p_AhjPnHkBAOHXxQNegQ@mail.gmail.com>
Subject: Update on real-time blog post: An update on real-time is overdue
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear all,

Last week, somebody pointed out to me that the real-time wiki did not
see some updates in the last months. So, I wrote a quick blog post on
the latest stuff that happened (and I have seen):

https://wiki.linuxfoundation.org/realtime/rtl/blog#an_update_on_real-time_is_overdue

Please let me know about any feedback you have on this blog post or if
there is anything else that should be mentioned.

Best regards,

Lukas
