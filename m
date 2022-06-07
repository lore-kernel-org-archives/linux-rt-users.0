Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87DCC43334
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Jun 2022 15:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbiFGPpf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242318AbiFGPp3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Jun 2022 11:45:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A6F1370
        for <linux-rt-users@vger.kernel.org>; Tue,  7 Jun 2022 08:45:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id n197so6431460qke.1
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Jun 2022 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjqZ7WITWrg1w3vt9O5tIjh0y3V9Me98pI8o/Nsw3As=;
        b=hjta+V8hS0/mlYEzkVbZayiNS9xewPpn7WGrYiSOm9c1nMoMOFMKl3D+/LiHE8YZbh
         fWFq8pe1LS7elKhAIjF3L4uMVJ1gWY7d6BcJ8+Q+U8b6Yf3ydMmFzZoFYBKlVU1XXbTp
         I8cWqFNLSY0potJ0iNzwv7qDHrYLb/i7NthjHuE6y1vxbAAvWrWZTaZImAGIdBB9NFUb
         5+E2q5VLr5tpdZxi7xOJyowVDOvMZ3kO2IAjYNg2qqFV5XI9IbhDr05vHvwCqh7EIrwr
         LM9T+IQdJFSt33ltbq9vm7qayn/XlAx3hv4wKpVlrHqAXCqBnLrxAqez07IbaI9D7s0c
         TOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MjqZ7WITWrg1w3vt9O5tIjh0y3V9Me98pI8o/Nsw3As=;
        b=kuj1QumwVy03rfRioXikHUnchUEPrO+770g5ZEzRkZ+5OlM1YecH9wuHN3X2TsvRYY
         zQLM8x1ZIHvjw8FO8LZ3oeliGtLYrx7R3gnrQq4lLHlqegsUTesTOpZrM5Dm3JEvPLPR
         OnkNqWYQ7saDthWfkXgTkXFCeh8KzV0A4y8pSltMNJvYhHWfXMmHoGgisG3po2QP5XuZ
         dFFt08ce7CppQ4E3l35fnstTEg5RxZPuJ4/A/tjV5tFK/L80zbVVZZ6xTqCyuHpzxN8l
         ynjQW3Mn40t8A8hAITrXeCkzxNoIBFF/gUgcrq59eq8ORmTUGCBIfpw+iWu/lH/3ccka
         K36w==
X-Gm-Message-State: AOAM5335Pdemu+HmBA8dM42dFOi70eXx+U3/NClc7Ba1+PGa2ATGu+Tj
        ACsj4VdT3+JBNYB2rrktIdTHUBbOSyw=
X-Google-Smtp-Source: ABdhPJy01e0+V9/o5cly0ReHNrLM8NQMtWKurKx6ygdDsv37M1hO6IJQ6CEc5TTn1JhTE7DlnLHRsw==
X-Received: by 2002:a05:620a:10a2:b0:6a6:b540:1c61 with SMTP id h2-20020a05620a10a200b006a6b5401c61mr8694254qkk.333.1654616727779;
        Tue, 07 Jun 2022 08:45:27 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id bk25-20020a05620a1a1900b006a673ac7891sm12659159qkb.91.2022.06.07.08.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:45:27 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Change the default kernel to compile to linux-5.18.1
Date:   Tue,  7 Jun 2022 11:45:18 -0400
Message-Id: <20220607154518.82004-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval compiles the linux kernel as a load
Change the default kernel that rteval compiles to linux-5.18.1

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                         | 2 +-
 rteval/modules/loads/kcompile.py | 4 ++--
 rteval/rteval.conf               | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 36d40867883c..ffea8a05f460 100644
--- a/Makefile
+++ b/Makefile
@@ -17,7 +17,7 @@ PREFIX  :=      /usr
 DATADIR	:=	$(DESTDIR)/$(PREFIX)/share
 LOADDIR	:=	loadsource
 
-KLOAD	:=	$(LOADDIR)/linux-5.13.2.tar.xz
+KLOAD	:=	$(LOADDIR)/linux-5.18.1.tar.xz
 BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
 LOADS	:=	$(KLOAD) $(BLOAD)
 
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 3d9b882d8810..2c93c794fe75 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -36,7 +36,7 @@ from rteval.Log import Log
 from rteval.misc import expand_cpulist, compress_cpulist
 from rteval.systopology import SysTopology
 
-DEFAULT_KERNEL_PREFIX = "linux-5.13"
+DEFAULT_KERNEL_PREFIX = "linux-5.18"
 
 class KBuildJob:
     '''Class to manage a build job bound to a particular node'''
@@ -326,7 +326,7 @@ class Kcompile(CommandLineLoad):
 
 def ModuleParameters():
     return {"source":   {"descr": "Source tar ball",
-                         "default": "linux-5.13.2.tar.xz",
+                         "default": "linux-5.18.1.tar.xz",
                          "metavar": "TARBALL"},
             "jobspercore": {"descr": "Number of working threads per core",
                             "default": 2,
diff --git a/rteval/rteval.conf b/rteval/rteval.conf
index aa0a53bcfc63..1a8d0afd2642 100644
--- a/rteval/rteval.conf
+++ b/rteval/rteval.conf
@@ -18,7 +18,7 @@ dbench:    external
 stressng: module
 
 [kcompile]
-source: linux-5.13.2.xz
+source: linux-5.18.1.xz
 jobspercore: 2
 
 [hackbench]
-- 
2.36.1

