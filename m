Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440D168DA
	for <linux-rt-users@vger.kernel.org>; Fri,  1 Nov 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494494; cv=none; b=hm5vNmgNeML7Q74pASZ3hegZOPGWCKnKM07XQq1zw7mRfPGCTHaTNR/G/o8OUZB3ebqXQW1JMgGh/54rg9b3f1Jy2tCypaS2D4X3lq6fe5da8bKF3HxDtzjah5f/VzzPENarOWGJPktKAaG3YrGZ/Z/QkuQ20xk3N0b6VfW5EzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494494; c=relaxed/simple;
	bh=gMrDuFYD5nH38ne9sQjwzsUipXZ0SrGESOn56lX+FVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5AJcaStVMZSp5i8jK2ZMKrCpwi5IjV19jfkwnzDc+5kgVHLAoI9wmPGfjKYEwHiHukWV+hUJLkDQIstqY6LS9aguCfNlQMzmafKcgEgjResOejgLRYqqGtzDjRDvFVAuNzJyXLXK1mr6HPgKc3e4b+1qBrP2Z37oSODHW8XXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gv5nvJUb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gv5nvJUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730494491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QpOqAFSrDgeR9+SnwYhxCs6Owpw4W5q4uZGJjW7DusM=;
	b=Gv5nvJUbrDID5ZZ9e3L92TqjNG/OijqcaG9UYbNo8otJod2Ky4Gcp5E+zL5OFpjOY8BEvS
	Lw3cUiwnzPq0iciCvB49I/BWGE6pOHkPCQWpmaYLf+5hvqKInPdSTUGhhsGmA99smAEfCI
	6gteAji+mEkfTurpOdRMmr4UH18qBrc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-42pa2d_xOFe1XumwsZOxgw-1; Fri, 01 Nov 2024 16:54:50 -0400
X-MC-Unique: 42pa2d_xOFe1XumwsZOxgw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7180a4bf542so2540220a34.1
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Nov 2024 13:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730494489; x=1731099289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpOqAFSrDgeR9+SnwYhxCs6Owpw4W5q4uZGJjW7DusM=;
        b=j3OacCsMwnt/sBx4poVA177txvSUggR/ALIRWIwfr49nt6ZYhYi5RXdtvRYhwuBauE
         +hSlMEsZEAw3ylWDkW3O19ekTbrRi3bUD4oaPVbls8qhl90f3wrL40swDIbGlFabNuh/
         V8o/z0RNtUnTrqfK3I9Q52VAl7GY7HEy7v8m0853i+Y1elrXEr/Af+MKOUpCxUfK3drn
         ohWb2wfJhePii8/ySsYGqa1u9tBrIeb9+0s1f9WIlMn4El71KJsDZ3KyyelG5cuoob22
         xcbOqFUhtEexiRf6ZatUjQvSz12eGAyAlpxbhD9QCG/jkrkfu2NugqFoBohE+r7pMttw
         C5aQ==
X-Gm-Message-State: AOJu0Yw0bZVyK3wCv+KFSKHp66do8mVB60AGcDb6z6tB0ZATRHB8TsGP
	ZybgsffmR9ycRLvpuJ3e9jaAqENRN5+jY8Cm1FMTk9CeHEF7iWm3yr0WZc9kTpENmIw1L2iitgn
	L/vzuH1WsFc5r/RAPKNWLOWGLalZqedsztwUUgQckIZQjkt6FhjOpx+vj7eeRaeV9
X-Received: by 2002:a05:6830:6015:b0:717:fe2d:a4e4 with SMTP id 46e09a7af769-7189b4f40e0mr8091299a34.19.1730494489599;
        Fri, 01 Nov 2024 13:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCsJqK07FNZEuXspWjgdsC+MXikRtFGcawRcpiNTtqSyi0fCOTHCn3jf7JxERP1nbH1IPiRg==
X-Received: by 2002:a05:6830:6015:b0:717:fe2d:a4e4 with SMTP id 46e09a7af769-7189b4f40e0mr8091287a34.19.1730494489281;
        Fri, 01 Nov 2024 13:54:49 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc6a0dfsm879613a34.24.2024.11.01.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:54:49 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] rteval: Print useful exception info and exit on missing measurement tool
Date: Fri,  1 Nov 2024 15:54:46 -0500
Message-ID: <20241101205446.41310-1-crwood@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if cyclictest or rtla (whichever rteval is configured to use)
is missing, the error output only says "measurement threads did not use
the full time slot" and then rteval hangs.

Avoid catching these exceptions so that they will be printed out,
pointing to the actual problem.  Also set up a thread exception hook to
do a prompt and (relatively) graceful exit if a thread has any uncaught
exception (this requires python >= 3.8).

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 README                                   |  2 +-
 rteval/__init__.py                       | 12 ++++++++++++
 rteval/modules/__init__.py               | 14 +++++++++++---
 rteval/modules/measurement/cyclictest.py | 14 +++++---------
 rteval/modules/measurement/timerlat.py   | 13 +++++--------
 5 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/README b/README
index b352d7f..19704b4 100644
--- a/README
+++ b/README
@@ -16,7 +16,7 @@ The rteval source may be pulled from it's git tree on kernel.org:
 
 Rteval requires the following packages to run:
 
-Python >= 3.0
+Python >= 3.8
     http://www.python.org/download/
 
 python-lxml
diff --git a/rteval/__init__.py b/rteval/__init__.py
index 7c13e84..6097ddf 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -19,6 +19,7 @@ import threading
 import time
 from datetime import datetime
 import sysconfig
+from traceback import format_exception
 from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
 from rteval.rtevalReport import rtevalReport
@@ -29,6 +30,7 @@ from rteval import version
 RTEVAL_VERSION = version.RTEVAL_VERSION
 
 EARLYSTOP = False
+threaderr = False
 
 stopsig = threading.Event()
 def sig_handler(signum, frame):
@@ -39,9 +41,17 @@ def sig_handler(signum, frame):
     else:
         raise RuntimeError(f"SIGNAL received! ({signum})")
 
+def except_hook(args):
+    global threaderr
+
+    threading.__excepthook__(args)
+    threaderr = True
+    stopsig.set()
+
 class RtEval(rtevalReport):
     def __init__(self, config, loadmods, measuremods, logger):
         self.__version = RTEVAL_VERSION
+        threading.excepthook = except_hook
 
         if not isinstance(config, rtevalConfig.rtevalConfig):
             raise TypeError("config variable is not an rtevalConfig object")
@@ -237,6 +247,8 @@ class RtEval(rtevalReport):
         global EARLYSTOP
         rtevalres = 0
         measure_start = self.__RunMeasurement()
+        if threaderr:
+            return 1
 
         self._report(measure_start, self.__rtevcfg.xslt_report)
         if self.__rtevcfg.sysreport:
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index eb29db8..9827651 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -124,8 +124,8 @@ class rtevalModulePrototype(threading.Thread):
 
     def WaitForCompletion(self, wtime=None):
         """ Blocks until the module has completed its workload """
-        if not self.shouldStart():
-            # If it hasn't been started yet, nothing to wait for
+        if self.hadRuntimeError() or not self.shouldStart():
+            # If it failed or hasn't been started yet, nothing to wait for
             return None
         return self.__events["finished"].wait(wtime)
 
@@ -175,7 +175,7 @@ class rtevalModulePrototype(threading.Thread):
         return self._donotrun is False
 
 
-    def run(self):
+    def __run(self):
         "Workload thread runner - takes care of keeping the workload running as long as needed"
         if self.shouldStop():
             return
@@ -215,6 +215,12 @@ class rtevalModulePrototype(threading.Thread):
 
         self._WorkloadCleanup()
 
+    def run(self):
+        try:
+            self.__run()
+        except Exception as e:
+            self._setRuntimeError()
+            raise e
 
     def MakeReport(self):
         """ required module method, needs to return an libxml2.xmlNode object
@@ -532,6 +538,8 @@ class RtEvalModules:
         rep_n = libxml2.newNode(self._report_tag)
 
         for (modname, mod) in self.__modules:
+            if mod.hadRuntimeError():
+                continue
             self._logger.log(Log.DEBUG, f"Getting report from {modname}")
             modrep_n = mod.MakeReport()
             if modrep_n is not None:
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 2e8f6f1..3d25c20 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -285,15 +285,11 @@ class Cyclictest(rtevalModulePrototype):
                 fp.flush()
 
         self.__cyclicoutput.seek(0)
-        try:
-            self.__cyclicprocess = subprocess.Popen(self.__cmd,
-                                                    stdout=self.__cyclicoutput,
-                                                    stderr=self.__nullfp,
-                                                    stdin=self.__nullfp)
-            self.__started = True
-        except OSError:
-            self.__started = False
-
+        self.__cyclicprocess = subprocess.Popen(self.__cmd,
+                                                stdout=self.__cyclicoutput,
+                                                stderr=self.__nullfp,
+                                                stdin=self.__nullfp)
+        self.__started = True
 
     def WorkloadAlive(self):
         if self.__started:
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 92bc070..df42777 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -252,14 +252,11 @@ class Timerlat(rtevalModulePrototype):
 
         self.__timerlat_out.seek(0)
         self.__timerlat_err.seek(0)
-        try:
-            self.__timerlat_process = subprocess.Popen(self.__cmd,
-                                                       stdout=self.__timerlat_out,
-                                                       stderr=self.__timerlat_err,
-                                                       stdin=None)
-            self.__started = True
-        except OSError:
-            self.__started = False
+        self.__timerlat_process = subprocess.Popen(self.__cmd,
+                                                   stdout=self.__timerlat_out,
+                                                   stderr=self.__timerlat_err,
+                                                   stdin=None)
+        self.__started = True
 
     def WorkloadAlive(self):
         if self.__started:
-- 
2.47.0

