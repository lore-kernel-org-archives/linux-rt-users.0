Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE16136E0E
	for <linux-rt-users@vger.kernel.org>; Sun, 18 Aug 2024 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724010156; cv=none; b=IXSPKsdEA9UkFUddUrQuJdiscyj1ep/l4pQdABX36dDom6FU6y0KwZml2czmpn6/rQtAbUV/Kptx8xkecG9TOwYEJ5SNTq8B+K+k/rtfsy+AI5pRx9nyJKcY3pLvgN/rlxrystxHIEvSnhax6377VFFpg4F2k7AxaPYcKnyLvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724010156; c=relaxed/simple;
	bh=BqOyHHKiDqN0HU9OM9lYaQsiFeeZJOTuxAV54F8ixM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNPYrwOUc6G9HTHWZADj8XdEkXkI4qkoa78IdNmS/ySQLgFkRun5HvVhjSXjFGrx/qoUba68ISMoww3PBkNxdikO4a501cZIYa8yisY/eySERIacpXtn73oTjljzaleqeQ2QM8S0ONyrN7lS1DczO7HXG2zwrpJewlLj4715joA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCAzonmQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCAzonmQ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf99fee82aso3311306d6.2
        for <linux-rt-users@vger.kernel.org>; Sun, 18 Aug 2024 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724010153; x=1724614953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+O+eAFl8v1echfvzcQU6H06Krm3NvFueaMXh+RD1Fg=;
        b=WCAzonmQjfcBsIjKjn1UQmKlvglFuZhJ4s89FPUYsfKvbNnmZwDfFuHCmDCW7nB5fp
         0oceygRp3y21qIGNRh3hUpRdQj1kpi4hLVwcfSyoMENkcWgF8aWHfAb2uspICD2/+zZx
         5kVMvla0ahvkx57VHd00mHGclsBWCyPs3Ytd05VKOUTMGk/mle1EGddn4YE/zAvfHYyx
         r9+Xlb9isS0CQ96/W7yfcLhcw/jJkY8ah1b/7c+XOB7AXklf04C9+V/zwz5VOsW+Mu2Z
         kCVmwXTOfDnXF9In/OuJLprf6WW5bwZw090dzs+ituOZKcGULtkjLt7F34DzLrnEjMdy
         7kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724010153; x=1724614953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+O+eAFl8v1echfvzcQU6H06Krm3NvFueaMXh+RD1Fg=;
        b=QABRJboMuFeFLcX+h55A5anw3fRcEoJihtvjt5ykmcjSBLUYKKf+JYKQBC1GLFBZwr
         d7OrnN/6P0IaaknH21F0GqYU2SkJrH9dY0xBdnvZRcFasv3jtQ9ZNpM87YmP4FBTulM5
         reF73eRRT427kX0awpA3hUHQrLnKnPi5H9qnBIcQH3fEMTYG7NoX0pCCbTb0By6y7ctR
         6B4mzw1GkNNLxiRC2k9qpcQFyXHxtMT9SBZIs+mwB77ruzaaXnNgct+pl7dQl5vobSKM
         e2GIMY/GLDqKpSksOS3O8qwbCI/8yqq7beuxrprfwkK6W2X87Xac8YchdsW81/lqoFxq
         KFgg==
X-Gm-Message-State: AOJu0YwSbbYLQ2E/fF8GKVwS7DJvoA+HPK3r5obUptLkc6XYqrmd+kV0
	wQEw43LewHvDAKdy0LX42adLwZpBTENTvPtsJq8lCFWvzLyjKlTMnfRQRw==
X-Google-Smtp-Source: AGHT+IHt1OeMQS3Zlb/2CkaYE4P5ewbfjmtGDdbLOZK49jzHyjY5lEeXxwwSr+umSrvVd3DL/8a9Qg==
X-Received: by 2002:a05:6214:5342:b0:6bf:888d:a10a with SMTP id 6a1803df08f44-6bf888da38emr65882056d6.10.1724010153325;
        Sun, 18 Aug 2024 12:42:33 -0700 (PDT)
Received: from localhost.localdomain ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5f4fsm36909566d6.84.2024.08.18.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 12:42:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Chris White <chwhite@redhat.com>,
	Anubhav Shelat <sanubhav1000@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] rteval: Fix parsing in kcompile of the kernel to compile
Date: Sun, 18 Aug 2024 15:42:16 -0400
Message-ID: <20240818194216.299176-4-jkacur@redhat.com>
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

This patch does two things.
1. It allows you to create your own customer kernel with a dash -rteval
   in the name, eg, linux-6.10.5-rteval
2. It fixes parsing of the kernel name so that if the user requests
   linux-6.10.5 it doesn't use linux-6.10.6-rteval instead

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/kcompile.py | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 80106812af0a..58c542201a1b 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -122,6 +122,8 @@ class Kcompile(CommandLineLoad):
         self.cpulist = config.cpulist
         CommandLineLoad.__init__(self, "kcompile", config, logger)
         self.logger = logger
+        self._kernel_prefix = ""
+        self._log(Log.DEBUG, f'self._cfg.source = {self._cfg.source}')
 
     def _extract_tarball(self):
         if self.source is None:
@@ -152,22 +154,29 @@ class Kcompile(CommandLineLoad):
                 f"error removing builddir ({self.builddir}) (ret={ret})")
 
     def _find_tarball(self):
-       # If the user specifies the full kernel name, check if available
-        tarfile = os.path.join(self.srcdir, self._cfg.source)
-        if os.path.exists(tarfile):
-            return tarfile
+        """ Find the tarball and self._kernel_prefix """
 
         if 'rc' in self._cfg.source:
-            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", self._cfg.source).group(0)
+            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-rc\d{1,2}", self._cfg.source).group(0)
+        elif 'rteval' in self._cfg.source:
+            tarfile_prefix = re.search(r"(\d{1,2}\.\d{1,3}\.\d{1,3}\-rteval)|(\d{1,2}\.\d{1,3}\-rteval)", self._cfg.source).group(0)
         else:
             tarfile_prefix = re.search(r"(\d{1,2}\.\d{1,3}\.\d{1,3})|(\d{1,2}\.\d{1,3})", self._cfg.source).group(0)
 
+        # Save the kernel prefix
+        self._kernel_prefix = "linux-" + tarfile_prefix
+
+        # If the user specifies the full kernel name, check if available
+        tarfile = os.path.join(self.srcdir, self._cfg.source)
+        if os.path.exists(tarfile):
+            return tarfile
+
         # either a tar.xz or tar.gz might exist. Check for both.
         xz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.xz" )
         gz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.gz" )
         if os.path.exists(xz_file):
             return xz_file
-        elif os.path.exists(gz_file):
+        if os.path.exists(gz_file):
             return gz_file
         raise rtevalRuntimeError(self, f"tarfile {tarfile} does not exist!")
 
@@ -178,21 +187,20 @@ class Kcompile(CommandLineLoad):
         # find our source tarball
         if self._cfg.source:
             self.source = self._find_tarball()
-            kernel_prefix = re.search(r"(linux-\d{1,2}\.\d{1,3}\.\d{1,3})|(linux-\d{1,2}\.\d{1,3})", self.source).group(0)
         else:
             tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
             if tarfiles:
                 self.source = tarfiles[0]
             else:
                 raise rtevalRuntimeError(self, f" no kernel tarballs found in {self.srcdir}")
-            kernel_prefix = DEFAULT_KERNEL_PREFIX
-        self._log(Log.DEBUG, f"kernel_prefix = {kernel_prefix}")
+            self._kernel_prefix = DEFAULT_KERNEL_PREFIX
+        self._log(Log.DEBUG, f"self._kernel_prefix = {self._kernel_prefix}")
 
         # check for existing directory
         kdir = None
         names = os.listdir(self.builddir)
         for d in names:
-            if d.startswith(kernel_prefix):
+            if d == self._kernel_prefix:
                 kdir = d
                 break
         if kdir is None:
@@ -200,7 +208,7 @@ class Kcompile(CommandLineLoad):
             names = os.listdir(self.builddir)
             for d in names:
                 self._log(Log.DEBUG, f"checking {d}")
-                if d.startswith(kernel_prefix):
+                if d == self._kernel_prefix:
                     kdir = d
                     break
         if kdir is None:
-- 
2.46.0

