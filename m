Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EEAC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3002A64E92
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBSSsx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSSsx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 13:48:53 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043E3C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 10:48:12 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id h8so6516495qkk.6
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 10:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1lP7RHpEdyQv8YWxClmirpuTFJa1y+ezUzFrJ4K/zxU=;
        b=CflrXZrmLHk3IX2Yi7viuGMPjySFtzpeQETlJh9Bu8P2keXMr3OkhrwmfVenPJVlWK
         TYn1D8JtJzUZnneR4zU4/5fyHO1LpIfRi7fRNuGVh2f7hpZ2F6QPJcgcvBr9+cPhjesi
         judAlWTr1rnJv+1kZnhINUTn1JMvfbkWigbbXpdzfPTLMetzEhC8UyPbWhIuYVdAL2BD
         MJNDFqbPFmJoeGOT1K39+PEe7fiv+Iu5RZNOd1gd1qM7kFm0+/Y7UpmNANwb23+Ewnqt
         RAx+x7LvK0BLQoUgYKKw8mJP7zVE8yt55CmAAgEz8KmsDBliwVOas5i9M8EEQqfmaq4w
         aqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1lP7RHpEdyQv8YWxClmirpuTFJa1y+ezUzFrJ4K/zxU=;
        b=qsOHEMI0gKA00gtD7eywpMJE+vywq03/UHRUFssXtZzBdWQ+6woR+JCPNdDBiW5oUR
         oGYMkEgfL8udmOZrxeiPeNGw8ZgpcTOsVCgRaMMGxMS9ocuEjjOg5SgBz3svhFcGkahK
         d5NlmAZ0Fao9l67KRrBJ34VYvpZoY4sXzCBPuzjrzqbmHmbxYs1axf2uOVdvFqg3x9PC
         opdJy5mW4w+VtO3rasMHNuS9FjsSjEms6ZUJB7Ndgs+nQt3zcAHbCJ2eyMDrKMIv7C5/
         v83f1jN0I8hq+q6Ty1d6yOTYHN8r9lwBHbM1CEhQZXMBLGJ4JnaOeblg49H9kBWalvSa
         UkTA==
X-Gm-Message-State: AOAM532o3kkZmvV1Lo+fP/kxUn67zfgjj3vCSCcw0/6M83FMg7wG6U+M
        R+ypib5C7O4AWbTi4XlqupGhGfCgYkbm2J9C
X-Google-Smtp-Source: ABdhPJwyPB1CbIGzeJDVXuuzVnWp+XBgE/AAj9PmB+d/0+I67LflHi08aA8c5VuXBgzDh6ZmaMBRfw==
X-Received: by 2002:a05:620a:22f:: with SMTP id u15mr10557164qkm.22.1613760492018;
        Fri, 19 Feb 2021 10:48:12 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id s136sm6831647qka.106.2021.02.19.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:48:11 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Christian Eggers <ceggers@arri.de>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/3] Revert always use libnuma patches
Date:   Fri, 19 Feb 2021 13:47:58 -0500
Message-Id: <20210219184801.13905-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

libnuma is a build requirement but not a runtime requirement.

Test branch unstable/devel/no-numa-runtime

I would appreciate some testing before I push commits upstream

John


John Kacur (3):
  Revert "cyclictest: Use affinity_mask for steering thread placement"
  Revert "cyclictest: Always use libnuma"
  Revert "signaltest: Always use libnuma"

 src/cyclictest/cyclictest.c | 97 ++++++++++++++++++++++++-------------
 src/cyclictest/rt_numa.h    |  2 +
 src/signaltest/signaltest.c | 10 ++--
 3 files changed, 71 insertions(+), 38 deletions(-)

-- 
2.26.2

