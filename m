Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D8AC433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0686661264
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhKKUp0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhKKUp0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:26 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7579BC061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:36 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id r8so7051334qkp.4
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wpb+FIK9aVxcUGJ4/wV3peAtqkKdxJm2p173XNHD3D4=;
        b=F8Boc22ujx2qyOyZuHFau1IOrrSstqjMbkYq8k4KP1N5fZgaYVHZXqEqdNYD0eqPk7
         psd6k89Pe9dZJZGDQA76UL5XyrOWeamMPCxjcXRMhUDrWLlxcNGtaVVtJbbbZArp+ZFn
         UnYzN5v0xVKCv3kXkjzmsK2Uz+KKpHxF+pnQbBMnOG0bA6JXb6hsf1J/J5EFRDz7RLBb
         CLEnxJFsGCf6b0pyD8NbulDDU/tnaPObOxiq+J8kakTcdl4K13L64ec+P1aUl/BLbmQT
         RC47rg69XZDs1SSaILMZe72LVoyRgDOcSG/D3w5VwSMSqhQ/LIYTSSn+pr+K4ZzkChYs
         iU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Wpb+FIK9aVxcUGJ4/wV3peAtqkKdxJm2p173XNHD3D4=;
        b=mV5mRC/MJePWwMtTvKVwBoPrtbtvJ7tplOLXdPqG2xoNFTMcYWXJHLfEn6XNh6acaq
         hgqVIf5kWwQuqGvY6kB8VKBmdpRCnfPKTV9ZQVk40tuZFyYWvS7MwYsrCzU4f23Mu0W5
         LlRPvStdS0uvh99VmlotlH5KiJ1ZGyMRXtiWB5L9/xlSSSED8uup+yYRtVSOpKTZzaBS
         EHVzkGK21IG1aZ9zAjI+YCtVA9y9RfbDVpg6DIzDycG5zyYW3n9sf7dhBuVCGIsN6ec9
         kZ81m1hyPN3ueewERZAWPdSH6mFwiuHkvcWVGYTExLkGKq8lGD/k+2PoKQLpTT8z5tZO
         raDQ==
X-Gm-Message-State: AOAM531xRmBNAt1W/yqf968EKnroCRv4OZAzmwg2IivtJtWonhPFu4gz
        9XQ2AFnhTl2ETd14Dht/Ep6VCi7ToHI=
X-Google-Smtp-Source: ABdhPJwnjkjyuNMg0EPuMC1Kkg0/cpq0ONn3Gl8PdEr/NYfS1nTJCDEYJ6ESTsuYI/f161b6BR5heA==
X-Received: by 2002:a05:620a:1aa0:: with SMTP id bl32mr8624462qkb.140.1636663355372;
        Thu, 11 Nov 2021 12:42:35 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:35 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 12/17] rt-tests: hwlatdetect: Use abstractmethod decorator
Date:   Thu, 11 Nov 2021 15:42:02 -0500
Message-Id: <20211111204207.10167-12-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Use abstractmethod decorator instead of raising error if a method is
  not overridden.
- Remove unnecessary trailing comma
- fix import order

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 37 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index ff8265ac39c5..ea8f2036fe82 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -1,4 +1,5 @@
 #!/usr/bin/python3
+""" Module to detect smis """
 
 # SPDX-License-Identifier: GPL-2.0-only
 
@@ -6,12 +7,13 @@
 # (C) 2015,2016 Clark Williams <williams@redhat.com>
 # (C) 2009 Clark Williams <williams@redhat.com>
 
-import sys
-import os
-import time
-import subprocess
+import abc
 import errno
+import os
 import os.path
+import subprocess
+import sys
+import time
 
 version = "0.8"
 debugging = False
@@ -72,7 +74,7 @@ class DebugFS:
 
     def getval(self, item, nonblocking=False):
         path = os.path.join(self.mountpoint, item)
-        if nonblocking == False:
+        if nonblocking is False:
             with open(path) as f:
                 val = f.readline()
         else:
@@ -228,24 +230,25 @@ class Detector:
             os.close(self.dma_latency_handle)
             debug("c-states enabled")
 
+    @abc.abstractmethod
     def cleanup(self):
-        raise RuntimeError("must override base method 'cleanup'!")
+        ''' abstract cleanup method, must override '''
 
+    @abc.abstractmethod
     def get(self, field):
-        '''get the value of a debugfs field'''
-        raise RuntimeError("must override base method 'get'!")
+        ''' get the value of a debugfs field '''
 
+    @abc.abstractmethod
     def set(self, field, val):
-        '''set a value in a debugfs field'''
-        raise RuntimeError("must override base method 'set'!")
+        ''' set a value in a debugfs field '''
 
+    @abc.abstractmethod
     def save(self, output=None):
-        '''save sample data to reportfile'''
-        raise RuntimeError("must override base method 'save'!")
+        ''' save sample data to output '''
 
+    @abc.abstractmethod
     def display(self):
-        '''output the sample data as a string'''
-        raise RuntimeError("must override base method 'display'!")
+        ''' output the sample data as a string '''
 
     def start(self):
         count = 0
@@ -277,9 +280,9 @@ class Detector:
         self.c_states_on()
         debug("detector module disabled")
 
+    @abc.abstractmethod
     def detect(self):
-        '''get detector output'''
-        raise RuntimeError("must override base method 'detect'!")
+        ''' get detector output '''
 #
 # class to handle running the hwlat tracer module of ftrace
 #
@@ -294,7 +297,7 @@ class Tracer(Detector):
 
     class Sample:
         'private class for tracer sample data'
-        __slots__ = 'timestamp', 'inner', 'outer',
+        __slots__ = 'timestamp', 'inner', 'outer'
         def __init__(self, line):
             fields = line.split()
             i,o = fields[6].split('/')
-- 
2.31.1

