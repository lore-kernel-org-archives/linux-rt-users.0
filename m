Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28AB1802A
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Nov 2023 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kyh1e4Os"
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA903ABF
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Nov 2023 12:46:40 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d13ac2796so7888036d6.2
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Nov 2023 12:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699562798; x=1700167598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QIUUR5VYOR1QzS0mX6skjZmMqak6w8QZAdmGNPuZ4/g=;
        b=Kyh1e4OsHZfX4zUNXxVtvzR+Z9FsZB8ncTSHDcU8hYwwQv73NEd7XhUvwOIOBrYXdQ
         WGe66qKbnvtKFUUTblOVDJKZRufxiEdVZ0azf5xVxbsU5lzEWiPytK8GDrxea/wjfGoT
         Kal8xug1Qgn4xe3l3kjoZksjQPWlql1wiv98EfiFyyx87YJF22erIBZqJxTdnBulf6A7
         ZOM1gYLEkK4y/mxNRj1i1QT0FieNRbuR2EGzs6c4Tp34ik8R+d0EethVdJjSrRBoyJta
         WLzxLhQuKTGZq0qLEKIC7IpUJ07VrCtQT4cY099r9nOL2bQxAa1S74cZetjslQ904rgb
         0OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699562798; x=1700167598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIUUR5VYOR1QzS0mX6skjZmMqak6w8QZAdmGNPuZ4/g=;
        b=Pl/Pb4CGbpmAGvspswkv84k1jjMLc1KdrurldUXcCevRl55yICvtjS+u9/vD4LF7pz
         yuFhMCd+3F75TH9Lp/0alDwTWkG6LmkCQ+J+MyxL9pWAWspfFkjQAP/2qHGW00eQTI5i
         dA2SiH3xrWgPr1P2o0aUpsJTUoQAbIGo+NouElhA/LJDmQPHZc+Rhh45XChpPgmyYJ9N
         AEp262i5EvrWoh/MvI+QbVq4WeWET74cEiMtvH2vGnlhza832fRjiIRgt9alZE8DVJpF
         zzTIuwzbBUA5pQo/ii1d3gnVfYrGIjjiiChcrmyUd782Xj1T0r2W/r/W4hqnsRX7G617
         uf6A==
X-Gm-Message-State: AOJu0YwpbkmkmH/WI+7mc2KdAVRTGdwctvgfiWSPr8zXbuvyMzLkVw7w
	Obnt0EU+4q67i+J3hP5g6xTDlwbIQYQ=
X-Google-Smtp-Source: AGHT+IEHtyqFm1ayMnFl7a0ONzvHWUH9QnkQ+tzdtVMeFQfQXcuEvsCTAgno6N5N9GOtnQKnweJ9dQ==
X-Received: by 2002:a0c:e212:0:b0:676:320d:8303 with SMTP id q18-20020a0ce212000000b00676320d8303mr5366780qvl.49.1699562798687;
        Thu, 09 Nov 2023 12:46:38 -0800 (PST)
Received: from localhost.localdomain ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id x12-20020a0ce78c000000b00670867d7bdfsm2382102qvn.122.2023.11.09.12.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 12:46:38 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Change the default kernel for kcompile to linux-6.6.1
Date: Thu,  9 Nov 2023 15:45:54 -0500
Message-ID: <20231109204554.98770-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the default kernel for kcompile to linux-6.6.1

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                         | 2 +-
 rteval/modules/loads/kcompile.py | 4 ++--
 rteval/rteval.conf               | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b73e8c13f3e5..14f74e087eff 100644
--- a/Makefile
+++ b/Makefile
@@ -18,7 +18,7 @@ PREFIX  :=      /usr
 DATADIR	:=	$(DESTDIR)/$(PREFIX)/share
 LOADDIR	:=	loadsource
 
-KLOAD	:=	$(LOADDIR)/linux-6.1.8.tar.xz
+KLOAD	:=	$(LOADDIR)/linux-6.6.1.tar.xz
 BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
 LOADS	:=	$(KLOAD) $(BLOAD)
 
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 8be79ce630d5..0d025771e90e 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -20,7 +20,7 @@ expand_cpulist = CpuList.expand_cpulist
 compress_cpulist = CpuList.compress_cpulist
 nonisolated_cpulist = CpuList.nonisolated_cpulist
 
-DEFAULT_KERNEL_PREFIX = "linux-6.1"
+DEFAULT_KERNEL_PREFIX = "linux-6.6"
 
 class KBuildJob:
     '''Class to manage a build job bound to a particular node'''
@@ -334,7 +334,7 @@ class Kcompile(CommandLineLoad):
 
 def ModuleParameters():
     return {"source":   {"descr": "Source tar ball",
-                         "default": "linux-6.1.8.tar.xz",
+                         "default": "linux-6.6.1.tar.xz",
                          "metavar": "TARBALL"},
             "jobspercore": {"descr": "Number of working threads per core",
                             "default": 2,
diff --git a/rteval/rteval.conf b/rteval/rteval.conf
index 79e28032dc6b..a4aad33e264f 100644
--- a/rteval/rteval.conf
+++ b/rteval/rteval.conf
@@ -18,7 +18,7 @@ dbench:    external
 stressng: module
 
 [kcompile]
-source: linux-6.1.8.xz
+source: linux-6.6.1.xz
 jobspercore: 2
 
 [hackbench]
-- 
2.41.0

