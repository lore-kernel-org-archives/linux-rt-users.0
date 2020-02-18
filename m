Return-Path: <SRS0=BQEv=4G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5A2C34026
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Feb 2020 19:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772DA24125
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Feb 2020 19:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaCpEEXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgBRTzm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:55:42 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:47094 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTzm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Feb 2020 14:55:42 -0500
Received: by mail-qk1-f179.google.com with SMTP id u124so20251846qkh.13
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Feb 2020 11:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUVPGhu6OwamOO6fdJJ5XHy4AuuvrL4+m37F8JatzPM=;
        b=TaCpEEXsoBdEb8fmEkcJW/nUtog75kAEFHxgixSe5bQYVyMFyp2De94Ho1UfGcvZ9U
         +TskYqHprzqmZ8mECZauWqHsaHb906gEmHUuKXtONI6e6XpPF4p2cBYOWgDFivF5TUXr
         u070oamgORJurzohOAWm4M1fQYvhDQwhKtz3UG6XcCDze3thcHJpdh/bkIcimzu70/yK
         wEj6GMWYlVkKY/PzxdWvpveWP4AII67G8fxaQ4AhoN68dXsXgt8q6IooaLwnnEIUhGWA
         ZuFLOVPYLTv8l5Dqz+KIUFjIsUd3AwcgXF01yB5tFPbdUcfzFOBP0fji/TVkb1ulvT7W
         30ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YUVPGhu6OwamOO6fdJJ5XHy4AuuvrL4+m37F8JatzPM=;
        b=YjuCoI7k2bLgVPk+3M8aLsuB2ob48WDx+9D3NTV0P7p5wfcl0gO9aUtwICxP7chxEQ
         pV+MrIXqs+PqOcr7ktymkzTzeJOxhxWJiuBqWrcorE+9ac3t1oeRQQnrINDLMCbDbnl4
         BC4fTjJRWRtQYEG4IrDDrnA4K+Qn7qpGEMPzZyt/e6Mw23w+m7VqPtKApmKxzBR6Ym+j
         6YZxmjLRtLT8XiDmnEE3wx+TGi9Wn5lEgDmn2tOa5j/TjcKCw29l6WOXuAhjSdAd6jyM
         1sKgx8KnIDY5DZ+oL/4zvD7XpTulJd7BXnV1Pcl6rgMiYJedLRtuLJo/lI+R8Y21q46O
         cVkg==
X-Gm-Message-State: APjAAAURFDo+XfjgFhpXJjQGK4LqDeP+hc+MAFNlDmwrBiFWcHyg008+
        uYnDxUhZkUTWL62QYmLDNaRnNlXL
X-Google-Smtp-Source: APXvYqzBN0UkSOHY0BwHFcC49KxrHQnIOKGThidLKYhMLrs06CCLPR6b3wlVaah5nDZ3jPYLP6SODQ==
X-Received: by 2002:ae9:e50b:: with SMTP id w11mr20552095qkf.110.1582055739470;
        Tue, 18 Feb 2020 11:55:39 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id z5sm2486453qta.7.2020.02.18.11.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:55:38 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rt-tests: Add the get_cyclictest_snapshot.py utility
Date:   Tue, 18 Feb 2020 14:55:28 -0500
Message-Id: <20200218195528.8142-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218195528.8142-1-jkacur@redhat.com>
References: <20200218195528.8142-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a python script to get the current status of running cyclictest
instances.

There are a few options as explained in the online help, but you can
simply run it without any options to get the status of all instances.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/get_cyclictest_snapshot.py | 76 +++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100755 src/cyclictest/get_cyclictest_snapshot.py

diff --git a/src/cyclictest/get_cyclictest_snapshot.py b/src/cyclictest/get_cyclictest_snapshot.py
new file mode 100755
index 000000000000..7dddfc5d65b0
--- /dev/null
+++ b/src/cyclictest/get_cyclictest_snapshot.py
@@ -0,0 +1,76 @@
+#!/usr/bin/env python3
+
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2020 John Kacur <jkacur@redhat.com>
+
+import subprocess, signal, argparse, re, glob, sys
+
+parser = argparse.ArgumentParser(description='Get a snapshot of running instances of cyclictest')
+parser.add_argument('-l', '--list', action='store_true', help='list the main pid(s) of running instances of cyclictest')
+parser.add_argument('-s', '--snapshot', nargs='*', metavar='pid', help='take a snapshot of running instances of cyclictest')
+parser.add_argument('-p', '--print', nargs='*', metavar='pid', help='print the snapshots')
+args = parser.parse_args()
+
+
+class Snapshot:
+
+    def __init__(self):
+        self.pids = []
+        self.shm_files = []
+        self.refresh()
+
+    def refresh(self):
+        self.pids = []
+        self.shm_files = glob.glob('/dev/shm/cyclictest*')
+        self.shm_files.sort()
+        for shm_file in self.shm_files:
+            pid = re.search('[0-9]*$', shm_file).group()
+            self.pids += [pid]
+
+    # Send USR2 to all running instances of cyclictest or just to
+    # a specific pid (spid) if specified
+    def take_snapshot(self, spids=None):
+        for pid in self.pids:
+            if (spids == None) or (pid in spids):
+                # print("kill -s USR2 ", pid)
+                subprocess.run(["kill", "-s", "USR2", pid])
+
+    def print_pids(self):
+        for pid in self.pids:
+            print(pid)
+
+    # Print the data in /dev/shm/cyclictest*
+    def print(self, spids=None):
+        if spids == None:
+            for shm_file in self.shm_files:
+                with open(shm_file, 'r') as f:
+                    data = f.read()
+                print(data)
+        else:
+            for spid in spids:
+                if spid in self.pids:
+                    shm_file = '/dev/shm/cyclictest' + spid
+                    with open(shm_file, 'r') as f:
+                        data = f.read()
+                    print(data)
+
+snapshot = Snapshot()
+
+if args.list:
+    snapshot.print_pids()
+
+if args.snapshot != None:
+    if len(args.snapshot) == 0:
+        snapshot.take_snapshot()
+    else:
+        snapshot.take_snapshot(args.snapshot)
+
+if args.print != None:
+    if len(args.print) == 0:
+        snapshot.print()
+    else:
+        snapshot.print(args.print)
+
+if len(sys.argv) == 1:
+    snapshot.take_snapshot()
+    snapshot.print()
-- 
2.20.1

