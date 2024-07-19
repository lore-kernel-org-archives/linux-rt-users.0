Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA101465A9
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419132; cv=none; b=o7c0O8Oz8K+EsNWJ4nt12G57p+LRFXVNpJYdW6uE5VCaPbkDATMiQ/YRJ+4b7RBkkU9aO7HeKuq6kDQ/j9+g8j2AEb+IJDTWQy9KP2ZCpAVG1IiI7sSs4rUvvCRYExrvVm351r7yATLz8c4LMxq1jl/NZgu1csd8dXwp6jpJyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419132; c=relaxed/simple;
	bh=Qb6oanmW/OQLCqN54EMzO00QH0tPSewCFDxfKjsuP+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOGh3Rt/gkAhnYMe1pzYIeBOtTcoqV46vktkngCEE+Vdn7MCkESaLDt5+6AaWx1xF/OvPXgRvwh96w38hu76f8ALZDvgCQCsTXWy+7jsE4XJBrkAx/IJElXTWxYTC+n+mQTOb3exrUybjP01rHcw4MkTl73T3LmlRbvnxsegHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxWsfXnU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxWsfXnU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721419129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wq7xDDaGAa/7bUB+Sjeg98W3dabh8o9HJ9bPcEpFFcE=;
	b=VxWsfXnUBOPipxp+4enUSEkXCB3/yS3HiN8IlMWgqgH7cndJRhHdcZxEv/Kn8PsUkH421k
	bax4yeazbb8J9wrPscywTkg2QUqzII/afAMLErhIvIrhfLwG+9sQ/oMu5W/TW53GnhFz2m
	DgtKGMBs+5/zLb5HXvoqOPUDMv8e86Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-UIJ5yQhAMvaOyqyteaofhw-1; Fri,
 19 Jul 2024 15:58:45 -0400
X-MC-Unique: UIJ5yQhAMvaOyqyteaofhw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40EEC19560B3
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 19:58:44 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DFEB1955E80;
	Fri, 19 Jul 2024 19:58:42 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3] rteval: Add --noload option
Date: Fri, 19 Jul 2024 14:58:41 -0500
Message-ID: <20240719195841.88214-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This option allows measurement to be done without any loads.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v3: Update XSLT to handle the absence of loads
---
 doc/rteval.8           |  3 +++
 rteval-cmd             |  9 +++++++
 rteval/__init__.py     | 54 ++++++++++++++++++++++--------------------
 rteval/rtevalReport.py |  3 ++-
 rteval/rteval_text.xsl |  9 ++++++-
 5 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/doc/rteval.8 b/doc/rteval.8
index 9e2b377752e5..1981ac7b3913 100644
--- a/doc/rteval.8
+++ b/doc/rteval.8
@@ -108,6 +108,9 @@ Print rteval version and exit.
 .TP
 .B \-S KERNEL_VERSION, \-\-source\-download=KERNEL_VERSION
 download a source kernel from kernel.org and exit
+.TP
+.B \-\-noload
+Only run the measurements (don't run loads)
 
 .SH GROUP OPTIONS
 .TP
diff --git a/rteval-cmd b/rteval-cmd
index 5cb6d7a44523..36b167a034e5 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -146,6 +146,9 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("-S", "--source-download", nargs="*", dest="rteval___srcdownload",
                         type=str, default=None, metavar="KERNEL_VERSION",
                         help='download a source kernel from kernel.org and exit')
+    parser.add_argument("--noload", dest="rteval___noload",
+                        action="store_true", default=False,
+                        help="only run the measurements (don't run loads)")
 
 
     if not cmdargs:
@@ -273,6 +276,12 @@ if __name__ == '__main__':
         measuremods.SetupModuleOptions(parser)
         cmd_args = parse_options(config, parser, sys.argv[1:])
 
+        if rtevcfg.noload:
+            if rtevcfg.onlyload:
+                # Make up your mind!
+                raise RuntimeError('The --noload and --onlyload options are incompatible.')
+            loadmods = None
+
         # download kernel tarball
         if rtevcfg.srcdownload:
             logger.log(Log.DEBUG, f"Kernel Version to download = {rtevcfg.srcdownload}")
diff --git a/rteval/__init__.py b/rteval/__init__.py
index 226d14f80f48..4d3e0c23e5ab 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -46,9 +46,6 @@ class RtEval(rtevalReport):
         if not isinstance(config, rtevalConfig.rtevalConfig):
             raise TypeError("config variable is not an rtevalConfig object")
 
-        if not isinstance(loadmods, LoadModules):
-            raise TypeError("loadmods variable is not a LoadModules object")
-
         if not isinstance(measuremods, MeasurementModules):
             raise TypeError("measuremods variable is not a MeasurementModules object")
 
@@ -111,20 +108,21 @@ class RtEval(rtevalReport):
         except Exception as err:
             raise RuntimeError(f"Cannot create report directory (NFS with rootsquash on?) [{err}]]")
 
+        params = {'workdir':self.__rtevcfg.workdir,
+                  'reportdir':self.__reportdir and self.__reportdir or "",
+                  'builddir':builddir,
+                  'srcdir':self.__rtevcfg.srcdir,
+                  'verbose': self.__rtevcfg.verbose,
+                  'debugging': self.__rtevcfg.debugging,
+                  'numcores':self._sysinfo.cpu_getCores(True),
+                  'logging':self.__rtevcfg.logging,
+                  'memsize':self._sysinfo.mem_get_size(),
+                  'numanodes':self._sysinfo.mem_get_numa_nodes(),
+                  'duration': float(self.__rtevcfg.duration),
+                  }
+
         if self._loadmods:
             self.__logger.log(Log.INFO, "Preparing load modules")
-            params = {'workdir':self.__rtevcfg.workdir,
-                      'reportdir':self.__reportdir and self.__reportdir or "",
-                      'builddir':builddir,
-                      'srcdir':self.__rtevcfg.srcdir,
-                      'verbose': self.__rtevcfg.verbose,
-                      'debugging': self.__rtevcfg.debugging,
-                      'numcores':self._sysinfo.cpu_getCores(True),
-                      'logging':self.__rtevcfg.logging,
-                      'memsize':self._sysinfo.mem_get_size(),
-                      'numanodes':self._sysinfo.mem_get_numa_nodes(),
-                      'duration': float(self.__rtevcfg.duration),
-                      }
             self._loadmods.Setup(params)
 
         self.__logger.log(Log.INFO, "Preparing measurement modules")
@@ -144,15 +142,18 @@ class RtEval(rtevalReport):
 
             print(f"rteval run on {os.uname()[2]} started at {time.asctime()}")
             onlinecpus = self._sysinfo.cpu_getCores(True)
-            cpulist = self._loadmods._cfg.GetSection("loads").cpulist
-            if cpulist:
-                print(f"started {self._loadmods.ModulesLoaded()} loads on cores {cpulist}", end=' ')
-            else:
-                print(f"started {self._loadmods.ModulesLoaded()} loads on {onlinecpus} cores", end=' ')
-            if self._sysinfo.mem_get_numa_nodes() > 1:
-                print(f" with {self._sysinfo.mem_get_numa_nodes()} numa nodes")
-            else:
-                print("")
+            if self._loadmods:
+                cpulist = self._loadmods._cfg.GetSection("loads").cpulist
+                if cpulist:
+                    print(f"started {self._loadmods.ModulesLoaded()} loads on cores {cpulist}",
+                          end=' ')
+                else:
+                    print(f"started {self._loadmods.ModulesLoaded()} loads on {onlinecpus} cores",
+                          end=' ')
+                if self._sysinfo.mem_get_numa_nodes() > 1:
+                    print(f" with {self._sysinfo.mem_get_numa_nodes()} numa nodes")
+                else:
+                    print("")
             cpulist = self._measuremods._cfg.GetSection("measurement").cpulist
             if cpulist:
                 print(f"started measurement threads on cores {cpulist}")
@@ -192,7 +193,7 @@ class RtEval(rtevalReport):
                     if threading.active_count() < nthreads:
                         raise RuntimeError("load thread died!")
 
-                if not load_avg_checked:
+                if self._loadmods and not load_avg_checked:
                     self._loadmods.SaveLoadAvg()
                     load_avg_checked = 5
                 else:
@@ -202,7 +203,8 @@ class RtEval(rtevalReport):
                     left_to_run = stoptime - currtime
                     self.__show_remaining_time(left_to_run)
                     rpttime = currtime + report_interval
-                    print(f"load average: {self._loadmods.GetLoadAvg():.2f}")
+                    if self._loadmods:
+                        print(f"load average: {self._loadmods.GetLoadAvg():.2f}")
                 currtime = time.time()
 
             self.__logger.log(Log.DEBUG, "out of measurement loop")
diff --git a/rteval/rtevalReport.py b/rteval/rtevalReport.py
index 57d99f520f50..7379a7904f3f 100644
--- a/rteval/rtevalReport.py
+++ b/rteval/rtevalReport.py
@@ -57,7 +57,8 @@ class rtevalReport:
         self.__xmlreport.AppendXMLnodes(self._sysinfo.MakeReport())
 
         # Add load info
-        self.__xmlreport.AppendXMLnodes(self._loadmods.MakeReport())
+        if self._loadmods:
+            self.__xmlreport.AppendXMLnodes(self._loadmods.MakeReport())
 
         # Add measurement data
         self.__xmlreport.AppendXMLnodes(self._measuremods.MakeReport())
diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index b801679abcc5..96846aaf4d54 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -15,7 +15,14 @@
     <xsl:text>&#10;</xsl:text>
 
     <xsl:text>   Loads:        </xsl:text>
-    <xsl:value-of select="loads/@loads"/><xsl:text> loads run on cores </xsl:text><xsl:value-of select="loads/@loadcpus"/>
+    <xsl:choose>
+      <xsl:when test="loads">
+        <xsl:value-of select="loads/@loads"/><xsl:text> loads run on cores </xsl:text><xsl:value-of select="loads/@loadcpus"/>
+      </xsl:when>
+      <xsl:otherwise>
+        <xsl:text>none</xsl:text>
+      </xsl:otherwise>
+    </xsl:choose>
     <xsl:text>&#10;</xsl:text>
 
     <xsl:text>   Measurement:  </xsl:text>
-- 
2.45.2

