Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A3BC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jan 2022 19:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiAMTZE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jan 2022 14:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiAMTZD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jan 2022 14:25:03 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33358C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jan 2022 11:25:03 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id jr5so7911919qvb.11
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jan 2022 11:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OTN42X16amUFwGXSesgB29lNQgKIHfhxZFtb0Q5f18=;
        b=LnXQwDexeG9STp/Nx3O0QW6moIMSQhoEStbWleNPWjV2MxIgt5YWwvG2TQqNm3WXRn
         DRsRVUJybj6nUEKeasP/IEy/+NMt8uTz6vn1V8aAS0jGbQ4O+0geljXbbSx/wjKjsiNC
         cuHiPjQKr3TZsTkpCgp2BArKXqxj45vvZKZIWVOOFsWCKwGILWphRcCn0/vBRKCaHY57
         d7kCXFCEitYVikZ2d75xMWMGDDHItjmvmJHfMNg7QCxma9kh19PckDXuO62s7XumiMx2
         hHQeBLK4rzpXuZIgyyrqQGx2AtaG+QYkzL2fLlpUUD2y4zvQHJBlQO0IQsLEiFG3SuEa
         xktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+OTN42X16amUFwGXSesgB29lNQgKIHfhxZFtb0Q5f18=;
        b=zYLD6eh8gLSvXkVsYa0AAL/gpV55ZIYlDwVFBmSI4kULjZFwz4P2J7dgK5TsKu6Yk0
         plCtHToxycZZKYIztm/mlT4yJR49vD0MzcIowMIqQItOYTd7KvhcCNvP92qSRnz0uSHm
         axSASltwibzLkoqyw06EefZmglNobVmbece/FEAk+xsAjUlF+SX9HIOXUdOJilgogNGe
         E29+Pfm+Guy4bJFHuzhY+XGKpNJh02ND4yzYIxvmoRBQLgjrXQrO5YeKdRAkIQge8Cbk
         E5eswsusT/TDTTMOHiXuYtGsYh1kVpi+RO8Ygc2GlI6TrUgbzfRMje+0DmcMvcBuZyLR
         IQ7w==
X-Gm-Message-State: AOAM533qUsuVuif4Qh/qnuiMiGOcR91f+WwnDw3Bn0LR7WgpT7BnNxfT
        gjCEta4xwuiNyVycNrvaoYL1rXA1ugc=
X-Google-Smtp-Source: ABdhPJy85dH1JlOfuFCgVANZP+6e6jnxhpkzCd7aPC/wYVjPUS5McL8k7vJTSR7jX4CW6h2ycfD01w==
X-Received: by 2002:a05:6214:20ac:: with SMTP id 12mr5250977qvd.119.1642101901702;
        Thu, 13 Jan 2022 11:25:01 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id r4sm2514369qkp.93.2022.01.13.11.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 11:25:01 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] I'm pleased to announce version 3.3 of rteval
Date:   Thu, 13 Jan 2022 14:24:43 -0500
Message-Id: <20220113192443.168001-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm pleased to announce rteval-3.3

Some changes of note:
- The idea of an exclusive load module has ben added.
- stress-ng has been made an exclusive load module, so that when it
  runs, no other load modules run
- --cyclictest-threshold=USEC added to end a rteval run early if the
  threshold exceeds the specified USEC
- --hackbench-runlowmem allows hackbench to run on machines with
  low memory (by default it is not run on low memory machines)
- Support for systems running kthreads with a deadline policy

A special thanks to Punit Agrawal for many bug fixes and for changes
that make it easier to run rteval on non-x86-64 machines such as ARM

Comments, bug reports and patches are always welcome

Thanks
John Kacur

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.3

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval/

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older

Atsushi Nemoto (1):
  rteval: cyclictest.py: Do not pass obsolete --notrace option

John Kacur (18):
  rteval: Restrict measurement threads to the cpus in cpumask
  rteval: Update to using the linux-5.13.2 kernel
  rteval: Add __contains__ in rtevalConfig
  rteval: Only process warnings if dmidecode_loaded is True
  rteval: Construct a 'model name' on architectures that don't have one
  rteval: kcompile: Fix for no numactl and no cpulist
  rteval: services: Iterate through items in MakeReport
  rteval: Remove mult from hackbench.py
  rteval: Remove self.__err_sleep
  rteval: Make donotrun work correctly in load modules
  rteval: Add idea of exclusive load module and make stress-ng one
  rteval: systopology: Use 'with' on open with sysread
  rteval: systopology: Update copyright
  rteval: kcompile: Fix spelling in debug message
  rteval: Change misc.py to be executable
  rteval: Add --cyclictest-threshold=USEC
  rteval: Don't run hackbench by default on low memory systems
  rteval: update version number to v3.3

Punit Agrawal (8):
  rteval: systopology.py: Add support for systems that don't have Numa
  rteval: osinfo.py: Fix RT kernel detection
  rteval: services.py: Fix incorrect detection of container environment
  rteval: hackbench.py: Enable running on a system with low memory
  rteval: kernel.py: Add support for kthreads running with deadline
    policy
  rteval: cyclictest.py Parse max latencies from cyclictest output
  rteval: cyclictest.py: Sort the list of cpus
  rteval: cyclictest.py: Skip statistics reporting in case of an
    overflow

 Makefile                                 |  2 +-
 rteval.spec                              |  2 +-
 rteval/__init__.py                       |  4 +-
 rteval/misc.py                           | 21 ++++++++
 rteval/modules/__init__.py               | 21 ++++++++
 rteval/modules/loads/__init__.py         |  2 +-
 rteval/modules/loads/hackbench.py        | 22 +++++---
 rteval/modules/loads/kcompile.py         | 39 ++++++++++----
 rteval/modules/loads/stressng.py         |  2 +
 rteval/modules/measurement/cyclictest.py | 65 ++++++++++++++++++++----
 rteval/rteval.conf                       |  2 +-
 rteval/rtevalConfig.py                   |  2 +
 rteval/sysinfo/dmi.py                    |  3 ++
 rteval/sysinfo/kernel.py                 |  2 +-
 rteval/sysinfo/osinfo.py                 |  2 +-
 rteval/sysinfo/services.py               | 16 +++---
 rteval/systopology.py                    | 42 ++++++++++++---
 rteval/version.py                        |  2 +-
 18 files changed, 199 insertions(+), 52 deletions(-)
 mode change 100644 => 100755 rteval/misc.py

-- 
2.31.1

