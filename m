Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98592264A74
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Mar 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725045; cv=none; b=CFQLGIC6HQPmVwnu4pCGaRf3BgJefmSIfBbCQ09QvVd6ADqBDfbjrTMKCU86v2OZe2PPTXy9ozzNms8w8sQKqiFUnHmYfZvyHSdjDo7yPa0fd0rQA5qMe69SqC515RFC22HoVrX41yU4wWztf5qOd+U2aHgm3d1WPYXf4ewift8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725045; c=relaxed/simple;
	bh=nOj5OVVBOdoiY8OwQy/GwYAO7moccz/SPrb56/a81ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eixA+GJBfiI2q7v9A1l3FTqMGHTNeANIf7bIB19uK7TzZnIiid3dUE+FWAMhBvUc86t5XhtIk06KR8xD2yntbKmVHqHJKYqryQnqnsecD0jmunwKslRpm55OYr/efW9UJ4eDCd0sI1PEJ8JCKnp/Tw3lyWlnoPEtu84HZ7elm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqvusXsD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqvusXsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741725042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESzk/xmFDUMaKg25Y3/ZHg37Ot5KD2TXuuBYQNvNP9E=;
	b=HqvusXsDH/60ljkOUTIEiBwcjuj0TSUjVICOXOSlb5LlnWxdeUp+3sd5M6JmpNz/KRfTOM
	zYVTNQCoVChetmZFgLTCUgZhq49WghceFgQFCLwStdsP5oyMwedYL4k+4wZHZMhBmLwPvU
	CQrjbc4CcPOoTK0CqpWhsgzDF3UCL54=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-PqW1DdBLPHyddhi0CENFtw-1; Tue, 11 Mar 2025 16:30:41 -0400
X-MC-Unique: PqW1DdBLPHyddhi0CENFtw-1
X-Mimecast-MFC-AGG-ID: PqW1DdBLPHyddhi0CENFtw_1741725040
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c544d2c34fso612551785a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Mar 2025 13:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741725040; x=1742329840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESzk/xmFDUMaKg25Y3/ZHg37Ot5KD2TXuuBYQNvNP9E=;
        b=c4gt0DkUj6bfeq1aRr+GShroe0TqGrkY3M0E6ASbuEE/SN9g/7K6td7juUMFzjZo1p
         TYIAdYm8UjLTgf2i5mXXZORucL37/HEIeqC0lO1CZ6+JeaDnjUKsho0zf7VXUp+uFn/g
         lt6lHdCmC9F9HCRlaLlyacyCtInUxwf9VJIw0+wmVnCjFw1xhH6v8E8RpDvhva1Wd125
         QcZie/rdZoJtIMNukbAgXrQ23yvx4GJi1gPK/a+9/fho8AR6TahvreXudC5md45uHhWK
         2FJjAFgvnFqY56Bag3nXNS2a/BP6CiD533Rb/bvt5Qn4EY2xYMdoi6zB8yrvUbJJN1GD
         THtw==
X-Forwarded-Encrypted: i=1; AJvYcCVzNEQ9xV6120k3+g7CeDUoJbLN0P3HNn9x1Uflbs8E8Fzg3TAs/DwLa29oHpqqNUigqPoI1PJ5LCI4muHPfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtilQBkSy2BNF61fb/NvOSjJWpxSPG5S8qgMa93SFpZwcE2JPq
	+RIV/9BwZg8inCkMqvtIk2HL+3f4NAl5z47N4WN/ISxwmhW7y5CqHLUf2UKeKzYoMzK5QRtRCLE
	99/3h+J+TbW4Q7+d2LvgSixmInlIosF4Z3QtGsyrfW9N8JM89VIgSLcFX0411RYiN
X-Gm-Gg: ASbGncsqJnS7Py0sGjYV7fiaeZDRJwciBgSNmM+8RrS+aJbeLWciKLVG5Bht1sEOZd/
	xadGTytW/SLVJjy4itzm1z+ZICHQd2e0UFJnxn1QH+x8/hDuXHknbHHWEvNaA/WQ7INLJB/ZCKz
	wLcwJPGuefS+IoSsfVJE9g4Tx0s2nkHBwikLE7/oTcbKB2Zt2n1a2Lmqx7rpy/NDoQjzHnuRdP4
	xd/nm3KYG71l+iRj1dHixmnIRwxjVdufoUeatC9kHf74L5m95v3iDa1MLIV4UvJj2l1WK2lXqPS
	SA8nsfrg2vFMrEAHSA4NfglOgw==
X-Received: by 2002:a05:620a:278c:b0:7c5:4caa:21a4 with SMTP id af79cd13be357-7c54caa3399mr1726402785a.55.1741725040446;
        Tue, 11 Mar 2025 13:30:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/jHk10+OXI2VZNsV8gU1tMMLwnqY0FZA1aQaef0e8K3RRL84Gg9q3Qdy+eTwGmd4KJ/dpQA==
X-Received: by 2002:a05:620a:278c:b0:7c5:4caa:21a4 with SMTP id af79cd13be357-7c54caa3399mr1726399585a.55.1741725040085;
        Tue, 11 Mar 2025 13:30:40 -0700 (PDT)
Received: from thinkpad2024.redhat.com ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c555b74a32sm357658585a.19.2025.03.11.13.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:30:39 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v4 2/2] tuna: Add idle_state control functionality
Date: Tue, 11 Mar 2025 16:30:19 -0400
Message-ID: <20250311203034.8065-3-jwyatt@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311203034.8065-1-jwyatt@redhat.com>
References: <20250311203034.8065-1-jwyatt@redhat.com>
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

This patch revision includes text snippet suggestions by Crystal Wood
(v2) and small Python suggestions by John Kacur (v3 and v4).

Suggested-by: Crystal Wood <crwood@redhat.com>
Suggested-by: John Kacur <jkacur@redhat.com>

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tuna-cmd.py      |  30 +++++++-
 tuna/cpupower.py | 184 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+), 3 deletions(-)
 create mode 100755 tuna/cpupower.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index d0323f5..96a25a5 100755
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
+            "idle_state_disabled_status": dict(dest='idle_state_disabled_status', metavar='IDLE-STATE', type=int, help='Print whether IDLE-STATE is enabled on the selected	CPUs.'),
+            "disable_idle_state": dict(dest='disable_idle_state', metavar='IDLE-STATE', type=int, help='Disable IDLE-STATE on the selected CPUs.'),
+            "enable_idle_state": dict(dest='enable_idle_state', metavar='IDLE-STATE', type=int, help='Enable IDLE-STATE on the selected CPUs.')
+    }
 
     parser = HelpMessageParser(description="tuna - Application Tuning Program")
 
@@ -127,6 +132,9 @@ def gen_parser():
 
     subparser = parser.add_subparsers(dest='command')
 
+    idle_set = subparser.add_parser('idle_set',
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
 
+    if args.command == 'idle_set':
+        if not cpw.have_cpupower:
+            print(f"Error: libcpupower bindings are not detected; please install libcpupower bindings from at least kernel {cpw.cpupower_required_kernel}.")
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
index 0000000..7913027
--- /dev/null
+++ b/tuna/cpupower.py
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2024 John B. Wyatt IV
+
+from typing import List
+import tuna.utils as utils
+
+cpupower_required_kernel = "6.12"
+have_cpupower = None
+
+try:
+    import raw_pylibcpupower as lcpw
+    lcpw.cpufreq_get_available_frequencies(0)
+    have_cpupower = True
+except:
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
+            if cpu_list == None or cpu_list == []: # args.cpu_list == [] when the -c option is not used
+                self.__cpu_list = utils.get_all_cpu_list()
+            else:
+                self.__cpu_list = cpu_list
+
+        @staticmethod
+        def handle_common_lcpw_errors(e, error_type, idle_name):
+            match e:
+                case 0:
+                    pass
+                case -1:
+                    print(f"Idlestate {idle_name} not available")
+                case -2:
+                    print("Disabling is not supported by the kernel")
+                case -3:
+                    if error_type == Cpupower.LCPW_ERROR_THREE_CASE:
+                        print("No write access to disable/enable C-states: try using sudo")
+                    else:
+                        print(f"Not documented: {e}")
+                case _:
+                    print(f"Not documented: {e}")
+
+        @staticmethod
+        def get_idle_states(cpu):
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
+        @staticmethod
+        def get_idle_info(cpu=0):
+            idle_states, idle_states_amt = Cpupower.get_idle_states(cpu)
+            idle_states_list = []
+            for idle_state in range(0, len(idle_states)):
+                idle_states_list.append(
+                    {
+                        "CPU ID": cpu,
+                        "Idle State Name": idle_states[idle_state],
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
+        @staticmethod
+        def print_idle_info(cpu_list=[0]):
+            for cpu in cpu_list:
+                idle_info = Cpupower.get_idle_info(cpu)
+                print_str = f"""
+CPUidle driver: {idle_info["CPUidle-driver"]}
+CPUidle governor: {idle_info["CPUidle-governor"]}
+analyzing CPU {cpu}
+
+Number of idle states: {idle_info["idle-states-count"]}
+Available idle states: {idle_info["available-idle-states"]}
+"""
+                for state in idle_info["cpu-states"]:
+                    print_str += f"""{state["Idle State Name"]}
+Flags/Description: {state["Flags/Description"]}
+Latency: {state["Latency"]}
+Usage: {state["Usage"]}
+Duration: {state["Duration"]}
+"""
+                print(
+                    print_str
+                )
+
+        def idle_set_handler(self, args) -> int:
+            if args.idle_state_disabled_status != None:
+                cstate_index = args.idle_state_disabled_status
+                cstate_list, cstate_amt = self.get_idle_states(self.__cpu_list[0]) # Assuming all cpus have the same idle state
+                if cstate_index < 0 or cstate_index >= cstate_amt:
+                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
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
+            elif args.idle_info != None:
+                self.print_idle_info(self.__cpu_list)
+                return 0
+            elif args.disable_idle_state != None:
+                cstate_index = args.disable_idle_state
+                cstate_list, cstate_amt = self.get_idle_states(self.__cpu_list[0]) # Assuming all cpus have the same idle state
+                if cstate_index < 0 or cstate_index >= cstate_amt:
+                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
+                    return 1
+                cstate_name = cstate_list[cstate_index]
+                ret = self.disable_idle_state(cstate_index, 1)
+                for e in ret:
+                    self.handle_common_lcpw_errors(e, self.LCPW_ERROR_THREE_CASE, cstate_name)
+            elif args.enable_idle_state != None:
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
2.48.1

