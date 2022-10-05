Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E045C433FE
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Oct 2022 16:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJEQBu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJEQBt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Oct 2022 12:01:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA977B291
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 09:01:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp15so12720765lfb.13
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Oct 2022 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=j18n/ByzhTJuRe/Yje4hL3zEmMHFsP76LlIGrQO+d30=;
        b=ApegP87zPbJy0CqZfsvDAnFNh7bu+L66owb95RGD3Mk18AQq74l9/aPuJPSALzBsVH
         /+7PpXg/IZw3pO78MK6+TCamsRMdvEyNq7FMryFI+0/P+sAS9WpsFj2LAKqMSy6iSte2
         0I/Yr23m3RR04L4BhRfcplEsDkXUR99bTT/PtKI7sq1ldZ3ndffbCRc4C+UyvmWRcfQN
         jjhSXcqR82d+QVApGUQOHgu/8fhLT566OvCaKQ6E4iN4Zph7vheoP+TXcLsVeFQ3/EbB
         eL8+cDkWt4+ZeoqCR/sEOX+Ktt+FfN7+vPExR7gjyw0Huy52LDaxz4vMtSHwH12Rsf+i
         XdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=j18n/ByzhTJuRe/Yje4hL3zEmMHFsP76LlIGrQO+d30=;
        b=YHHTJcPPkFAjyPmUIx+4I5EXVDKAYM3Yg7lUfkWzIO+QuuXCi50Rtl4vQkPew6SbYJ
         C4vTJNFZwFMeFymHmWkFQNFCP0Qxquzpl+ax110M6z7M3iK1u+aMtsFl/GQkEdXQgX50
         +xXC72Nhio02bbj/RdGkKF4ggIEUp/YVUwebPKZ3hfZdbmOxjVFeO+6a7i1OYdkYLa1F
         m/MpPxSU6FEuqEf2pJpSyq6yttGBh2aUpc63Ea2IdddR9vcsXLrPY/yVKM9r4bxgE825
         rBJXgZ9U+yYb8/2dv99D8ozYqo/dHhG7BupXYvdUDAsDh5PXks2uIYE4edVAhv792WnN
         rLEQ==
X-Gm-Message-State: ACrzQf0HIrx+SuHJyaaY6CW5vUeFXRjkKmydSai9fklVZWUjDt8ajvkX
        T0hKM/v2sJnRQhrBgkt48OaMgSgucVDcAvp/J0r/ia2uP3k=
X-Google-Smtp-Source: AMsMyM5gXwAA19Whvltvwa2bxI8Y3MbFCq24NGGDzIvXo2IeAZWHrr74xKbE3cO6Q2MfYJnDyHAOhawBjvZAoSulnn0=
X-Received: by 2002:a05:6512:34d3:b0:4a2:3500:3b39 with SMTP id
 w19-20020a05651234d300b004a235003b39mr199108lfr.276.1664985705758; Wed, 05
 Oct 2022 09:01:45 -0700 (PDT)
MIME-Version: 1.0
From:   Florent Carli <fcarli@gmail.com>
Date:   Wed, 5 Oct 2022 18:01:34 +0200
Message-ID: <CAJuRqcBVvpTCrDTNPGeJVARYfVxGxVWGXqq7eYjJDzUmprcqBQ@mail.gmail.com>
Subject: RCU stall warnings even with rcu_nocbs and rcu_nocb_poll
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

I'm trying to isolate some cores to run a CPU-bound real-time task and
even though I'm using rcu_nocbs and rcu_nocb_poll, I can see the rcuc
threads wake up, and I get RCU stall warnings on the isolated core.
As per the documentation, if I use rcutree.kthread_prio with a
priority > my RT task, then the rcu stall does not happen.

However I find it confusing: why are the rcuc threads woken up on the
isolated cores despite using rcu_nocbs and rcu_nocb_poll? In my (very
likely erroneous) understanding, I shouldn't have to fiddle with rcu
priority... In other words, how come I get rcu stalls on cores that
have no rcu callbacks?

Thanks.
