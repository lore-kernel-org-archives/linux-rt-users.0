Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEE161915
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848364; cv=none; b=G5nGmW+5d/V8LK6Y9MElpR1hoYbPo8UKX5C/zBKa9qFGIYwoGej92yHM+w/jaMMgDEztM3CFIG0NqZ1ldZf/XYCl5SZxlyDqQl7ASnV1glvXj7Vi1tJOzW20J+brPHjqDPcHa8V1w834NGnNECvJo7eNKMekUI3UoU68jZLoYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848364; c=relaxed/simple;
	bh=eqlUszIbtLxQ8IL+S0qSFre+MRwnlUsQV+sjApfceu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HW2uaKiLnuOieIgUAbQ4Ej5Vl97u8FOBGKSNMPBW9TFOZay5yH8u4xpP6jAzbKT6pZiWtFpMDIxyzBEGs0TsRw69HOjNUyIdCU8HMTg/JEKRllzeSZZy80uQ59SXXDzGKy1CuMyTfF9sqFT7Z+1jc30YPXP9ZPJkOFdKZmAlol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBsrubR7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBsrubR7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721848360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3jzCBvoF5e1RMrga8Ea+lWQAGBzfvigCybdHhBqcpqE=;
	b=VBsrubR7UByJJaaYZyTBGVG246FYUbG4/xFHkLg+B5VUlIf1vTQI/wsbRjbwXWE1dqiRcv
	Auk3ntiNONBVI25zt9UnJ5lfOsFda8WWpk0GssAmbgQ1V2EkxHFns0A9eZglIqA4CUFBVj
	8Xyh3spDwWN24mw7UOqr3dsxloJjSGY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-14NDYCW3NVemyVbVBy9xUg-1; Wed,
 24 Jul 2024 15:12:38 -0400
X-MC-Unique: 14NDYCW3NVemyVbVBy9xUg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D0A41955D4D
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 19:12:37 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.33.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 906013000192;
	Wed, 24 Jul 2024 19:12:35 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v4] rteval: Added functionality to allow user to set the cstate of specified cpus when running rteval
Date: Wed, 24 Jul 2024 15:12:24 -0400
Message-ID: <20240724191225.1722773-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We would like to be able to set the idle states of CPUs while running
rteval.

This patch adds the file cpupower.py and option '--idle-set' within
rteval to use cpupower. The set idle state is applied to the cpulist
given by '--measurement-cpulist'.

cpupower.py provides the infrastructure to interface and execute the cpupower
command, and the options in rteval-cmd let the user specify the idle state
to be set and the CPUs to set it on.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd                 | 22 ++++++++-
 rteval/cpupower.py         | 94 ++++++++++++++++++++++++++++++++++++++
 rteval/modules/__init__.py |  2 +-
 3 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 rteval/cpupower.py

diff --git a/rteval-cmd b/rteval-cmd
index 5cb6d7a44523..c676ad56bf85 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -29,6 +29,7 @@ from rteval.Log import Log
 from rteval import RtEval, rtevalConfig
 from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
+from rteval import cpupower
 from rteval.version import RTEVAL_VERSION
 from rteval.systopology import SysTopology, parse_cpulist_from_config
 from rteval.modules.loads.kcompile import ModuleParameters
@@ -146,7 +147,8 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("-S", "--source-download", nargs="*", dest="rteval___srcdownload",
                         type=str, default=None, metavar="KERNEL_VERSION",
                         help='download a source kernel from kernel.org and exit')
-
+    parser.add_argument('--idle-set', dest='rteval___idlestate', metavar='IDLESTATE',
+                        default=None, help='Idle state to enable for this rteval run')
 
     if not cmdargs:
         cmdargs = ["--help"]
@@ -169,6 +171,12 @@ def parse_options(cfg, parser, cmdargs):
         cmd_args = cmdargs[ind+1:]
         cmdargs = cmdargs[:ind+1]
 
+    # if --cpulist is specified, make sure --idle-set is too
+    if ((sys.argv.count('-c')+sys.argv.count('--cpulist')) > 0) and \
+    (sys.argv.count('--idle-set') == 0):
+        print('--cpulist must be used with --idle-set')
+        cmdargs = ["--help"]
+
     cmd_opts = parser.parse_args(args=cmdargs)
 
     # if no kernel version was provided for --source-download, set version to default
@@ -263,6 +271,9 @@ if __name__ == '__main__':
                 | (rtevcfg.debugging and Log.DEBUG)
         logger.SetLogVerbosity(loglev)
 
+        # check if cpupower is being used
+        if sys.argv.count('--idle-set') > 0:
+            rtevcfg.update({'usingCpupower': True})
         # Load modules
         loadmods = LoadModules(config, logger=logger)
         measuremods = MeasurementModules(config, logger=logger)
@@ -394,6 +405,11 @@ if __name__ == '__main__':
         if not os.path.isdir(rtevcfg.workdir):
             raise RuntimeError(f"work directory {rtevcfg.workdir} does not exist")
 
+        # if idle-set has been specified, enable idlestate in rtecfg.cpulist
+        cpupower_controller = None
+        if rtevcfg.idlestate:
+            cpupower_controller = cpupower.Cpupower(msrcfg.cpulist, rtevcfg.idlestate)
+            cpupower_controller.enable_idle_state()
 
         rteval = RtEval(config, loadmods, measuremods, logger)
         rteval.Prepare(rtevcfg.onlyload)
@@ -413,6 +429,10 @@ if __name__ == '__main__':
             ec = rteval.Measure()
             logger.log(Log.DEBUG, f"exiting with exit code: {ec}")
 
+        # reset idlestate
+        if rtevcfg.idlestate:
+            cpupower_controller.restore_cstate()
+
         sys.exit(ec)
     except KeyboardInterrupt:
         sys.exit(0)
diff --git a/rteval/cpupower.py b/rteval/cpupower.py
new file mode 100644
index 000000000000..9437b2451b54
--- /dev/null
+++ b/rteval/cpupower.py
@@ -0,0 +1,94 @@
+#! /user/bin/python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Object to execute cpupower tool
+# Copyright 2024    Anubhav Shelat <ashelat@redhat.com>
+
+import subprocess
+import argparse
+import os
+import multiprocessing
+import time
+
+
+class Cpupower:
+    def __init__(self, cpulist, idlestate):
+        self.cpulist = cpulist
+        self.idlestate = idlestate
+        self.nstates = len(os.listdir('/sys/devices/system/cpu/cpu0/cpuidle/'))    # number of cstates
+        self.cpu_count = multiprocessing.cpu_count()
+        self.cstate_cfg = []
+
+
+    def enable_idle_state(self):
+        ''' Enable a specific cstate, while disabling all other cstates, and save the current cstate configuration '''
+        self.cstate_cfg = self.get_cstate_cfg()
+
+        # ensure that cstate is in range of available cstates
+        if int(self.idlestate) > self.nstates-1 or int(self.idlestate) < 0:
+            print(f'Idle state {self.idlestate} is out of range, using POLL')
+            self.idlestate = 0
+
+        # enable cstate and disable the rest
+        if (self.cpulist):
+            subprocess.run(['sudo', 'cpupower', '-c', self.cpulist,'idle-set', '-e', str(self.idlestate)], stdout=open(os.devnull, 'wb'))
+            for cs in range(self.nstates):
+                if str(cs) != self.idlestate:
+                    subprocess.run(['sudo', 'cpupower', '-c', self.cpulist,'idle-set', '-d', str(cs)], stdout=open(os.devnull, 'wb'))
+        else:
+            subprocess.run(['sudo', 'cpupower', 'idle-set', '-e', str(self.idlestate)], stdout=open(os.devnull, 'wb'))
+            for cs in range(self.nstates):
+                if str(cs) != self.idlestate:
+                    subprocess.run(['sudo', 'cpupower', 'idle-set', '-d', str(cs)], stdout=open(os.devnull, 'wb'))
+
+        if self.cpulist: print(f'Idlestate {self.idlestate} enabled on CPUs {self.cpulist}')
+        else: print(f'Idlestate {self.idlestate} enabled on all CPUs')
+
+
+    def get_cstate_cfg(self):
+        ''' Store the current cstate config '''
+        # cstate [m] configuration on cpu [n] can be found in '/sys/devices/system/cpu/cpu*/cpuidle/state*/disable'
+        cfg = []
+        for cpu in range(self.cpu_count):
+            cfg.append([])
+            for cs in range(self.nstates):
+                f = open('/sys/devices/system/cpu/cpu'+str(cpu)+'/cpuidle/state'+str(cs)+'/disable', 'r')
+                d = f.read(1)
+                cfg[cpu].append(d)   # cstate_cfg[n][m] stores the m-th idle state on the n-th cpu
+
+        return cfg
+
+
+    def restore_cstate(self):
+        for cpu in range(self.cpu_count):
+            for cs in range(self.nstates):
+                f = open('/sys/devices/system/cpu/cpu'+str(cpu)+'/cpuidle/state'+str(cs)+'/disable', 'w')
+                f.write(self.cstate_cfg[cpu][cs])
+                f.close()
+        print('Idle state configuration restored')
+
+    def get_idle_info():
+        subprocess.call(['cpupower', 'idle-info'])
+
+
+if __name__ == '__main__':
+    parser = argparse.ArgumentParser()
+    parser.add_argument('-c', '--cpu-list', required=False, default=None,
+                        help='List of cpus to perform cpupower-idle-set operation on.')
+    parser.add_argument('-s', '--idle-set', default='',
+                        help='Specify idle state to enable/disable')
+    parser.add_argument('--info', default=False, action='store_true', help='Get idle state information')
+
+    args = parser.parse_args()
+    print(args)
+    cpulist = args.cpu_list
+    idlestate = args.cstate
+    if (idlestate):
+        cpupower = Cpupower(cpulist, idlestate)
+        cpupower.enable_idle_state()
+        time.sleep(10)
+        cpupower.restore_cstate()
+    elif (args.info):
+        Cpupower.get_idle_info()
+
+
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 4330a839db6f..9d42d0e949fc 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -284,7 +284,7 @@ the information provided by the module"""
         grparser.add_argument(f'--{self.__modtype}-cpulist',
                             dest=f'{self.__modtype}___cpulist', action='store', default="",
                             help=f'CPU list where {self.__modtype} modules will run',
-                            metavar='LIST')
+                            metavar='CPULIST')
 
         for (modname, mod) in list(self.__modsloaded.items()):
             opts = mod.ModuleParameters()
-- 
2.45.2

