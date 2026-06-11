Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B46481236
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210337; cv=none; b=lX7w3jV615/oDTECzeKQocXVgU7XJKUt302vmMeEWAIAegUiMGocCwv5Pofdtt9QLMIT9zhkjTj161zdgrpibG5nOUmAttwJOyJW0vf4gsLykfyQjphq8i9opPPeUjI+yYbw/72pks5wwNmE/T0CRnbK4v1AG0aMe/VvIqoWL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210337; c=relaxed/simple;
	bh=a4MFKeuWqkMsNxaBtRWEG2c8v91kLroESaiQtDIsklA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEBqfIpA3wJPuh4I6QM15/P311ppV8WjD5Zov4rxVXd/8ASEYa60At1C4QWtmxQGnpLTI32IS+9UrOO2V+gYZksFpFHojhp4iGAeMaaJu8QGqWoYk6Ea0qb/5dcmI44koyXP+YNqmHPwJKD5JTClog0BUO+7/s5gW8JtF4aVNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM49jkIJ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM49jkIJ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5176a2fd597so1760241cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210333; x=1781815133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFwUnoNF4N0Pt0JCt+ovnP99QiC/04VsOgfV9GTh/G8=;
        b=AM49jkIJ+UJvB2FwCQDRciZd4byvY5WyiKrxyFkd68QXmJhJzvcQCtCMNLjtAqQwB5
         teHtwIl5VxCGQEno6lL5meIaUzvNHAblxHEUC9wJClh3ymnaixYVlulr/IofR8Uezsd6
         4cbE9PprASpqqBcA/xNhIDsE78Nbw/60AzYrvYuuM+AEmZk2X6RIHa8pQdiQF/HJ1tdP
         MeIM1+e7ZygDL8yEWIiGpNsus/vVP35ve9FyjNqKe6D10VXLwkmKubRWMPCSXi51KleP
         iaLa8Q9mUqW4rYLrP2czJRsAGSzlg02cNZtImOy220EtpBMQXvbVs0tBkqssbIlWV/5W
         QPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210333; x=1781815133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFwUnoNF4N0Pt0JCt+ovnP99QiC/04VsOgfV9GTh/G8=;
        b=TUg2RvciXZVE4ATyr1WUcGiobLdZdEZF404JBNlclifoQOo76OcF/eeYFctcbl0I5w
         WP7ShBAwSTqDE4gP22ySzv+tFWm64PDn3NAReXX050u75tHUOZa5s2IVEgnRyCqKJJqd
         NMQgiN5lpaLGswc97d04zitI4tsa9iAPt6cVs2m9CodOihFfsfYLiYyiKAQTx0S3Z/UQ
         II0S4Gc2qEfRLkuVd1D+xOCKs1nm10hzI7OzGQVuPrg75ok33NsCC+SPPaPM2KXlQ9PN
         6ln9fIE5JW5KPmTTu9QAn8GeZbcCfoF+xCslqmIcKyNPyjWlKSxh6i1HfO22pvI9xTNw
         4LdA==
X-Gm-Message-State: AOJu0Yy92PecQuXBuO8bBaHrarycrrr6EuXI4rcB9bK3x01gKnblxChr
	S10efo5+6+yeTiYTB7vYb2VbTfnJMyxv7+maGFWRryt1BcGMQBnnXlUooLgQYw==
X-Gm-Gg: Acq92OG8tsSafwAdxzs6kVTnBlaeCXxK65XZhZhT3mqoikXQ/qswQI+nhAY7tnadp4d
	8bd8s1t+6MxbrbzDp7M5q6jXmtE3xcbMw7oLsojN6yFQu+Ina14wr2aLG7StB/WcwPZcvjKouRe
	RyoOuIFptgFQj+p0JqxcyPbYnQ5DZQHfIK25c89SC59W4kemVT5YKYSlk3n0sdC01L+xOVrhZZ7
	61h8VGrGh+seggCPtgTs1KuffJbKoygspB6/n/z1ULWG4Jzf9GnfOvSTbb4ZGDEf5PHEpLT016F
	XgmpgQpLkNxRO7BRCWv8KHx//IhUE4QfcXkJrEUMSkRoi2kv5RGH09WmaIzLTonCRnAf8AR/3bJ
	WqCaAM945srFkmr27pJFb9NHfGSEb2BKvyEvC0YB9qLkfy/xTFmS2ujBDNtHMG3B7vMJM+3qa88
	oKucHh0Ebl+RjZSfnNz8ylqaHr9YGDqqM20QXgEzDGakeeb386kvZa+ql1OAjKZ/Ptd8L9F65LM
	ANkgOVf0C55Z2u/VW0=
X-Received: by 2002:a05:622a:99b:b0:50b:4a84:aa94 with SMTP id d75a77b69052e-517edcd82f9mr71731351cf.7.1781210333276;
        Thu, 11 Jun 2026 13:38:53 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642541sm3214051cf.10.2026.06.11.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:38:52 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 3/5] tuna: Eliminate global ps and irqs variables
Date: Thu, 11 Jun 2026 16:38:30 -0400
Message-ID: <20260611203832.176805-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611203832.176805-1-jkacur@redhat.com>
References: <20260611203832.176805-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the remaining global variables (ps and irqs) and pass them as
function parameters instead. This completes the refactoring to eliminate
side effects and global state from the codebase.

The ps and irqs globals were used as a cache/singleton pattern where they
would be lazily initialized on first use and reused across function calls.
However, most commands only call these functions once, so the caching
benefit was minimal while the global state made the code harder to
understand and test.

Changes:
- Removed global variable declarations for ps and irqs (lines 78-82)
- Removed "FIXME: ETOOMANYGLOBALS" comment - issue is now resolved
- Updated thread_help() to accept ps as parameter
- Removed global ps declaration from main(), made it local variable
- Added irqs parameter to ps_show_thread() signature
- Added irqs parameter to ps_show() signature
- Updated do_ps() to create irqs locally and pass to ps_show()
- Updated show_irqs() to create irqs locally instead of using global
- Updated what_is command to create ps if needed and pass to thread_help()
- Updated all call sites to pass parameters correctly

Benefits:
- No global variables - all state is now local or explicitly passed
- Functions are pure with clear dependencies visible in signatures
- Code is more testable and easier to understand
- Explicit control flow with no hidden state

All 6 existing unit tests pass.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index 4da6c6ea6ce5..d83e57732360 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -75,11 +75,6 @@ try:
 except ImportError:
     have_inet_diag = False
 
-# FIXME: ETOOMANYGLOBALS, we need a class!
-
-ps = None
-irqs = None
-
 class HelpMessageParser(argparse.ArgumentParser):
     def error(self, message):
         sys.stderr.write(f'error: {message}\n')
@@ -250,11 +245,7 @@ def gen_parser():
     return parser
 
 
-def thread_help(tid):
-    global ps
-    if not ps:
-        ps = procfs.pidstats()
-
+def thread_help(tid, ps):
     if tid not in ps:
         print(f"tuna: thread {tid} doesn't exist!")
         return
@@ -329,8 +320,7 @@ def format_affinity(affinity):
     return ",".join(str(hex(a)) for a in procfs.hexbitmask(affinity, utils.get_nr_cpus()))
 
 def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
-                   sock_inode_re, cgroups, columns=None, compact=True):
-    global irqs
+                   sock_inode_re, cgroups, irqs, columns=None, compact=True):
     try:
         affinity = format_affinity(os.sched_getaffinity(pid))
     except OSError as e:
@@ -345,8 +335,6 @@ def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
     users = ""
     if tuna.is_irq_thread(cmd):
         try:
-            if not irqs:
-                irqs = procfs.interrupts()
             users = irqs[tuna.irq_thread_number(cmd)]["users"]
             for u in users:
                 if u in utils.get_nics():
@@ -388,12 +376,12 @@ def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
         for tid in list(ps[pid]["threads"].keys()):
             ps_show_thread(tid, False, ps[pid]["threads"],
                            has_ctxt_switch_info,
-                           sock_inodes, sock_inode_re, cgroups, columns, compact)
+                           sock_inodes, sock_inode_re, cgroups, irqs, columns, compact)
 
 
 def ps_show(ps, affect_children, thread_list, cpu_list,
             irq_list_numbers, show_uthreads, show_kthreads,
-            has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested):
+            has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested, irqs):
 
     ps_list = []
     for pid in list(ps.keys()):
@@ -443,7 +431,7 @@ def ps_show(ps, affect_children, thread_list, cpu_list,
 
     for pid in ps_list:
         ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info,
-                       sock_inodes, sock_inode_re, cgroups, columns, compact)
+                       sock_inodes, sock_inode_re, cgroups, irqs, columns, compact)
 
 
 def load_socktype(socktype, inodes):
@@ -469,6 +457,8 @@ def do_ps(thread_list, cpu_list, irq_list, show_uthreads, show_kthreads,
     if affect_children:
         ps.reload_threads()
 
+    irqs = procfs.interrupts()
+
     sock_inodes = None
     sock_inode_re = None
     if show_sockets:
@@ -481,7 +471,7 @@ def do_ps(thread_list, cpu_list, irq_list, show_uthreads, show_kthreads,
             ps_show_header(has_ctxt_switch_info, cgroups)
         ps_show(ps, affect_children, thread_list,
                 cpu_list, irq_list, show_uthreads, show_kthreads,
-                has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested)
+                has_ctxt_switch_info, sock_inodes, sock_inode_re, cgroups, compact, match_requested, irqs)
     except IOError:
         # 'tuna -P | head' for instance
         pass
@@ -505,9 +495,7 @@ def find_drivers_by_users(users):
 
 
 def show_irqs(irq_list, cpu_list, match_requested):
-    global irqs
-    if not irqs:
-        irqs = procfs.interrupts()
+    irqs = procfs.interrupts()
 
     if sys.stdout.isatty():
         print("%4s %-16s %8s" % ("#", _("users"), _("affinity"),))
@@ -655,8 +643,6 @@ def nohz_full_to_cpu():
 
 
 def main():
-    global ps
-
     i18n_init()
     parser = gen_parser()
     # Set all necessary defaults for gui subparser if no arguments provided
@@ -681,6 +667,7 @@ def main():
 
     # Convert string arguments to lists after parsing
     match_requested = False
+    ps = None
 
     # Convert thread_list from string to list
     if 'thread_list' in vars(args) and args.thread_list:
@@ -772,8 +759,10 @@ def main():
         save(args.cpu_list, args.thread_list, args.filename)
 
     elif args.command in ['W', 'what_is']:
+        if not ps:
+            ps = procfs.pidstats()
         for tid in args.thread_list:
-            thread_help(tid)
+            thread_help(tid, ps)
 
     elif args.command in ['g', 'gui']:
         # Don't try to start the gui if no display is available
-- 
2.54.0

