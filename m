Return-Path: <SRS0=J4zX=TK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A3DC04A6B
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D750E21479
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 14:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOE/CczV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfEJOB7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 May 2019 10:01:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38549 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfEJOB7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 May 2019 10:01:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id f2so7661409wmj.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 May 2019 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tWlx1PabJFfrWe+WpvjjXR/GmXXSsCxmQGAmAKOOC0=;
        b=dOE/CczV6ijqLbeThORU/x99tDU+3WqXN/ru9EXMWogIwJBORqtKta/y/Dy5hdZ1hP
         H6Wil//S8LKDOPeruS9Avtgc4/k7noY+YoktpvWSCuxbIqPG/ntSlUOB5sjUOYOp0Yzm
         fIJ1xDw67W/AVVqZKFxzwGL74w5NWV/QG2ZsY0ZNqwFvMEueArUJgaYGZgnaULPK2XbJ
         C7x26L1NP2sNfxDZKONK5aTKzR4+S3w8h/Jm6MyEWL4eEMM/hD/OA5qVAc7L9Pg9Ttpl
         5sQ14M3Vv326WXZzr8i5Vlq0hvxnzJbH1TybCUE1t/NpH11GDrdbc5oM3t6wgFU6PkiZ
         qRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5tWlx1PabJFfrWe+WpvjjXR/GmXXSsCxmQGAmAKOOC0=;
        b=VrFcMEnA5psg+qiGm9nQZB+80HIYPASxw+I1QV0rZ1Zg/5fHDuDrzX427R9m6L9pcK
         uMUoBjGNG9sXm4niEIqcSrZ66hoVeNZKoFT6SB4g40d6WB5MnymtpgDcCRUHxGe7xgFD
         E1QlGcZFPOskj3NN0pQB9GDVnMbWDrjThz/ZyM/Vtr7pf4rqu+jZnc26rHdq/JzLy2f7
         4dBl0xrhcOZidpvyivlawTFV1dGYD0gjarR2Cmo3bFo7eb78MmG/+58n7f6ehJhMXrZ0
         t+nzf0MdJcTXkryu7CyFwBEfkX8IbY3KB3NAQnlEyJv2tlSRhTjSj9keYXsjv2hepXJX
         A+8g==
X-Gm-Message-State: APjAAAUidcNz8CmFKLPx4pj7yqZHUkNxydDKNEk5d7LrR8kBT+A8zURv
        IBg9lMDomhtTlBu4+HBp9S3NCqnC
X-Google-Smtp-Source: APXvYqxrT5gDb6/ALlCVFB318xG6z7qeyNSmO1mZ8TVt87nYTZ1Z96ataAHHDTgpXGh2uNYKlQv48g==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr7338949wmm.51.1557496915607;
        Fri, 10 May 2019 07:01:55 -0700 (PDT)
Received: from planxty.redhat.com (ip1f12216f.dynamic.kabel-deutschland.de. [31.18.33.111])
        by smtp.gmail.com with ESMTPSA id p14sm3713820wrt.53.2019.05.10.07.01.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 07:01:54 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: hwlatdetect.py: Code clean-up
Date:   Fri, 10 May 2019 16:01:44 +0200
Message-Id: <20190510140144.6817-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Remove obsolete from __future__
- Fix spacing around calls to print, open and brackets
- Fix spacing around assignments

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 368079a158b1..b72bdc3aa930 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -8,7 +8,7 @@
 # modify it under the terms of the GNU General Public License Version 2
 # as published by the Free Software Foundation.
 
-from __future__ import print_function
+
 
 import sys
 import os
@@ -84,7 +84,7 @@ class DebugFS(object):
             try:
                 val = f.readline()
             except OSError as e:
-                print ("errno: %s" % e)
+                print("errno: %s" % e)
                 if e.errno == errno.EAGAIN:
                     val = None
                 else:
@@ -159,7 +159,7 @@ class Kmod(object):
             return
 
         # now look for already loaded module
-        for l in open ('/proc/modules'):
+        for l in open('/proc/modules'):
             field = l.split()
             if self.name in field[0]:
                 self.preloaded = True
@@ -210,7 +210,7 @@ class Detector(object):
         if self.have_msr:
             p = subprocess.Popen(['/usr/sbin/rdmsr', '-a', '-d', '0x34'], stdout=subprocess.PIPE)
             p.wait()
-            counts = [ int(x.strip()) for x in p.stdout.readlines()]
+            counts = [int(x.strip()) for x in p.stdout.readlines()]
         return counts
 
     # methods for preventing/enabling c-state transitions
@@ -295,11 +295,11 @@ class Tracer(Detector):
 
     class Sample(object):
         'private class for tracer sample data'
-        __slots__= 'timestamp', 'inner', 'outer',
+        __slots__ = 'timestamp', 'inner', 'outer',
         def __init__(self, line):
             fields = line.split()
             i,o = fields[6].split('/')
-            ts=fields[7][3:]
+            ts = fields[7][3:]
             self.timestamp = str(ts)
             self.inner = int(i)
             self.outer = int(o)
@@ -332,14 +332,14 @@ class Tracer(Detector):
         self.set('current_tracer', 'hwlat')
 
     def set(self, field, val):
-        path=self.translate(field)
+        path = self.translate(field)
         self.debugfs.putval(path, str(val))
 
     def get(self, field):
         if field == "count":
             return len(self.samples)
         elif field == "max":
-            max=0
+            max = 0
             for values in self.samples:
                 s = int(values.largest())
                 if s > max:
@@ -435,7 +435,7 @@ class Hwlat(Detector):
 
     def display(self):
         for s in self.samples:
-            print (s)
+            print(s)
 
     def save(self, output=None):
         if output:
-- 
2.20.1

