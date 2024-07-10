Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B01974FA
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Jul 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638878; cv=none; b=BhNZnjaeidcAEpPgS+KsBQHuPIpxOdku0+QBN1yrp1pFu1NlEHRA7XxxeTyS5qhUiYSJqHh85J7K2up/ZptPirJWsehfz2s+6w94mbVkCu5jFh1xlmtoZIijZpXi+izSoUwOlaTsuD8yT6yHpb1S+1sXSMwm3aQXIo+RW+JnEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638878; c=relaxed/simple;
	bh=ZCo31V163GtswZ6dpFe7g87wfiVLuAKgKXUsSZyGu3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IS577zI9dTeeuAbN3oz7KOMeevkX5HXQqJ7+XfZHhK9bKlxWGP8tbPE+vauHobjyGaIoEa8hzxnc3ATqtGXo64XoCxA/8D3EEQvmoMoiB6ShLoTsWC+8hr00GwC86V2Khk1QPjzqO+nd5xBnOiUm83qAXqtUKbQLDdAO00Sa9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpWldCXF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpWldCXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720638875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GenyUG4WGoJzFPh+kl1VoQjdVWr8O2znE33SIbBnDPM=;
	b=hpWldCXFvlw4fg+2+2+ep6ElqLu78UWa/eXHptSX/JxPIz954x5XElkhak+/hm3e2+iAGQ
	TBqMKBYw7pY38I3Ta1UzP5TtSlN+FeuGxHE2MkC9Vjt0q4pIrQfsUiEeXU3HVHMUOXqfyY
	oKMwn7KXkKhPI9JvzbDy8Y1Om7pDb+o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-_-MIJb8qMX-zpZgXs5t_zg-1; Wed,
 10 Jul 2024 15:14:34 -0400
X-MC-Unique: _-MIJb8qMX-zpZgXs5t_zg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 413BC19560B3
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Jul 2024 19:14:33 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.64.33])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 322941956046;
	Wed, 10 Jul 2024 19:14:32 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v3] tuna: Add functionality to set the cstate of specified CPUs  when running tuna
Date: Wed, 10 Jul 2024 15:14:25 -0400
Message-ID: <20240710191424.15972-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We would like to be able to set the cstate of CPUs while running tuna.

This patch adds the file cpupower.py and cstate subcommand to tuna-cmd.py.
cpupower.py provides the infrastructure to interface with the cpupower
command, and the cstate subcommand in tuna-cmd.py lets the user specify
the cstate to be set and the cpu list to set it on.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tuna-cmd.py      | 14 +++++++--
 tuna/cpupower.py | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 3 deletions(-)
 create mode 100644 tuna/cpupower.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index f37e286bffdb..c6ef8bae09a3 100755
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
@@ -116,7 +116,8 @@ def gen_parser():
             "disable_perf": dict(action='store_true', help="Explicitly disable usage of perf in GUI for process view"),
             "refresh": dict(default=2500, metavar='MSEC', type=int, help="Refresh the GUI every MSEC milliseconds"),
             "priority": dict(default=(None, None), metavar="POLICY:RTPRIO", type=tuna.get_policy_and_rtprio, help="Set thread scheduler tunables: POLICY and RTPRIO"),
-            "background": dict(action='store_true', help="Run command as background task")
+            "background": dict(action='store_true', help="Run command as background task"),
+            "cstate": dict(dest='cstate', metavar='CSTATE', help='Set cpus in IDLE-LIST to a specific cstate'),
          }
 
     parser = HelpMessageParser(description="tuna - Application Tuning Program")
@@ -147,6 +148,7 @@ def gen_parser():
     show_threads = subparser.add_parser('show_threads', description='Show thread list', help='Show thread list')
     show_irqs = subparser.add_parser('show_irqs', description='Show IRQ list', help='Show IRQ list')
     show_configs = subparser.add_parser('show_configs', description='List preloaded profiles', help='List preloaded profiles')
+    cstate = subparser.add_parser('cstate', description='Set a cstate on a given CPU list.', help='Set a cstate on a given CPU list.')
 
     what_is = subparser.add_parser('what_is', description='Provides help about selected entities', help='Provides help about selected entities')
     gui = subparser.add_parser('gui', description="Start the GUI", help="Start the GUI")
@@ -219,6 +221,9 @@ def gen_parser():
     show_irqs_group.add_argument('-S', '--sockets', **MODS['sockets'])
     show_irqs.add_argument('-q', '--irqs', **MODS['irqs'])
 
+    cstate.add_argument('-c', '--cpus', **MODS['cpus'])
+    cstate.add_argument('-i', '--cstate', **MODS['cstate'])
+
     what_is.add_argument('thread_list', **POS['thread_list'])
 
     gui.add_argument('-d', '--disable_perf', **MODS['disable_perf'])
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
+        cpupower_controller = cpupower.Cpupower(str(args.cpu_list).strip('[]').replace(' ', ''), args.cstate)
+        cpupower_controller.enable_idle_state()
+
     if 'irq_list' in vars(args):
         ps = procfs.pidstats()
         if tuna.has_threaded_irqs(ps):
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

