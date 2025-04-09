Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C271E5202
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Apr 2025 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227110; cv=none; b=YS1+q25/DjKd91tmI5MFhZenisLEVf32n8oucCF5kBfUqm/4Adb67JXJUP+gCjhagoDsGjsBZh31MlnpCusnYo27qFsSFGM8eH8eY6KSp6ZDtjNfFqBRJD0bIMEKX1M97q6d1Jsh4Whmb30eOtqeqtM7pVYHPmOmZ2wLujZYdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227110; c=relaxed/simple;
	bh=7bP5FwgTmGHhFWQNGa8fRFCueEUjW0vw4/7QKdaeWOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7waOSabd7WYwmFyzvVJVyyA9YyMY3OCFUISudUK3feNW88doSZTgUuc53jKenUXpfrTaKBt3TdIqCWiorBSlYTr54C0bkA0PYsJ467epv497+mKuZwf6Q8Ain+6wZCt/JJCitZO5FDScMqvJayEzXRrRIhakNGfRLmb8RjAUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlJUwxSi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlJUwxSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744227106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijS93QQYWRSAkwN52KEGBurxKSvytMWN4Imru6jLWKE=;
	b=MlJUwxSibsKR34JiFZnulMtzPqGFPhz3+aOcxY7EKB7oCBmTdxBOUvN0c8ntjL9N8nfl2T
	jBN7K1YJHO/7zUqsSG0mcXGFqYXP+sQsWdEPZ7WYFl5MQaBU0vTMLujKRO8RbXms9v4bh6
	xfAFBZhn8r5M+vu5a9ST3zbrMgOQJ7E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-57RP-jbtP-SL2RW7H7ijeg-1; Wed, 09 Apr 2025 15:31:45 -0400
X-MC-Unique: 57RP-jbtP-SL2RW7H7ijeg-1
X-Mimecast-MFC-AGG-ID: 57RP-jbtP-SL2RW7H7ijeg_1744227104
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e91d8a7183so133995886d6.0
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Apr 2025 12:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744227104; x=1744831904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijS93QQYWRSAkwN52KEGBurxKSvytMWN4Imru6jLWKE=;
        b=lO1aQVmNqBlqSL6LgyVpqVC/VQBVHKFQ+dqN4Pf7oYNPsAiHrP+uBR9lnzwJtE9xFl
         iYhLPDbjj+ZPql4One+duN5QPC60AB5fnVEmS7lgpjxgUzAg65bYfmjV8I64DM93RdeQ
         5f9vLnjjCO5dj70k9odAd49lVYKeP+Uw++7eZrTzQlNVtOZwgypOWuIzcU9lACnDJG8Z
         0SfpykymH41EITQDb2L/Q8N44NWNLWvCUKuz76sLIOT+br20kPPBOu4pxZGF+KVCcu4L
         jTH9sEb/CG0wAfIkldGWLMN9bqyhg+X7JD0Nf0iLafIldgarkmVHfG9fclINvm+q+eSQ
         N6aw==
X-Forwarded-Encrypted: i=1; AJvYcCUda1GL7AxlywEwithrQbL9/aIHn3eokiF83m7oNTohY/hrl5gB6ZRaeFzA1szgTVNJhoPgHS/IeceeZvgXog==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPu5jk1+yaSMIY0Bi7oCoeke/DiVPXUDInUScDbgX3N1puEQN
	WhbyqAx9TWwT4BDbSCAWqRYBC+KZfRnIB7edPm2GHOpNJZ92f9bEcqhQ9ChppcGgih4lKIzPoAX
	ZWC6bCzi6YTPqgS+UJhJHKfb49L/tQldQG+ZTQTdFoR6Epx7uV4ElbUuKbLCd/znM
X-Gm-Gg: ASbGncsh6vg11kw1JMuScIiMyzYwGvDU+LNI9yDkKpecSyCFOugjCEk+Rns1wJtJb41
	qDX6aIkkB8sFFO61WmzMrAnaBTgu0cC8oDIDsV7ZPw0mpUQx0V819kSsrYltc7vn7GQ1HvHc+XM
	Qe+cRZBIiIAQBfYe0SQQoBWn3SeTsWJFWyTxsm2AeAs96Xt7qOpv8hF3Sn7eYEP8VkMkZy7/KT6
	90UqtwjfpEfuonNCQ1umRE8Sux+ola8AlSxBr+yLNVQ+1RZdd037YmO0I0m5dJjZfcQhB+Gxaas
	H26ckTxWrg==
X-Received: by 2002:a05:6214:5289:b0:6e8:97f6:3229 with SMTP id 6a1803df08f44-6f0e5a9a3a1mr3458636d6.16.1744227104514;
        Wed, 09 Apr 2025 12:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtUdfdMKCbMiU3nC4/tPv5jl2AK18JLQeewW0QgtczI3KZShKEiZr/ZEXpPH1vCxKPSjW54w==
X-Received: by 2002:a05:6214:5289:b0:6e8:97f6:3229 with SMTP id 6a1803df08f44-6f0e5a9a3a1mr3458296d6.16.1744227104188;
        Wed, 09 Apr 2025 12:31:44 -0700 (PDT)
Received: from thinkpad2024.. ([71.217.69.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea08028sm10808586d6.90.2025.04.09.12.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:31:43 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v5 2/2] tuna: Add idle_state control functionality
Date: Wed,  9 Apr 2025 15:31:33 -0400
Message-ID: <20250409193136.44411-3-jwyatt@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409193136.44411-1-jwyatt@redhat.com>
References: <20250409193136.44411-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows Tuna to control cpu idle-state functionality on the system,
including querying, enabling, disabling of cpu idle-states to control
power usage or to test functionality.

This requires cpupower, a utility in the Linux kernel repository and
the cpupower Python bindings added in Linux 6.12 to control cpu
idle-states.

This patch revision includes text snippet & Python suggestions by Crystal
Wood (v2-4) and small Python suggestions & code snippets by John Kacur
(v3-5).

Suggested-by: John Kacur <jkacur@redhat.com>

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tuna-cmd.py      |  30 +++++++-
 tuna/cpupower.py | 177 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+), 3 deletions(-)
 create mode 100755 tuna/cpupower.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index d0323f5..4997eaa 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -25,6 +25,7 @@ from tuna import tuna, sysfs, utils
 import logging
 import time
 import shutil
+import tuna.cpupower as cpw
 
 def get_loglevel(level):
     if level.isdigit() and int(level) in range(0,5):
@@ -115,8 +116,12 @@ def gen_parser():
             "disable_perf": dict(action='store_true', help="Explicitly disable usage of perf in GUI for process view"),
             "refresh": dict(default=2500, metavar='MSEC', type=int, help="Refresh the GUI every MSEC milliseconds"),
             "priority": dict(default=(None, None), metavar="POLICY:RTPRIO", type=tuna.get_policy_and_rtprio, help="Set thread scheduler tunables: POLICY and RTPRIO"),
-            "background": dict(action='store_true', help="Run command as background task")
-         }
+            "background": dict(action='store_true', help="Run command as background task"),
+            "idle_info": dict(dest='idle_info', action='store_const', const=True, help='Print general idle information for the selected CPUs, including index values for IDLE-STATE.'),
+            "idle_state_disabled_status": dict(dest='idle_state_disabled_status', metavar='IDLE-STATE', type=int, help='Print whether IDLE-STATE is enabled on the selected CPUs.'),
+            "disable_idle_state": dict(dest='disable_idle_state', metavar='IDLE-STATE', type=int, help='Disable IDLE-STATE on the selected CPUs.'),
+            "enable_idle_state": dict(dest='enable_idle_state', metavar='IDLE-STATE', type=int, help='Enable IDLE-STATE on the selected CPUs.')
+    }
 
     parser = HelpMessageParser(description="tuna - Application Tuning Program")
 
@@ -127,6 +132,9 @@ def gen_parser():
 
     subparser = parser.add_subparsers(dest='command')
 
+    idle_set = subparser.add_parser('cpu_power',
+                                    description='Manage CPU idle state disabling (requires libcpupower and it\'s Python bindings)',
+                                    help='Set all idle states on a given CPU-LIST.')
     isolate = subparser.add_parser('isolate', description="Move all allowed threads and IRQs away from CPU-LIST",
                                     help="Move all allowed threads and IRQs away from CPU-LIST")
     include = subparser.add_parser('include', description="Allow all threads to run on CPU-LIST",
@@ -146,7 +154,6 @@ def gen_parser():
     show_threads = subparser.add_parser('show_threads', description='Show thread list', help='Show thread list')
     show_irqs = subparser.add_parser('show_irqs', description='Show IRQ list', help='Show IRQ list')
     show_configs = subparser.add_parser('show_configs', description='List preloaded profiles', help='List preloaded profiles')
-
     what_is = subparser.add_parser('what_is', description='Provides help about selected entities', help='Provides help about selected entities')
     gui = subparser.add_parser('gui', description="Start the GUI", help="Start the GUI")
 
@@ -218,6 +225,13 @@ def gen_parser():
     show_irqs_group.add_argument('-S', '--sockets', **MODS['sockets'])
     show_irqs.add_argument('-q', '--irqs', **MODS['irqs'])
 
+    idle_set_group = idle_set.add_mutually_exclusive_group(required=True)
+    idle_set_group.add_argument('-i', '--idle-info', **MODS['idle_info'])
+    idle_set_group.add_argument('-s', '--status', **MODS['idle_state_disabled_status'])
+    idle_set_group.add_argument('-d', '--disable', **MODS['disable_idle_state'])
+    idle_set_group.add_argument('-e', '--enable', **MODS['enable_idle_state'])
+    idle_set.add_argument('-c', '--cpus', **MODS['cpus'])
+
     what_is.add_argument('thread_list', **POS['thread_list'])
 
     gui.add_argument('-d', '--disable_perf', **MODS['disable_perf'])
@@ -647,6 +661,16 @@ def main():
             print("Valid log levels: NOTSET, DEBUG, INFO, WARNING, ERROR")
             print("Log levels may be specified numerically (0-4)\n")
 
+    if args.command == 'cpu_power':
+        if not cpw.have_cpupower:
+            print(f"Error: libcpupower bindings are not detected; please install libcpupower bindings from at least kernel {cpw.cpupower_required_kernel}.", file=sys.stderr)
+            sys.exit(1)
+
+        my_cpupower = cpw.Cpupower(args.cpu_list)
+        ret = my_cpupower.idle_set_handler(args)
+        if ret > 0:
+            sys.exit(ret)
+
     if 'irq_list' in vars(args):
         ps = procfs.pidstats()
         if tuna.has_threaded_irqs(ps):
diff --git a/tuna/cpupower.py b/tuna/cpupower.py
new file mode 100755
index 0000000..9a80f8e
--- /dev/null
+++ b/tuna/cpupower.py
@@ -0,0 +1,177 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2025 John B. Wyatt IV
+
+import sys
+from typing import List
+from tuna import utils
+
+cpupower_required_kernel = "6.12"
+have_cpupower = None
+
+try:
+    import raw_pylibcpupower as lcpw
+    lcpw.cpufreq_get_available_frequencies(0)
+    have_cpupower = True
+except ImportError:
+    lcpw = None
+    have_cpupower = False
+
+if have_cpupower:
+    class Cpupower:
+        """The Cpupower class allows you to query and change the power states of the
+        cpu.
+
+        You may query or change the cpus all at once or a list of the cpus provided to the constructor's cpulist argument.
+
+        The bindings must be detected on the $PYTHONPATH variable.
+
+        You must use have_cpupower variable to determine if the bindings were
+        detected in your code."""
+
+        LCPW_ERROR_TWO_CASE = 1 # enum for common error messages
+        LCPW_ERROR_THREE_CASE = 2
+
+        def __init__(self, cpu_list=None):
+            if cpu_list and not cpu_list == []:
+                self.__cpu_list = cpu_list
+            else:
+                self.__cpu_list = utils.get_all_cpu_list()
+
+        def handle_common_lcpw_errors(self, e, error_type, idle_name):
+            match e:
+                case 0:
+                    pass
+                case -1:
+                    print(f"Idlestate {idle_name} not available", file=sys.stderr)
+                case -2:
+                    print("Disabling is not supported by the kernel", file=sys.stderr)
+                case -3:
+                    if error_type == Cpupower.LCPW_ERROR_THREE_CASE:
+                        print("No write access to disable/enable C-states: try using sudo", file=sys.stderr)
+                    else:
+                        print(f"Not documented: {e}", file=sys.stderr)
+                case _:
+                    print(f"Not documented: {e}", file=sys.stderr)
+
+        def get_idle_states(self, cpu):
+            """
+            Get the c-states of a cpu.
+
+            You can capture the return values with:
+            states_list, states_amt = get_idle_states()
+
+            Returns
+                List[String]: list of cstates
+                Int: amt of cstates
+            """
+            ret = []
+            for cstate in range(lcpw.cpuidle_state_count(cpu)):
+                ret.append(lcpw.cpuidle_state_name(cpu,cstate))
+            return ret, lcpw.cpuidle_state_count(cpu)
+
+        def get_idle_info(self, cpu):
+            idle_states, idle_states_amt = self.get_idle_states(cpu)
+            idle_states_list = []
+            for idle_state, idle_state_name in enumerate(idle_states):
+                idle_states_list.append(
+                    {
+                        "CPU ID": cpu,
+                        "Idle State Name": idle_state_name,
+                        "Flags/Description": lcpw.cpuidle_state_desc(cpu, idle_state),
+                        "Latency": lcpw.cpuidle_state_latency(cpu, idle_state),
+                        "Usage": lcpw.cpuidle_state_usage(cpu, idle_state),
+                        "Duration": lcpw.cpuidle_state_time(cpu, idle_state)
+                    }
+                )
+            idle_info = {
+                "CPUidle-driver": lcpw.cpuidle_get_driver(),
+                "CPUidle-governor": lcpw.cpuidle_get_governor(),
+                "idle-states-count": idle_states_amt,
+                "available-idle-states": idle_states,
+                "cpu-states": idle_states_list
+            }
+            return idle_info
+
+        def print_idle_info(self, cpu_list):
+            for cpu in cpu_list:
+                idle_info = self.get_idle_info(cpu)
+                print(
+f"""CPUidle driver: {idle_info["CPUidle-driver"]}
+CPUidle governor: {idle_info["CPUidle-governor"]}
+analyzing CPU {cpu}
+
+Number of idle states: {idle_info["idle-states-count"]}
+Available idle states: {idle_info["available-idle-states"]}""")
+                for state in idle_info["cpu-states"]:
+                    print(
+f"""{state["Idle State Name"]}
+Flags/Description: {state["Flags/Description"]}
+Latency: {state["Latency"]}
+Usage: {state["Usage"]}
+Duration: {state["Duration"]}""")
+
+        def idle_set_handler(self, args) -> int:
+            if args.idle_state_disabled_status is not None:
+                cstate_index = args.idle_state_disabled_status
+                cstate_list, cstate_amt = self.get_idle_states(self.__cpu_list[0]) # Assuming all cpus have the same idle state
+                if cstate_index < 0 or cstate_index >= cstate_amt:
+                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}", file=sys.stderr)
+                    return 1
+                cstate_name = cstate_list[cstate_index]
+                ret = self.is_disabled_idle_state(cstate_index)
+                for i,e in enumerate(ret):
+                    if e == 1:
+                        print(f"CPU: {self.__cpu_list[i]} Idle state \"{cstate_name}\" is disabled.")
+                    elif e == 0:
+                        print(f"CPU: {self.__cpu_list[i]} Idle state \"{cstate_name}\" is enabled.")
+                    else:
+                        self.handle_common_lcpw_errors(e, self.LCPW_ERROR_TWO_CASE, cstate_name)
+            elif args.idle_info is not None:
+                self.print_idle_info(self.__cpu_list)
+                return 0
+            elif args.disable_idle_state is not None:
+                cstate_index = args.disable_idle_state
+                cstate_list, cstate_amt = self.get_idle_states(self.__cpu_list[0]) # Assuming all cpus have the same idle state
+                if cstate_index < 0 or cstate_index >= cstate_amt:
+                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
+                    return 1
+                cstate_name = cstate_list[cstate_index]
+                ret = self.disable_idle_state(cstate_index, 1)
+                for e in ret:
+                    self.handle_common_lcpw_errors(e, self.LCPW_ERROR_THREE_CASE, cstate_name)
+            elif args.enable_idle_state is not None:
+                cstate_index = args.enable_idle_state
+                cstate_list, cstate_amt = self.get_idle_states(self.__cpu_list[0]) # Assuming all cpus have the same idle state
+                if cstate_index < 0 or cstate_index >= cstate_amt:
+                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
+                    return 1
+                cstate_name = cstate_list[cstate_index]
+                ret = self.disable_idle_state(cstate_index, 0)
+                for e in ret:
+                    self.handle_common_lcpw_errors(e, self.LCPW_ERROR_THREE_CASE, cstate_name)
+            return 0
+
+        def disable_idle_state(self, state, disabled) -> List[int]:
+            """
+            Disable or enable an idle state using the object's stored list of cpus.
+
+            Args:
+                state (int): The cpu idle state index to disable or enable as an int starting from 0.
+                disabled (int): set to 1 to disable or 0 to enable. Less than 0 is an error.
+            """
+            ret = []
+            for cpu in self.__cpu_list:
+                ret.append(lcpw.cpuidle_state_disable(cpu, state, disabled))
+            return ret
+
+        def is_disabled_idle_state(self, state) -> List[int]:
+            """
+            Query the idle state.
+
+            Args:
+                state: The cpu idle state. 1 is disabled, 0 is enabled. Less than 0 is an error.
+            """
+            ret = []
+            for cpu in self.__cpu_list:
+                ret.append(lcpw.cpuidle_is_state_disabled(cpu, state))
+            return ret
-- 
2.49.0

