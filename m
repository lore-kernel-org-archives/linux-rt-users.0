Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871B154670
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Jul 2024 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067560; cv=none; b=U0icw1k961Qo9XirCF31R/i+kK+kK8oA9MxuNkjVWGayem+QgAAGS/08im6fAmjQSvmGjptVPCqKJ/R2vYDF91wzmlosHB+OO27i5XIaYVvvruZnoX6FAh01PZ8hKlKXXt7QSz5Iz6ZQZ1QFLebmJvmaZUaWT5La6F4V+cDv9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067560; c=relaxed/simple;
	bh=xjgDr9qIR8iQjGDtO9RabCCdZ+LsmpQcQV1LTBUAohc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcyZtXe4iH3eiHBqaHJRKJVaat88TzkgEgXqS9ZPz2t2P3AsdPPsPRK3enzxjw3pr/OVPfBkkfggTq8KIhLejjnCuRnxiGiIhMC6kEyCy7tGuFNf4S7kMTehyV2srhmxdM1xQxABYU/XmEwQ5JnuUUvJzwSabZVKranxu0NArqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q94kTQMA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q94kTQMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721067557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZhLShELRHH8hC106lENh9F9FDB7kQnfv77qJHx72Zzs=;
	b=Q94kTQMAGWz7ywWss9s+IrLPH6WPbHwnvXMWydAkFzGVYKf1fhUTwY+wy/ejnRhUl0we2x
	JUL+0pSeNi/9/8cLlW2621Zq6r2fICM3IwyRcfivPeGzV6xTzPOTs4F5CBwnkwDLCvS+HY
	136nJq+H8yRPPAFFTXSXLoLB8bNDQds=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-nFX7dztYM8u9NNlcOhAXEw-1; Mon,
 15 Jul 2024 14:19:13 -0400
X-MC-Unique: nFX7dztYM8u9NNlcOhAXEw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02AE71955F41
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Jul 2024 18:19:13 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.64.144])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64F471955D42;
	Mon, 15 Jul 2024 18:19:11 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 1/2] rteval: Added functionality to allow user to set the cstate of specified cpus when running rteval
Date: Mon, 15 Jul 2024 14:15:24 -0400
Message-ID: <20240715181524.188573-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We would like to be able to set the cstates of CPUs while running
rteval.

This patch adds the file cpupower.py and options '--idle-set' and '--cpulist'
within rteval to use cpupower.

cpupower.py provides the infrastructure to interface with the cpupower
command, and the options in rteval-cmd let the user specify the cstate to be set
and the CPUs to set it on.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd         | 16 ++++++++-
 rteval/cpupower.py | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 rteval/cpupower.py

diff --git a/rteval-cmd b/rteval-cmd
index 5cb6d7a44523..d9bf16838b6d 100755
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
@@ -394,6 +399,11 @@ if __name__ == '__main__':
         if not os.path.isdir(rtevcfg.workdir):
             raise RuntimeError(f"work directory {rtevcfg.workdir} does not exist")
 
+        # if idle-set has been specified, enable idlestate in rtecfg.cpulist
+        cpupower_controller = None
+        if rtevcfg.cstate:
+            cpupower_controller = cpupower.Cpupower(rtevcfg.cpulist, rtevcfg.cstate)
+            cpupower_controller.enable_idle_state()
 
         rteval = RtEval(config, loadmods, measuremods, logger)
         rteval.Prepare(rtevcfg.onlyload)
@@ -413,6 +423,10 @@ if __name__ == '__main__':
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
index 000000000000..da869420eb6f
--- /dev/null
+++ b/rteval/cpupower.py
@@ -0,0 +1,85 @@
+#! /user/bin/python3
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

