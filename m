Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494317C9E
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jul 2024 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464355; cv=none; b=Yqv/4N2At/u7JYIULUea5zAn//kJ07zhX72h8Ahew8imH7SnBUFoG8hq7j9JMgcuCjELAL7e6PwZO+4dQNfld+PGvYRKbAgn+NibriOx66Ax4R5FHAQzm+oeURNGOkFLEaVPfyerpAL9qLN92HaVeAb2nkLb4HUZHTBKyulPHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464355; c=relaxed/simple;
	bh=USkGh0IYiSx53OJ0IQFkAmhJvLHM+HX156br5ahMy58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSlY2WCGkhBmPJ0E87b44hA5vFF6yoxSzTFuenYtc4uK3dScnzdGMEQXZpzbnJqJpa2MGw9Xl7eIq1m3NYB73zpbgDGteJd9KHvJtYmix2cDc8/rRrnwtJyKRwpr3n/JwvcPY+MrMq0lplNZ3YaT5yajVHnReDzc9plJx8GruMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPJgQ8Ot; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPJgQ8Ot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720464353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jAdj5nmA1lio4A/LUX1Zr1jwvJt0VIYtUlQS2bnIjGQ=;
	b=MPJgQ8OtX+rTT/zz41D29OdcTwcsTsmtRbPVKUuasY2WWNIa7M7aAEh0Qg1SBy+6ZjoojS
	tWoHlAIq5ooShaYkKccTk849z4yGEu+o0ZJqdqCh3iSSWbKFdFEO0XQwwApRloX2EbxbVq
	qTtvyHFMzqYmrA/csTiLpw7sEX27aUo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-C21uZJn5MHuG_PUH9wI8Xw-1; Mon,
 08 Jul 2024 14:45:51 -0400
X-MC-Unique: C21uZJn5MHuG_PUH9wI8Xw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C75B3195608F
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jul 2024 18:45:50 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.18.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 562B01955F40;
	Mon,  8 Jul 2024 18:45:49 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2] tuna: Add functionality to set the cstate of specified CPUs  when running tuna
Date: Mon,  8 Jul 2024 14:45:40 -0400
Message-ID: <20240708184540.207579-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We would like to be able to set the cstate of CPUs while running tuna.

This patch adds the file cpupower.py and options to tuna-cmd.py.
This allows the user to execute the cpupower command from tuna,
allowing the user to set the cstate on a given list or cpus.
Once tuna exits, the original cstate configuration will be restored.

This will let the user to test balancing power consumption and
performance.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tuna-cmd.py      | 17 +++++++++--
 tuna/cpupower.py | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 3 deletions(-)
 create mode 100644 tuna/cpupower.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index f37e286bffdb..683cf848b9a4 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -21,7 +21,7 @@ from functools import reduce
 import tuna.new_eth as ethtool
 import tuna.tuna_sched as tuna_sched
 import procfs
-from tuna import tuna, sysfs
+from tuna import tuna, sysfs, cpupower
 import logging
 import time
 import shutil
@@ -116,7 +116,10 @@ def gen_parser():
             "disable_perf": dict(action='store_true', help="Explicitly disable usage of perf in GUI for process view"),
             "refresh": dict(default=2500, metavar='MSEC', type=int, help="Refresh the GUI every MSEC milliseconds"),
             "priority": dict(default=(None, None), metavar="POLICY:RTPRIO", type=tuna.get_policy_and_rtprio, help="Set thread scheduler tunables: POLICY and RTPRIO"),
-            "background": dict(action='store_true', help="Run command as background task")
+            "background": dict(action='store_true', help="Run command as background task"),
+            "cstate": dict(dest='cstate', metavar='CSTATE', help='Set cpus in IDLE-LIST to a specific cstate'),
+            "idle_list": dict(dest="idle_list", metavar='IDLE-LIST',
+                              help='CPU list to set idle states on (default: all cpus).')
          }
 
     parser = HelpMessageParser(description="tuna - Application Tuning Program")
@@ -125,6 +128,8 @@ def gen_parser():
     parser.add_argument('-v', '--version', **MODS['version'])
     parser.add_argument('-L', '--logging', **MODS['logging'])
     parser.add_argument('-D', '--debug', **MODS['debug'])
+    parser.add_argument('-i', '--cstate', **MODS['cstate'])
+    parser.add_argument('-l', '--idle-list', **MODS['idle_list'])
 
     subparser = parser.add_subparsers(dest='command')
 
@@ -649,7 +654,6 @@ def main():
     parser = gen_parser()
     # Set all necessary defaults for gui subparser if no arguments provided
     args = parser.parse_args() if len(sys.argv) > 1 else parser.parse_args(['gui'])
-
     if args.debug:
         my_logger = setup_logging("my_logger")
         my_logger.addHandler(add_handler("DEBUG", tofile=False))
@@ -667,6 +671,10 @@ def main():
             print("Valid log levels: NOTSET, DEBUG, INFO, WARNING, ERROR")
             print("Log levels may be specified numerically (0-4)\n")
 
+    if args.cstate:
+        cpupower_controller = cpupower.Cpupower(args.idle_list, args.cstate)
+        cpupower_controller.enable_idle_state()
+
     if 'irq_list' in vars(args):
         ps = procfs.pidstats()
         if tuna.has_threaded_irqs(ps):
@@ -760,6 +768,9 @@ def main():
         except KeyboardInterrupt:
             pass
 
+    if cpupower_controller:
+        cpupower_controller.restore_cstate()
+
 
 if __name__ == '__main__':
     main()
diff --git a/tuna/cpupower.py b/tuna/cpupower.py
new file mode 100644
index 000000000000..abbbe0448a8a
--- /dev/null
+++ b/tuna/cpupower.py
@@ -0,0 +1,79 @@
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
+
+if __name__ == '__main__':
+    parser = argparse.ArgumentParser()
+    parser.add_argument('-c', '--cpu-list', required=False, default=None, 
+                        help='List of cpus to perform cpupower-idle-set operation on.')
+    parser.add_argument('-s', '--cstate', default='',
+                        help='Specify cstate to enable/disable')
+    
+    args = parser.parse_args()
+    print(args)
+    cpulist = args.cpu_list
+    cstate = args.cstate
+    cpupower = Cpupower(cpulist, cstate)
+
+    cpupower.enable_idle_state()
+    time.sleep(10)
+    cpupower.restore_cstate()
+
+
-- 
2.45.2

