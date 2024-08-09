Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95F1DFE1
	for <linux-rt-users@vger.kernel.org>; Fri,  9 Aug 2024 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214660; cv=none; b=M4Cu0JilRnL1LUjI5vo8MncK+bPKnZs6mJ5K5bvVFf5MU25//SqRiiOCzhTYRDS9lCiS0iSJqB554bdu+531gc4DQ/m1XGY8Ue6hXkdam/eTx+XsHTJaBtZ6Qv7B25Kd682pOZ/89xQyE5mSI5n9xNFbOqroNfh9Ve5kmhFF+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214660; c=relaxed/simple;
	bh=iUhDTWCHKIIt6yBMeiQ8C+xginNVylcWXbQ7aMxzABc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aiThMuToqP/C5a6lfve7r8TWVOI89kA6kLYXq3GidvzWRcLyolHLb7gSQHxFXbpvEAEGpFufIGxLPot3Mob1kYE75+offgCKZW7vbjyGnofjwkhjbdLmq2XHqqIeWy5km7etkAi7/frFkWkRe17XNms26hUjK5RKLkzlgyAz4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arJefbm2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arJefbm2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723214657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xPZ3MpYaKMBmxONlYDobM0v76TpZKgEGudv0MQyo8u0=;
	b=arJefbm2rLoqcbmGpkoHMzRUVpdWBamReyyY5GfbagYhdurbJMVpCjxlVZs0GHg8dYnGg4
	GTJBXUdxaa89slkiNwSXjCyrGxuGawrICnsWxFXYV+mwKu8UVj/oG4qu04AAKpW3KinnEo
	q2WwkNVUjZaTNxSaQpVPsoB0WGhMgeM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-D4TA3c5YM962MW3-d0yYfA-1; Fri,
 09 Aug 2024 10:44:15 -0400
X-MC-Unique: D4TA3c5YM962MW3-d0yYfA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1A1D1955D5B
	for <linux-rt-users@vger.kernel.org>; Fri,  9 Aug 2024 14:44:14 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.33.142])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69C381955F40;
	Fri,  9 Aug 2024 14:44:13 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] tuna: Add functionality to set the idle state of specified CPUs when running tuna
Date: Fri,  9 Aug 2024 10:43:57 -0400
Message-ID: <20240809144356.2729930-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We would like to be able to set the idle state of CPUs while running tuna.

This patch adds the file cpupower.py and idle-set subcommand to tuna-cmd.py.
cpupower.py provides the infrastructure to interface with the cpupower
command, and the idle-set subcommand in tuna-cmd.py lets the user specify
the idle state depth to be set and the cpu list to set it on, or to display
information about idle states.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tuna-cmd.py      |  35 +++++++++++++-
 tuna/cpupower.py | 120 +++++++++++++++++++++++++++++++++++++++++++++++
 tuna/tuna.py     |   2 +
 3 files changed, 155 insertions(+), 2 deletions(-)
 create mode 100644 tuna/cpupower.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index f37e286bffdb..090aff0cb972 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -22,9 +22,11 @@ import tuna.new_eth as ethtool
 import tuna.tuna_sched as tuna_sched
 import procfs
 from tuna import tuna, sysfs
+from tuna.cpupower import Cpupower
 import logging
 import time
 import shutil
+from multiprocessing import cpu_count
 
 def get_loglevel(level):
     if level.isdigit() and int(level) in range(0,5):
@@ -116,7 +118,12 @@ def gen_parser():
             "disable_perf": dict(action='store_true', help="Explicitly disable usage of perf in GUI for process view"),
             "refresh": dict(default=2500, metavar='MSEC', type=int, help="Refresh the GUI every MSEC milliseconds"),
             "priority": dict(default=(None, None), metavar="POLICY:RTPRIO", type=tuna.get_policy_and_rtprio, help="Set thread scheduler tunables: POLICY and RTPRIO"),
-            "background": dict(action='store_true', help="Run command as background task")
+            "background": dict(action='store_true', help="Run command as background task"),
+            "idle_state": dict(dest='idle_state', metavar='IDLESTATE', help='Set cpus in CPU-LIST to an idle state depth. If CPU-LIST is not specified, default to all cpus.'),
+            "all_idlestates": dict(dest='all_idlestates', action='store_true', default=False,
+                                   help='Enable all idle states on CPU-LIST.'),
+            "info": dict(dest='info', default=False, action='store_true',
+                          help='Display information about available CPU idle states.'),
          }
 
     parser = HelpMessageParser(description="tuna - Application Tuning Program")
@@ -147,6 +154,8 @@ def gen_parser():
     show_threads = subparser.add_parser('show_threads', description='Show thread list', help='Show thread list')
     show_irqs = subparser.add_parser('show_irqs', description='Show IRQ list', help='Show IRQ list')
     show_configs = subparser.add_parser('show_configs', description='List preloaded profiles', help='List preloaded profiles')
+    idle_set = subparser.add_parser('idle-set', description='Set all idle states, up to and including the given idle state, on a given CPU list.',
+                                    help='Set all idle states, up to and including the given idle state, on CPU-LIST.')
 
     what_is = subparser.add_parser('what_is', description='Provides help about selected entities', help='Provides help about selected entities')
     gui = subparser.add_parser('gui', description="Start the GUI", help="Start the GUI")
@@ -219,6 +228,12 @@ def gen_parser():
     show_irqs_group.add_argument('-S', '--sockets', **MODS['sockets'])
     show_irqs.add_argument('-q', '--irqs', **MODS['irqs'])
 
+    idle_set_group = idle_set.add_mutually_exclusive_group(required=True)
+    idle_set.add_argument('-c', '--cpus', **MODS['cpus'])
+    idle_set_group.add_argument('-i', '--state', **MODS['idle_state'])
+    idle_set_group.add_argument('-E', '--enable-all', **MODS['all_idlestates'])
+    idle_set_group.add_argument('--info', **MODS['info'])
+
     what_is.add_argument('thread_list', **POS['thread_list'])
 
     gui.add_argument('-d', '--disable_perf', **MODS['disable_perf'])
@@ -649,7 +664,6 @@ def main():
     parser = gen_parser()
     # Set all necessary defaults for gui subparser if no arguments provided
     args = parser.parse_args() if len(sys.argv) > 1 else parser.parse_args(['gui'])
-
     if args.debug:
         my_logger = setup_logging("my_logger")
         my_logger.addHandler(add_handler("DEBUG", tofile=False))
@@ -667,6 +681,23 @@ def main():
             print("Valid log levels: NOTSET, DEBUG, INFO, WARNING, ERROR")
             print("Log levels may be specified numerically (0-4)\n")
 
+    if args.command == 'idle-set':
+        if args.cpu_list and args.info:
+            print("Error: must specify idle state with -i/--state or -E/--enable-all when using -c/--cpus.")
+            sys.exit(1)
+
+        if args.info:
+            Cpupower.get_idle_info()
+        elif args.idle_state or args.all_idlestates:
+            if args.cpu_list == [] or args.cpu_list == ['all']:
+                args.cpu_list = list(range(cpu_count()))
+            cpulist = tuna.list_to_cpustring(args.cpu_list)
+
+            if args.idle_state:
+                Cpupower(cpulist, args.idle_state).enable_idle_state()
+            elif args.all_idlestates:
+                Cpupower(cpulist, 0).enable_all_idle_states()
+
     if 'irq_list' in vars(args):
         ps = procfs.pidstats()
         if tuna.has_threaded_irqs(ps):
diff --git a/tuna/cpupower.py b/tuna/cpupower.py
new file mode 100644
index 000000000000..b778bb4af852
--- /dev/null
+++ b/tuna/cpupower.py
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Copyright 2024    Anubhav Shelat <ashelat@redhat.com>
+""" Object to execute cpupower tool """
+
+import subprocess
+import os
+import shutil
+import sys
+from multiprocessing import cpu_count
+
+PATH = '/sys/devices/system/cpu/'
+
+class Cpupower:
+    """ class to store data for executing cpupower and restoring idle state configuration """
+    def __init__(self, cpulist, idlestate):
+        if not self.cpupower_present():
+            print('cpupower not found')
+            sys.exit(1)
+
+        self.__idle_state = int(idlestate)
+        self.__states = os.listdir(PATH + 'cpu0/cpuidle/')
+        # self.__idle_states is a dict with cpus as keys,
+        # and another dict as the value. The value dict
+        # has idle states as keys and a boolean as the
+        # value indicating if the state is disabled.
+        self.__idle_states = {}
+        self.__all_cpus = list(range(cpu_count()))
+        self.__cpulist = cpulist
+
+
+    def enable_idle_state(self):
+        """ Use cpupower to set the idle state """
+        self.get_idle_states()
+
+        # ensure that idle state is in range of available idle states
+        if self.__idle_state > len(self.__states) - 1 or self.__idle_state < 0:
+            print(f'Idle state {self.__idle_state} is out of range')
+            sys.exit(1)
+
+        # enable all idle states to a certain depth, and disable any deeper idle states
+        with open(os.devnull, 'wb') as buffer:
+            for state in self.__states:
+                s = state.strip("state")
+                if int(s) > self.__idle_state:
+                    self.run_cpupower(['cpupower', '-c', self.__cpulist,'idle-set', '-d', s], buffer)
+                else:
+                    self.run_cpupower(['cpupower', '-c', self.__cpulist,'idle-set', '-e', s], buffer)
+
+
+    def enable_all_idle_states(self):
+        """ Enable maximum idle state depth on cpulist """
+        self.get_idle_states()
+        with open(os.devnull, 'wb') as buffer:
+            for state in self.__states:
+                s = state.strip("state")
+                self.run_cpupower(['cpupower', '-c', self.__cpulist,'idle-set', '-e', s], buffer)
+
+
+    def restore_idle_states(self):
+        """ restore the idle state setting """
+        for cpu, states in self.__idle_states.items():
+            for state, disabled in states.items():
+                fp = os.path.join(PATH, 'cpu' + str(cpu) + '/cpuidle/' + state + '/disable')
+                self.write_idle_state(fp, disabled)
+
+
+    @classmethod
+    def get_idle_info(cls):
+        """ execute cpupower idle-info """
+        cls.run_cpupower(['cpupower', 'idle-info'])
+
+
+    @staticmethod
+    def run_cpupower(args, output_buffer=None):
+        """ execute cpupower """
+        try:
+            subprocess.run(args, check=True, stdout=output_buffer)
+        except subprocess.CalledProcessError:
+            print('cpupower failed')
+            sys.exit(1)
+
+
+    def get_idle_states(self):
+        """ Store the current idle state setting """
+        for cpu in self.__all_cpus:
+            self.__idle_states[cpu] = {}
+            for state in self.__states:
+                fp = os.path.join(PATH, 'cpu' + str(cpu) + '/cpuidle/' + state + '/disable')
+                self.__idle_states[cpu][state] = self.read_idle_state(fp)
+
+
+    def read_idle_state(self, file):
+        """ read the disable value for an idle state """
+        with open(file, 'r', encoding='utf-8') as f:
+            return f.read(1)
+
+
+    def write_idle_state(self, file, state):
+        """ write the disable value for and idle state """
+        with open(file, 'w', encoding='utf-8') as f:
+            f.write(state)
+
+
+    def cpupower_present(self):
+        """ check if cpupower is downloaded """
+        return shutil.which("cpupower") is not None
+
+
+if __name__ == '__main__':
+    cpulist = str(list(range(cpu_count()))).strip('[]').replace(' ', '')
+    idlestate = '1'
+    info = True
+
+    cpupower = Cpupower(cpulist, idlestate)
+    if idlestate:
+        cpupower.enable_idle_state()
+        cpupower.restore_idle_states()
+    print()
+    cpupower.get_idle_info()
diff --git a/tuna/tuna.py b/tuna/tuna.py
index bd678e2dc7ae..52e4c3ec356d 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -122,6 +122,8 @@ def cpustring_to_list(cpustr):
     Returns a list of integers."""
 
     fields = cpustr.strip().split(",")
+    if fields == ['all']:
+        return fields
     cpu_list = []
     for field in fields:
         ends = [int(a, 0) for a in field.split("-")]
-- 
2.45.2

