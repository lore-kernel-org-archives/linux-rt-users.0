Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559B33997
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Jul 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018765; cv=none; b=V+VGDf8VA7k88BAIZGnwTAwUj2S6FfboJ3pDA9cIK4FZTey+5FCTeiZXbmDs3zqHFMRLTOPewuEOJhVnwc989SgqJ4AF+e/46g9V9FjhBpBhTicV5FB+tcfSmc4n295S3BeR565N0e7t2aj0ElZM/FScznlQhEhSwoeGg/wP0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018765; c=relaxed/simple;
	bh=W0ld7PRW8cneA9AiDXPkGrH9YQMwP7bdN65o1W4lJaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVsIaDwcL+fhE7d9gI+M/y2o41jRmk79FmkhObz7H83/FcULuwKCCMz+/jHFnqpiEp4mSC/Z2i7OxAC/d5PlJtMlPv91JVVBjDYpu55ZNsQhCDNFKX4ji/88SSyUjMQ/bUlHYtSzvDZOffJrRxIaT35b5JHM+QjeUwbrUFXJuic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5ffEppk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5ffEppk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722018762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fGyiIBKUn3JKcKaWDY9U5KEnvhAnrBTffK9DQp7T7EM=;
	b=B5ffEppkSGhkAs1utzWOd2BNe0QqQgzpQiVM5q1Oy6YXPSKIJ75gZt2kjtdCJ08JrEe/3y
	iDlv+OTVcrQNjcq0L5NMngLS6TOF9LUgSPpkC+0kfm++gWGb7/6EfHB7itGs6t/Ha5BBjo
	bICEKTcXrRhgKKGaMhpnN46jMHaXKiw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-z3xtzXu2N0uwc58AwZbvZQ-1; Fri,
 26 Jul 2024 14:32:40 -0400
X-MC-Unique: z3xtzXu2N0uwc58AwZbvZQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FCD119560BA
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Jul 2024 18:32:40 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.49])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA2841955D45;
	Fri, 26 Jul 2024 18:32:38 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] rteval: measurement: Change latency flag to latency_test
Date: Fri, 26 Jul 2024 13:32:37 -0500
Message-ID: <20240726183237.44769-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

As requested by John, change the name of the latency flag to avoid
looking like it holds an actual latency value.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval/modules/__init__.py               | 14 +++++++-------
 rteval/modules/measurement/cyclictest.py |  2 +-
 rteval/modules/measurement/timerlat.py   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 2a4eafae71c7..d7792108d5b8 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -40,7 +40,7 @@ class rtevalModulePrototype(threading.Thread):
                          "finished": threading.Event()}
         self._donotrun = False
         self._exclusive = False
-        self._latency = False
+        self._latency_test = False
         self.__timestamps = {}
         self.__sleeptime = 2.0
 
@@ -68,9 +68,9 @@ class rtevalModulePrototype(threading.Thread):
         self._exclusive = True
 
 
-    def set_latency(self):
+    def set_latency_test(self):
         """ Sets the module as an exclusive latency measurer """
-        self._latency = True
+        self._latency_test = True
 
 
     def set_donotrun(self):
@@ -418,14 +418,14 @@ class RtEvalModules:
 
         self._logger.log(Log.INFO, f"Preparing {self._module_type} modules")
         exclusive = 0
-        latency = False
+        latency_test = False
         for (modname, mod) in self.__modules:
             if mod.is_exclusive() and mod.WorkloadWillRun():
                 exclusive += 1
-            if mod._latency:
-                if latency:
+            if mod._latency_test:
+                if latency_test:
                     raise RuntimeError("More than one exclusive latency test")
-                latency = True
+                latency_test = True
         for (modname, mod) in self.__modules:
             if exclusive >= 1:
                 if exclusive != 1:
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index a9f5b0c4fba7..d919058e927f 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -216,7 +216,7 @@ class Cyclictest(rtevalModulePrototype):
         self.__started = False
         self.__cyclicoutput = None
         self.__breaktraceval = None
-        self.set_latency()
+        self.set_latency_test()
 
 
     @staticmethod
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index e4b80c33552e..92bc07051aa1 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -216,7 +216,7 @@ class Timerlat(rtevalModulePrototype):
                                                   logfnc=self._log)
         self.__timerlatdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
         self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
-        self.set_latency()
+        self.set_latency_test()
 
 
     def _WorkloadSetup(self):
-- 
2.45.2

