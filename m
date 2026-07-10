Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDEA31716B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692956; cv=none; b=Eqpgm7N4hHZCuxmAQ/VVyFfe7xw1DEnUa0EnZjXLkYZN9UlxMxkbmNDS4EaaDOG8eL9B6a/ho/Nc6/QXgpY1cdpKmjtlC82cmd/uETgN6OaHvz7UgvBnL2Hnqa6goLGowHAZbagpozxihz6QIPp7qKpHeBEx9wWszW7Cn9cM8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692956; c=relaxed/simple;
	bh=Cv1I3V07bZRDcWbIKqTu8w7SRd1q6yx1T9v7gfLyUQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvzrD4NPIRZt22ISgHc5e8DTZv4vDMRttt1kLTtxF9V5GwU+5EDKXwj0yUqUoRNtngF3g6jDyV6bI0uA7HXBmftpMMaify/5V2gODvjYAlwUMSrCFIibfiq+PbDA4JLRwQZnaDicG4x0qj9M3Dh3KN0nUG+GK3Nxahl/HNIs2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7MVNhc4; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7MVNhc4"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bf8a2932a3so457251e0c.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692954; x=1784297754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nahrfgdoAuNKhOUE2hPr4MTycM6VdPMk+vl8eJB3Df0=;
        b=q7MVNhc4ULB61vbfs6dJ7LHq2kN4gNHH6q73GLZDu7vbgYUni6ttuiUGfQYcwFJS1U
         XTeuE87GkHmeSS6gwCg4XNk5XEBh0vyAyLzVEPbiGtYQqCQwh7WI+gLGo5s78mayKy6z
         1/or0TuTWcNgSOGQKXrVyoXuPu2/1ltREzn/pEnZI8Jhof8YkRJSuUhSIe2PNOZ98Dze
         /FvhFPIE8nQ/bvSzWDBunSXFXm6psFP+ccOBMxXWfpInkNifdGwh+oIbREqobgfvsopK
         s5NDJ9z7Kqrrxa7wWk9iAOhsSZdL9mXOe38IXTGCccDJYvZXSynkl3L/3DmwQPRcpLgw
         qmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692954; x=1784297754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nahrfgdoAuNKhOUE2hPr4MTycM6VdPMk+vl8eJB3Df0=;
        b=fKpwVZr1cEgc/LKDm2hNyMe5T71Sgv/VZcHJ5JH4K6wl2GhnZS3EVDjiefINmY/6ct
         zO3u4uEO1FPkJUU6w5pBDLuuGObFf/hgXHxyvGVbukNw6PpLjK3kNkYAqO6L2rajoK3Q
         wmp927FUlercRergK1WrDEpW0q86owOkj4IPwA76YbAID3oFOliHtmCOpEr5Ac3gO1nO
         3h90S9eSWbVlVAXacASnT3CNIlfgwyIXso+OOA66Hs1jtHbIWdT2kH4YxHauUU3iiHl+
         X/6M5ucoOM6Oti71F4vMvl78G3YfsjQJszKh4FOkZ1Rk77+ntUPhJcejnuAI/49VQuif
         PLcA==
X-Gm-Message-State: AOJu0Ywz6fmMRJ4Md0GvuFa5jEU99j9MRf7/tdaZpU+7y8ya00i4NboA
	RZMkYdIJ0larRKVxRFVFOto7OAMsxJdY2SR9LOtr7juqb7J5popUE21cRDck/g==
X-Gm-Gg: AfdE7ckxj2BaR9fB31Zd9IHmhu+fSu9Sz1Y9coirGQWrxUFE684UT6puynzFskX7Ucl
	Q7orD0xloFfV0D/7m0X6Q991Hf1+7JzDQf2VTt4h40HHP4hj2bDq705INiJQKqlYnqfjiJE99u4
	ggAmz17ePZYV2Eh/7JiHrNSwrVq7PLtH0MFoGJopCBpJTl511BvMcrz4GRbe2bFSM9bAQEAzX5q
	65l5YNWoKQo0wykXETauNAHqRXak42uG3veMUtB7kh4QZOElFVPWoM3DYqhO/vEm1Fehdc7Bl8D
	I7ah5TElfKn8oHwofXA5JJV/ZrFHIhNEyo7E+pNMyfrFcB9EbQ3g1yIrLqwyRnQAaFhbKA5CX1v
	h9EZ8+tGU2ut8VEeuPtaCkgzWALUArHCiy1Gu9y9mOo5Y6HDI/G/Qyy5OlWkCqcB/OUdXMglHQS
	mdSfwjKJL1hWxuHzTdVWo5bvBrOhHBCRcXrS+Fz3b5LEEkZHwG+stm6DNnzWL0lf3XTrrF9ariU
	w==
X-Received: by 2002:a05:6102:5126:b0:738:fd01:5b60 with SMTP id ada2fe7eead31-744dfde9057mr8073292137.3.1783692953550;
        Fri, 10 Jul 2026 07:15:53 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:53 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 05/36] tuna: Add comprehensive docstrings to converter functions
Date: Fri, 10 Jul 2026 10:14:43 -0400
Message-ID: <20260710141523.36440-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710141523.36440-1-jkacur@redhat.com>
References: <20260710141523.36440-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add detailed docstrings to all argparse converter functions to improve
code documentation and maintainability:

- threadstring_to_list(): Documents flexible input formats (PIDs,
  patterns, mixed), parameters, and the match_requested return value
- irqstring_to_list(): Explains IRQ number and pattern matching
- socketstring_to_list(): Documents socket-to-CPU expansion and
  validation behavior
- pick_op(): Explains operation prefix extraction (+, -, or None)
- get_loglevel(): Documents numeric (0-4) and string format conversion
- get_policy_and_rtprio(): Explains POLICY:RTPRIO parsing

Each docstring includes Args, Returns, and Notes sections with clear
examples of accepted input formats. This completes task #3 from the
argparse enhancements tracking document.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py  | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tuna/tuna.py |  30 +++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 6cb0a679cc60..f1605896c33c 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -28,6 +28,28 @@ import shutil
 import tuna.cpupower as cpw
 
 def get_loglevel(level):
+    """Convert a logging level string to a Python logging level constant.
+
+    Accepts either numeric (0-4) or string (DEBUG, INFO, WARNING, ERROR) formats.
+    Numeric values are multiplied by 10 to match Python logging constants.
+
+    Args:
+        level: Logging level as string. Can be:
+              - Numeric: "0" (NOTSET), "1" (DEBUG), "2" (INFO), "3" (WARNING), "4" (ERROR)
+              - String: "DEBUG", "INFO", "WARNING", "ERROR" (case-insensitive)
+
+    Returns:
+        Integer logging level constant compatible with Python's logging module.
+        - Numeric input: Returns level * 10 (e.g., "1" -> 10 for DEBUG)
+        - String input: Returns the uppercase string (e.g., "debug" -> "DEBUG")
+
+    Raises:
+        ValueError: If level is "CRITICAL" (not supported by tuna)
+
+    Note:
+        Python logging levels: 0=NOTSET, 10=DEBUG, 20=INFO, 30=WARNING, 40=ERROR, 50=CRITICAL
+        CRITICAL level is explicitly rejected as tuna does not support it.
+    """
     if level.isdigit() and int(level) in range(0,5):
         # logging built-in module levels:
         # 0 - NOTSET
@@ -541,6 +563,31 @@ def do_list_op(op, current_list, op_list):
     return list(set(op_list))
 
 def threadstring_to_list(threadstr, ps=None):
+    """Convert a thread specifier string to a list of thread IDs.
+
+    Accepts flexible input formats with comma and/or space separators.
+    Thread specifiers can be numeric PIDs or name patterns with wildcards.
+
+    Args:
+        threadstr: String of thread specifiers. Can be:
+                  - Numeric PIDs: "1", "1,2,3", "1, 2, 3", "1 2 3"
+                  - Thread name patterns: "systemd*", "kworker/*"
+                  - Mixed: "1,systemd*,100", "1 systemd* 100"
+                  Patterns use shell-style wildcards (* and ?).
+        ps: Optional procfs.pidstats() object. If None, will be created
+            on demand when needed to resolve name patterns.
+
+    Returns:
+        Tuple of (thread_list, match_requested) where:
+        - thread_list: List of integer PIDs that match the specifiers
+        - match_requested: Boolean indicating if any filtering was requested
+                          (True if threadstr is non-empty, False otherwise)
+
+    Note:
+        The match_requested flag is used by display functions to determine
+        whether to show only matched threads or all threads in the system.
+        Empty input returns ([], False) to indicate "show all threads".
+    """
     match_requested = bool(threadstr)
     thread_list = []
     if not threadstr:
@@ -561,6 +608,30 @@ def threadstring_to_list(threadstr, ps=None):
     return thread_list, match_requested
 
 def irqstring_to_list(irqstr):
+    """Convert an IRQ specifier string to a list of IRQ numbers.
+
+    Accepts flexible input formats with comma and/or space separators.
+    IRQ specifiers can be numeric IRQ numbers or IRQ user patterns with wildcards.
+
+    Args:
+        irqstr: String of IRQ specifiers. Can be:
+                - Numeric IRQ numbers: "50", "50,51,52", "50, 51, 52", "50 51 52"
+                - IRQ user patterns: "eth0*", "nvme*"
+                - Mixed: "50,eth0*,100", "50 eth0* 100"
+                Patterns use shell-style wildcards (* and ?) matched against
+                IRQ user names from /proc/interrupts.
+
+    Returns:
+        Tuple of (irq_list, match_requested) where:
+        - irq_list: List of integer IRQ numbers that match the specifiers
+        - match_requested: Boolean indicating if any filtering was requested
+                          (True if irqstr is non-empty, False otherwise)
+
+    Note:
+        The match_requested flag is used by display functions to determine
+        whether to show only matched IRQs or all IRQs in the system.
+        Empty input returns ([], False) to indicate "show all IRQs".
+    """
     match_requested = bool(irqstr)
     irq_list = []
     if not irqstr:
@@ -578,6 +649,30 @@ def irqstring_to_list(irqstr):
     return irq_list, match_requested
 
 def socketstring_to_list(socketstr):
+    """Convert a CPU socket specifier string to a list of CPU numbers.
+
+    Accepts flexible input formats with comma and/or space separators.
+    Socket specifiers are socket IDs that get expanded to all CPUs in those sockets.
+
+    Args:
+        socketstr: String of socket specifiers. Can be:
+                  - Single socket: "0"
+                  - Multiple sockets: "0,1", "0, 1", "0 1"
+                  Socket IDs must be valid socket numbers present in the system.
+
+    Returns:
+        List of integer CPU numbers belonging to the specified sockets.
+        CPUs are returned in the order they appear in sysfs.
+
+    Raises:
+        SystemExit: If any socket ID is invalid. Prints available sockets
+                   and exits with code 2.
+
+    Note:
+        This function queries sysfs to discover CPU topology and validate
+        socket IDs. Invalid socket IDs cause immediate program termination
+        with an error message showing valid options.
+    """
     cpu_list = []
     # Split by both comma and whitespace
     import re
@@ -593,6 +688,30 @@ def socketstring_to_list(socketstr):
     return cpu_list
 
 def pick_op(argument):
+    """Extract an operation prefix from an argument string.
+
+    Checks if the argument starts with a '+' or '-' operation prefix.
+    If present, returns the operation and the remaining string.
+
+    Args:
+        argument: String to check for operation prefix.
+
+    Returns:
+        Tuple of (operation, remaining_string) where:
+        - operation: '+' for addition, '-' for removal, None for replacement
+        - remaining_string: The argument with the operation prefix removed,
+                           or the original argument if no prefix was found
+
+    Examples:
+        >>> pick_op("+1,2,3")
+        ('+', '1,2,3')
+        >>> pick_op("-0,1")
+        ('-', '0,1')
+        >>> pick_op("1,2,3")
+        (None, '1,2,3')
+        >>> pick_op("")
+        (None, '')
+    """
     if argument == "":
         return (None, argument)
     if argument[0] in ('+', '-'):
diff --git a/tuna/tuna.py b/tuna/tuna.py
index be3ca5017ef0..1cb538575b17 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -530,6 +530,36 @@ def get_irq_affinity_text(irqs, irq):
         return ""
 
 def get_policy_and_rtprio(parm):
+    """Parse a scheduling policy and priority from a POLICY:RTPRIO string.
+
+    Accepts flexible input formats for specifying scheduler policy and real-time priority.
+    Can specify just a policy, just a priority, or both separated by a colon.
+
+    Args:
+        parm: String specifying policy and/or priority. Can be:
+             - Policy only: "FIFO", "RR", "OTHER", "BATCH", "IDLE"
+             - Priority only: "50" (assumes current policy)
+             - Both: "FIFO:50", "RR:99"
+             Policy names are case-insensitive.
+
+    Returns:
+        Tuple of (policy, rtprio) where:
+        - policy: Integer scheduling policy constant (e.g., SCHED_FIFO, SCHED_RR)
+                 or None if only priority was specified
+        - rtprio: Integer real-time priority (1-99 for RT policies, 0 for others)
+                 Defaults to 1 for RT policies if not specified
+
+    Raises:
+        ValueError: If the policy name is invalid or cannot be parsed
+
+    Examples:
+        >>> get_policy_and_rtprio("FIFO:50")
+        (SCHED_FIFO, 50)
+        >>> get_policy_and_rtprio("RR")
+        (SCHED_RR, 1)
+        >>> get_policy_and_rtprio("50")
+        (None, 50)
+    """
     parms = parm.split(":")
     rtprio = 0
     policy = None
-- 
2.54.0

