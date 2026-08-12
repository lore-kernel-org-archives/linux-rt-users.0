Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098A382397
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Aug 2026 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564465; cv=none; b=eM50rNDFvELkJmTOPCBmrlGNID24Kmr7QbHirLxm8JVLEMLuk2RL6CjgCmb7zSBeBYcWHD57s2na1K2H1rZBnoPpM1Ku3m+csNG32uZvI0WSrUUDwlIXBTMcmayJOmjXshgOU7qHCPShLBX/N/3euy1KZG/TUU8xrk4bGY9IRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564465; c=relaxed/simple;
	bh=bian4c/7chKD1E1Sq13XNMYsMh4i4Jr4yclKiTCv+Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aq7CEq3U5/FcbxWj1095gpHIFoFazd3a8aGDqDIdvAz0E5wMau2bTvxk5TDAlA2ug3QS/YOxIlRyhBTPAuZ5SaQW2lyaOp/s2vl8hFG9PO14IF174+5Ovi4Kwt7dKnfUUSAAJCzT6ykJGEnOaMErEWk5XBNJ7mWVGJVmZ+lMwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CT412gqq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT412gqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786564463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JVwAjzHJm4KlMQp3rfSP5R2uLU2/WdYI7xOe5CspWiE=;
	b=CT412gqqwfyPawxka+1HgkI0GloN2Kp0Nv63aYBNqLqmCHCuJMMEPRyreoF9mVZ77XleTO
	k855IuD0rw3yL6sayYc52kENCuIm1p9YmGEkZ3R86Por4XleTHWIS/y0SFAFDDwtCHMbqT
	n5mwYJicPC47oG5bXIdsFQTCEKM69mU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-lMVbCEX-OMK74n4WnV6ypQ-1; Wed,
 12 Aug 2026 15:54:12 -0400
X-MC-Unique: lMVbCEX-OMK74n4WnV6ypQ-1
X-Mimecast-MFC-AGG-ID: lMVbCEX-OMK74n4WnV6ypQ_1786564451
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BB0A1955F5A
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Aug 2026 19:54:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.2.16.119])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36F4F422;
	Wed, 12 Aug 2026 19:54:11 +0000 (UTC)
Received: from fedora.redhat.com (localhost [127.0.0.1])
	by fedora.redhat.com (Postfix) with ESMTPS id E68F62CF0DE;
	Wed, 12 Aug 2026 15:54:09 -0400 (EDT)
Received: (from sanasharma@localhost)
	by fedora.redhat.com (8.18.1/8.18.1/Submit) id 67CJs9me378372;
	Wed, 12 Aug 2026 15:54:09 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>
Subject: [PATCH] rteval: Updated parameter names
Date: Wed, 12 Aug 2026 15:52:57 -0400
Message-ID: <20260812195257.378272-1-sansshar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Updated ModuleParameters, init and WorkloadPrepare with new parameter names.
- option is now named stressor, and
- arg is now named workers
to promote clarity.

Unit tests have also been changed to reflect this parameter renaming

Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 rteval/modules/loads/stressng.py | 25 +++++++++++++------------
 tests/e2e/loads.t                |  6 +++---
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 03fe842..32e2dbd 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -23,8 +23,8 @@ class Stressng(CommandLineLoad):
         self.__err = None
         self.__nullfp = None
         self.args = None
-        " Only run this module if the user specifies an option "
-        if self.cfg.option is not None:
+        " Only run this module if the user specifies an stressor "
+        if self.cfg.stressor is not None:
             self._donotrun = False
         else:
             self._donotrun = True
@@ -49,11 +49,11 @@ class Stressng(CommandLineLoad):
         else:
             self.__out = self.__err = self.__nullfp
 
-        # stress-ng is only run if the user specifies an option
+        # stress-ng is only run if the user specifies an stressor
         self.args = ['stress-ng']
-        self.args.append(f'--{str(self.cfg.option)}')
-        if self.cfg.arg is not None:
-            self.args.append(self.cfg.arg)
+        self.args.append(f'--{str(self.cfg.stressor)}')
+        if self.cfg.workers is not None:
+            self.args.append(self.cfg.workers) #default is 0
         if self.cfg.timeout is not None:
             self.args.append('--timeout')
             self.args.append(self.cfg.timeout)
@@ -135,13 +135,14 @@ def create(config, logger):
 def ModuleParameters():
     """ Commandline options for Stress-ng """
     return {
-        "option": {
-            "descr": "stressor specific option",
-            "metavar": "OPTION"
+        "stressor": {
+            "descr": "stressor name (eg. vm, cpu)",
+            "metavar": "STRESSOR"
         },
-        "arg": {
-            "descr": "stressor specific arg",
-            "metavar" : "ARG"
+        "workers": {
+            "descr": "number of workers(default: 0 = one per CPU)",
+            "default": "0",
+            "metavar" : "N"
         },
         "timeout": {
             "descr": "timeout after T seconds",
diff --git a/tests/e2e/loads.t b/tests/e2e/loads.t
index c367c46..b49002c 100644
--- a/tests/e2e/loads.t
+++ b/tests/e2e/loads.t
@@ -20,15 +20,15 @@ check "stress-ng debug" \
     "--onlyload -D -d 1" 0 '\[DEBUG\]'
 
 check "stress-ng command" \
-    "--onlyload -D -d 1 --stressng-option procfs --stressng-arg 1" 0 \
+    "--onlyload -D -d 1 --stressng-stressor procfs --stressng-workers 1" 0 \
     'starting with stress-ng --procfs 1 --taskset'
 
 check "stress-ng command, with --loads-cpulist" \
-    "--onlyload -D -d 1 --loads-cpulist=0-2 --stressng-option procfs --stressng-arg 1" 0 \
+    "--onlyload -D -d 1 --loads-cpulist=0-2 --stressng-stressor procfs --stressng-workers 1" 0 \
     'starting with stress-ng --procfs 1 --taskset 0,1,2'
 
 check "stress-ng command, with --stressng-timeout" \
-    "--onlyload -D -d 1 --stressng-option procfs --stressng-arg 1 --stressng-timeout 2" 0 \
+    "--onlyload -D -d 1 --stressng-stressor procfs --stressng-workers 1 --stressng-timeout 2" 0 \
     'starting with stress-ng --procfs 1 --timeout 2'
 
 # hackbench checks
-- 
2.54.0

