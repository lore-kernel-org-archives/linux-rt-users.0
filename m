Return-Path: <SRS0=ADFb=AR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C2C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BDA206B6
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS96XEHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGFURr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgGFURg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF02C08E88C
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2020 13:17:35 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c30so32239742qka.10
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jul 2020 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcufJaQ6tvjaSRdqCJZ8LFvNc6emkGhoR+xdYmyaIug=;
        b=DS96XEHT1Ue12CZVseCJSPF6lFCu20UaK7GvYxd/ZVWxm/2/rn/nUhjWThw76MZgnm
         ct1UvULn+7SdapzOH5oZYlpddPHbCIqPKwdBllBLvIYne+Q7wDvesAjdIWBJCp04skg+
         EUMcqKPHUcnTeuWP84Mdlt2jUO8L6q7Jjn5slaMpKv6+oyPhwumGU5T8ITrfSrbY1e4T
         Oj/M3TAulPpFppRq74z/IgA14E2K5SHc46P6wv9qpQucnj7SzO8tP3fLab60YTaN+gSI
         x8q6TB8dIbajXvvzqLqkEDVDifx8iSXyds2U0gzATCZvjmtuWNXmtwtqUn+nJ5YDu/jF
         zMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KcufJaQ6tvjaSRdqCJZ8LFvNc6emkGhoR+xdYmyaIug=;
        b=AOuf2wPH9ggdw/+egxXC4oCH7lf46Y9CVkkVXStc2WlARZeZ5Ryg1OqPkXyzhjx61Z
         JXPkwkvj3SD4ChQmSfSVh6rtxs+dguL2S3w25np55TWaQP1dRCPaMlnbxn68FVGuwTzf
         ooVptthk0kMkUz8fDq9BbxNH32mrc4E/iiD2LupAJGyI/4+2D3BpZMR4WAY/crZc9iCK
         LXn+wXk4s6+0RcU/lWK+kKEyS29d73uwX3u+tySJqXIeiLj8/A50s+OGj+npETNVV5OK
         onHxVm+8BG8mFz0cNLJeG5dFpZBB78lwJxMNTJ0MIknLW8dSZaeS+3TzLo0Ox/vkSIJx
         N27A==
X-Gm-Message-State: AOAM531YofHKwKnhRM4e9pwaRrONSxovTn4/q4JMx9QRFx7X4rWBjUfg
        4eGXcbgpcr3EBogD8/BLxzUpOip1phI=
X-Google-Smtp-Source: ABdhPJxJLdMsXIozlZWI3yvJ3RgEmx8T+C24fCeh+RN+wxJ7/3oon6I+cCzR9qIuLvsP51Iynj8A1Q==
X-Received: by 2002:a05:620a:238:: with SMTP id u24mr49490714qkm.168.1594066654084;
        Mon, 06 Jul 2020 13:17:34 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id 73sm21551692qkk.38.2020.07.06.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:33 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/7] cyclicteset: improvements to the python style in get_cyclictest_snapshot
Date:   Mon,  6 Jul 2020 16:17:16 -0400
Message-Id: <20200706201722.13400-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Improvements to the python style in get_cyclictest_snapshot

- Add comments to the methods, functions, class and moduleb
- Put imports on individual lines
- Use "is" and "is not" with None insteald of == or !=
- Don't compare the length of lists to zero, to determine if they are
  empty

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/get_cyclictest_snapshot.py | 38 +++++++++++++----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/src/cyclictest/get_cyclictest_snapshot.py b/src/cyclictest/get_cyclictest_snapshot.py
index 7dddfc5d65b0..27fc629ca53e 100755
--- a/src/cyclictest/get_cyclictest_snapshot.py
+++ b/src/cyclictest/get_cyclictest_snapshot.py
@@ -1,9 +1,14 @@
 #!/usr/bin/env python3
+""" Program to get a snapshot of a running instance of cyclictest """
 
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (C) 2020 John Kacur <jkacur@redhat.com>
 
-import subprocess, signal, argparse, re, glob, sys
+import subprocess
+import argparse
+import re
+import glob
+import sys
 
 parser = argparse.ArgumentParser(description='Get a snapshot of running instances of cyclictest')
 parser.add_argument('-l', '--list', action='store_true', help='list the main pid(s) of running instances of cyclictest')
@@ -11,8 +16,8 @@ parser.add_argument('-s', '--snapshot', nargs='*', metavar='pid', help='take a s
 parser.add_argument('-p', '--print', nargs='*', metavar='pid', help='print the snapshots')
 args = parser.parse_args()
 
-
 class Snapshot:
+    """ Class for getting a snapshot of a running cyclictest instance """
 
     def __init__(self):
         self.pids = []
@@ -20,6 +25,7 @@ class Snapshot:
         self.refresh()
 
     def refresh(self):
+        """ Create a list of running cyclictest instances. """
         self.pids = []
         self.shm_files = glob.glob('/dev/shm/cyclictest*')
         self.shm_files.sort()
@@ -27,21 +33,21 @@ class Snapshot:
             pid = re.search('[0-9]*$', shm_file).group()
             self.pids += [pid]
 
-    # Send USR2 to all running instances of cyclictest or just to
-    # a specific pid (spid) if specified
     def take_snapshot(self, spids=None):
+        """ Send USR2 to all running instances of cyclictest,
+            or just to a specific pid (spids) if specified. """
         for pid in self.pids:
-            if (spids == None) or (pid in spids):
-                # print("kill -s USR2 ", pid)
+            if (spids is None) or (pid in spids):
                 subprocess.run(["kill", "-s", "USR2", pid])
 
     def print_pids(self):
+        """ Print the list of pids of running cyclictest instances. """
         for pid in self.pids:
             print(pid)
 
-    # Print the data in /dev/shm/cyclictest*
     def print(self, spids=None):
-        if spids == None:
+        """ Print the data in /dev/shm/cyclictest* """
+        if spids is None:
             for shm_file in self.shm_files:
                 with open(shm_file, 'r') as f:
                     data = f.read()
@@ -59,17 +65,17 @@ snapshot = Snapshot()
 if args.list:
     snapshot.print_pids()
 
-if args.snapshot != None:
-    if len(args.snapshot) == 0:
-        snapshot.take_snapshot()
-    else:
+if args.snapshot is not None:
+    if args.snapshot:
         snapshot.take_snapshot(args.snapshot)
-
-if args.print != None:
-    if len(args.print) == 0:
-        snapshot.print()
     else:
+        snapshot.take_snapshot()
+
+if args.print is not None:
+    if args.print:
         snapshot.print(args.print)
+    else:
+        snapshot.print()
 
 if len(sys.argv) == 1:
     snapshot.take_snapshot()
-- 
2.21.3

