Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20F33C514
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541889; cv=none; b=cL7To2JVYhv/9izxj2pmPkUugBC7Lft52GL6Gzj4MHWyavB2sLedw6grz0iIfhQcwz60CmLA0/44DRZbGvwSPG7FCydwg68cfMyGoUp3Va0K21VT4NrUcZFj6Fu0IhjTMPvAbDl2VggIhLqWfEYrXozEdZHMxJGVb2tkpu+94Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541889; c=relaxed/simple;
	bh=/8KVlUVtPhAuRF7z4o9neMhwnmVtxiyu+YvRxcDOnyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVTxs8LvOlu2hKAn5KoThfdppCPhmBEc8DEGf3Wvd2n04EI/8mknGoAkTamTDswd1mCWiGFYy/mXaz/KAIaBSXvSbBrlqJqxxOFjvFaRY/mKC+D0LAG91b0wSEGBn2ukt4yeK9GjC1g+5Vn8Ic043x8QcwwUt+6Wo6LYb5ThPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh7uP32U; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh7uP32U"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-89ed2ee35bbso139636885a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541886; x=1763146686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuVTIz3JMK/iLsy4yCmnmcKiAq6ieTYk1b09hV8oVI4=;
        b=Hh7uP32UDqDfDCZkZlQwNK9fjnJ1HHZGC/zvWYa585F6RDUvs+rmasra2DYek0jyS2
         GFtqSNtHcJDoX+GothT7Qi+pmvVUeZnE8AjQZoYv6o0h13/lCgXKPlNSIIanl2zmMzbU
         L8d+49wmcuMs5d2nMWhVfPHVqXzVnEKG5/Jjv2fPwf4fW6Ei7XkfQoNTEovxbXJVkO+R
         PJKg04d/1x7Komhme1Sz4BPeVwCsKhK2C9ZMFCwh8EKgGWGgba9gWObvppM1933s8KGE
         LgIKjckSino2mc8MQzmco2XYh+ch08Rjo1bfYHtzbJp6uduOWQyAm6B2XHUe6h2y//FA
         X1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541886; x=1763146686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuVTIz3JMK/iLsy4yCmnmcKiAq6ieTYk1b09hV8oVI4=;
        b=kZAaN63KQNOq5/w+QH4YoeAhhCA+oen9gW6ptv2OrZYT8+KKk6h7dzQVSSwwjBK0/x
         TpURWCrFRB+7z6ZjVwt9PYhMsOJYaBo72r/kQ+yEpUPKCwuyOzGlQLc0BX/s5OPkA040
         +xxixf6529cX7tWYxdhjuztFaSL3dbsz/y/sR3oWXF+ZMEI7sMyaIx+tuoieVdEGUJCw
         FMJ4X2QRfdssBIyFZrT7YQ9KH3fcKdPI5Lfac7bezbp1t5j1L0oE1YObUADxMYCxj4hT
         e17x2YYU1OeLi8Hd/d6Wq1eeFfdVJXSVCR4YVcV042pajl2SXEpSZyPzOieR9TpSTc00
         z3uA==
X-Gm-Message-State: AOJu0YxCusE2PmbU3ZWq3fIi0rKxMWQa71QgPT4LVrATNg+CuT0h35XB
	ijCzu0rhvAjEtzua8tFu8dPsTYrB0es+xz69RBRcd2hPowbouiEz70VmNUEW5oVG
X-Gm-Gg: ASbGncuplPZ23sBaZNKKzIWBwCEvTuy5qRVSZbT4rgmoQhacOpZ9DCimtFoxocw1Zd9
	ZJ+R3wQUr7o1xit8YLhLK4r/27I+74vHlXIy+jQocIGagV7LUaHTgLCHcPKTPOk4VvAlovdxayx
	+Vxc8iHErun6FXDceJPtgl6bLQO+c6c3M/RuTOIEz14VvYVwNgCFWcaprWfU4MUMd9GgqK20+7e
	cMqXdZVwp96x+RULVZzL1hl5chDlcHZCAa3e+Q10H9xqx1a1sPKu8m356ex0G+mA5fIEZcE45Px
	K95+CMPddAZ4zPlGYzhKeiKv+5NfQ0Yt30Nbkpx8DyCpjmLjA27I+F9a4WDt3/sVxvx3Ij0D1/B
	E5x9w0Akoel+5/xNxoXIoG0tyT6ob6g5x1bS1A/pQVqBe50nOpNeB2JaQxaAGR+u/Ij1BknKYmg
	==
X-Google-Smtp-Source: AGHT+IFaOAEmH5iEzfNNFmpY+NZxubKLwF11n5d+MbrTelToeDNlBPeJxlV3n+u9EcIF270VAdnTCA==
X-Received: by 2002:a05:620a:28d1:b0:8b1:8cdb:c005 with SMTP id af79cd13be357-8b257f6949amr44299585a.84.1762541886292;
        Fri, 07 Nov 2025 10:58:06 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:05 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 08/23] tuna: Add idle_state control functionality
Date: Fri,  7 Nov 2025 13:57:17 -0500
Message-ID: <20251107185732.23992-9-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185732.23992-1-jkacur@redhat.com>
References: <20251107185732.23992-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "John B. Wyatt IV" <jwyatt@redhat.com>

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
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py      |  30 +++++++-
 tuna/cpupower.py | 177 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+), 3 deletions(-)
 create mode 100755 tuna/cpupower.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index d0323f510750..4997eaa5de92 100755
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
index 000000000000..ec04b908855a
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
2.51.1

