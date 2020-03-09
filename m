Return-Path: <SRS0=JZDS=42=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF69C10F25
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB91921927
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Mar 2020 19:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/MnJubd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCITMG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:12:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33937 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgCITMG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Mar 2020 15:12:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id 59so7891287qtb.1;
        Mon, 09 Mar 2020 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=boJJOMs47hvrAL3gkrOn4XN/mgR+u/alIqrNyZApEIg=;
        b=h/MnJubdCQn4MyuFiYsI7JSAWiiKdR3lin/guP2E7lnZnbNg7aXiwJ95RRw3HvS+Vp
         0hvgo3KqnuH+l6rSs/4V6CiDSk09Vfl6Q9skhLuXc/QvWZd1pRMq/ZP9hlj4l8pXZXRZ
         0bwl5Vkl9UbRfJGGrzuxS/9hGU55EjGdDRvgVQCm13/u7v2QMmKPDkgBD8CJsMc9MhWm
         RWh3DZYXIp2tjJpYaL3sE0cPbc+DIEI4AVqjBnxyglqkwg2iq62j+3cHIPmkzyFHnl+K
         oZqEaDNweJwoAA1aBBLSvjU6HiNThJt9/b1FFfA34GuAhk0qTtl/gAaoPm3u0C5AZqof
         30KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=boJJOMs47hvrAL3gkrOn4XN/mgR+u/alIqrNyZApEIg=;
        b=ntBCxX5+6GbLyR22u3uc0ku4Fzb01XGvFuxjd90ANIlb6ns65NPqy16aU/BT6haLem
         //jarTl7Gt4Wsm4gfEQF7moj7O8cs7ckbLEP6s4LBhqr2XTUrTaq4K0UnL8dSCaZoxMX
         fVUCOTZIFtYu3dUldHi2OYWwKXti1KXYCeVnRqMUIpXouM3faDqOrj98r6VxapoEy4Pl
         f9+HlH3I6WNhStRr94ml+kqDV02Uaa3vnIHGWicm39u7yRopM52TRtkk5SN+C9AF9+hg
         RsiF6yySq5eGFa8uGJJhGFOqzDZ1jLudcXeaY7bm0mR0mawT6BkLzNT5ShjuuCsJaCJx
         ertQ==
X-Gm-Message-State: ANhLgQ2aMtZiiefw1Wbxbuts67Uq5fiZ5GuyetpcLFYT2lJbE2ncuPq+
        mK3BngGdZdgkwLxO1zgQLUQUp+K1wvE=
X-Google-Smtp-Source: ADFU+vu6M9SEnyXU7z/pERlgjRQZp5KhldfDsYFMhXCwVwr/xBae/49KObGqg87N/dX1WkmFVYKKEw==
X-Received: by 2002:aed:31c1:: with SMTP id 59mr11517693qth.370.1583781124224;
        Mon, 09 Mar 2020 12:12:04 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id a84sm1109956qkb.90.2020.03.09.12.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 12:12:03 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-1.8
Date:   Mon,  9 Mar 2020 15:11:34 -0400
Message-Id: <20200309191134.9062-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Lots of changes to affinity
- Fixes to the parsing of affinity in cyclictest
- Changes to cyclictest to obey the affinity of the environment it finds
  itself running in, instead of acting like it owns the whole machine.
  This should improve cyclictest running in containers
- Removal of old unsupported code
- Fix from Jeremy Puhlman to generate manpages in a cleaner fashion

Bug reports, testing, patches are always appreaciated.

Enjoy!

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: unstable/devel/latest

Tag: v1.8

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

Jeremy Puhlman (1):
  rt-tests: make manpages builds reproducible

John Kacur (11):
  rt-tests: cyclictest: Set errno to 0 before call to mlock
  rt-tests: cyclictest: Report all errors from pthread_setaffinity_np
  rt-tests: cyclictest: Fix parsing affinity with a space and a leading
    zero
  rt-tests: cyclictest: Fix parsing affinity with leading exclamation
    mark
  rt-tests: cyclictest: Only run on available cpus according to the
    affinity
  rt-tests: cyclictest: Only run on runtime affinity and user supplied
    affinity
  rt-tests: cyclictest: Remove HAVE_PARSE_CPUSTRING_ALL
  rt-tests: cyclictest: Remove support for compiling without NUMA
  rt-tests: cyclictest: Make the affinity mask apply to the main thread
    too
  rt-tests: cyclictest: Fix -t without a user specified [NUM]
  rt-tests: Makefile - update version

 Makefile                    |  29 ++-------
 src/cyclictest/cyclictest.c | 125 +++++++++++++++++++++++++++++++++---
 src/cyclictest/rt_numa.h    |  77 ----------------------
 3 files changed, 122 insertions(+), 109 deletions(-)

-- 
2.20.1

