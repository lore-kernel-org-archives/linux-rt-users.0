Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D01FF7D1
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Oct 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793322; cv=none; b=sYXyqv9dOmcXFgO7CuoDc+rKRtPW4DUEH9/CnMHznHr3gEv0VNireYm+GFNyVQVUSkUoltJ/thcF+HJO5+yZEgAdbMeZ9iqxgTVBjaI24qC5PD7KkHwy/NUARPDXOdCq0aI84RUsRIObKw8AS1UlshJaHoN2VLchIH2JAzXyUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793322; c=relaxed/simple;
	bh=PF72ECj5PBo75wsfGeMdHuyAtNi96WFOR1K/jC01TUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDRoYDLBqADO1pH8XulTxY95yKDUnjU3nIaGQ9iwFK7WCG/2cRR5RBkAb95MHmWoIXjOPau7L0TyyWJdHqks4DAb9hTglV1DZA8ZOeJYEvOB8umQi1/Lr3XRwo2NMnQJRFTBmjHFXDx3Vb9pymOfOUo09VAHAtzWjjFbLBE0KR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUGn62nN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUGn62nN"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460a23ad00eso20555951cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Oct 2024 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729793318; x=1730398118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsMse6RhkmQoDdzdi7pQFoBD7eBUzg4xqvJjR9HedzA=;
        b=FUGn62nNh10nY/bTnFx7KxH69qaXpVHpZRPmdWVSopNzkNLQWtfAK/Mv1Xx6xM9moL
         O9An49zqTwaimdfhA5OuBVxoaUluufICwoJi2g9nceV78h24i6OpsHCSIGiItITxVevt
         1tX7lDK7HgxLktBPRwoPhrBPkVja2LjS4ePe3rwsTXq+YJN+Kl9KY9GArEriONKK7bWp
         lEFVD5q715f6nr5zIBHKc4FjoLB1wZLRfwheo0dZC3es2M5spb6ZXGxDyjaXMG6JEfVV
         4vk8UfE8WJ2PSzqB+zyCBGkdUlIZVv913N7RNU9iqS7WC5l2O29Q6dmn1lfjW2ltPVnh
         G8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793318; x=1730398118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FsMse6RhkmQoDdzdi7pQFoBD7eBUzg4xqvJjR9HedzA=;
        b=UBriUyrceWiv0hGKhgB/m18LF1z/3BYhnFqimUmSoJIb60h13yI4eKuuyAkrEO4Bub
         do8TXi9ZXuFmtu9/+6cIOez0TEwYrcy8p6NHhRqXJmIxxIhL9eEwZgqMHzBfhxtIAstC
         04pO1iUpPk5Oq67ONKDeOCyuTkAzSevZajYdMah+YbBnOGSPGSXZh4oyjxSatNqkJfor
         odw088SAHLnV+VogZJlXI3N2UaBEhZmAr4r0oOhhgndrS5lbdmFPTC30KchmFzz2OO3U
         troTC2E4eD17iHBH1VGucLnzKECc+Z0VzRXwKcMzgx5JaEwHsNeGt5u8rLwZNnalt6/Z
         wYXA==
X-Gm-Message-State: AOJu0YxZXEltvOofjwjOoE7k+OK8dAnxHwjc4fcqj+Di+KZO5Lc0+JL7
	iQ61mCmU2o9wX0WlFOqgRAGmwwuOWel9og+6Na4O0i7WrZiIOo6rIZuLQg==
X-Google-Smtp-Source: AGHT+IENbhJQ4xzoladGbbS1O4f+wpuMz8LBihrD2Uo8g5bLy7oWiiTrZ8z3MVA2rvTgKNA+aXZC+w==
X-Received: by 2002:a05:622a:19a5:b0:460:3764:2844 with SMTP id d75a77b69052e-4612526d419mr49230201cf.10.1729793318000;
        Thu, 24 Oct 2024 11:08:38 -0700 (PDT)
Received: from fionn.home ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3dab83fsm54121801cf.88.2024.10.24.11.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:08:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rteval: Update the kcompile kernel to linux-6.12-rc4
Date: Thu, 24 Oct 2024 14:08:13 -0400
Message-ID: <20241024180813.48368-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241024180813.48368-1-jkacur@redhat.com>
References: <20241024180813.48368-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the kernel that rteval compiles as a load in the load module
kcompile

This kernel contains patches to address the fact that ENGINE API has
been deprecated since OpenSSL version 3.0. This is important because
some distros have been dropping the headers for the deprecated api
and this has been causing kcompile to fail, unless you supply a special
kernel with the patches to address this.

With this change the upstream kernel as is will work again.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Dockerfile                       | 2 +-
 Makefile                         | 2 +-
 rteval/modules/loads/kcompile.py | 4 ++--
 rteval/rteval.conf               | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index f3ee516b57d5..b8f602b11703 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,7 +1,7 @@
 # Use CentOS Stream 9 as base image
 FROM centos:stream9
 
-ARG KERNEL_VERSION=linux-6.10.5.tar.xz
+ARG KERNEL_VERSION=linux-6.12-rc4.tar.gz
 
 
 # Copy current directory to /opt/rteval/
diff --git a/Makefile b/Makefile
index e1a2bbba0373..a250b18611b4 100644
--- a/Makefile
+++ b/Makefile
@@ -14,7 +14,7 @@ PREFIX  :=      /usr
 DATADIR	:=	$(DESTDIR)/$(PREFIX)/share
 LOADDIR	:=	loadsource
 
-KLOAD	:=	$(LOADDIR)/linux-6.10.5.tar.xz
+KLOAD	:=	$(LOADDIR)/linux-6.12-rc4.tar.gz
 BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
 LOADS	:=	$(KLOAD) $(BLOAD)
 
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 58c542201a1b..8a3a0e93fa14 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -21,7 +21,7 @@ expand_cpulist = cpulist_utils.expand_cpulist
 compress_cpulist = cpulist_utils.compress_cpulist
 nonisolated_cpulist = cpulist_utils.nonisolated_cpulist
 
-DEFAULT_KERNEL_PREFIX = "linux-6.10.5"
+DEFAULT_KERNEL_PREFIX = "linux-6.12-rc4"
 
 class KBuildJob:
     '''Class to manage a build job bound to a particular node'''
@@ -342,7 +342,7 @@ class Kcompile(CommandLineLoad):
 
 def ModuleParameters():
     return {"source":   {"descr": "Source tar ball",
-                         "default": "linux-6.10.5.tar.xz",
+                         "default": "linux-6.12-rc4.tar.gz",
                          "metavar": "TARBALL"},
             "jobspercore": {"descr": "Number of working threads per core",
                             "default": 2,
diff --git a/rteval/rteval.conf b/rteval/rteval.conf
index 0611c031c2a0..5a49040d980f 100644
--- a/rteval/rteval.conf
+++ b/rteval/rteval.conf
@@ -18,7 +18,7 @@ dbench:    external
 stressng: module
 
 [kcompile]
-source: linux-6.10.5.xz
+source: linux-6.12-rc4.tar.gz
 jobspercore: 2
 
 [hackbench]
-- 
2.46.2

