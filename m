Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B7C34B437
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159714; cv=none; b=FLewp0bO7Zp+2JsTCYuvmbEgRkW+Si4EGlfRCdgGkk4XhiEtxM2ilgYzuUDdJNsUTTYOiExwyi8W890je6rldcFXKyiFcmJ0HJNu1GdJbXyirW8q6HQCuVQvFKNx4kaaT1+dfwYCaZOb6rd5OjdVdVHRSmkTSGtBvKS7T/3PKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159714; c=relaxed/simple;
	bh=MI3o3gAejomAPxCJEp9rujUor9F8nMqXHj1wY9ztUVY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTWbZPOCSUy826j2+6Hy++u1KIP8+EAqvMZFKmUXaYuFJO4C/3VYiqxucofLUJW3GLdWo11KPCu7J6n/C2LnchqZ1yF4L+VR7p4RZMP/QIYpZ4VVijz2bPG69w76daSzkmgO0/BnLqkEq90T08YIgdV+wx8/sRwrSv3bhU+Jt3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf3Q2NUf; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf3Q2NUf"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91587626ae1so569614985a.3
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Jun 2026 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782159712; x=1782764512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg6XtZ9qWrWrLCGK6K2i3BNU1PrXj5y3nR3VFxY1O4w=;
        b=Yf3Q2NUfTlFBiaNv4LTh7CvLMToCau28vRQ3LN+byEgg0NadVp4WlDWiTn3/2C0Z0U
         p9nAYJYuMzZEook3CygcaCKgNsrNPyWUbmcwlydVlwbdRfNIPZGlNJ+ssvdJ0g4Fn7TM
         AaoVBkTjIbhAIPSI1xdJwb89UbFZ/GF4O1cQL10Ud78hH+UWNNv4PyLOVL/ByUkMugpB
         P3uWYr4avM43NmAYYThALQsFfGILE5bxTeC+zvbuVG1AICARHeBXFhOZNELTAN5fg/Ah
         Od8gpyWIR+1fYHaQtliLqSdfBTRqmolmgoBrBHkQexQUnm1jXeZD8I5DT9ChTUuccPtW
         xUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159712; x=1782764512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lg6XtZ9qWrWrLCGK6K2i3BNU1PrXj5y3nR3VFxY1O4w=;
        b=IfNWsjBeMlrU8Ep9ntcb/M3IeTEjgd/XpHosTW0NAeIdRyP86O8RIsaQVSCfrUk4hc
         ej9Z6w8HAgkOJhjD6IxTA5W8VDCCb0eq2Pe+P8WVBtYfF55c5PEY8zUyPZbfMowRZCfC
         a4m0hx2QwOnK2HAFev8xMgv8hjd5IAPfpH8elKfK7MWrriIy/7ZTeexIOPRFkmeH/KE3
         YK0w2uxw/B7a9rgktI+Poq1gxNVWVBtk+hR2ZYX25zPTmxJeRHakEZgeu+to4I4zdWSK
         IMXxmzkM+FW6JmpMnDGokbAdauUKR6SeI2PudSD+Zcjv7w4pewcSHc0H1gllCipfwl0h
         Y2+w==
X-Gm-Message-State: AOJu0YwUu6mSKgPVA3B4TZdSMvj3uNOPEyo0QfXa/lCIIVS7bJF9TU3Y
	M5fwg7jupwm08rif7XwrKKDByoMQuAzeA/ZLHYi77ud5BR6ukORJNDXl4yeqpg==
X-Gm-Gg: AfdE7cmC/o7RUKQOEQga4bnZ3SVoBklyO7dt9STY7WsgL8300uTCVJOd7YiB8oq53Ss
	Wa3M4DRxqk8nvmH6XnXSxHTccjiTJtZq0bSrA/FFqscwv6vb6aVOEUd/bJvxWkh9y+WCje++O4i
	mNKur69u+6lqcXhO30OneP/Dr4PsceTTtMn+uxzVgHMq3vwy3l/Q/nIWIRtcHj38diU6uqwJoDX
	ZkpDhKkEJjzvZVMmKTQ6cbns/MsI6BDjlwtRiqx9ongESO59WeOIOYTiXf8tsW/Jrw4tshJq4rT
	pV9FngxYpfxayJDgAan97wGuP811Qgk6p3ChcV/SGbYiJ7BZfRXeAgs3aTBCddpiUyibmmly27/
	oeU7vhwr5oYbWa8UUhFxvyLq+3/nDnK8sELlvC3Do/z25I9naQ2mTZY+zml/d3YSPY9MraQuSI4
	7/AXs2te3xkh6sxsbm9YaeF2rEnt9ej8xtw/x4DOYUgAeEYiTtj+XcmL4UezTz7tHnteF+m3dc+
	2ghVi1Yv6udSPR9IMzX
X-Received: by 2002:a05:620a:280e:b0:912:67ca:bac6 with SMTP id af79cd13be357-920913955d3mr2491048185a.26.1782159711826;
        Mon, 22 Jun 2026 13:21:51 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bd89sm70661285a.45.2026.06.22.13.21.50
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:21:50 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH 5/6] tuna: Add comprehensive docstrings to converter functions
Date: Mon, 22 Jun 2026 16:21:30 -0400
Message-ID: <20260622202131.182067-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202131.182067-1-jkacur@redhat.com>
References: <20260622202131.182067-1-jkacur@redhat.com>
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

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
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

