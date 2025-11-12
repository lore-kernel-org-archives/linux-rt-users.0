Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD535CBA9
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762991330; cv=none; b=mRyS9Uo1Ijy+t/UpWd+jtCxts6G5NZdFsCFkcjehF/280bIOmXgkN40ERRMoGV4HwZpikev8vltML1aZkK1c9c+wtDzH0glxA25DRFoM2WcQ3tltSWyb/8eX1L9OYpWzlEERbOKGNkNUxLvh/44qr5Ud8mm1bavsxHUKsjHWof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762991330; c=relaxed/simple;
	bh=+iBPSzUw90P+DyvX+VuwPc3faW4m5RPQ0X5heR2FqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjCqfn2MLg5i3FH2tVK/tZ6PbANfIJ0CiVXCHZvCKjvnewzc5/GB8BOKu0X+lBGUXeeFmlc3LI8WIsVJp3tM00AP7SUvHl47gORZ6JRqRsYigkT4YgCKDOQMUrYLn/GhWUnBBY4HG5UX3TnJ8T8X+AIKWLKnRbIzj4jUW90WySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc+ql9G3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc+ql9G3"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b25ed53fcbso33665285a.0
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2025 15:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762991327; x=1763596127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nAyT28sEf/dI90ELuoRjZRehk4bb3PCz+7aigkNBeXk=;
        b=Xc+ql9G3dZ5MMPn+KSJHkoSB6k5vhEZdKPH/UDRXJS+agRGYw4AIrrCwF6mZHxSj42
         njKJn7Tpgwopgfao9T940RuRyi2csJP6syi13fUua5Rfg2+Erh8EFOmZZPO0ahW2aFGR
         SkkkCXQMBeRVSE7ET6jYvYHxUrkCDeKalTXNsYwEsIXJ+wserUgTDWVfE0gi4ZwQBgpN
         Hkpaey68DHdWXmihxKLcI190fR6hv/kAsvaxen/RQwX0/O9ODXVYN5AiTtKzUcsfFsPI
         Gd6mhlvNroA1YM7t0Yuey5sPN84PC7oiRbYgVwhsDhM+jT3qeX78I2u7p2KD1kZlAuZ4
         HHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762991327; x=1763596127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAyT28sEf/dI90ELuoRjZRehk4bb3PCz+7aigkNBeXk=;
        b=ADZSvBX3mXi/i+pZPByzxrjM++Idzocc9Ts66uFnlH0KFo9M0d0S5trr0c9aa/ThaC
         gDEawvkErXmPHELGS8bFnHTObz3UzebmbP4ssZpiSBXcsvx3yd8NartjvUnJc5CRhheR
         O/4O/vF1D1T4H5jsGucUCnyUv/aYYv+/YqTlAu9ayaGQK4Oz8g6669o7mSVNdKVJd9EG
         9xRv2jgM/7Z8Z0J2UidUf6ITRXH/+dUfZTvvbqoQvQBhvOEFNrWT9t3SYVKxLv2Vd0IE
         pc+i1qmXl6RiYC7DNCB4qzTiHwYN4xGLw5pr+bsUlo1xLADZycKQTaOXI/U+1Jj9NvyJ
         rRyw==
X-Gm-Message-State: AOJu0YyYgMg6Jxrv171gWN7J2PYzgwzckeXdDIQF9LR8RKuhxxeEj9Qt
	cRpR5nvH6u6ojI6Chdj5UDIJZKJ8oXL5AMhyzaY0RpED74ntRsTrKAjVYnX0K7TV
X-Gm-Gg: ASbGncuvOa4o3BluRe5ShC2vCLtEWbURP696gYkyoGj0k86dhFvBHOpmOm0UAmSh1mt
	wg1MQhxy1Qyzsxg8oIWDfPWyKTOddj6YomX9cPf04P6jvsRFdiqG3ITn+Iuqi9rtCAZcRWpm+Up
	BHBPyxxLBzKe46GDxxX8Zg7YyJ0GucegXka1v4tTe9F1J4wp8BXmsN+HCBcOnjsNND+9u755YOZ
	Z6EatITpk2eN4ukmsqDxT2fcxsFuS50i16Q/Jvd8cowI8xHRQR64kySJXA2m69V2qq+np2IUT1a
	6NWy7xg6CufzIgYngYu3NoL0rzO7W4H4xnFEIEx8mHiFjXirHX0d4tPNvy/u7wlb65yZg4/c/01
	kPUD+zOhMYzVoauMI/+/+m+Zr6zWO7V83EsNY0mCmiMWZIFD3K9XJk/XbIGG4i18=
X-Google-Smtp-Source: AGHT+IFhnDOyDQWbDVyrwPCrr/HuMf+fSYW7VqYglhM1eBZqB1jMXhZRRwfWxVtyBbnyyqSnKF0E5w==
X-Received: by 2002:a05:620a:4708:b0:8b2:772b:5f5f with SMTP id af79cd13be357-8b29b769a00mr620594885a.28.1762991326832;
        Wed, 12 Nov 2025 15:48:46 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aee9eeb1sm20886885a.8.2025.11.12.15.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 15:48:45 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Upgrade kcompile kernel to linux-6.17.7
Date: Wed, 12 Nov 2025 18:48:28 -0500
Message-ID: <20251112234828.262150-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the kernel that rteval compiles as a load in the kcompile
load module to linux-6.17.7.tar.xz

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Dockerfile                       | 2 +-
 Makefile                         | 2 +-
 rteval/modules/loads/kcompile.py | 4 ++--
 rteval/rteval.conf               | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index b8f602b11703..0c4fee028312 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,7 +1,7 @@
 # Use CentOS Stream 9 as base image
 FROM centos:stream9
 
-ARG KERNEL_VERSION=linux-6.12-rc4.tar.gz
+ARG KERNEL_VERSION=linux-6.17.7.tar.xz
 
 
 # Copy current directory to /opt/rteval/
diff --git a/Makefile b/Makefile
index 36f2eda626c1..9b8897d89b03 100644
--- a/Makefile
+++ b/Makefile
@@ -14,7 +14,7 @@ PREFIX  :=      /usr
 DATADIR	:=	$(DESTDIR)/$(PREFIX)/share
 LOADDIR	:=	loadsource
 
-KLOAD	:=	$(LOADDIR)/linux-6.12-rc4.tar.gz
+KLOAD	:=	$(LOADDIR)/linux-6.17.7.tar.xz
 BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
 LOADS	:=	$(KLOAD) $(BLOAD)
 
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 8a3a0e93fa14..404b46d505d0 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -21,7 +21,7 @@ expand_cpulist = cpulist_utils.expand_cpulist
 compress_cpulist = cpulist_utils.compress_cpulist
 nonisolated_cpulist = cpulist_utils.nonisolated_cpulist
 
-DEFAULT_KERNEL_PREFIX = "linux-6.12-rc4"
+DEFAULT_KERNEL_PREFIX = "linux-6.17.7"
 
 class KBuildJob:
     '''Class to manage a build job bound to a particular node'''
@@ -342,7 +342,7 @@ class Kcompile(CommandLineLoad):
 
 def ModuleParameters():
     return {"source":   {"descr": "Source tar ball",
-                         "default": "linux-6.12-rc4.tar.gz",
+                         "default": "linux-6.17.7.tar.xz",
                          "metavar": "TARBALL"},
             "jobspercore": {"descr": "Number of working threads per core",
                             "default": 2,
diff --git a/rteval/rteval.conf b/rteval/rteval.conf
index 5a49040d980f..e4437e04347a 100644
--- a/rteval/rteval.conf
+++ b/rteval/rteval.conf
@@ -18,7 +18,7 @@ dbench:    external
 stressng: module
 
 [kcompile]
-source: linux-6.12-rc4.tar.gz
+source: linux-6.17.7.tar.xz
 jobspercore: 2
 
 [hackbench]
-- 
2.51.1

