Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E7FC0A
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210338; cv=none; b=NSEa+PmMUw1vIzNXQRpmq6UHJHVgNtE9kf2jkFSG9ShAVxGqWx2u1sqr6zsEzHcMDBRD60Fe8EieFUrDKSbyOxKAh2sk4NZV5KxCCQA6EHZlQx+fuq179Kn6meXmfE3MupqP7BqcvTFVNAixRNWwsKBbhOF/pEGH55rAxQUi0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210338; c=relaxed/simple;
	bh=kpHfKYgnrBzhKIRvhNzTqxY0ofUk0TY4s1cYYKvnFLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBmwcPD3/zrGhpfVEkXi5Lp8C9NoiLQGFQ3uMtn+SN+MIP0L0JvNcsA0flz4Q+bK3hs3ieS0yMqieL7vEkgPUhxObjJLFvmNzSoFrz7AQUdFvFWIuI5yqXnbVyTAAqp3bK+sjdRl51qA9KFT89v57lxTDoQ2yGSd/SPpgbCac4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CswoXrMx; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CswoXrMx"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517863a2edfso1721411cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210332; x=1781815132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5Kir3lKD9Nn3afcNhQm0a5tYkuXpeYD5zw8HEdOY+o=;
        b=CswoXrMx7JBBaYDZ6okOSzxnFnJp9wCA8VQv+HKM8Bn/AbdXeixYFQrgH/JASQwkRi
         HKJbwnRxi14nra5I8KY2vI7QvAiJdti1z0mUyjLcPHvTmjpFOTwgxMIuzW5t4xLoWG8e
         ge7FT759Bv0NJqTXlnJYrftULP3zuqMjfPG7NHSLNyh07cT/i8KCLiyPZVhPL4L0Jhp4
         ogjh+NHcD8YMz94Z+9nplJX8jFYPwdxLFAdLZmm7VcrRDAAinhMG1/XitUvehjqrOX+K
         PhgdzzkUrAAOTNwsf7NcXo99tSDFNCt54qxwvejAfljof7iuuR6diXw2dJ3nKbZjRSUh
         JQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210332; x=1781815132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Kir3lKD9Nn3afcNhQm0a5tYkuXpeYD5zw8HEdOY+o=;
        b=sDf3ZBo9EUknoWu74mYDMTWfqXyo69kYRSOP19zs0F1opT+/d1fJYXTWC2lJGEvH1v
         pyO/SYKtKag+5wFgtL+p+OoOW3VhmUoedL47Lm2u8iFbY8PjS6SzB4+1O0FvJc/4APau
         gkuKSYpFh0sXLkL6i6/KBqgd7Uqm69kwyi8Jy6mSenQn9+gAE8nf/QqaxuXwq3+hDbY0
         aOAFYrWbiLd7fboIYBoCCtbpD/gf/20XPtHV+GQV0lKroqUAuOCHLEBG01+4T+JOvDu6
         ZUBJsHcRwUKIq6A4uQyy+LW4Ik+xlntHbnSCRSlXuq10V1OODMhkN7aTAiAqWw+rQOPX
         shQQ==
X-Gm-Message-State: AOJu0YyKJ1UzM64xCvGSbyEh++QyK/DtfouJUmCQ2kQ2UHl6dBpTYBEL
	Eh2yMeXYITzVhIYM4GIDYQH5MLCL6lpWMZxSJ8rbrS8PdoePLaQUS5y/DRLTlQ==
X-Gm-Gg: Acq92OGo9u8+y3rPSALYL4Qh/0NrM1tK49zN24LHSOLseuitebruQhydmUJM7S/A4lJ
	7A3jdyjR+asWHgQwfBhPK4SGzRHBl6gy4gPDolZVXIUEHhlwGDFTB74GWvEFPdntxHk0sf2v3X5
	pkRyCePOzxbJZGVeJGYdCp+YazULDU1kdm0VmdXMGkBrx9q0/Gvxktra/PZIOAmFkoGLTdaJlFd
	qnyQlEiWS0lKlFGOhZKwKc9HzEtF+HTahnN1XNd7Wmj81Jlj0e2lWP/uW5bAusTz3cjIPM4lyNN
	e+mNbZ+M+liGBcxhvrNAaiWWY6wIPJnU1SvrjFgxASC836kR26qpiyYgiLz0j6nyoP6LyZCvDjl
	L09Qa1aLTSig1Z94pYcTFyhBivUovOn/A/lixvyWBgAMUAFpSnfcFf/SqPJHzK5z5cw67zjrG04
	kFZ5rtnCvopxnQqzZVrswTKccsMZSEMRkAlfpCHWDjyS7wfaQqqNsoMcSrOsrjvBvgR9WjvaPMD
	kFROky6OQ+/kOVtmd4=
X-Received: by 2002:ac8:5e46:0:b0:517:626b:778 with SMTP id d75a77b69052e-517ee25753amr65092861cf.49.1781210332346;
        Thu, 11 Jun 2026 13:38:52 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642541sm3214051cf.10.2026.06.11.13.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:38:51 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 2/5] tuna: Eliminate side effects from argparse by deferring type conversions
Date: Thu, 11 Jun 2026 16:38:29 -0400
Message-ID: <20260611203832.176805-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611203832.176805-1-jkacur@redhat.com>
References: <20260611203832.176805-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor argument parsing to remove side effects during the argparse phase
by deferring type conversions until after parsing completes. This creates a
clearer separation between parsing, conversion, and execution.

Problems with the previous implementation:
- Converter functions (threadstring_to_list, irqstring_to_list) were called
  via type= parameter during argparse parsing
- These converters set global variables and created procfs objects before
  knowing what command would run
- Global state (match_requested) was used to coordinate between parsing
  time and execution time

Changes:
- Removed type= parameters for threadstring_to_list and irqstring_to_list
  from POS and MODS dictionaries, changed to type=str with default=''
- Changed sockets argument to store in 'sockets' dest instead of 'cpu_list'
- Updated threadstring_to_list() to accept ps parameter and return tuple
  (thread_list, match_requested_flag)
- Updated irqstring_to_list() to return tuple (irq_list, match_requested_flag)
- Added explicit conversion block in main() after argument parsing
- Eliminated match_requested global variable, now local in main()
- Updated ps_show(), show_irqs(), do_ps() to accept match_requested parameter
- Kept ps and irqs as module-level variables for now

Benefits:
- No side effects during argument parsing
- Clear control flow: parse → convert → execute
- match_requested is now local state instead of global
- Easier to understand and maintain
- Sets foundation for future refactoring of remaining globals

All 6 existing unit tests pass.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 65 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 54f0666fa1bb..4da6c6ea6ce5 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -79,7 +79,6 @@ except ImportError:
 
 ps = None
 irqs = None
-match_requested = False
 
 class HelpMessageParser(argparse.ArgumentParser):
     def error(self, message):
@@ -92,7 +91,7 @@ def gen_parser():
 
     POS = {
             "cpu_list": dict(metavar='CPU-LIST', type=tuna.cpustring_to_list, help="CPU-LIST affected by commands"),
-            "thread_list": dict(metavar='THREAD-LIST', type=threadstring_to_list, help="THREAD-LIST affected by commands"),
+            "thread_list": dict(metavar='THREAD-LIST', type=str, help="THREAD-LIST affected by commands"),
             "filename": dict(metavar='FILENAME', type=str, help="Save kthreads sched tunables to this file"),
             "profilename": dict(type=str, help="Apply changes described in this file"),
             "run_command": dict(metavar='COMMAND', type=str, help="fork a new process and run the \"COMMAND\""),
@@ -103,10 +102,10 @@ def gen_parser():
             "logging": dict(dest='loglevel', metavar='LOG-LEVEL', type=get_loglevel, help="Log application details to file for given LOG-LEVEL"),
             "debug" : dict(action='store_true', dest='debug', help='Print DEBUG level logging details to console'),
             "version": dict(action='version', version='0.20', help="show version"),
-            "threads": dict(dest='thread_list', default=[], metavar='THREAD-LIST', type=threadstring_to_list, help="THREAD-LIST affected by commands"),
-            "irqs": dict(dest='irq_list', default=[], metavar='IRQ-LIST', type=irqstring_to_list, help="IRQ-LIST affect by commands"),
+            "threads": dict(dest='thread_list', default='', metavar='THREAD-LIST', type=str, help="THREAD-LIST affected by commands"),
+            "irqs": dict(dest='irq_list', default='', metavar='IRQ-LIST', type=str, help="IRQ-LIST affect by commands"),
             "cpus": dict(dest='cpu_list', default=[], metavar='CPU-LIST', type=tuna.cpustring_to_list, help='CPU-LIST affected by commands'),
-            "sockets": dict(dest='cpu_list', default=[], metavar='CPU-SOCKET-LIST', type=socketstring_to_list, help="CPU-SOCKET-LIST affected by commands"),
+            "sockets": dict(dest='sockets', default='', metavar='CPU-SOCKET-LIST', type=str, help="CPU-SOCKET-LIST affected by commands"),
             "show_sockets": dict(action='store_true', help='Show network sockets in use by threads'),
             "cgroups": dict(action='store_true', dest='cgroups', help='Display the processes with the type of cgroups they are in'),
             "spaced": dict(action='store_false', dest='compact', help='Display spaced view for cgroups'),
@@ -394,9 +393,7 @@ def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
 
 def ps_show(ps, affect_children, thread_list, cpu_list,
             irq_list_numbers, show_uthreads, show_kthreads,
-            has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact):
-
-    global match_requested
+            has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested):
 
     ps_list = []
     for pid in list(ps.keys()):
@@ -467,7 +464,7 @@ def load_sockets():
 
 
 def do_ps(thread_list, cpu_list, irq_list, show_uthreads, show_kthreads,
-          affect_children, show_sockets, cgroups, compact):
+          affect_children, show_sockets, cgroups, compact, match_requested):
     ps = procfs.pidstats()
     if affect_children:
         ps.reload_threads()
@@ -484,7 +481,7 @@ def do_ps(thread_list, cpu_list, irq_list, show_uthreads, show_kthreads,
             ps_show_header(has_ctxt_switch_info, cgroups)
         ps_show(ps, affect_children, thread_list,
                 cpu_list, irq_list, show_uthreads, show_kthreads,
-                has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact)
+                has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested)
     except IOError:
         # 'tuna -P | head' for instance
         pass
@@ -507,9 +504,8 @@ def find_drivers_by_users(users):
     return drivers
 
 
-def show_irqs(irq_list, cpu_list):
+def show_irqs(irq_list, cpu_list, match_requested):
     global irqs
-    global match_requested
     if not irqs:
         irqs = procfs.interrupts()
 
@@ -554,30 +550,29 @@ def do_list_op(op, current_list, op_list):
         return list(set(current_list) - set(op_list))
     return list(set(op_list))
 
-def threadstring_to_list(threadstr):
-    global ps
-    global match_requested
-    if threadstr:
-        match_requested = True
+def threadstring_to_list(threadstr, ps=None):
+    match_requested = bool(threadstr)
     thread_list = []
+    if not threadstr:
+        return thread_list, match_requested
     thread_strings = list(set(threadstr.split(',')))
     for s in thread_strings:
         if s.isdigit():
             thread_list.append(int(s))
         else:
-            ps = procfs.pidstats()
+            if ps is None:
+                ps = procfs.pidstats()
             try:
                 thread_list += ps.find_by_regex(re.compile(fnmatch.translate(s)))
             except re.error:
                 thread_list += ps.find_by_name(s)
-    return thread_list
+    return thread_list, match_requested
 
 def irqstring_to_list(irqstr):
-
-    global match_requested
-    if irqstr:
-        match_requested = True
+    match_requested = bool(irqstr)
     irq_list = []
+    if not irqstr:
+        return irq_list, match_requested
     irq_strings = list(set(irqstr.split(',')))
     for s in irq_strings:
         if s.isdigit():
@@ -586,7 +581,7 @@ def irqstring_to_list(irqstr):
             # find_by_user_regex returns a list of strings corresponding to irq number
             irq_list_str = procfs.interrupts().find_by_user_regex(re.compile(fnmatch.translate(s)))
             irq_list += [int(i) for i in irq_list_str if i.isdigit()]
-    return irq_list
+    return irq_list, match_requested
 
 def socketstring_to_list(socketstr):
     cpu_list = []
@@ -684,6 +679,24 @@ def main():
             print("Valid log levels: NOTSET, DEBUG, INFO, WARNING, ERROR")
             print("Log levels may be specified numerically (0-4)\n")
 
+    # Convert string arguments to lists after parsing
+    match_requested = False
+
+    # Convert thread_list from string to list
+    if 'thread_list' in vars(args) and args.thread_list:
+        if isinstance(args.thread_list, str):
+            args.thread_list, match_requested = threadstring_to_list(args.thread_list, ps)
+
+    # Convert irq_list from string to list
+    if 'irq_list' in vars(args) and args.irq_list:
+        if isinstance(args.irq_list, str):
+            args.irq_list, irq_match_requested = irqstring_to_list(args.irq_list)
+            match_requested = match_requested or irq_match_requested
+
+    # Convert socket strings to cpu lists
+    if hasattr(args, 'sockets') and args.sockets:
+        args.cpu_list = socketstring_to_list(args.sockets)
+
     if args.command == 'cpu_power':
         if not cpw.have_cpupower:
             print(f"Error: libcpupower bindings are not detected; please install libcpupower bindings from at least kernel {cpw.cpupower_required_kernel}.", file=sys.stderr)
@@ -738,10 +751,10 @@ def main():
 
     elif args.command in ['show_threads']:
         do_ps(args.thread_list, args.cpu_list, args.irq_list, args.uthreads,
-                args.kthreads, args.affect_children, args.show_sockets if "show_sockets" in args else None, args.cgroups, args.compact)
+                args.kthreads, args.affect_children, args.show_sockets if "show_sockets" in args else None, args.cgroups, args.compact, match_requested)
 
     elif args.command in ['show_irqs']:
-        show_irqs(args.irq_list, args.cpu_list)
+        show_irqs(args.irq_list, args.cpu_list, match_requested)
 
     elif args.command in ['move', 'm', 'spread', 'x']:
         spread = args.command in ['spread', 'x']
-- 
2.54.0

