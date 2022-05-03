Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B6C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 May 2022 13:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiECOC6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 May 2022 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiECOCv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 May 2022 10:02:51 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE02F39E
        for <linux-rt-users@vger.kernel.org>; Tue,  3 May 2022 06:59:17 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id w124so16479062vsb.8
        for <linux-rt-users@vger.kernel.org>; Tue, 03 May 2022 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Kc9EqZyyYSZAOs9cnIhJHFzWGVjy5TAUNXSAD6jVZpA=;
        b=JedDEuKdmrsPWDkD8pL33DMl16cRPAIUnzhzgjUokuf0iwvR3uKxISGKO5mJrYB4M9
         PTUl8i9vKd62f1RUYcQhNrjJABCSNe0xXvqmbWFGfOcW8LTNkfGgvp8nEpIjf3u41d4q
         /ORrGfeNvpuodn7nVnroNIRsR32kl1j8IObLhXZZ0OQ4kZ6r5+zki0p/3S6gwJHeFcAG
         k6f5cpWUpcNWi2G6lVHDRdEUad8we0u1+JLc7Mwps+fRC+A0je0czEhwXGBE7e4BjdgP
         ROJ0V1dMhbLU4vZYNxQ4SsYFRtCYT/MY/ZwPuJExb69JknOHAWzHoZD3Pwk3p7nPWMKW
         Coiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Kc9EqZyyYSZAOs9cnIhJHFzWGVjy5TAUNXSAD6jVZpA=;
        b=USGI/PxP//B8JDHJsLJw0m1E3kU9qlt1Xh44P4Z4wtEgHw6vGNw2Sw4H7g0vEkH7ML
         WEcE9gBq5kJTPYpJDmSJVO9d7UFJREsV5E7uoNTD6XJ+B0kGEQlW53yuW6I0LZfJyTiN
         ly+VR0yTcJ+33/eRdaFbaG7HZVlJ5TCtAkcR3V46b2JMngBU7Xoo5bSOv9IZGb1uC2Bj
         0mU64ezKkwB0jj2viT1vkPlB0s/WNVVc6GwCfcGyIPlaubpzkCkeON5Xs3hEobNnjk4L
         gQcWjH/284jd0oSVLRjinCyx8NQkXeR7Lde5sVJEefzX5xpgcc+JK8qRL4EW34m6lJhR
         ekyA==
X-Gm-Message-State: AOAM530GUeC3oO1UK7kavTt6llUsqST2x283+XxK+A8dTWCwvBMimBqo
        pp6NDT+LNX/opD2wE9OVw6x4Aj4vdR5ppbbHdsdQDncGgmo=
X-Google-Smtp-Source: ABdhPJy5hF/fDDF6hxFMyYdGq0bR9M7CQV1D1LPLcUZWukCUKzFiugc5Nx8C9G3q2XEDzXHgw4EvBXz0sueVlk0q+GY=
X-Received: by 2002:a67:d81e:0:b0:31b:a09a:1c4d with SMTP id
 e30-20020a67d81e000000b0031ba09a1c4dmr5255307vsj.0.1651586356082; Tue, 03 May
 2022 06:59:16 -0700 (PDT)
MIME-Version: 1.0
From:   Gautam Thaker <ghthaker@gmail.com>
Date:   Tue, 3 May 2022 09:59:05 -0400
Message-ID: <CA+1+E3V4Z-Y=-iBRxoFzD=14Tq7ndaHdM=3fzT=nKDZmUNpbeg@mail.gmail.com>
Subject: seeking a .config with ALL DEBUG settings turned off...
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I am building 5.17.1-RT and I want to disable ALL DEBUG (both related
to RT Patch) and all others that can be turned off and still have a
working RT kernel. I want todo this to try to measure scheduling
latency, etc that is not marred by various counters and trace support
things.

Is there a page or directions that can tell me how to do this? I go
thru and disable various DEBUG settings in .config manually, but then
I notice that making the kernel re-enables some of them, it is unclear
to me why this is.

I do:

# cp -vi /boot/config-`uname -r` .config

as my starting point.

Thanks.
