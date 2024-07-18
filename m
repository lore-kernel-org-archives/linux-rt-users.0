Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCC2AF12
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315746; cv=none; b=PGi1ay36cZx6jPPB2UmRXqiq1/tCHQ6e3qFeUgGgCAcvaUECOnpNyQBR2zlKQJrJ8PDiu+Noq4TRjQ2HAPTH7JkdSd9b1qcycuqr3YFsDGPEzLoj9Y0apKOWw+15o3yTbVLtih1A/6bwbis6cY8aiM2DfGxeBjfpBn+MvITlzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315746; c=relaxed/simple;
	bh=K5Ua1h6cT5HD7NOUU7Cnus4pmE66luWkmstH53MkqPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pp1Zs9T8d+WVJuoR3a7/4pf00/5zBKiMjpehYSA6FkxpkSdDtsa/vPt2qXphtNFGhIDMeH7Xvp7hNozFEMxggINeFa9CxvtPlW+yt17UeBiBA7CYL4IH2TfKLWW5Fsvf/xn+oNQlZY2Zx/5MAd3NjpHq0Ak2Ecmoy7EHwFZRozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKH6KH5R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKH6KH5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721315743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C7ewXza8OwEceG6deX7Nsmvwy8ahgbjOeEmPUb45TEg=;
	b=PKH6KH5RyhymllML5/ZEcQOtEv84S8IUaEa4A20XabSaUWX97Djert5if7gDO145BdRe0q
	u3vJ+qTw2g5iHpKUw1MJSS4LNbbMOUUiwQQJXGcbKqvmsNs3OKhz9x6Ulk9q7PMHSZE5r4
	wYGg8gIFSjMyn8B0qVA+1RbCRFdhH4U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-kqxTs1NPMMa-wl0Q63Dbkg-1; Thu,
 18 Jul 2024 11:15:41 -0400
X-MC-Unique: kqxTs1NPMMa-wl0Q63Dbkg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEAEC184061B
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jul 2024 15:15:21 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.20.9.183])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1713B3000185;
	Thu, 18 Jul 2024 15:15:20 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v3] rteval: Added functionality to allow user to set the cstate of specified cpus when running rteval
Date: Thu, 18 Jul 2024 11:14:55 -0400
Message-ID: <20240718151454.208555-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We would like to be able to set the cstates of CPUs while running
rteval.

This patch adds the file cpupower.py and options '--idle-set' and '--cpulist'
within rteval to use cpupower.

cpupower.py provides the infrastructure to interface with the cpupower
command, and the options in rteval-cmd let the user specify the cstate to be set
and the CPUs to set it on.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd         | 25 ++++++++++++-
 rteval/cpupower.py | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 rteval/cpupower.py

diff --git a/rteval-cmd b/rteval-cmd
index 5cb6d7a44523..0692e71b4243 100755
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
@@ -146,7 +147,11 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("-S", "--source-download", nargs="*", dest="rteval___srcdownload",
                         type=str, default=None, metavar="KERNEL_VERSION",
                         help='download a source kernel from kernel.org and exit')
-
+    parser.add_argument("-c", "--cpulist", dest="rteval___cpulist", metavar="CPULIST",
+                        default=str([i for i in range(os.cpu_count())]).strip('[]'),
+                        help='specify list of cpus whose idle state to modify')
+    parser.add_argument('--idle-set', dest='rteval___cstate', metavar='CSTATE',
+                        default=None, help='cstate to enable for this rteval run')
 
     if not cmdargs:
         cmdargs = ["--help"]
@@ -169,6 +174,12 @@ def parse_options(cfg, parser, cmdargs):
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
@@ -263,6 +274,9 @@ if __name__ == '__main__':
                 | (rtevcfg.debugging and Log.DEBUG)
         logger.SetLogVerbosity(loglev)
 
+        # check if cpupower is being used
+        if sys.argv.count('--idle-set') > 0:
+            rtevcfg.update({'usingCpupower': True})
         # Load modules
         loadmods = LoadModules(config, logger=logger)
         measuremods = MeasurementModules(config, logger=logger)
@@ -394,6 +408,11 @@ if __name__ == '__main__':
         if not os.path.isdir(rtevcfg.workdir):
             raise RuntimeError(f"work directory {rtevcfg.workdir} does not exist")
 
+        # if idle-set has been specified, enable idlestate in rtecfg.cpulist
+        cpupower_controller = None
+        if rtevcfg.cstate:
+            cpupower_controller = cpupower.Cpupower(rtevcfg.cpulist, rtevcfg.cstate)
+            cpupower_controller.enable_idle_state()
 
         rteval = RtEval(config, loadmods, measuremods, logger)
         rteval.Prepare(rtevcfg.onlyload)
@@ -413,6 +432,10 @@ if __name__ == '__main__':
             ec = rteval.Measure()
             logger.log(Log.DEBUG, f"exiting with exit code: {ec}")
 
+        # reset idlestate
+        if rtevcfg.cstate:
+            cpupower_controller.restore_cstate()
+
         sys.exit(ec)
     except KeyboardInterrupt:
         sys.exit(0)
diff --git a/rteval/cpupower.py b/rteval/cpupower.py
new file mode 100644
index 000000000000..00c3789af270
--- /dev/null
+++ b/rteval/cpupower.py
@@ -0,0 +1,91 @@
+#! /user/bin/python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import subprocess
+import argparse
+import os
+import multiprocessing
+import time
+
+
+class Cpupower:
+    def __init__(self, cpulist, cstate):
+        self.cpulist = cpulist
+        self.cstate = cstate
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
+        if int(self.cstate) > self.nstates-1 or self.cstate < 0:
+            print(f'Idle state {self.cstate} is out of range, using POLL')
+            self.cstate = 0
+
+        # enable cstate and disable the rest
+        if (self.cpulist):
+            subprocess.run(['sudo', 'cpupower', '-c', self.cpulist,'idle-set', '-e', str(self.cstate)], stdout=open(os.devnull, 'wb'))
+            for cs in range(self.nstates):
+                if str(cs) != self.cstate:
+                    subprocess.run(['sudo', 'cpupower', '-c', self.cpulist,'idle-set', '-d', str(cs)], stdout=open(os.devnull, 'wb'))
+        else:
+            subprocess.run(['sudo', 'cpupower', 'idle-set', '-e', str(self.cstate)], stdout=open(os.devnull, 'wb'))
+            for cs in range(self.nstates):
+                if str(cs) != self.cstate:
+                    subprocess.run(['sudo', 'cpupower', 'idle-set', '-d', str(cs)], stdout=open(os.devnull, 'wb'))
+
+        if self.cpulist: print(f'Idlestate {self.cstate} enabled on CPUs {self.cpulist}')
+        else: print(f'Idlestate {self.cstate} enabled on all CPUs')
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
+    parser.add_argument('-s', '--cstate', default='',
+                        help='Specify cstate to enable/disable')
+    parser.add_argument('--info', default=False, action='store_true', help='Get idle state information')
+
+    args = parser.parse_args()
+    print(args)
+    cpulist = args.cpu_list
+    cstate = args.cstate
+    if (cstate):
+        cpupower = Cpupower(cpulist, cstate)
+        cpupower.enable_idle_state()
+        time.sleep(10)
+        cpupower.restore_cstate()
+    elif (args.info):
+        Cpupower.get_idle_info()
+
+
-- 
2.45.2

