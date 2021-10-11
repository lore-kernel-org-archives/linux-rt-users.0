Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8D6C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 00:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FD660F6E
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 00:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhJKA6M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 10 Oct 2021 20:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhJKA6K (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 10 Oct 2021 20:58:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA2C061570
        for <linux-rt-users@vger.kernel.org>; Sun, 10 Oct 2021 17:56:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g25so3942407wrb.2
        for <linux-rt-users@vger.kernel.org>; Sun, 10 Oct 2021 17:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=5eZe8auRPPIEuaOMDd560cwXo8cHGm73/351k4msGzs=;
        b=ZULbN0nVwXt7BNKQkom5ztXkuH1ng1fOWa0zEg7z/0JLS0c46OMGR4HVAij8KGRYNF
         jzEocvX0rKqprCniwEoNfX8T8knFoOPeWuXIZF7uP9KJVhMn6vAvc+9Ie2UJ7JMSHfHM
         EvfI0ovlLg9WRNSwp0/VDDUQNCMiseW4KEioPRAlcthZ6gn31NK09eEckxMnCthW+GR8
         dkmmz0DPbZx2zEj4mo5xhFcVOsBThd/fEnLMH9dKhBlK73n/T5R0r/0MmkMTWBOb9Pet
         24r3+CbcjjDQIQDQfouJBLuukz/FDK1lBeh6zUnxD2ZgAK2yY/3u60AaHeScfpvJvV6y
         n1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5eZe8auRPPIEuaOMDd560cwXo8cHGm73/351k4msGzs=;
        b=CydKB4gzc+klp2tx6W9Tz2o93QqWmGDU6o+81g/AJbu8ozTnbNuEk9KxT5e5k5roMA
         INCnspQmD08ik7swpxLF0v/km+K933mrFR6GapJOYRHzGummpv/6nRoBhbl8JG58/O3b
         BoD3UsgByzHkX0eJj5mKDpTfW7jgAD2CcPJY5cwz9DYHspZFRR8JxLwBvFWTk8f1f3PB
         Z6492PAbIjM7IQCAteO6GHX7htCajFZo7cpxabDe01BoHhROLZaqIvDgV/by1tUWl18b
         o2aXYcufacCs/ZAVWzSRXln8EBBc/yLiVQMJ59MnQqDFtPPHqDfT7+p7zo42eW9iJcrv
         W1QA==
X-Gm-Message-State: AOAM530NwYPPGGMrWTvOd8oUWZ1osWOmfOdrRyR8w6BdL69jw3bPrvts
        azJrXRzDohss039m5FfUQOt3OOCiWGdq9yU83XXPgsEnmN8=
X-Google-Smtp-Source: ABdhPJzNc5GR5Gii+GO1URvbDBd8viY8yjW4zdXqww35BjJ/xs9QAxLBgi0R2KDWM/Oyk9VN4iXpLTtPjUkGHDOgNlY=
X-Received: by 2002:adf:ecc9:: with SMTP id s9mr13216673wro.434.1633913768768;
 Sun, 10 Oct 2021 17:56:08 -0700 (PDT)
MIME-Version: 1.0
From:   Joseph Salisbury <josephtsalisbury@gmail.com>
Date:   Sun, 10 Oct 2021 20:55:57 -0400
Message-ID: <CAGHUO10W0-MR4zPbbCZY96zXRTsRU4eKgb_0_1S+TLgcX=q4mg@mail.gmail.com>
Subject: [RFC] Following RT Linux Upstream Development
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Per the RTL Project wiki[0], patches for PREEMPT_RT should be sent to
LKML with the option to CC this mailing list.

As most of you know, LKML receives a lot of mail everyday.  I'm
interested in following the RT Linux Project as closely as possible,
but I would like to filter out non RT related messages on LKML.  Has
anyone found a way to do this? Are there any suggestions to filter RT
Linux messages out of all the other LKML mail?

Thanks,

Joe


[0] https://wiki.linuxfoundation.org/realtime/communication/send_rt_patches
