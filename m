Return-Path: <SRS0=vtwn=A3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A2EC433E5
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3BD2067D
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 17:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austral-dynamics-com.20150623.gappssmtp.com header.i=@austral-dynamics-com.20150623.gappssmtp.com header.b="dfIT/ZqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgGPR3Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPR3Y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jul 2020 13:29:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1642C061755
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 10:29:24 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k23so6841080iom.10
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ewErMFcwzMpYjgOszqbuRFY0jrAQOjd/DNqaBpbeczk=;
        b=dfIT/ZqHLk2mnoFJyUnWNdMWkZo2vX6GO3xFJJAqP3uTrp+Dv7FHUN8UmTVvLJqhqH
         8IpMK2rchs2+hqO1FgsVAi3c/mJ/rymQALcDu88rqbHRVzGe//j+Ob/+Lhd6sYc7RSp2
         GHsBChN8xmX8Kw0xGFpJtaPKLWZG8ZC0Q2xryz0jZqE/Ev9B55NcIkRDkjddcRUe4yf2
         RHrHVIbJj96V0+zDxV1TgIlXWb1n38Pejodb1oZL93J8MUvNjdkg/j7gQhwdb4jtfwlz
         de/XvFQUw2Y1OVrMB1TEl9qsBgCzHK/8UuEmM66FCC+/yfz3fzhTYbP5vnzRhclyzgjf
         NOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ewErMFcwzMpYjgOszqbuRFY0jrAQOjd/DNqaBpbeczk=;
        b=jtoItQ3uN/GZTzxOfH3noYDBhgIT/IXMXu0LHGH+rSpNuUiNTdELP3F1/KQode6nnJ
         MuYLgZELG4e1y5QnGiYOBqHHhfzGH127AJ43tZfbe7IXRVkwuNdZq/Y584d/iT9bi31/
         XRTw3HqJyX8u2HcgWnzs/LWW8QAGntwxvJUUDexAnJ7yfR5JxU4kBEEV7qIoUVE6BW7K
         8Ma23Xirgv2rA+TGAGG+5tvwrw9JXmWYZHv/vJgv540MXhIOphngr2/DdLRYOdsY8Vb0
         APcbShOxLOSxEqHYOiVebUHatl5XQ5+h4ve2pjJ/MlVbWGMTJ2sHb7wjfUWvbbmI0URS
         L3IQ==
X-Gm-Message-State: AOAM532sTRmj/XFYM/0M+4lHcPp9ldYkQs2uWq7uM9X4ly/iCf1X+Tv+
        9JICEqF/+AqjJRdV2nD4LZ3R8cgit+lLeOSRmbphL1jJ
X-Google-Smtp-Source: ABdhPJwZZF/97U+7DOjlx2FTufT7n5O+xxS67PeQwxNc9JPcgFnWuFIv0D2da0/KjCjwp3UvOlpG76SO8fkW8EL73vM=
X-Received: by 2002:a02:5b83:: with SMTP id g125mr6319604jab.91.1594920563886;
 Thu, 16 Jul 2020 10:29:23 -0700 (PDT)
MIME-Version: 1.0
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Thu, 16 Jul 2020 14:29:13 -0300
Message-ID: <CAKkbJ-yB4XGuexzmwfkR8g76HR8iCkXaHsXaLaS6V+Wfy86bvg@mail.gmail.com>
Subject: Serial port driver usage and status
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi, sorry for my newbie question,
What is the status of the serial port driver?
I've written some code to use serial ports  for the generic kernel linux,
And now I want to write something similar for the real time kernel, do
I have to use some specific library, flags or something or is it just
the same settings?

I'm asking because now I need to take into account the serial access
in the scheduler to ensure a real time behavior .

Any help, advice, hint or tips would be appreciated.
