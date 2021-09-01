Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC152C432BE
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEF560238
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbhIAIJU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 04:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242940AbhIAIJT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Sep 2021 04:09:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A9C061575
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Sep 2021 01:08:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fs6so1330190pjb.4
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Sep 2021 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugYiMv+ykYIGvpqdgPtuQvf7xfLiJnIw6tvaPdBf9lg=;
        b=rCZ/YYTsEXqDjSYHUzzg2VuN5oSejjbUVuSZSKdUAe4ggbodDKgf73//ulb640yx5E
         c3q5LPV6glPxo0+t2iuj5gIwKnj8iemPWPpy2EtiTImzXmEOHwMS5/MpX2eCqXBKTNKC
         KVqzH3ZL9MYvxF6qeSM1tv4wWJhzLqRPZ10IgeOpSe5g/bLPLTkIEsq3g2YJ4jPpuVND
         AO4DwAZOT+P10XEFozqeCEg+BHNGMtn9JRSyK5lpV8AWWE2SI/tyf/GB6L64fe+wgPuU
         NfQUdbctwG6SSGTENhyczI36Wm0/99/lPoIM6goRA+qk9fJa43N9NZlQuXUccFlyxEJ5
         OFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugYiMv+ykYIGvpqdgPtuQvf7xfLiJnIw6tvaPdBf9lg=;
        b=V8Npz7Ti97PELEPsfhVvWQ7lpfbc6KPjIkX++J7/LiSyvW6+Gp9ABNQlVWqYUwm1SO
         a8FJbgIWJZxRgQcWXy7ZNQNPCT1nh5tJpx8NiZiUIzOyhPK2xIuSe0VkESqA9/dPCs7K
         3n05AXbyfT63ck7caaDE+hNHA/QvvUUExUDbDaVkXfYod0h+RRFTmyqHwSwJE9E8gZJm
         wtekSzC6M3R8f/n6iNHlJUdkTXkWqzhXK4XToCyMGuWYqhFNaVpPekgbOWOxdL4WX2x/
         OcptRAM/95g1vjP3IDrrzJ0sTI7X3AFa4xi2m/dEyMFkrS/evh5R9p98m7GBn7ta8sHP
         Bj+w==
X-Gm-Message-State: AOAM531RTrUnkuV+m0hEO2x8y++f836Sbtwkmz8iwUnmj3mImK2GYi1t
        IZ6md5eeRqsB1KUkbpNvwimqEhBYfTM=
X-Google-Smtp-Source: ABdhPJygog4KN9UkeyHgvvMR7ysRimYs+QB04UkLUQU8kj25jGxMXleSpMFYeHTmmA+s4h6r0UAmHg==
X-Received: by 2002:a17:902:e5d0:b0:132:36f5:72bd with SMTP id u16-20020a170902e5d000b0013236f572bdmr8712342plf.8.1630483701445;
        Wed, 01 Sep 2021 01:08:21 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id d17sm19645113pfn.110.2021.09.01.01.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 01:08:20 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     punit1.agrawal@toshiba.co.jp,
        Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 0/5] Enable rteval on Arm based systems
Date:   Wed,  1 Sep 2021 17:08:11 +0900
Message-Id: <20210901080816.721731-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

The following small set of patches were required to enable rteval on
Arm based systems. Of these, the first two patches have been posted
before[0] and have been updated to fix some issues noticed since then.

The remaining three patches are new and fix issues encountered while
running rteval on a 64bit Arm platform.

All feedback welcome.

Thanks,
Punit

[0] https://lore.kernel.org/linux-rt-users/20210224021603.446274-1-punit1.agrawal@toshiba.co.jp/

Punit Agrawal (5):
  rteval: systopology.py: Add support for systems that don't have Numa
  rteval: cyclictest.py: Update logic to get core description
  rteval: kernel.py: Add support for kthreads running with deadline
    policy
  rteval: hackbench.py: Enable running on a system with low memory
  rteval: kcompile.py: Gracefully handle missing affinity information

 rteval/misc.py                           | 23 +++++++++++++-
 rteval/modules/loads/hackbench.py        |  3 +-
 rteval/modules/loads/kcompile.py         |  6 +++-
 rteval/modules/measurement/cyclictest.py |  8 +++--
 rteval/sysinfo/kernel.py                 |  2 +-
 rteval/systopology.py                    | 38 ++++++++++++++++++++----
 6 files changed, 66 insertions(+), 14 deletions(-)

-- 
2.32.0

