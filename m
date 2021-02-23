Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6513CC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161BA64DDA
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 13:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhBWNzl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhBWNzh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 08:55:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BACC06174A
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Feb 2021 05:54:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id q10so25981603edt.7
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Feb 2021 05:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31L8CdPXYIf2pBwS3sZHR5MeKJ3Rd53shpL1dvDop5E=;
        b=PSEn1dEioEOWgmkAsry90RBm7z1/swM31/UGAM3BDGXyx678JwjmFmCZD7P0k0RvAH
         NhqkhmXjA78o2XYLoFPfkG7GoOKicmPBx1x9o29ppSYdscrskoDArCsJLuVf5JuZtooj
         friAAnWQJ1Fb2bzMkXWm0VHWIzixZ2ECpsXkE96yPYw2tSke7dTOiSPIjSzyxWXc6S+n
         2Fbfwv3g0Oc7dpY3HqQmWV0Tt22FC6mTqBKH7GpWYgz2xA0J0K9RGfhrM0ZYdVGo/DLJ
         jmPVAAjdTxIy6h0dAFKYaxp6sZ6QjKEVC3LUjn4WH4cuD/CqrN39FEpydgTvTRnDVMMo
         vSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31L8CdPXYIf2pBwS3sZHR5MeKJ3Rd53shpL1dvDop5E=;
        b=D4rLgG/pBGMkIXMXt1mLM1Z+yoAnCxppXlJRX4eMeWxQ10xb4IUKbCMCDksisFoD1+
         MqSRy4Sj8FkGvUEVfQkvRfjp2VlOjoFqtFYRkdPavO9jwAThhi4PELZJpCyuK4LxD6s0
         Vj2OvibHgbWOu0Swc8CtRaSET6v8bS9fzTtHvwLPSBR4o692NRDDfFZQcJpnzBLcvOBl
         M0X9Tjj/6w5e0e3Fq6gMG2/Tj6WpM8ts03q474Dhi4W8EyKt4dMWJHiYSBl71T5Kyz9s
         +JC1Xk8kamxFZ1l4Gaq6YOBx6GemmvFZhkCNfcrUq42pobwKCpm994eaVkzLdRTBZgWC
         NCyw==
X-Gm-Message-State: AOAM532iIwaXfOGdR2XDqHYn6TpjaSHZLadLTgbmORD0MhpuCMu99/YR
        rDB8D+fuNhpEEXVPoqAMAYg=
X-Google-Smtp-Source: ABdhPJyR5cWv7kJwuXzAcn/cPscvIyp/Zkoz4sePIdj748ze4euFgONpq/1kBvL0hJNKqpGgv7qYQg==
X-Received: by 2002:a05:6402:3582:: with SMTP id y2mr28163568edc.345.1614088495581;
        Tue, 23 Feb 2021 05:54:55 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-6883-f900-4d8f-ff61-45e1-6480.c23.pool.telefonica.de. [2a01:c23:6883:f900:4d8f:ff61:45e1:6480])
        by smtp.gmail.com with ESMTPSA id z13sm14447509edc.73.2021.02.23.05.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:54:55 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v2 0/2] rt-tests: cyclictest: Add option to specify main pid affinity
Date:   Tue, 23 Feb 2021 14:54:44 +0100
Message-Id: <20210223135446.7201-1-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

Changes in v2:
I moved the wrapper around numa_sched_setaffinity
to lib/rt-numa.c and added the pid as a parameter.
I called it try_numa_sched_setaffinity since it's basically
just a wrapper, that warns if an error occurs.
I'm not sure if this is what you had in mind, when you
suggested moving that section to rt-numa.c
The code-style should also be consistent now.


This patch adds the option --mainaffinity to specify the affinity of
the main pid. 
This is mainly useful if you want to bind the main thread to a 
different (e.g. housekeeping ) CPU than the measurement threads.

Regards

Jonathan


Jonathan Schwender (2):
  cyclictest: Move main pid setaffinity handling into a function
  cyclictest: Add --mainaffinity=[CPUSET] option.

 src/cyclictest/cyclictest.c | 28 +++++++++++++++++++---------
 src/include/rt-numa.h       |  2 ++
 src/lib/rt-numa.c           | 11 +++++++++++
 3 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.29.2

