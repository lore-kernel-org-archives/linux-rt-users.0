Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD36BC2D0A3
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6731E2076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzrxHpen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgJ2RlO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgJ2RlO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:14 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F8C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:13 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id r7so2678921qkf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1SETHpPN/B3AVr56UMoShN8hp190fbku8PnD9uYK9Ao=;
        b=lzrxHpenQwv4v9x8ls5uiBBLjZQzzZLqBjgsYr51glI1jzLWHac7gyNFTxJyKM2c0Y
         a9Ha1H5A8pG7F95D9c/v/g5atMDBWuhNS3RFsMBskEz/S6PP/qE20QqTTC18I1zrbMUC
         qaz+AgJqrLAO/D6sp6reClUBlFvOD05ME+ZF3kxe8x6fx/1DvFem67f25Il0QN0pX+7H
         /GgvSnHQ3Ioo3TNM/cg97aTTO4WGGYidoIpb+NxfqZGlLg1a+vH011D3LvtLGNy/Opke
         Es+CbrA61iOjJliooKTc3sKXQJPecnA31URFZp2VDlfKKm29jo02o4VvxWQchpnfJJsV
         Felg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1SETHpPN/B3AVr56UMoShN8hp190fbku8PnD9uYK9Ao=;
        b=mnVnhIKgHfmwzsMMgX893cMsdajrmVROJZuITvDzifk4yBlZNCi7Fyr8puGsBfPaex
         bDzZhMsftioxpIDKyXvdS91ZVjHz/P7vHjpSc0RLzkrGR0uHTzvZqf2TFFbD/piAIpAq
         hDWXDIHuWofb7pw3T7QqUMBWDFgkfuoG1v3s09uyAmluT3sSDRO0z+gb4jZiQo9BS4YJ
         6aBCo+eDFtmpTWbEOapjdSYpqwwNCz6drvDhgE2VU8ep+0j1ikok/lVIDB2c7N6tADYS
         ZQCbkpA+Xdn3/6HWBBKoLv+49HsJcq+yhweO0FacieB6NySrHD5Ph0mq8LdCDkFH/L3R
         BBZQ==
X-Gm-Message-State: AOAM533de2gIV1EjuJ7oeXnNXHWYP/TjGvZXODONXHkEI/JU+Qj7n7f6
        +s92Sff3gY7InhDLa8pXhZjAbplh0Bx4zA==
X-Google-Smtp-Source: ABdhPJydIrdliIE7PeiA7Vyav7gkjVCKbtACerVNXr1Vv1ybzfdEYHgOOYp+XFfFYsW0f6Aif3WFEg==
X-Received: by 2002:ae9:de45:: with SMTP id s66mr4877264qkf.281.1603993272005;
        Thu, 29 Oct 2020 10:41:12 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:11 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 00/16] Time for some new clean-ups
Date:   Thu, 29 Oct 2020 13:40:41 -0400
Message-Id: <20201029174057.20033-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

After getting a series of patches from Daniel Wagner, I was reminded
that we try to follow suggestions from checkpatch.pl in the kernel where
applicable. We're not slavish about it, but I figured it was time for a
few clean-ups. I also removed an ancient and unused spec file.

John Kacur (16):
  rt-tests: remove pi_tests.spec
  rt-tests: cyclictest: A few style changes from checkpatch.pl
  rt-tests: rt-sched.c: Style change
  rt-tests: rt-utils.c: Correct mix of spaces and tabs in code
    indentation
  rt-tests: pi_stress.c: Change unsigned to unsigned int
  rt-tests: pip_stress.c: Remove unnecessary brackets
  rt-tests: pmqtest.c: Fix spacing around parentheses
  rt-tests: ptsematest.c: Fix spacing around parentheses
  rt-tests: queuelat.c: Fix various style problems
  rt-tests: rt-migrate-test.c: Fix spacing around parentheses
  rt-tests: cyclicdeadline.c: Fix spacing around commas
  rt-tests: deadline_test.c: Fix spacing around commas
  rt-tests: signaltest.c: Fix various style problems
  rt-tests: sigwaittest.c: Fix spacing around brackets
  rt-tests: ssdd.c: Remove unncessary "else"
  rt-tests: svsematest.c: Fix various style problems

 src/cyclictest/cyclictest.c           | 86 ++++++++++++---------------
 src/lib/rt-sched.c                    |  2 +-
 src/lib/rt-utils.c                    | 10 ++--
 src/pi_tests/pi_stress.c              |  8 +--
 src/pi_tests/pi_tests.spec            | 81 -------------------------
 src/pi_tests/pip_stress.c             |  6 +-
 src/pmqtest/pmqtest.c                 | 29 +++++----
 src/ptsematest/ptsematest.c           | 12 ++--
 src/queuelat/queuelat.c               | 58 +++++++++---------
 src/rt-migrate-test/rt-migrate-test.c |  2 +-
 src/sched_deadline/cyclicdeadline.c   | 23 ++++---
 src/sched_deadline/deadline_test.c    | 25 ++++----
 src/signaltest/signaltest.c           | 15 ++---
 src/sigwaittest/sigwaittest.c         | 30 +++++-----
 src/ssdd/ssdd.c                       |  4 +-
 src/svsematest/svsematest.c           | 50 ++++++++--------
 16 files changed, 168 insertions(+), 273 deletions(-)
 delete mode 100644 src/pi_tests/pi_tests.spec

-- 
2.26.2

