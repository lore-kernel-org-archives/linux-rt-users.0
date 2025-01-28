Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A313632B
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jan 2025 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738028799; cv=none; b=d3ShWbPqgXN+q4IMMVYNXi/UjDNBuOz21KQlVRXzIC0uYbdCiZ4dgTagMUw6HRvCHmQaPt/Yg2nPcAZOdKtrZ4FmB1E3Gy7fsQf3IAS+FuXc+hjMWcClgpIL4Vg82X9johsmGgVfdib2Kf//fcaOfHqAWE4/rhPuCEHSrpusBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738028799; c=relaxed/simple;
	bh=LA+r9bLRKXtUC4GkvMGsVKND3wr6cX2MTFcEzLBHye8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBSh58JbGsRX+TfGZnuXCeuzgrqTdblhQRrjYAD/Q0CFk4SNDUKuNC0sVO5i/cll6MaxIlUDXEwiBciQ1fsowf5TwRsrnf5pYpfyk1Z5WP6WO3iyvDzOz0FoiuYsjqEoVo2/e+JfapSn3rDSEALOZXA4LEtvl+V9x2NUlSYrhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHKVCqhD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHKVCqhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738028796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7khaybFoJxMDoUzqES4uEL5pRXfXHSSHDMr02gnV9I=;
	b=DHKVCqhDhDBOoHDZx3TC1kTYU7/gTtxYUj6pezsxVNMgZWRFzebmmTpIm7kbxnI4q8LCwC
	TKfk4r/jOCkAJQUbvCfZvT4ytmdWxVkqbtUufS6WU/7HDFjaK3tgQJN6eRiW9i6urieQJB
	fJ9Jiw7W7B6cE0J7JAr3AKDtcWXQ8wo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-__KsQtPdMUe-dhf6kgpa4Q-1; Mon, 27 Jan 2025 20:46:32 -0500
X-MC-Unique: __KsQtPdMUe-dhf6kgpa4Q-1
X-Mimecast-MFC-AGG-ID: __KsQtPdMUe-dhf6kgpa4Q
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6ebe1ab63so1414019985a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jan 2025 17:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738028792; x=1738633592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7khaybFoJxMDoUzqES4uEL5pRXfXHSSHDMr02gnV9I=;
        b=pZFUErwau0OChRvdGDukyst7ID9Cct9ZWQxN5HawULtgPeLCPwLtQTfOjGgsEOH/m9
         1MDsOvJyAqc06gFoiImIdZZXlYyEKSn/48wZf9oUmmF0RPn6As9+kpYVaKCbGXZcWcey
         jBCJTw3zAoi57kUkHjHA+qGXdZidJebjulI4aztiwm4SGy1gTwORuO+jObjjCW/rAtVu
         TOageYSZOujOXXZq2QFeOWcKAcpBEpPq2UB2M3x4lIvNUGmhVLtQDTz0ovew7yJm89LX
         vsMgw2YGadieXxtmLy8/2u+9vqSZ00TC8/HFdPclq03x7/ONEs7SkYEQNv2W0PvQ7XAi
         Ut0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+2JNbstplElqo5dBCv9nAVhGyhxrU24KiE6+T8xtcdLPZuVRoEe4MR1cfiF9e7Cu7ciYNKl32T4L2MBkqwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2d1/YxV8TjXrhWHY8d35uVDbaKGVzcaR/KvOH4mFbR5aXfrG
	hBXgr6Csi9Ci/nIphvyIAQb4T6mNijD9ejf9FRSTyrqjWD0Ai3yr7xESWkFrFPTLmB4w6+0SO+C
	TR64rcQA5/r8DOavmxnb7XivmSnTIjP88V+NAjqdTq/V2PQquCDwzGZduW4vGKehC
X-Gm-Gg: ASbGncuCBE4omK/v5pEXzDzQNXdp3sCGy0En2m6GnNDGhDEu7OxyGacj0cgh13oK98d
	uPxperSm12E3KN26oS9zkI+GWRo2sPNjyQeXHKWRQqaj+Og2HChZ2TQ1YmyeMVlFLP7yK3h+mOF
	U764WxqAAzzhLPqgaZHmcyP7GlwO2CxMXGzPfh4EG2eTJBaC9/D0ACiUxYE5P2vlfzyi+nj2MJL
	9nK9B/H5g94G4w0MLUupX+9XarMQKusfFQ4dYrjMCicoBYMeSwwhaHFCJ4w8SMSkuqJJ6Xj4+OF
	mUmXa0NLaTHYcsM=
X-Received: by 2002:a05:620a:4083:b0:7b6:db05:12a9 with SMTP id af79cd13be357-7be6324fba5mr6411141485a.39.1738028791791;
        Mon, 27 Jan 2025 17:46:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR1lem2B27A71QcvERvGFkU7564je+SC3ylKRgKnCNOZp4DkdRyvvq5hYgBHY+VCEZz1UniA==
X-Received: by 2002:a05:620a:4083:b0:7b6:db05:12a9 with SMTP id af79cd13be357-7be6324fba5mr6411138285a.39.1738028791416;
        Mon, 27 Jan 2025 17:46:31 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.51.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e6687f10dsm45570161cf.25.2025.01.27.17.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 17:46:30 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 2/2] tuna: Add idle-state control functionality
Date: Mon, 27 Jan 2025 20:45:48 -0500
Message-ID: <20250128014551.15058-3-jwyatt@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250128014551.15058-1-jwyatt@redhat.com>
References: <20250128014551.15058-1-jwyatt@redhat.com>
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
idle-states. If cpupower is missing Tuna as a whole will continue to
function and idle-set functionality will error out.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tuna-cmd.py      |  33 +++++++-
 tuna/cpupower.py | 202 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100755 tuna/cpupower.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index d0323f5..81d0f48 100755
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
+            "idle_state_disabled_status": dict(dest='idle_state_disabled_status', metavar='IDLESTATEDISABLEDSTATUS', type=int, help='Print if cpu idle state of the cpus in CPU-LIST is enabled or disabled. If CPU-LIST is not specified, default to all cpus.'),
+            "idle_info": dict(dest='idle_info', action='store_const', const=True, help='Print general idle information on cpus in CPU-LIST. If CPU-LIST is not specified, default to all cpus.'),
+            "disable_idle_state": dict(dest='disable_idle_state', metavar='IDLESTATEINDEX', type=int, help='Disable cpus in CPU-LIST\'s cpu idle (cpu sleep state). If CPU-LIST is not specified, default to all cpus.'),
+            "enable_idle_state": dict(dest='enable_idle_state', metavar='IDLESTATEINDEX', type=int, help='Enable cpus in CPU-LIST\'s cpu idle (cpu sleep state). If CPU-LIST is not specified, default to all cpus.')
+    }
 
     parser = HelpMessageParser(description="tuna - Application Tuning Program")
 
@@ -147,6 +152,10 @@ def gen_parser():
     show_irqs = subparser.add_parser('show_irqs', description='Show IRQ list', help='Show IRQ list')
     show_configs = subparser.add_parser('show_configs', description='List preloaded profiles', help='List preloaded profiles')
 
+    idle_set = subparser.add_parser('idle-set',
+                                    description='Query and set all idle states on a given CPU list. Requires libcpupower to be installed',
+                                    help='Set all idle states on a given CPU-LIST.')
+
     what_is = subparser.add_parser('what_is', description='Provides help about selected entities', help='Provides help about selected entities')
     gui = subparser.add_parser('gui', description="Start the GUI", help="Start the GUI")
 
@@ -218,6 +227,13 @@ def gen_parser():
     show_irqs_group.add_argument('-S', '--sockets', **MODS['sockets'])
     show_irqs.add_argument('-q', '--irqs', **MODS['irqs'])
 
+    idle_set_group = idle_set.add_mutually_exclusive_group(required=True)
+    idle_set.add_argument('-c', '--cpus', **MODS['cpus'])
+    idle_set_group.add_argument('-s', '--status', **MODS['idle_state_disabled_status'])
+    idle_set_group.add_argument('-i', '--idle-info', **MODS['idle_info'])
+    idle_set_group.add_argument('-d', '--disable', **MODS['disable_idle_state'])
+    idle_set_group.add_argument('-e', '--enable', **MODS['enable_idle_state'])
+
     what_is.add_argument('thread_list', **POS['thread_list'])
 
     gui.add_argument('-d', '--disable_perf', **MODS['disable_perf'])
@@ -635,6 +651,19 @@ def main():
         my_logger.addHandler(add_handler("DEBUG", tofile=False))
         my_logger.info("Debug option set")
 
+    if args.command == 'idle-set':
+        if not cpw.have_cpupower:
+            print(f"Error: libcpupower bindings are not detected; need {cpw.cpupower_required_kernel} at a minimum.")
+            sys.exit(1)
+
+        if not args.cpu_list or args.cpu_list == []:
+            args.cpu_list = cpw.Cpupower().get_all_cpu_list()
+
+        my_cpupower = cpw.Cpupower(args.cpu_list)
+        ret = my_cpupower.idle_state_handler(args)
+        if ret > 0:
+            sys.exit(ret)
+
     if args.loglevel:
         if not args.debug:
             my_logger = setup_logging("my_logger")
diff --git a/tuna/cpupower.py b/tuna/cpupower.py
new file mode 100755
index 0000000..b09dc2f
--- /dev/null
+++ b/tuna/cpupower.py
@@ -0,0 +1,202 @@
+# Copyright (C) 2024 John B. Wyatt IV
+# SPDX-License-Identifier: GPL-2.0-only
+
+from typing import List
+import tuna.utils as utils
+
+cpupower_required_kernel = "6.12"
+have_cpupower = None
+
+
+import raw_pylibcpupower as cpw
+try:
+    # Noticed that SWIG generated bindings will simply complain a
+    # function does not exist instead of triggering an exception.
+    # Call some query function to trigger an AttributeError for
+    # when the bindings are missing.
+    cpw.cpufreq_get_available_frequencies(0)
+    have_cpupower = True
+except:
+    have_cpupower = False
+
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
+        def __init__(self, cpulist=None):
+            if cpulist == None:
+                self.__cpulist = self.get_all_cpu_list()
+            else:
+                self.__cpulist = cpulist
+
+        @classmethod
+        def get_all_cpu_list(cls):
+            return list(range(cls.get_idle_info()["all_cpus"]))
+
+        @classmethod
+        def get_idle_states(cls, cpu):
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
+            for cstate in range(cpw.cpuidle_state_count(cpu)):
+                ret.append(cpw.cpuidle_state_name(cpu,cstate))
+            return ret, cpw.cpuidle_state_count(cpu)
+
+        @classmethod
+        def get_idle_info(cls, cpu=0):
+            idle_states, idle_states_amt = cls.get_idle_states(cpu)
+            idle_states_list = []
+            for idle_state in range(0, len(idle_states)):
+                idle_states_list.append(
+                    {
+                        "CPU ID": cpu,
+                        "Idle State Name": idle_states[idle_state],
+                        "Flags/Description": cpw.cpuidle_state_desc(cpu, idle_state),
+                        "Latency": cpw.cpuidle_state_latency(cpu, idle_state),
+                        "Usage": cpw.cpuidle_state_usage(cpu, idle_state),
+                        "Duration": cpw.cpuidle_state_time(cpu, idle_state)
+                    }
+                )
+            idle_info = {
+                "all_cpus": utils.get_nr_cpus(),
+                "CPUidle-driver": cpw.cpuidle_get_driver(),
+                "CPUidle-governor": cpw.cpuidle_get_governor(),
+                "idle-states-count": idle_states_amt,
+                "available-idle-states": idle_states,
+                "cpu-states": idle_states_list
+            }
+            return idle_info
+
+        @classmethod
+        def print_idle_info(cls, cpu_list=[0]):
+            cpu_count = utils.get_nr_cpus()
+            for cpu in cpu_list:
+                idle_info = cls.get_idle_info(cpu)
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
+        def idle_state_handler(self, args) -> int:
+            if args.idle_state_disabled_status != None:
+                cstate_index = args.idle_state_disabled_status
+                cstate_list, cstate_amt = self.get_idle_states(args.cpu_list[0]) # Assumption, that all cpus have the same idle state
+                if cstate_index < 0 or cstate_index >= cstate_amt:
+                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
+                    return 1
+                cstate_name = cstate_list[cstate_index]
+                ret = self.is_disabled_idle_state(cstate_index)
+                for i, e in enumerate(ret):
+                    match e:
+                        case 1:
+                            print(f"CPU: {args.cpu_list[i]} Idle state \"{cstate_name}\" is disabled.")
+                        case 0:
+                            print(f"CPU: {args.cpu_list[i]} Idle state \"{cstate_name}\" is enabled.")
+                        case -1:
+                            print(f"Idlestate not available")
+                        case -2:
+                            print(f"Disabling is not supported by the kernel")
+                        case _:
+                            print(f"Not documented: {e}")
+            elif args.idle_info != None:
+                self.print_idle_info(args.cpu_list)
+                return 0
+            elif args.disable_idle_state != None:
+                cstate_index = args.disable_idle_state
+                cstate_list, cstate_amt = self.get_idle_states(args.cpu_list[0]) # Assumption, that all cpus have the same idle state
+                if cstate_index < 0 or cstate_index >= cstate_amt:
+                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
+                    return 1
+                cstate_name = cstate_list[cstate_index]
+                ret = self.disable_idle_state(cstate_index, 1)
+                for i, e in enumerate(ret):
+                    match e:
+                        case 0:
+                            print(f"CPU: {args.cpu_list[i]} Idle state \"{cstate_name}\" is disabled.")
+                        case -1:
+                            print(f"Idlestate not available")
+                        case -2:
+                            print(f"Disabling is not supported by the kernel")
+                        case -3:
+                            print(f"No write access to disable/enable C-states: try using sudo")
+                        case _:
+                            print(f"Not documented: {e}")
+            elif args.enable_idle_state != None:
+                cstate_index = args.enable_idle_state
+                cstate_list, cstate_amt = self.get_idle_states(args.cpu_list[0]) # Assumption, that all cpus have the same idle state
+                if cstate_index < 0 or cstate_index >= cstate_amt:
+                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
+                    return 1
+                cstate_name = cstate_list[cstate_index]
+                ret = self.disable_idle_state(cstate_index, 0)
+                for i, e in enumerate(ret):
+                    match e:
+                        case 0:
+                            print(f"CPU: {args.cpu_list[i]} Idle state \"{cstate_name}\" is enabled.")
+                        case -1:
+                            print(f"Idlestate not available")
+                        case -2:
+                            print(f"Disabling is not supported by the kernel")
+                        case -3:
+                            print(f"No write access to disable/enable C-states: try using sudo")
+                        case _:
+                            print(f"Not documented: {e}")
+            else:
+                print(args)
+                print("idle-set error: you should not get here!")
+            return 0
+
+        """
+        Disable or enable an idle state using the object's stored list of cpus.
+
+        Args:
+            state (int): The cpu idle state index to disable or enable as an int starting from 0.
+            disabled (int): set to 1 to disable or 0 to enable. Less than 0 is an error.
+        """
+        def disable_idle_state(self, state, disabled) -> List[int]:
+            ret = []
+            for cpu in self.__cpulist:
+                ret.append(cpw.cpuidle_state_disable(cpu, state, disabled))
+            return ret
+
+        """
+        Query the idle state.
+
+        Args:
+            state: The cpu idle state. 1 is disabled, 0 is enabled. Less than 0 is an error.
+        """
+        def is_disabled_idle_state(self, state) -> List[int]:
+            ret = []
+            for cpu in self.__cpulist:
+                ret.append(cpw.cpuidle_is_state_disabled(cpu, state))
+            return ret
-- 
2.48.1

