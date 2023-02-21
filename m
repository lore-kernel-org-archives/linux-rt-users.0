Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0D3C636D7
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Feb 2023 17:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjBURv7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjBURv6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Feb 2023 12:51:58 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7712D178
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 09:51:57 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id j2so5188192wrh.9
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 09:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKEyaHgsQXeiwJnGrO+oPf7B369IdttcUln6hmUp0QM=;
        b=kQl6Ax5KltLKGkxVz3tTD+R4P2l/n2ZXGbh5Yqn3jiXHGDtnAZdw8SvkYk3F/bBCXR
         nNA2VcxV4huhhXYLp+xGLl1LGkMFQw2l1hNVwrK9/P0m9pyp0UtsjiBb916fzsVvN8vq
         JmAmYW3IYlYjMNrg9bV6kruVPvTSyJhPvNUnk8NHaRH6wBPKY1rb2phtXdCixrZOLegA
         Hwp4sGZBNgN6sa9omi2Lbp6upfeMImDyrhaimsypvOke3rxJHo6BtD1caC1HCyMl4scv
         jF51hKJxYK5CJAZDVSHNWnq5LxuFoqIGGsgEHjrPgZOD3MzZCKIpdHTyIV1UrkKHgqs1
         GLvA==
X-Gm-Message-State: AO0yUKW3j8L0w+wY3Q2hfQ3STo0h8s03YSbShNtY6xUjYje8W4UrFQYq
        Q69XdIQ8XafwCC3Ap2mRGHC4m6xtQZ0B1g==
X-Google-Smtp-Source: AK7set/WzzixStpxKa3fnlA8H+RLeXzDt7s1UjD9MkQACiZu2FwwARmMZYmbuj/6wndc2RH77NsZwg==
X-Received: by 2002:a5d:6286:0:b0:2c5:fd85:43e4 with SMTP id k6-20020a5d6286000000b002c5fd8543e4mr4096735wru.47.1677001915537;
        Tue, 21 Feb 2023 09:51:55 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id f4-20020a7bcd04000000b003e00c9888besm13511628wmj.30.2023.02.21.09.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:51:55 -0800 (PST)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Bart Wensley <bwensley@redhat.com>, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH v1] rt-tests: hwlatdetect: Add field cpu to samples output
Date:   Tue, 21 Feb 2023 19:51:53 +0200
Message-Id: <20230221175153.452991-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Information about CPU index is valuable for debugging
latency issues
---
 src/hwlatdetect/hwlatdetect.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 68df58f..dc28f38 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -237,10 +237,11 @@ class Tracer(Detector):
 
     class Sample:
         'private class for tracer sample data'
-        __slots__ = 'timestamp', 'inner', 'outer'
+        __slots__ = 'cpu', 'timestamp', 'inner', 'outer'
 
         def __init__(self, line):
             fields = line.split()
+            self.cpu = int(fields[1][1:-1])
             i, o = fields[6].split('/')
             ts = fields[7][3:]
             self.timestamp = str(ts)
@@ -248,7 +249,7 @@ class Tracer(Detector):
             self.outer = int(o)
 
         def __str__(self):
-            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}"
+            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
 
         def display(self):
             """ convert object to string and print """
-- 
2.31.1

