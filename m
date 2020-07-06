Return-Path: <SRS0=ADFb=AR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989D4C433E3
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737AB206B6
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8pDdi+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGFURm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGFURk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57922C061794
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2020 13:17:40 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e13so36099705qkg.5
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jul 2020 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQc8EgrklepcdukQ7b2jsvSEGOX+8xiNYSrg0f5VsY4=;
        b=p8pDdi+F8iq+DXitFheGTZwdRMt6UKfAwl2B6+gBIAxgVkFn9vaKcZOOLhCp0V4hmJ
         HYLeCgRSc2KL7nYUjsdSbGLV09CjuW92JDC1Dn3Z/R+hjDGk9evXpt164KGY0lSmBecB
         7Rpls9+WZziyHBusZH9yOD5qJ1kD6rkGa8bY60CjzbR7uz0sjFb4CfhRaHUSIKe5J+nU
         KeD6BPup6JC/SYEYBFzjZOoJ7uwtHDMHo0oqMv0v82Fw9CmoOxnj04qdlF7lhexnov7A
         uNHKVtX1Q8eHO5i0G7ZTbFgNIm9UsfG0moi6I2Uth7D3YkjxJg4xR6h34gMX9Wo0sIv7
         CAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wQc8EgrklepcdukQ7b2jsvSEGOX+8xiNYSrg0f5VsY4=;
        b=IPbZ4kbksnveDiizQoJWW5yNr42UNkbXCPNy2mDmxiq6qIZLP8LPYcoNhwnCUm4EHd
         dcvWnIxyvzKnUh9FlCSX/vcy9ymDA0w82v0AFk26ipZ39F0BBvzQSlBhKR+zj5XoDCRm
         zORWMCaKcX4x9tjmDcL0EdlH3lM08MYytJTOrJEHhLWYiFxmamKFqIzGsPew8ZIUKu5a
         mSmPPjVXiU3M42o+sUmnnFRzFsO+xseEvjQ5MW2eRll5EMHKFBwBZaPlK+pV9dc6TRog
         VqpitBPMp+406blZbptynbMGYsRPXXfkMhJS7HW0y8n+lAXXyhZgs9lDbo/hH4Z9InO3
         U44Q==
X-Gm-Message-State: AOAM5300tMWbSTlX43nQ2kThy8kudmotueWyERzWV/7eOJ7H74crI/Qd
        3/89wQh+jnZvdmdTb4l9qHI0ddaxEdc=
X-Google-Smtp-Source: ABdhPJyu+O/eUWK42Xj2gO3DTvhtJ/feBBmRbgCNN4X6/fDK0/CocMlCE/EngnKxD4m+FTqVQ75uQQ==
X-Received: by 2002:a37:9dcc:: with SMTP id g195mr45733234qke.425.1594066659432;
        Mon, 06 Jul 2020 13:17:39 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id 73sm21551692qkk.38.2020.07.06.13.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:39 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 7/7] rt-tests: get_cyclictest_snapshot: Warn if no cyclictest instance found
Date:   Mon,  6 Jul 2020 16:17:22 -0400
Message-Id: <20200706201722.13400-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200706201722.13400-1-jkacur@redhat.com>
References: <20200706201722.13400-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Print a warning if no cyclictest instance is found.
- Also fix up the method take_snapshot for the case when the user
  provides a pid.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/get_cyclictest_snapshot.py | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/get_cyclictest_snapshot.py b/src/cyclictest/get_cyclictest_snapshot.py
index 27fc629ca53e..aed9681e4cc5 100755
--- a/src/cyclictest/get_cyclictest_snapshot.py
+++ b/src/cyclictest/get_cyclictest_snapshot.py
@@ -19,6 +19,14 @@ args = parser.parse_args()
 class Snapshot:
     """ Class for getting a snapshot of a running cyclictest instance """
 
+    warned = False
+
+    def print_warning():
+        """ print a warning one time only even if called multiple times """
+        if not Snapshot.warned:
+            Snapshot.warned = True
+            print("No cyclictest instance found")
+
     def __init__(self):
         self.pids = []
         self.shm_files = []
@@ -36,18 +44,27 @@ class Snapshot:
     def take_snapshot(self, spids=None):
         """ Send USR2 to all running instances of cyclictest,
             or just to a specific pid (spids) if specified. """
-        for pid in self.pids:
-            if (spids is None) or (pid in spids):
+        if spids is None:
+            if not self.pids:
+                Snapshot.print_warning()
+            for pid in self.pids:
+                subprocess.run(["kill", "-s", "USR2", pid])
+        else:
+            for pid in spids:
                 subprocess.run(["kill", "-s", "USR2", pid])
 
     def print_pids(self):
         """ Print the list of pids of running cyclictest instances. """
+        if not self.pids:
+            Snapshot.print_warning()
         for pid in self.pids:
             print(pid)
 
     def print(self, spids=None):
         """ Print the data in /dev/shm/cyclictest* """
         if spids is None:
+            if not self.shm_files:
+                Snapshot.print_warning()
             for shm_file in self.shm_files:
                 with open(shm_file, 'r') as f:
                     data = f.read()
@@ -59,6 +76,8 @@ class Snapshot:
                     with open(shm_file, 'r') as f:
                         data = f.read()
                     print(data)
+                else:
+                    Snapshot.print_warning()
 
 snapshot = Snapshot()
 
-- 
2.21.3

