Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F42C636D7
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Feb 2023 19:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBUT7S (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjBUT7J (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Feb 2023 14:59:09 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC9726CF2
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 11:59:05 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id l12so5462639qtr.0
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P1/Xd9+oZ6XAtyZJIv3edyNg9K0ooZPKCGjWPRvGkiA=;
        b=BmyzCSxVty9Ib0GTv94ys6GUWifw/gA2eYhyqGovpBqi/sOxEvz1T2ud+Fbm2YRqTU
         0udcEQgW1C7qnHD/CfEt/N+a80pgMKFcPoEUkqCE19La6toR2nBdy6pV84XZ77w1Z1wW
         coY4njlrXtkBALQiwGVFioCejV8PonGk//2NAi9+0GB2hQh7pzUioMLkjbTOWragVYST
         DpgjwD7KUV6grNlv/hyUqF9ah+38I7OTtSn7MJvDF75QTODP0wpDCRK/BKnCGqBRVE1J
         9zHKdFcvxc1LWEw3H9Dhleb1EGmtCt9NKjqMuYZlPFvWHYJwaYJYo3VhiKWcUYlsmMrv
         XcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1/Xd9+oZ6XAtyZJIv3edyNg9K0ooZPKCGjWPRvGkiA=;
        b=Dgj1btqkr+t3m/4MjU63LFU9y/XiPiI2zluV+P9Jjzwey1JJrZ20S9SRf6ZvX5wkMN
         jhD2o0nRVFpuisV94zYivU/5nsr5On5cBZE58GGZPvcQrEkWc5EaLzEj6wiyd4uGtg6d
         p3DV32+tT9kVRTWiODp83IE9HRKKiMGw95Gy8nawdseU0sKw4r+Iw2lEzM0D4LyaiU6r
         RtcVN1QzdyJWcGEW6coKECZdAvGC68p8uCFGlhdYRiSiCOo/NFTVyONoZcNlNNNfDmFh
         C8HIR5neJYonNoqmU9bLQz+HWHQT/A0wPOZYgq/OSSGRXaJRVPuoMrc2dRErASkZpknq
         ezbQ==
X-Gm-Message-State: AO0yUKWGoX+RCB+26T9bkkBMiqLRA91i8TDr1xUSoWaieJ4evMgs+akS
        tjBd/7iQIw7wrI8znmS7Eu5/3s6XBW8=
X-Google-Smtp-Source: AK7set8MX128ZwVZ362f87lgChIqGpDSjtPaWxBLQS0a2lepxF4jNmMM1beXFxQdwawqncrQLbTTyQ==
X-Received: by 2002:ac8:7d81:0:b0:3bd:11a5:c126 with SMTP id c1-20020ac87d81000000b003bd11a5c126mr8082130qtd.53.1677009543984;
        Tue, 21 Feb 2023 11:59:03 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id r21-20020a37a815000000b00742301f1bfbsm758934qke.45.2023.02.21.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:59:02 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] *** rteval-3.6 ***
Date:   Tue, 21 Feb 2023 14:58:25 -0500
Message-Id: <20230221195828.17919-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I am pleased to announce version 3.6 of rteval

Some highlights of this release
- It removes the dependency on python-ethtool
- Catches any failures in python-dmidecode without failing
  Reports have also been sent upstream to fix a problem in python
  dmidecode uncovered by rteval
- Changes the default linux kernel to compile as a load to linux-6.1.8
- Removes deprecated distutils

Enjoy!

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.6

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older


John Kacur (14):
  rteval: Fix "DMI WARNING" when not running as root
  rteval: Replace python-ethtool with inline code
  rteval: Don't attempt to get DMIinfo if there are dmi warnings
  rteval: rteval/__init__.py: Convert regular strings to f-strings
  rteval: rtevalReport.py: Convert regular strings to f-strings
  rteval: rtevalXMLRPC.py: Convert regular strings to f-strings
  rteval: rtevalConfig.py: Convert regular strings to f-strings
  rteval: xmlout.py: Convert to f-strings where possible
  rteval: Log.py: Convert to f-strings
  rteval: Catch failures in python-dmidecode
  rteval: Change the default kernel to compile to linux-6.1.8
  rteval: Use sysconfig instead of deprecated distutils
  rteval: setup: Remove distutils and clean-ups
  rteval: Update version number to v3.6

 Makefile                         |   2 +-
 rteval-cmd                       |   4 +-
 rteval.spec                      |   2 +-
 rteval/Log.py                    |   9 +-
 rteval/__init__.py               |  39 +++---
 rteval/modules/loads/kcompile.py |   4 +-
 rteval/rteval.conf               |   2 +-
 rteval/rtevalConfig.py           |  10 +-
 rteval/rtevalReport.py           |   6 +-
 rteval/rtevalXMLRPC.py           |  34 ++---
 rteval/sysinfo/__init__.py       |  11 +-
 rteval/sysinfo/dmi.py            |  87 +++++++-----
 rteval/sysinfo/network.py        | 117 ----------------
 rteval/sysinfo/newnet.py         | 225 +++++++++++++++++++++++++++++++
 rteval/version.py                |   2 +-
 rteval/xmlout.py                 |  10 +-
 setup.py                         |  27 ++--
 17 files changed, 359 insertions(+), 232 deletions(-)
 delete mode 100644 rteval/sysinfo/network.py
 create mode 100644 rteval/sysinfo/newnet.py

-- 
2.39.1

