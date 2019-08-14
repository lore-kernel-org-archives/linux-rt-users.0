Return-Path: <SRS0=V9Xa=WK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E025DC433FF
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 15:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FCE2133F
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 15:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E68uOgMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfHNPtr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:49:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33283 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfHNPtq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Aug 2019 11:49:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so3610515wme.0;
        Wed, 14 Aug 2019 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GgpF7Bn3iLxmnrlzmfTXq5Ybf354IdpR2J0OxIgAaos=;
        b=E68uOgMU8ez6QYfyKgOF0aUz+R483YEAGnrHG78TwWWLqRfyXaosFyZvuMjED77gpF
         RYoLcNxdOCkQ9N9Q8ck78j5lekrj1M9x6avQQOMyd0S3O9kpp0LhO3Cj19U7ztzYNPeG
         8Yh+YN+ZfkDMYYZwb01/Yn0kpQmifXZNG6KPfQVgAQnStDcBLgT1AxNbK4Cum1HR0VoG
         T8M/ZZG+z4d9FXPlVHGEpdPxdrFA6Lrx2sRy9tqxHP7/P85GLOv/Ua75Ojw4zoIsRdaU
         soqMu9OT2kwnTPeTREA3x6oFewWg7o6GrlLDibyKykicoaVDm/VTRV+JgjAmWq4bmuh1
         CofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GgpF7Bn3iLxmnrlzmfTXq5Ybf354IdpR2J0OxIgAaos=;
        b=FNncLivW+J/NTdydfN8VEQsaXsFQguPdo9Bs/8KIvO0wwpS7s2GZdynjHcMpwYJszr
         uNyJG3xnIDMZpUkL/gl9vsvxP160ItNIpsVggzjhWLg2tL5JHxV4xbwO12+VoiyrzTJl
         ndgoKikbsBdpJxdi6po8ZUAlzi6LAbj87iae4KXDEJxwWUpggn5nCLvXDXpdX4EiGJgG
         SS0wVapxHAw/yB1NRLbzRM0Hv7I+GgP5Sn7+C7S44w7jDomBoGYtnhwVy8eE68DMXkhM
         XpY9D/p56ciiJ6VthnUy6oSSDKsmEizxsUca2ByIBtxqCoJONpUeTJgwXtxa/3mY1W4+
         vpnw==
X-Gm-Message-State: APjAAAWLzhNU/s914XDeQdPg3bXyHty2nevfXTGRA41KuZ/Qd4eQv7SJ
        2q7iUaVRrM4lztJVeiNFeh5boHMjdd4=
X-Google-Smtp-Source: APXvYqzmHYv2EUqjBT0QKvTZqMloDV5pIEqjUO6JotbuaOuSFQ46EuBUNff9GAYIkVEc36bwchX0zg==
X-Received: by 2002:a1c:1a4c:: with SMTP id a73mr9505796wma.109.1565797784296;
        Wed, 14 Aug 2019 08:49:44 -0700 (PDT)
Received: from planxty.redhat.com ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id r190sm94942wmf.0.2019.08.14.08.49.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 08:49:43 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-1.5
Date:   Wed, 14 Aug 2019 17:49:29 +0200
Message-Id: <20190814154929.9481-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Mostly small clean-ups and bug fixes,

There was a fix to a bug where the paramater to -t was being ignored if 
the user didn't also specify the affinity -a.

This was a bit of fallout from the changes to automatically use numa if
support for it is available.

Bug reports and patches, are always welcome.

John Kacur

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
branches

Branches
unstable/devel/latest (rt-tests: Version 1.5)
unstable/devel/latest-devel (for latest development of Version 1.5)

tarballs are available here
https://kernel.org/pub/linux/utils/rt-tests

older version tarballs are available to in
https://kernel.org/pub/linux/utils/rt-tests/older

John Kacur (3):
  rt-tests: Use gettid from rt-utils.c everywhere
  rt-tests: hwlatdetect: Remove kmodule options and clean-up help
  rt-tests: cyclictest: Without -t default to 1 thread in numa case

Kurt Kanzenbach (6):
  rt-tests: deadline: Remove duplicated code for sched_{set,get}_attr
  rt-tests: cyclicdeadline: Remove unused getcpu code
  rt-tests: deadline: Remove duplicated gettid() code
  rt-tests: cyclicdeadline: Add options to usage
  rt-tests: cyclicdeadline: Print fail only if something failed
  rt-tests: cyclicdeadline: Fix cgroup setup

Qiao Zhao (1):
  ptsematest, sigwaittest, pmqtest, svsematest reprot error "Could not
    access /sys/kernel/debug/tracing/tracing_enabled"

 src/cyclictest/cyclictest.c           | 13 ++---
 src/hwlatdetect/hwlatdetect.8         | 43 +++++++--------
 src/hwlatdetect/hwlatdetect.py        | 12 +----
 src/pmqtest/pmqtest.c                 |  4 +-
 src/ptsematest/ptsematest.c           |  4 +-
 src/rt-migrate-test/rt-migrate-test.c |  2 -
 src/sched_deadline/cyclicdeadline.c   | 71 ++++++------------------
 src/sched_deadline/deadline_test.c    | 78 ++-------------------------
 src/signaltest/signaltest.c           |  3 --
 src/sigwaittest/sigwaittest.c         |  4 +-
 src/svsematest/svsematest.c           |  4 +-
 11 files changed, 51 insertions(+), 187 deletions(-)

-- 
2.20.1

