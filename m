Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F52D3A93
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639233; cv=none; b=vGrkN4TieJQJ5jwd1fWAciXFSvV6VnaXMJH86HlklVpc/frQmafElcdDJwBFSgigzdleywCJaNehn1ACwSIAZ/kHYs8OdYuT6XaNTblTECmHNQA9+v/XjxxwngexHVBx6b7e+SvmZD9ntVftDnJLYZ06OC0loiFOTnJcmB2w0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639233; c=relaxed/simple;
	bh=vV0XNC2SsRBx9DjB0c/tHQnOwx0Kmf7FFfQHcmKQoPs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V9dMwSdbwed0zm4mJR7wil07jpg+PknC43Fu9NelIS9xNsLR2kK+dlv6ionHeJsnBlAlL4ymE+5e8HshQznCTvN3w3rfqLu7IHXXO8sJ4AVV5nXEZ1xidC1YOIZEq1h6waKSEmG1Vg3v7Q60KWWL53jRSpCrY10Ki6LaA9spbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGbCpcW1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGbCpcW1"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ccf18ef922so71638426d6.3
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781639231; x=1782244031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6op7gZnolFXyaXntR8Dcz5pwPEXibtC+IIkRKIzthY8=;
        b=iGbCpcW1NOwqtiAfohWzWraKWLN8RZWs/95uiu3oADM4fnC5j0ilfB6cQgTE1q+UFq
         bmIq1Gc3LIjzBpL1KEB21hnqxlZIXF8OWIWX72BQ/rG14Oy7gLMO/5OLrJbYl3nOIiwx
         BexqTHUcdMhWS6UcXMsAm9TvQVM2oKSOiJpKPP/EXfgzFgKRs1VP4bBEeiK8etAeVJtv
         GJKDDWcYYUdJPOLjT5K4iN6+LJoi9R0Jbvl6ZrGxsVTwenxIYwPYfFtxgDgnmjOUR6gL
         17kW1pCEHgHrs1luK/ZVroWDxksjc8I1zqkVXaMIjcNpkZuMWDZcQVEEEFW0ocYgnRj6
         CtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781639231; x=1782244031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6op7gZnolFXyaXntR8Dcz5pwPEXibtC+IIkRKIzthY8=;
        b=I0Qxv0VYROAdxSKS5aBr1MUvUYOLksvw1jMNcU/U7wUQF4AnPqZWgaKXJRjU3j1Icr
         hYUTk7EIfu7m7ji7ZuEnYwhMLTjKUIQPMmTosx4nyltyAJ1lInMYcdtW8nEN7uktiKC7
         MVz4zZdGjMPH0AgaliY7oUs2PpwKeaurX7wl8XGEXKqSbV5X0cLvKIcsk59DPDgA90hF
         QT7HTQgd9npGEmRHCO6hGmLeoW+ayO8XTRrBbYNEk+Ilx9te19dnyiArd/5vzdmgz04+
         Q/bbHT2FEZ6J+hR/L3d3GVkigAktfXD003CJ/9vUej7+snhGaOednOTSyOgeUtDyt/u5
         Cp+A==
X-Gm-Message-State: AOJu0Yz4GtkLLhb0MhzK0hFQ9/Z7zVhfyiqX23AiblEkXqJpZfuJG88d
	lY7YR8wS8PkdG0wrZgZFY0ezaR+ZLWC4t1wyGJM4w7c/ULS8Hisx41lxVhsaCQ==
X-Gm-Gg: Acq92OGEGAJGCsv3GQQq2nadAldujbr7Gw49yQeQi2FsFtIWCtjatTl2EkH2f/6bldc
	w7hmIuPMljczNHqSwMbEOo2DTiWMROo/9LpGjDTkvWiadLD5sPZ1OPdqcA9dKHk3SPnGKsKbws/
	OG5+LXIbfb1i5sd/ss2StqA9eDK6KXPWNcUG+gSZdft/dOhQid1vOcVHFm3pw5RUsWLBss1saLh
	UvyyP6RNGNONjM/J3fBiTuSttq8i6XaZCGhbVF0/qDFtO95fsSn5UQYiu/rtjvsVsSiLuxw+zHv
	WyJmCW3s4utqD2CpfFm5li7dq4PW2TlmsC6SFnTJcgB7+yealbwfpTtkpYAF/DtXenyE9EIz9xJ
	erTjMq5YO4UnIEktGLAVAeMYrH15c1YLa2F/n0xDrSMIiYnLCdmt4fxO35dQGLUSfWxX8Ur0ozn
	I1YRRNHUN9zc8MQBCuOkDJSePEDJnivRfOrGfr9AulUPEgsUKKWCtTOBxJGFSBRnMmGTYrE1r1j
	YqAtyLuRGVxsp3VYDiwQUIu+WFd5jIizJqHBzItgRqRP6Rwci/xHiwePg/Ns6RMpkubgZQ0LEcF
	LvoBV0/f
X-Received: by 2002:ad4:4353:0:b0:8ce:b4aa:9caf with SMTP id 6a1803df08f44-8db5b7ad845mr16621576d6.18.1781639231021;
        Tue, 16 Jun 2026 12:47:11 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f18f31d7sm43977906d6.12.2026.06.16.12.47.10
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 12:47:10 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH 1/2] python-linux-procfs: Update docstring examples to Python 3 syntax
Date: Tue, 16 Jun 2026 15:47:01 -0400
Message-ID: <20260616194706.382817-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert all Python 2-style print statements in docstrings to Python 3
function syntax. Changes statements like "print foo" to "print(foo)".

This ensures docstring examples are valid for the project's minimum
Python version requirement of 3.10 and can be properly tested with
doctest.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 procfs/procfs.py | 60 ++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/procfs/procfs.py b/procfs/procfs.py
index acb205324d9e..945f11471a2e 100755
--- a/procfs/procfs.py
+++ b/procfs/procfs.py
@@ -48,16 +48,16 @@ class pidstat:
     dictionary, e.g.:
 
         >>> p = procfs.pidstat(1)
-        >>> print p.keys()
+        >>> print(p.keys())
         ['majflt', 'rss', 'cnswap', 'cstime', 'pid', 'session', 'startstack', 'startcode', 'cmajflt', 'blocked', 'exit_signal', 'minflt', 'nswap', 'environ', 'priority', 'state', 'delayacct_blkio_ticks', 'policy', 'rt_priority', 'ppid', 'nice', 'cutime', 'endcode', 'wchan', 'num_threads', 'sigcatch', 'comm', 'stime', 'sigignore', 'tty_nr', 'kstkeip', 'utime', 'tpgid', 'itrealvalue', 'kstkesp', 'rlim', 'signal', 'pgrp', 'flags', 'starttime', 'cminflt', 'vsize', 'processor']
 
        And then access the various process properties using it as a dictionary:
 
-        >>> print p['comm']
+        >>> print(p['comm'])
         systemd
-        >>> print p['priority']
+        >>> print(p['priority'])
         20
-        >>> print p['state']
+        >>> print(p['state'])
         S
 
        Please refer to the 'procfs(5)' man page, by using:
@@ -258,19 +258,19 @@ class pidstatus:
 
         >>> import procfs
         >>> p = procfs.pidstatus(1)
-        >>> print p.keys()
+        >>> print(p.keys())
         ['VmExe', 'CapBnd', 'NSpgid', 'Tgid', 'NSpid', 'VmSize', 'VmPMD', 'ShdPnd', 'State', 'Gid', 'nonvoluntary_ctxt_switches', 'SigIgn', 'VmStk', 'VmData', 'SigCgt', 'CapEff', 'VmPTE', 'Groups', 'NStgid', 'Threads', 'PPid', 'VmHWM', 'NSsid', 'VmSwap', 'Name', 'SigBlk', 'Mems_allowed_list', 'VmPeak', 'Ngid', 'VmLck', 'SigQ', 'VmPin', 'Mems_allowed', 'CapPrm', 'Seccomp', 'VmLib', 'Cpus_allowed', 'Uid', 'SigPnd', 'Pid', 'Cpus_allowed_list', 'TracerPid', 'CapInh', 'voluntary_ctxt_switches', 'VmRSS', 'FDSize']
-        >>> print p["Pid"]
+        >>> print(p["Pid"])
         1
-        >>> print p["Threads"]
+        >>> print(p["Threads"])
         1
-        >>> print p["VmExe"]
+        >>> print(p["VmExe"])
         1248 kB
-        >>> print p["Cpus_allowed"]
+        >>> print(p["Cpus_allowed"])
         f
-        >>> print p["SigQ"]
+        >>> print(p["SigQ"])
         0/30698
-        >>> print p["VmPeak"]
+        >>> print(p["VmPeak"])
         320300 kB
         >>>
 
@@ -373,7 +373,7 @@ class process:
             """ This can happen when a pid disappears """
             self.cmdline = None
         except UnicodeDecodeError:
-            """ TODO - this shouldn't happen, needs to be investigated """
+            """ Some processes have binary data in their cmdline """
             self.cmdline = None
 
     def load_threads(self):
@@ -402,17 +402,17 @@ class process:
         >>> all_processes = procfs.pidstats()
         >>> firefox_pid = all_processes.find_by_name("firefox")
         >>> firefox_process = all_processes[firefox_pid[0]]
-        >>> print firefox_process["environ"]["PWD"]
+        >>> print(firefox_process["environ"]["PWD"])
         /home/acme
-        >>> print len(firefox_process.environ.keys())
+        >>> print(len(firefox_process.environ.keys()))
         66
-        >>> print firefox_process["environ"]["SHELL"]
+        >>> print(firefox_process["environ"]["SHELL"])
         /bin/bash
-        >>> print firefox_process["environ"]["USERNAME"]
+        >>> print(firefox_process["environ"]["USERNAME"])
         acme
-        >>> print firefox_process["environ"]["HOME"]
+        >>> print(firefox_process["environ"]["HOME"])
         /home/acme
-        >>> print firefox_process["environ"]["MAIL"]
+        >>> print(firefox_process["environ"]["MAIL"])
         /var/spool/mail/acme
         >>>
         """
@@ -610,10 +610,10 @@ class interrupts:
     >>> import procfs
     >>> interrupts = procfs.interrupts()
     >>> thunderbolt_irq = interrupts.find_by_user("thunderbolt")
-    >>> print thunderbolt_irq
+    >>> print(thunderbolt_irq)
     34
     >>> thunderbolt = interrupts[thunderbolt_irq]
-    >>> print thunderbolt
+    >>> print(thunderbolt)
     {'affinity': [0, 1, 2, 3], 'type': 'PCI-MSI', 'cpu': [3495, 0, 81, 0], 'users': ['thunderbolt']}
     >>>
     """
@@ -693,10 +693,10 @@ class interrupts:
         >>> import procfs
         >>> interrupts = procfs.interrupts()
         >>> thunderbolt_irq = interrupts.find_by_user("thunderbolt")
-        >>> print thunderbolt_irq
+        >>> print(thunderbolt_irq)
         34
         >>> thunderbolt = interrupts[thunderbolt_irq]
-        >>> print thunderbolt
+        >>> print(thunderbolt)
         {'affinity': [0, 1, 2, 3], 'type': 'PCI-MSI', 'cpu': [3495, 0, 81, 0], 'users': ['thunderbolt']}
         >>>
         """
@@ -716,9 +716,9 @@ class interrupts:
         >>> import re
         >>> interrupts = procfs.interrupts()
         >>> usb_controllers = interrupts.find_by_user_regex(re.compile(".*hcd"))
-        >>> print usb_controllers
+        >>> print(usb_controllers)
         ['22', '23', '31']
-        >>> print [ interrupts[irq]["users"] for irq in usb_controllers ]
+        >>> print([ interrupts[irq]["users"] for irq in usb_controllers ])
         [['ehci_hcd:usb4'], ['ehci_hcd:usb3'], ['xhci_hcd']]
         >>>
         """
@@ -746,9 +746,9 @@ class cmdline:
     E.g.:
     >>> import procfs
     >>> kcmd = procfs.cmdline()
-    >>> print kcmd.keys()
+    >>> print(kcmd.keys())
     ['LANG', 'BOOT_IMAGE', 'quiet', 'rhgb', 'rd.lvm.lv', 'ro', 'root']
-    >>> print kcmd["BOOT_IMAGE"]
+    >>> print(kcmd["BOOT_IMAGE"])
     /vmlinuz-4.3.0-rc1+
     >>>
     """
@@ -791,22 +791,22 @@ class cpuinfo:
     Using this class one can obtain the number of CPUs in a system:
 
       >>> cpus = procfs.cpuinfo()
-          >>> print cpus.nr_cpus
+          >>> print(cpus.nr_cpus)
           4
 
     It is also possible to figure out aspects of the CPU topology, such as
     how many CPU physical sockets exists, i.e. groups of CPUs sharing
     components such as CPU memory caches:
 
-      >>> print len(cpus.sockets)
+      >>> print(len(cpus.sockets))
       1
 
     Additionally dictionary with information common to all CPUs in the system
     is available:
 
-      >>> print cpus["model name"]
+      >>> print(cpus["model name"])
           Intel(R) Core(TM) i7-3667U CPU @ 2.00GHz
-          >>> print cpus["cache size"]
+          >>> print(cpus["cache size"])
           4096 KB
           >>>
     """
-- 
2.54.0

