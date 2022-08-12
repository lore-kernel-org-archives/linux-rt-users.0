Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877DBC00140
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Aug 2022 22:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiHLW2F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 18:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiHLW1s (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Aug 2022 18:27:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3372315E
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Aug 2022 15:27:10 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s11so1811484qtx.6
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Aug 2022 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=+4wpD9EcjXfzR9ajqkBbmtzLSSsmQxP0/iUC5gA9qjM=;
        b=AmDlFBWvhwkJzY4AAzfPcLwkPvLLNyHv8B8qEq/L6Li2bobasvva95oYKz6gCX0TFw
         sBfkO+T45FYuQPJpmgfwUvp+pOBU9M3E9PYwiCn/KTrlmzQV0bS3b9c3Oi/ye2KJwURW
         3fWUc5pqHbQ7QJB7ftwDOt5nXRHhMMRTQhM5BufhD2YN0/rv0n9ZzFK+dPxnEt1A3rBt
         cGA6sMJJjZk7QVF4xmT9ZrZL7fiCSvXg3aEcBygdzYx+j9YChnmeSSl7v0gEFQBjAwU8
         8DQZxdbx2idn06r4F3mU1NDm4Sf8F687XEiZlVCvBKD7NQApYkIXw2ib7lGw/7yLaLSR
         BaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=+4wpD9EcjXfzR9ajqkBbmtzLSSsmQxP0/iUC5gA9qjM=;
        b=yzfepce9P587mLFcjXNB+aWf8odoweLNPF7w52e/LM8A6hu3hz/ByDkTsphDNCabr8
         0gQxJV7Qy6UD2XM90EKodoVn5N+OAYb2l5WLAEem6LlqLJhSOz/OaoHqJfbyx4adTZYi
         NjkyMOr3gEWn4kLuTF4yOw+SxpnedXw1YN/tUOQitH88jaSPCPAs9DgRoSuXsia7UjY+
         Q6tbNBXQsgCJJdaq6o3O1O6hgpanOHIqOCbII0IjlIs6IL/25V2bjpnD5ZQ5tt44E5S2
         JRnVwM5ExllwbdY4VHTwQjabb8BXuYFzu5TD06b8jGWM1KPAByFQEPITG4+5dHuBa4y5
         sDoA==
X-Gm-Message-State: ACgBeo2qO04EOkdGx0FJvycVmgs9hw6byi5wRZiBmNbtw9HWfsWndTwF
        9zQf4ZSrxO2nUSMuaD9wWipxyT1vi06Td2wFKFob+QU3IiQ=
X-Google-Smtp-Source: AA6agR5+5mVoKVRY548l1sxb0hGxKa5JNG4jwY+XcgdqDwe2ETg5MokaYxTIMZA7IAxo8uoJMa0669nlTgEV7ctO158=
X-Received: by 2002:a05:622a:1210:b0:31e:e139:a6d4 with SMTP id
 y16-20020a05622a121000b0031ee139a6d4mr5597363qtx.160.1660343229574; Fri, 12
 Aug 2022 15:27:09 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Fri, 12 Aug 2022 15:27:00 -0700
Message-ID: <CAJkfWY5KbJY_qD5qw88Bd9DNxrb47F+FVXnTQCsz-RDQxMujcg@mail.gmail.com>
Subject: rt-tests: cyclictest: Building cyclictest for Android
To:     linux-rt-users@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Bart Van Assche <bvanassche@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

I'm trying to build cyclictest for Android.

I'm able to build cyclictest on stable/v1.0 after making some changes
to src/include/bionic.h. There were redefinitions of several functions
that have existed in bionic since Android API level 24. See:
https://android.googlesource.com/platform/bionic/+/e7c2fffa16eccecfd43d99516751a43776f5f609

However, I'm unable to build cyclictest on main since support was
removed to build without libnuma (commit
240938737e7034c0ff533ddbbfc7003b72453854). Android's toolchain does
not provide libnuma.

Does cyclictest no longer support systems where libnuma is
unavailable? Should I just use stable/v1.0?

Thanks,
Huck
