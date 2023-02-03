Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF06C636CC
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Feb 2023 21:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjBCVQP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjBCVQA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2023 16:16:00 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1AB9D59E
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Feb 2023 13:15:46 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g7so7009594qto.11
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2023 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAmJ4bWrL6uHqTRBbi7KacegWXByiEy1/B9GJH3uDyg=;
        b=iK8DNtpGkBcdFXmkYQcDV/JecbiFNQFQXIqlAgxkfFQGgJ+5a3I41XaIVSd1RYHjtK
         FEZhBKw8IrbstufsNYKfA/86gjSzhJIjVa0NDDatPDRz2+MWgO/o4PVBBW1q7fVKVArs
         AtduEWsjUs1nMSV51lhxx4PCzmipO3o4r6YBzabGX/hKCXHbavZR+4xARlolKAxKacCd
         hmdZvtQKQ/QiULsqaMr7tnniKZQ1DFYjx83ZQSH7SsJQQFeiAI5oklfoYX3/YFuAEuIa
         ISDdJR3TlnHWmVfZB7jk+29IJPn39vF5GLRA/pwsnsrEmnoz3yCx+osYyqXqL1QQbNZv
         JBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SAmJ4bWrL6uHqTRBbi7KacegWXByiEy1/B9GJH3uDyg=;
        b=QvFrzqY6399WWwiGX1a0yIUlgq3A7Eagkl82ccTqCHKYbXVNlNPFUFgtpSYJx8sNB1
         1VgTxM4gy9t+IB2iI97kiw1bWEIzg8B6czzDQ7QSJfp/06xr/ofQlbOLM297cEbLelNi
         ycDM7IRgod2J8ggKPAwhpibxBZatgp8+8fXgnQvXRTQbpPVwusnsC/cKwjXybbAuqW+Q
         eRE7MQRctJodfYHX1qvFDbJ2ILW0SwC1cok2zsUEizEWV50o3FiPZYB42yvVJn/kBRhv
         zL6syeL/ya3aE0bUoEDU+TKoCkXsGlk9zX3EGQbjoyXdEK/zwozEu3NuuhTraqJhRrBH
         n8tw==
X-Gm-Message-State: AO0yUKUzbamLGLY7ixsc6jOAWTzu7+J4wxyssO6az+OLxHbKPW/wsw/x
        3Ic5bLZS3FQnSX2KTfbXxDqV0mrSWGQ=
X-Google-Smtp-Source: AK7set8HAyTfP8ZgE/OsQKvY/dDs1hg3hfERqM3COZfoaRDJShNb+K9X6gHhOJHvM/HpjEnw7+pV5A==
X-Received: by 2002:ac8:5a4b:0:b0:3b6:8881:6b07 with SMTP id o11-20020ac85a4b000000b003b688816b07mr19763635qta.48.1675458945188;
        Fri, 03 Feb 2023 13:15:45 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b00706bc44fda8sm2531004qkb.79.2023.02.03.13.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:15:44 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 8/8] rteval: Change the default kernel to compile to linux-6.1.8
Date:   Fri,  3 Feb 2023 16:15:27 -0500
Message-Id: <20230203211527.71181-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203211527.71181-1-jkacur@redhat.com>
References: <20230203211527.71181-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval compiles the linux kernel as a load
Change the default kernel that rteval compiles to linux-6.1.8

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                         | 2 +-
 rteval/modules/loads/kcompile.py | 4 ++--
 rteval/rteval.conf               | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ffea8a05f460..81ca8242bbbe 100644
--- a/Makefile
+++ b/Makefile
@@ -17,7 +17,7 @@ PREFIX  :=      /usr
 DATADIR	:=	$(DESTDIR)/$(PREFIX)/share
 LOADDIR	:=	loadsource
 
-KLOAD	:=	$(LOADDIR)/linux-5.18.1.tar.xz
+KLOAD	:=	$(LOADDIR)/linux-6.1.8.tar.xz
 BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
 LOADS	:=	$(KLOAD) $(BLOAD)
 
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 6faa686f81d0..35ee5cbbb52d 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -38,7 +38,7 @@ from rteval.systopology import CpuList, SysTopology
 expand_cpulist = CpuList.expand_cpulist
 compress_cpulist = CpuList.compress_cpulist
 
-DEFAULT_KERNEL_PREFIX = "linux-5.18"
+DEFAULT_KERNEL_PREFIX = "linux-6.1"
 
 class KBuildJob:
     '''Class to manage a build job bound to a particular node'''
@@ -349,7 +349,7 @@ class Kcompile(CommandLineLoad):
 
 def ModuleParameters():
     return {"source":   {"descr": "Source tar ball",
-                         "default": "linux-5.18.1.tar.xz",
+                         "default": "linux-6.1.8.tar.xz",
                          "metavar": "TARBALL"},
             "jobspercore": {"descr": "Number of working threads per core",
                             "default": 2,
diff --git a/rteval/rteval.conf b/rteval/rteval.conf
index 1a8d0afd2642..79e28032dc6b 100644
--- a/rteval/rteval.conf
+++ b/rteval/rteval.conf
@@ -18,7 +18,7 @@ dbench:    external
 stressng: module
 
 [kcompile]
-source: linux-5.18.1.xz
+source: linux-6.1.8.xz
 jobspercore: 2
 
 [hackbench]
-- 
2.39.0

