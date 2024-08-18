Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E391534EC
	for <linux-rt-users@vger.kernel.org>; Sun, 18 Aug 2024 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724010155; cv=none; b=IRqzpO+CegKCluQ9qKXp8tS7ST6gzWusXF7Vju/9itmVXOE1hoyi+yYBwaioNzD5JDK5e57g8FzMT93JSMN3O4l5yBLoVE9efHGi/uFRjNequiHjPPFdBc+G1TCzcsolH2LRdZMKNAKBnV9IuRhQcnrXU+h7WuCzSvH6L3kVd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724010155; c=relaxed/simple;
	bh=/5HTi0IU2p9WPa9lf3YupEiwPpHU9Ey+LEef4+9TCyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMRbe9iXsgE0A8lHdX2mGqWtynvFlGZ+VyeDy/oOxYs+qkNx/EDO4swjhANUslo8zrxBVxEY8qRQ8/O5OtmGsbj1FRmLeBvD0lagJiVIuEWvV5klLnGKCV77D1t5HoEdO/MiQYVq1Ij6pcoY29buOvWIkixF2z2ZEoVaNfi0mRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtEX7jbI; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtEX7jbI"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf9ddfc2dcso1238246d6.1
        for <linux-rt-users@vger.kernel.org>; Sun, 18 Aug 2024 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724010152; x=1724614952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1TfhiQ3mpQYYWNHgYmvCxEnprmzEPO8HyCKXM3Kj2U=;
        b=HtEX7jbIh0S+nS8VwX0JE97PWsaHzAVqXImCTXeOWsJRCRv4A3aaJWZWcaJ82x4Pvh
         MLM9Hwlv2WIJ8CcNZ0RRF9I31DK7PDeSbWLR1CFHpLMpvv37Cb/B8A89+6Jx/MLCKOQi
         b+AWIr4NEOsfCqgQYrHdRDY9r4cQCBV4QrdpGG5krPcO3Pt2kZ9kSFxfP9VtPeXi7Bfb
         Tm5d4yj3CcaKHpuTKx4vHYe22H5JGOhe8X5sdciMS/LXHFmUSTZvKjgOh7z/WBjvlkPa
         7N7LnKtx3r3WhLONt3tM8kXD97ZAEIYYQKdKatC9hPAvDtz1IZd8Ya4NebeBFRYkRRCM
         ggDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724010152; x=1724614952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1TfhiQ3mpQYYWNHgYmvCxEnprmzEPO8HyCKXM3Kj2U=;
        b=BrlhlDW47f36VFV0uAPJleUelu+af10IYwiyuync3q6nYtsTRxVlrw6K4YWVysILyT
         NzoBDfcSR9GAGKr9oobS+2jM8yJfLgfZ+kqfRWqsUJGjjJq25paNHdodA+FVIGiXnQXX
         MNALc3pqVtUQUwlBhcRt3VMs8QgTJbMV7PowNwivyEXV85sb1L+gi7i0CwYjia3S2zkZ
         ba0gwLn7KFvwKOldm5ZIw7lan4CLKKjGUIonT218KKN1HxeuJLWeaxK8FiKkb9AiypAs
         tIa6DyNm5vrCoDHh307x6ZJxWEk+zGBUTBjcmRra9hj9NU4GpUo41U9gaOPLIG2Xr3N5
         wswA==
X-Gm-Message-State: AOJu0YyPdrEdH/MkYw0/hsS1va1crveJ3yqjDXe4FCcUO284sVXxy0vG
	VJgzONnvkzUN5vQyxaKj9k0SDMQPKN9gR7uUfNwsp9Du1XXJRggeGmpbnQ==
X-Google-Smtp-Source: AGHT+IF4SkdxFi6xnltDQwz1pSKywF1Cvo0omGRiGIn5dCcC9V/zhaYtO8J3ZKaUt0yTdglsXxhayQ==
X-Received: by 2002:a05:6214:3b89:b0:6b5:61:53a9 with SMTP id 6a1803df08f44-6bf7cdedd3bmr82573956d6.28.1724010152197;
        Sun, 18 Aug 2024 12:42:32 -0700 (PDT)
Received: from localhost.localdomain ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5f4fsm36909566d6.84.2024.08.18.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 12:42:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Chris White <chwhite@redhat.com>,
	Anubhav Shelat <sanubhav1000@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] rteval: Upgrade load kernel to linux-6.10.5
Date: Sun, 18 Aug 2024 15:42:15 -0400
Message-ID: <20240818194216.299176-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240818194216.299176-1-jkacur@redhat.com>
References: <20240818194216.299176-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The older kernel fails to compile on newer tool chains, so upgrade
the kernel that kcompile compiles as a load to linux-6.10.5

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Dockerfile                       | 2 +-
 Makefile                         | 2 +-
 rteval/modules/loads/kcompile.py | 4 ++--
 rteval/rteval.conf               | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index 45f6434777d4..f3ee516b57d5 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,7 +1,7 @@
 # Use CentOS Stream 9 as base image
 FROM centos:stream9
 
-ARG KERNEL_VERSION=linux-6.6.1.tar.xz
+ARG KERNEL_VERSION=linux-6.10.5.tar.xz
 
 
 # Copy current directory to /opt/rteval/
diff --git a/Makefile b/Makefile
index d9a6b9f116ac..e1a2bbba0373 100644
--- a/Makefile
+++ b/Makefile
@@ -14,7 +14,7 @@ PREFIX  :=      /usr
 DATADIR	:=	$(DESTDIR)/$(PREFIX)/share
 LOADDIR	:=	loadsource
 
-KLOAD	:=	$(LOADDIR)/linux-6.6.1.tar.xz
+KLOAD	:=	$(LOADDIR)/linux-6.10.5.tar.xz
 BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
 LOADS	:=	$(KLOAD) $(BLOAD)
 
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index f7a9c0084805..80106812af0a 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -21,7 +21,7 @@ expand_cpulist = cpulist_utils.expand_cpulist
 compress_cpulist = cpulist_utils.compress_cpulist
 nonisolated_cpulist = cpulist_utils.nonisolated_cpulist
 
-DEFAULT_KERNEL_PREFIX = "linux-6.6"
+DEFAULT_KERNEL_PREFIX = "linux-6.10.5"
 
 class KBuildJob:
     '''Class to manage a build job bound to a particular node'''
@@ -334,7 +334,7 @@ class Kcompile(CommandLineLoad):
 
 def ModuleParameters():
     return {"source":   {"descr": "Source tar ball",
-                         "default": "linux-6.6.1.tar.xz",
+                         "default": "linux-6.10.5.tar.xz",
                          "metavar": "TARBALL"},
             "jobspercore": {"descr": "Number of working threads per core",
                             "default": 2,
diff --git a/rteval/rteval.conf b/rteval/rteval.conf
index a4aad33e264f..0611c031c2a0 100644
--- a/rteval/rteval.conf
+++ b/rteval/rteval.conf
@@ -18,7 +18,7 @@ dbench:    external
 stressng: module
 
 [kcompile]
-source: linux-6.6.1.xz
+source: linux-6.10.5.xz
 jobspercore: 2
 
 [hackbench]
-- 
2.46.0

