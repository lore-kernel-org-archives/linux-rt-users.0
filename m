Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CB33CE82
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541888; cv=none; b=Gq2ZmfFeAk3oqWd7+S6SZLLb84O1JNNSupz2LS73I0F9TwQZwWlOQbJpSsW5knMs1gEzIVB3YiPvHmgGVFSxYZKmmCKZi41gLkGPkt65g3StoTe/SuvEL/CvUh5kQG/7E7UWWUppKLiNHl53UQiAfm3xA0WA4kkINt75RtSwM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541888; c=relaxed/simple;
	bh=VuZgwKgQC7nsJUBVIQtS2AdrCSGA4sps7jg9qQ3yjak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+4XuZzbfMkN5wgVPhqUzhwikSx9Dzu5Xe9CNdVQOAWT+6jJIVeJ4FiX1e6bvBBIjPuMgAOTBfIHkZ6ADBlcDcbVTy6Rl28jwRPDj43hwSwOgSckQKd9etOyx/Qvm8+NlUawMkggisF22mfSx41sVJP3//swnVc2Cdw44j2syE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa0ZyBIC; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa0ZyBIC"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b21fa7b91bso101542385a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541885; x=1763146685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vavBd6sy8hynIA7QcE2Skyi6MESGUkztHlSrpKz6Fdc=;
        b=Oa0ZyBIC/pDg3WCuPRsSzBwD4SGYwo9armK8T8mP+5Bxnu4aPP5laZYE9sHLN5cN83
         e9G19m0tTK56BYNfQDp7YOj2Zy3exMd4/txS7l/vgfD5R1tWh4xYaZPw1oyLxaDFW6hi
         wYTSzTZENjnQnF1d6gOcUA7waNC0Gv9fjUgn1DZru3uV1EH26ijpXZhTWgngAxmRQ2Xa
         x/DHV1HiIM0ypUpjeahMfNcNC2r5u1xSYtXenfmh2GTQefavaqgDt5mFT4cLlzNYLkyA
         /Fh8xk5on2ti6tdzJ5VWv5vTworsUQKqFz6+6hnrUEYPKnQVwEmCLuds997wVSsnEskH
         JP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541885; x=1763146685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vavBd6sy8hynIA7QcE2Skyi6MESGUkztHlSrpKz6Fdc=;
        b=QiwaC62NAV2p52E5BkMRdeAAFHi+RIjypw94Qdjy70VlT/F9M6v2NTNdOsQ/lI3hwj
         OOI57VCjzMrf/4ImsDv3x2xG3a0pu23/DljqPH4q1DYhv4zdPlh9v1LcGWt9H93hSnLv
         rsIGdel8dHXwXrT1il4ea8wFGrbQvTO/gXrbDKoe7vPSlcLgHFj2tgIGKOUzWNkIYXrS
         Lcx1HNT64e9R+NjmfMX0T02waT7KkHFQpJbKKp4/O0TamJh/pfvef82siVW6JtlHiEHm
         pmZbjZeFh/Y6bhQcEfBQTUzsqogE5tD05r/e0i5edWDhgZCOELIdGxnq+NV7RwQrOsGt
         PLgw==
X-Gm-Message-State: AOJu0Yw7dqCb7MMT3HG/S8fVUGjHaSBNEgHwNrKIkJsJGtGyH0jQbY+A
	/w6gD07IihhgLIskvu994Q8Yz8LRGhmFWfljIUHRRTXmWMEcP3jpKU5aJKXtSfWL
X-Gm-Gg: ASbGncuh9Ghw3Lwb5yotHaqVpfPqDRbU8pCPkZbbxyjYnGS+4cTiMVV2s9bUrJh7ar8
	4kEm4Dc6vY6Igdqt+K8kO7sKef6jx5iWlfzYEAXYATsBoGnT6QLP9sIx3kq9BUtjjN9a0M0dA8e
	OXP5IoYuGdeZQjVG2X+vQYgX064NcHT59Cu7EVUh6mU7NAK+Ojie/EUSyDa1ivMxf+j6fGKcPVW
	znqVRNGHOY4viPyNJHoL0PGd3StdvsXhc+XQWwChZJiThaYRQF4MpyVvKJGgXv/moJNqXNF5JJy
	OInFAQohjkDAihZ5VFroz9vgY+Bt8UmjC1PN6ebjZeXVadd2FqylBfpNuCFXrMFQVM9VWEFfJBG
	VR7KL63vIw1jqcV6QWwGV9ugdlZAG2fZF1Q/R7tUYVh1LSASnM/asL6obtNfeoKo=
X-Google-Smtp-Source: AGHT+IEhb4knc/j0g8yRhADpbh38DJwpA8e4USG9RdgTf01HuGIPXM0SpnL9WK54gK/Jdu37Brr+9A==
X-Received: by 2002:a05:620a:710a:b0:8a3:1b83:fdb with SMTP id af79cd13be357-8b257f3b369mr42897985a.46.1762541885237;
        Fri, 07 Nov 2025 10:58:05 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:04 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 07/23] tuna: extract common cpu and nics determination code into a utils.py file
Date: Fri,  7 Nov 2025 13:57:16 -0500
Message-ID: <20251107185732.23992-8-jkacur@redhat.com>
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

Extracting the code allows these previously local (global to the file)
variables and functions to be used in other files of tuna. Reducing
the number of globals makes the code cleaner and reduces the size of
tuna-cmd.py.

Included a suggestion by Crystal to move a function from the latter
patch into utils.py and make it dependent on get_nr_cpus() (v2).

Included a request by John Kacur to place the SPDX message at the top of
the file (v4).

Suggested-by: Crystal Wood <crwood@redhat.com>

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
- minor spelling error fix
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py   | 34 +++++++---------------------------
 tuna/utils.py | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 27 deletions(-)
 create mode 100644 tuna/utils.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index f37e286bffdb..d0323f510750 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -21,7 +21,7 @@ from functools import reduce
 import tuna.new_eth as ethtool
 import tuna.tuna_sched as tuna_sched
 import procfs
-from tuna import tuna, sysfs
+from tuna import tuna, sysfs, utils
 import logging
 import time
 import shutil
@@ -76,7 +76,6 @@ except:
 
 # FIXME: ETOOMANYGLOBALS, we need a class!
 
-nr_cpus = None
 ps = None
 irqs = None
 
@@ -233,25 +232,6 @@ def gen_parser():
     return parser
 
 
-def get_nr_cpus():
-    """ Get all cpus including disabled cpus """
-    global nr_cpus
-    if nr_cpus:
-        return nr_cpus
-    nr_cpus = os.sysconf('SC_NPROCESSORS_CONF')
-    return nr_cpus
-
-nics = None
-
-
-def get_nics():
-    global nics
-    if nics:
-        return nics
-    nics = ethtool.get_active_devices()
-    return nics
-
-
 def thread_help(tid):
     global ps
     if not ps:
@@ -277,7 +257,7 @@ def save(cpu_list, thread_list, filename):
         if (cpu_list and not set(kt.affinity).intersection(set(cpu_list))) or \
            (thread_list and kt.pid not in thread_list):
             del kthreads[name]
-    tuna.generate_rtgroups(filename, kthreads, get_nr_cpus())
+    tuna.generate_rtgroups(filename, kthreads, utils.get_nr_cpus())
 
 
 def ps_show_header(has_ctxt_switch_info, cgroups=False):
@@ -328,7 +308,7 @@ def format_affinity(affinity):
     if len(affinity) <= 4:
         return ",".join(str(a) for a in affinity)
 
-    return ",".join(str(hex(a)) for a in procfs.hexbitmask(affinity, get_nr_cpus()))
+    return ",".join(str(hex(a)) for a in procfs.hexbitmask(affinity, utils.get_nr_cpus()))
 
 def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
                    sock_inode_re, cgroups, columns=None, compact=True):
@@ -351,7 +331,7 @@ def ps_show_thread(pid, affect_children, ps, has_ctxt_switch_info, sock_inodes,
                 irqs = procfs.interrupts()
             users = irqs[tuna.irq_thread_number(cmd)]["users"]
             for u in users:
-                if u in get_nics():
+                if u in utils.get_nics():
                     users[users.index(u)] = "%s(%s)" % (
                         u, ethtool.get_module(u))
             users = ",".join(users)
@@ -486,7 +466,7 @@ def do_ps(thread_list, cpu_list, irq_list, show_uthreads, show_kthreads,
 
 
 def find_drivers_by_users(users):
-    nics = get_nics()
+    nics = utils.get_nics()
     drivers = []
     for u in users:
         try:
@@ -689,10 +669,10 @@ def main():
         apply_config(args.profilename)
 
     elif args.command in ['include', 'I']:
-        tuna.include_cpus(args.cpu_list, get_nr_cpus())
+        tuna.include_cpus(args.cpu_list, utils.get_nr_cpus())
 
     elif args.command in ['isolate', 'i']:
-        tuna.isolate_cpus(args.cpu_list, get_nr_cpus())
+        tuna.isolate_cpus(args.cpu_list, utils.get_nr_cpus())
 
     elif args.command in ['run', 'r']:
 
diff --git a/tuna/utils.py b/tuna/utils.py
new file mode 100644
index 000000000000..f55432dbbbb0
--- /dev/null
+++ b/tuna/utils.py
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2024 John B. Wyatt IV
+
+import os
+
+import tuna.new_eth as ethtool
+
+# Collect a few globals and functions so they can be reused in other modules
+nr_cpus = None
+nics = None
+
+def get_nr_cpus():
+    """ Get all cpus including disabled cpus """
+    global nr_cpus
+    if nr_cpus != None:
+        return nr_cpus
+    nr_cpus = os.sysconf('SC_NPROCESSORS_CONF')
+    return nr_cpus
+
+def get_all_cpu_list():
+    return list(range(get_nr_cpus()))
+
+def get_nics():
+    global nics
+    if nics != None:
+        return nics
+    nics = ethtool.get_active_devices()
+    return nics
-- 
2.51.1

