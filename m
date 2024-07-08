Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC815278A
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jul 2024 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468109; cv=none; b=hxgq6vvmiB2GgZ8Kp3MAOQ4Y1dGcGBAIlNuIk90LtdHVU3IceskILxd5rkH6Njs2T1iPmybgyG74ZAsVpeqNtwFoq8iHBUrIi50RB6cYV9VTFLX4qlPsePj6XAaKuxnV5b6A0wpqFxOI3CIqO4Xh21tTvAoPLx90QhVD7oR29UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468109; c=relaxed/simple;
	bh=q8+np6932iOf+/yLkQezFjODtNlS5FrvZ1TocvyjWqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXh+sfJT/Bce3lX/sYZnvWmU+25IWhBJxrHRCqRc5fEYJ1DxIywVq4AaSYT4V79zOweaytQ9y1aA4Xzx2Q/r4cfR3NylkNlYVhNes7P1xIy46/HGz+5Fcqee5dKBfUrfldUdTRa7fddJ9pPptRYhzlFNsNJXsqg5MtnU5JFRSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lzirvh2c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lzirvh2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720468106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8KR6df9DdgWeYo+CbX5MONY+qDv5glYUCt4h4keQQNA=;
	b=Lzirvh2cbWk2eUlvtEDVgxGMqQI7lrYQxDcTekXCxiK+Q0/eSePbvqTqyBT4+EdNB5lMBc
	6++kBCcF9GwXMRHbmYvwJOEipLExC6sCXSCYsgrFxKiosn72HifEKhcMcNrfQMpUmTk7Qk
	MSrcCUb+CQug4pb3p4TYoJD5nRajnQ4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-sk2sjFJ1NI-SdlGo95LQ2g-1; Mon,
 08 Jul 2024 15:48:25 -0400
X-MC-Unique: sk2sjFJ1NI-SdlGo95LQ2g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FB991955BC6
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jul 2024 19:48:24 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.137])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C95D19560AE;
	Mon,  8 Jul 2024 19:48:23 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2] rteval: Add --noload option
Date: Mon,  8 Jul 2024 14:48:22 -0500
Message-ID: <20240708194822.221496-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This option allows measurement to be done without any loads.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: I forgot to update the man page

This patch is on top of the "rteval: Remove measurement profiles and
make latency mods exclusive" patchset I previously sent.

 doc/rteval.8           |  3 +++
 rteval-cmd             |  9 +++++++
 rteval/__init__.py     | 54 ++++++++++++++++++++++--------------------
 rteval/rtevalReport.py |  3 ++-
 4 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/doc/rteval.8 b/doc/rteval.8
index bfdeb9d36d9e..1eca63721b75 100644
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
-- 
2.45.1

