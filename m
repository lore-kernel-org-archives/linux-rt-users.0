Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD73C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9076120D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhKKUpR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhKKUpR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:17 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0EC061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:27 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id bk22so7054141qkb.6
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWkwSvOMrUHP+BW4pVYcw37m7qJM+gx7dB5W+YZNYOY=;
        b=HroXzu0/F69BnPBC/MNC+rFFrYTy9g3P3GW1T6+erD11b/07Bds4rEqDb0awc/yGkz
         pNV10JyMS6K0lZXk/5O5czBGjZutAR3Pam5pjBS45irQC/8vkGBVyo5kSP8/hZi1Op0X
         lEnrL0bffqnqFXWcpG12ztc1FeISJpzg/97iT/HNvSf9PlT15zpPXE/8/zA6DB0lNKx2
         ougXxmXp0GXxxN/5pNfHWDuLry0v6DuFIqC0DiFt1CBAX70DhPtPRUN25ESrDQ8+6OJ3
         msjU4IWMT5Ncbu0qseSKPWt6qvNUY3iEwoN6XApf9ENFugyvUh24W3H4HGoyCmIhxQDB
         mpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=IWkwSvOMrUHP+BW4pVYcw37m7qJM+gx7dB5W+YZNYOY=;
        b=3EODdNIpM7ckgl9Hbem6n52Hv7jKAllopKDGwaRwIxHO8+Pz1rtxyP4nCf8LkuNqyj
         4O3ErSOP0IQdonhy9K2057WkjZn/n7RtySjfGStJJ2KaLWJWnBu9A9LYb5x8E+6IhimR
         R+cKdiqGdEKYXPOiGB+sf3Y5qhmY6welcY+OnA18gsELOE2NoE6WT1NC+F7S6OQ8mW/2
         tLI64/maMfdfm7BFB5luJkF6EsJX3tj1Wdy8euPDRysw85QR+xNXzrDX6xJHYQwtVQp0
         uIw157wS8x29eBEUNfGfR5QpIKNYQsosRlrT1RzKWUh4EwkNKMLzsYiBK/LYJBa4qGm2
         p4Qw==
X-Gm-Message-State: AOAM530vs58fYAMQZYxR8e4mK70HUHYfrCzOG5zclbpcsfcbALUYNNL0
        f6jl/iz+CZJBwyYhnjsxSpM9sE7mxAc=
X-Google-Smtp-Source: ABdhPJzavavxIn5zMi8GhL7rBSAYGUszmW1LEb98ct23sYsjTB5FGl41lkEppGdkU6QjNoYl/iEUGw==
X-Received: by 2002:a05:620a:2e3:: with SMTP id a3mr8238425qko.451.1636663346594;
        Thu, 11 Nov 2021 12:42:26 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:26 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 01/17] rt-tests:hwlatdetect: Remove useless object in class declaration
Date:   Thu, 11 Nov 2021 15:41:51 -0500
Message-Id: <20211111204207.10167-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

There is no need to specify object in python3 when creating a class

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 56fd2af8641d..ac87036d4c08 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -31,7 +31,7 @@ def info(str):
 # discovers that debugfs is already mounted, it will leave
 # it mounted.
 #
-class DebugFS(object):
+class DebugFS:
     '''class to manage mounting/umounting the debugfs'''
     def __init__(self):
         self.premounted = False
@@ -116,7 +116,7 @@ class DetectorNotAvailable(Exception):
 # above, if the module is already loaded, this class will
 # leave it alone when cleaning up.
 #
-class Kmod(object):
+class Kmod:
     ''' class to manage loading and unloading of kernel modules'''
 
     names = ("hwlat_detector", "smi_detector")
@@ -184,7 +184,7 @@ class Kmod(object):
 #
 # base class for detection modules
 #
-class Detector(object):
+class Detector:
     '''base class for detector modules'''
     def __init__(self):
         self.type = "unknown"
@@ -293,7 +293,7 @@ class Tracer(Detector):
         'threshold' : "tracing_thresh",
     }
 
-    class Sample(object):
+    class Sample:
         'private class for tracer sample data'
         __slots__ = 'timestamp', 'inner', 'outer',
         def __init__(self, line):
-- 
2.31.1

