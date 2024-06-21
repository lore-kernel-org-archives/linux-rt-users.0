Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9083CD4
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936670; cv=none; b=SZOn5dBLKkeBcNPCB4xbcly/41zeowtGqvHbD1kScF5cqJGDyF6e/7HpwnEXyor5aXhoi1wfyFWpGFxiptRjDLltFQNJWvkTwZ5x5gSIFaZ3R9K/ZlhkJDWSs4+SGh0O0Fd/OQ80MQ9vLMTKYFO31QcxFtqPhj1s/H/MvPKj7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936670; c=relaxed/simple;
	bh=wTeTT5w8XKrJfQ7mt9QJw3NFnyd8ZQmBSlTSt+3u7sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj/HuOSNSRD6kJ0fiwy3nQeCopIsxyWfgxnYSL1ovrwfkeyBrzDaQiCByuLvRKT6qN3iaxy166raI2i6InGJmmVmFdV67F0Wea8hhsb+o2i8/o4J7581O4S0Zu7YGMBTjmxrGYUzvEaI8ZP10Z0rh8WMf8u+bAubft2TzUOITkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itLA+Naw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itLA+Naw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718936667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQFmeZ/Hi+Syg5tzZxyH+U1DjdQyotDHQrBwt9/UZYc=;
	b=itLA+NawOUUX3czK5oVL5O0Id79AXkFyQKMcHwlO4yd10YioRphtqUiRB8Bf3iaTCKjHlz
	hsq4+gg2MQpYSpVYOKFOVXnsrtvfzaD9D2B/DFs/itf3zzBG6+Jg40cyLYsXXM07LMkmHa
	g9BZsi419p9Hwd6/1vU4zQtQrOJ+RiI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-wwiwPuJ1MH6bNx7CI0YSrA-1; Thu,
 20 Jun 2024 22:24:26 -0400
X-MC-Unique: wwiwPuJ1MH6bNx7CI0YSrA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 352691956086
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 02:24:25 +0000 (UTC)
Received: from p1g2.hsd1.mn.comcast.net (unknown [10.2.16.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5D411956048;
	Fri, 21 Jun 2024 02:24:23 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 4/4] rteval: Enforce only one latency measurement module at a time
Date: Thu, 20 Jun 2024 21:24:17 -0500
Message-ID: <20240621022417.2086751-5-crwood@redhat.com>
In-Reply-To: <20240621022417.2086751-1-crwood@redhat.com>
References: <20240621022417.2086751-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Latency modules will step on each other's toes if run at the same time
(on the same CPU, though that's an enhancement for later), so only
run one of them.  A priority mechanism allows selecting

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval/modules/__init__.py               | 11 +++++++++++
 rteval/modules/measurement/cyclictest.py |  1 +
 rteval/modules/measurement/timerlat.py   |  1 +
 3 files changed, 13 insertions(+)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index de1ddc4628c1..2a4eafae71c7 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -40,6 +40,7 @@ class rtevalModulePrototype(threading.Thread):
                          "finished": threading.Event()}
         self._donotrun = False
         self._exclusive = False
+        self._latency = False
         self.__timestamps = {}
         self.__sleeptime = 2.0
 
@@ -67,6 +68,11 @@ class rtevalModulePrototype(threading.Thread):
         self._exclusive = True
 
 
+    def set_latency(self):
+        """ Sets the module as an exclusive latency measurer """
+        self._latency = True
+
+
     def set_donotrun(self):
         """ set a module's donotrun field to True """
         self._donotrun = True
@@ -412,9 +418,14 @@ class RtEvalModules:
 
         self._logger.log(Log.INFO, f"Preparing {self._module_type} modules")
         exclusive = 0
+        latency = False
         for (modname, mod) in self.__modules:
             if mod.is_exclusive() and mod.WorkloadWillRun():
                 exclusive += 1
+            if mod._latency:
+                if latency:
+                    raise RuntimeError("More than one exclusive latency test")
+                latency = True
         for (modname, mod) in self.__modules:
             if exclusive >= 1:
                 if exclusive != 1:
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 3a34c1b988d6..a9f5b0c4fba7 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -216,6 +216,7 @@ class Cyclictest(rtevalModulePrototype):
         self.__started = False
         self.__cyclicoutput = None
         self.__breaktraceval = None
+        self.set_latency()
 
 
     @staticmethod
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 19dd30732936..793b80cc0dac 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -206,6 +206,7 @@ class Timerlat(rtevalModulePrototype):
                                                   logfnc=self._log)
         self.__timerlatdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
         self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
+        self.set_latency()
 
 
     def _WorkloadSetup(self):
-- 
2.45.1

