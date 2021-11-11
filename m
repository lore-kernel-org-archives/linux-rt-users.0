Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2765FC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E55F61212
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhKKUpX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhKKUpW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:22 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86DC061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:33 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id bq14so7082470qkb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+9mwUvbRbvgV/9VKtFJuZpgcs1shqRnqERFSrUpDbQ=;
        b=HYXzgTV5rsaXuXERvE0yjfcqyLGLz7bjV35rI+XaiO0U6/B1RINd398TWlhQTvT2cR
         7BXIg3i6/JN3L+7dDTZ6Tc8gzXVfIEfkiQc7QbFIGYBEo0p1tpSBW8/c09RW/v+EquL7
         H24PvAZVL5SBWHLimmqzVTLY/8ZrMkt0bMzS6MH2vVqvgrm9s+Nz4sreXJeScIutVRtb
         fTsTN5uis6G4twKc88og+ZjavLWsByjpCduNIeDFsgPjIfy6nDvny0GaTmsJ/mm3wYxx
         Ojr5AYOxcM9g/WvgW6s23ILsAzfKr0CxMPrO0j12lOVW/LxqQKy0lPpt2V1KVym9QKzQ
         HwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=u+9mwUvbRbvgV/9VKtFJuZpgcs1shqRnqERFSrUpDbQ=;
        b=oPJFoKqmopwJeH+6WrEY7Kp0bwqcfutzHiKxUvjO4mv4FY6+SObuLtzBITZtAiWUTl
         XdEsxAujTHRKCKymYXjE9kdGXklXOYAPNolu5EL8RBkmGqfm9Waiw3X06GP6X/2k8WqW
         CkpccKpD7vISLQedQAc6ZnB//mbddM2gp6FMTkiBohQDO4odW5xKzxGbJg86G2EIVQgX
         A6uRXrZBbo8dADpwSj6sdIvsrQFbNN5oNCumyvgvdRFYPMGR18+PCPLpWpJNqBfkzLkI
         16PBop9SKLkyGs4c6p/aHs0NYF4I/cvWzrnNefZF9AJ59MqSMyutjJBY/zfanwxPKh6l
         ewqg==
X-Gm-Message-State: AOAM533R3cdS/n59wxE3RgT6SyG/OfC/uXa+d++eJq9XG+kDWSc8ZJWW
        lU+CDDBKBU2tLJFnvZRC3a/w8Ls85uI=
X-Google-Smtp-Source: ABdhPJzLRnqFQy2uil6o76LEhmYByVzdC4At6yCNjh6j3VKPWPTwBeGEJA2+Kdjle/mcDUxSjV0WoQ==
X-Received: by 2002:a05:620a:1901:: with SMTP id bj1mr8600192qkb.325.1636663352367;
        Thu, 11 Nov 2021 12:42:32 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:32 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 08/17] rt-tests: hwlatdetect: Use "with" for opening files
Date:   Thu, 11 Nov 2021 15:41:58 -0500
Message-Id: <20211111204207.10167-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use "with" for opening files

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 43 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 2fabbb55b242..a530867777a7 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -39,14 +39,13 @@ class DebugFS:
         self.premounted = False
         self.mounted = False
         self.mountpoint = ''
-        f = open('/proc/mounts')
-        for l in f:
-            field = l.split()
-            if field[2] == "debugfs":
-                self.premounted = True
-                self.mountpoint = field[1]
-                break
-        f.close()
+        with open('/proc/mounts') as f:
+            for l in f:
+                field = l.split()
+                if field[2] == "debugfs":
+                    self.premounted = True
+                    self.mountpoint = field[1]
+                    break
 
     def mount(self, path='/sys/kernel/debug'):
         if self.premounted or self.mounted:
@@ -74,9 +73,8 @@ class DebugFS:
     def getval(self, item, nonblocking=False):
         path = os.path.join(self.mountpoint, item)
         if nonblocking == False:
-            f = open(path)
-            val = f.readline()
-            f.close()
+            with open(path) as f:
+                val = f.readline()
         else:
             f = os.fdopen(os.open(path, os.O_RDONLY|os.O_NONBLOCK), "r")
             try:
@@ -97,10 +95,9 @@ class DebugFS:
 
     def putval(self, item, value):
         path = os.path.join(self.mountpoint, item)
-        f = open(path, "w")
-        f.write(str(value))
-        f.flush()
-        f.close()
+        with open(path, "w") as f:
+            f.write(str(value))
+            f.flush()
 
     def getpath(self, item):
         return os.path.join(self.mountpoint, item)
@@ -378,10 +375,10 @@ class Tracer(Detector):
 
     def save(self, output=None):
         if output:
-            f = open(output, "w")
-            for s in self.samples:
-                f.write("%s\n" % str(s))
-            print("report saved to %s (%d samples)" % (output, len(self.samples)))
+            with open(output, "w") as f:
+                for s in self.samples:
+                    f.write("%s\n" % str(s))
+                print("report saved to %s (%d samples)" % (output, len(self.samples)))
 
     def display(self):
         for s in self.samples:
@@ -443,10 +440,10 @@ class Hwlat(Detector):
 
     def save(self, output=None):
         if output:
-            f = open(output, "w")
-            for s in self.samples:
-                f.write("%s\n" % str(s))
-            print("report saved to %s (%d samples)" % (output, len(self.samples)))
+            with open(output, "w") as f:
+                for s in self.samples:
+                    f.write("%s\n" % str(s))
+                print("report saved to %s (%d samples)" % (output, len(self.samples)))
 
     def cleanup(self):
         if not self.kmod.unload():
-- 
2.31.1

