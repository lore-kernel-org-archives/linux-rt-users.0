Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159A175D5F
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Aug 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613605; cv=none; b=X0VW9P1tR9KW+HtJYkMnV3n6SNe5N804y5iZwS4mh9VTa3BEXMJDpU9RcHM+XFFUF3C3QPI7UHZmQjJ8Mbyif/QmUNVLjwUOBVPvLARO5PU7+ZgXGznbNqNxZkSI13Ve5I9T9zcWdGpJc+Hm1hBLNKud0Oo8s8cmUvxIOT8xvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613605; c=relaxed/simple;
	bh=ciMZK6cO+vo94rr6kDmNHlH/stUSFIrFXHq9j34nM7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUABRw6jTnaL+b2TJW7k15BBEqACulFt32DppSMoU4ikB4zmQHhMAi4Vml77F0zHZGip3pEgfWBAFwLCHhnE6UwYg6qJkTfMAzo66nc75OpprTdBNfXwwbWUw2f02WEySdEbghXy/TIeHJ95S/vbyjTzyKHJG7a33qjHilZOV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gi1rhdRz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gi1rhdRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722613602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qwp+EFamPoRLkC7Xx6iyNdSiABLocgS9RWpVfaBs9II=;
	b=gi1rhdRzOODsFj75kUI7iwEzjgVxM1pwfI19aNKRpYYRHrXb4W/h/qmv5C7YNZXegRX1IX
	EtHQOrgxeLmUHR4/HO6yJrz8IjYcORzuYWpoPqaaytr96qNpy/l3pMiGwcDnVKxaRyvA88
	hy3/X7tKysuKtrSdbZIKI4SAsemLomA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-kerX0mUHPpKUiC7_UW9t7g-1; Fri,
 02 Aug 2024 11:46:40 -0400
X-MC-Unique: kerX0mUHPpKUiC7_UW9t7g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9FF31944A8C
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Aug 2024 15:46:39 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.64.241])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D23F01955D4C;
	Fri,  2 Aug 2024 15:46:38 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v6 1/2] rteval: Added functionality to allow user to set the cstate of specified cpus when running rteval
Date: Fri,  2 Aug 2024 11:46:35 -0400
Message-ID: <20240802154636.1240064-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 rteval-cmd                             |  11 ++-
 rteval/cpupower.py                     | 125 +++++++++++++++++++++++++
 rteval/modules/__init__.py             |   2 +-
 rteval/modules/measurement/__init__.py |   2 +
 4 files changed, 138 insertions(+), 2 deletions(-)
 create mode 100644 rteval/cpupower.py

diff --git a/rteval-cmd b/rteval-cmd
index 19c82a0b64b3..6e7d8f5d99cb 100755
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
@@ -149,7 +150,7 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("--noload", dest="rteval___noload",
                         action="store_true", default=False,
                         help="only run the measurements (don't run loads)")
-
+
 
     if not cmdargs:
         cmdargs = ["--help"]
@@ -402,6 +403,10 @@ if __name__ == '__main__':
         if not os.path.isdir(rtevcfg.workdir):
             raise RuntimeError(f"work directory {rtevcfg.workdir} does not exist")
 
+        # if idle-set has been specified, enable the idle state via cpupower
+        if msrcfg.idlestate:
+            cpupower_controller = cpupower.Cpupower(msrcfg.cpulist, msrcfg.idlestate, logger=logger)
+            cpupower_controller.enable_idle_state()
 
         rteval = RtEval(config, loadmods, measuremods, logger)
         rteval.Prepare(rtevcfg.onlyload)
@@ -421,6 +426,10 @@ if __name__ == '__main__':
             ec = rteval.Measure()
             logger.log(Log.DEBUG, f"exiting with exit code: {ec}")
 
+        # restore previous idle state settings
+        if msrcfg.idlestate:
+            cpupower_controller.restore_idle_states()
+
         sys.exit(ec)
     except KeyboardInterrupt:
         sys.exit(0)
diff --git a/rteval/cpupower.py b/rteval/cpupower.py
new file mode 100644
index 000000000000..37c4d33f1df4
--- /dev/null
+++ b/rteval/cpupower.py
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Copyright 2024    Anubhav Shelat <ashelat@redhat.com>
+""" Object to execute cpupower tool """
+
+import subprocess
+import os
+import shutil
+import sys
+from rteval.Log import Log
+from rteval.systopology import SysTopology as SysTop
+from rteval import cpulist_utils
+
+PATH = '/sys/devices/system/cpu/'
+
+class Cpupower:
+    """ class to store data for executing cpupower and restoring idle state configuration """
+    def __init__(self, cpulist, idlestate, logger=None):
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
+        self.__name = "cpupower"
+        self.__online_cpus = SysTop().online_cpus()
+        self.__cpulist = cpulist
+        self.__logger = logger
+
+
+    def _log(self, logtype, msg):
+        """ Common log function for rteval modules """
+        if self.__logger:
+            self.__logger.log(logtype, f"[{self.__name}] {msg}")
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
+        self._log(Log.DEBUG, f'Idle state depth {self.__idle_state} enabled on CPUs {self.__cpulist}')
+
+
+    def run_cpupower(self, args, output_buffer=None):
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
+        for cpu in self.__online_cpus:
+            self.__idle_states[cpu] = {}
+            for state in self.__states:
+                fp = os.path.join(PATH, 'cpu' + str(cpu) + '/cpuidle/' + state + '/disable')
+                self.__idle_states[cpu][state] = self.read_idle_state(fp)
+
+
+    def restore_idle_states(self):
+        """ restore the idle state setting """
+        for cpu, states in self.__idle_states.items():
+            for state, disabled in states.items():
+                fp = os.path.join(PATH, 'cpu' + str(cpu) + '/cpuidle/' + state + '/disable')
+                self.write_idle_state(fp, disabled)
+        self._log(Log.DEBUG, 'Idle state settings restored')
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
+    def get_idle_info(self):
+        """ execute cpupower idle-info """
+        self.run_cpupower(['cpupower', 'idle-info'])
+
+
+    def cpupower_present(self):
+        """ check if cpupower is downloaded """
+        return shutil.which("cpupower") is not None
+
+
+if __name__ == '__main__':
+    l = Log()
+    l.SetLogVerbosity(Log.DEBUG)
+
+    online_cpus = cpulist_utils.collapse_cpulist(SysTop().online_cpus())
+    idlestate = '1'
+    info = True
+
+    cpupower = Cpupower(online_cpus, idlestate, logger=l)
+    if idlestate:
+        cpupower.enable_idle_state()
+        cpupower.restore_idle_states()
+    print()
+    cpupower.get_idle_info()
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index d7792108d5b8..acd6330788e2 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -282,7 +282,7 @@ reference from the first import"""
         grparser.add_argument(f'--{self.__modtype}-cpulist',
                             dest=f'{self.__modtype}___cpulist', action='store', default="",
                             help=f'CPU list where {self.__modtype} modules will run',
-                            metavar='LIST')
+                            metavar='CPULIST')
 
         for (modname, mod) in list(self.__modsloaded.items()):
             opts = mod.ModuleParameters()
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index ecadd0885991..9314d1cb6bbc 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -38,6 +38,8 @@ class MeasurementModules(RtEvalModules):
                               default=self._cfg.GetSection("measurement").setdefault("run-on-isolcpus", "false").lower()
                                       == "true",
                               help="Include isolated CPUs in default cpulist")
+        grparser.add_argument('--idle-set', dest='measurement___idlestate', metavar='IDLESTATE',
+                        default=None, help='Idle state depth to set on cpus running measurement modules')
 
 
     def Setup(self, modparams):
-- 
2.45.2

