Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5EE56C
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jan 2025 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738028796; cv=none; b=rtLEhSK2Ax8V+7EsO/wANfCeC/EgZ7KbiI35bugbO7CZFQfbez8YTjOk1QoUTELdZyx8zDICpNz3aIBaTjHTtimKkkh8cn1tGOngLsLqs4eidczcCUsfryJoEmqCGC4Uk/+yviFZ50ef2CCmsRJgoGaKd/pVVEZnJNS1wZpmNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738028796; c=relaxed/simple;
	bh=7XYHtJGGb+mhRRC+sWWKeGteQEwC33UgALMAo1IdvYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhJ86zGc/xAf5S6mJ30M+RViHyBePdbBFcOWVtw2jOZe/7z467l7JV7KROZiszHIP6z2iwTy5iif9Pa8Xj2c3aepcM7B6NvY/oTQkZSYHJm/GCgggu76J7GHz4omjX3oQmyR6g7GuXSXgfa1OxfX6VfEeXNZ2Ji2YRv6CmQuaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfMDiWuQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfMDiWuQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738028793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ex1R/2r/ilXLlHAU+yR9SsSdW4tWJH58IB+AS83QX0k=;
	b=WfMDiWuQFgPwIoEJisesZTbv5NYpHyYjbD+9qMPTmniiojLvVlJJ0QbvwNlrs6krZ0bNoq
	AM8cxuHDwA3Pxo4GmO/X7uhT5KZetifHC/nuxkaK85jLcGKEmydIHHoEFfJaNmF0XuwHan
	lugXZ4sOtnkPfLQsNedxkE050l0Pkro=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Sihib_EYPLWco3suzy_8Pg-1; Mon, 27 Jan 2025 20:46:31 -0500
X-MC-Unique: Sihib_EYPLWco3suzy_8Pg-1
X-Mimecast-MFC-AGG-ID: Sihib_EYPLWco3suzy_8Pg
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46790c5b1a5so131642201cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jan 2025 17:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738028790; x=1738633590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ex1R/2r/ilXLlHAU+yR9SsSdW4tWJH58IB+AS83QX0k=;
        b=L/CzxsWXpJ/xrc4QnLan7gc7ZeJG8wsoyk9cQxkCRuFc7UUtfWA6fne3p0Q6GrnR2j
         n0i6qwtBn6qOYfo1+Jajhc7c0zbKKu6NHl/iqeRx5OBWI7mzaPRZYuShcypA9YLrjtsS
         IFHBXG1azoFNcc2/mpGQM41Wo7DiSldKPND1qcuXhmvf35JBX39mz3Nx25b2jHV2YnWJ
         UQLBw85KhAkjStp5lFqRNf9+eu6z2YoVXdPdWJ2RuVER4VI8Oaep0cCIbIDE7veJabTg
         FxwEOskArLyzDYXRNVcMMKdqrUlIYxviSEzbQXamnCDnsdMSGk/wmJ61OaAY2lgsyY/S
         quOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3YkwdChYbhUGCs/eIMKlKXAqa5p2wzhNnv0rDY7X5knIPwbLi2yxv9aF5hOJGKKOnf2nZm0K1OqfdKFvCGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxygK5dlJKZGtoL8p+VcvFfpfYM6RSoJs/Ldo/N/0ca6RjPSV
	o7J8E4yf9POHpQRrfJT0G/R+VazJ7bDc5FAQ4EI9B2s1pqUcY2jTP5OQGo3kxLiq/b66LNK22sM
	G8KYkAIO8uI8VT0laJXM5/+QC6qvKSqVckmxWu2ly65S8fQ4ZdldvOcJJwqubchrQ
X-Gm-Gg: ASbGncvR8LlbK4NkOu6T6LiMhmrBZaZVxzHkZPjNe2hcfONgS+QiqWqUP8640emZ0Or
	vnkbYpWVIyZ8X+5bLsyc/2NsTwwsFI3zVU7bX51umEVIAUbAbDkth/bpJCdTKOSMsj/PFyUIG72
	3lpkyX1uWo/p+YAuvjv875XW2wwXOpMP45shJOhM63mUK49bxmlskBI3BjFvj9lsiRD2AGFjADN
	HT2duAC4prnyngVRZZ6X1ZtYDaaWFMAA0NIEsQLCGAdhQYgxKjFSrCYECcLxkpD0dRKPYJa38th
	yF+xPuT3/vdzf18=
X-Received: by 2002:ac8:59d0:0:b0:466:89f8:305e with SMTP id d75a77b69052e-46e12b85de9mr659053321cf.38.1738028790454;
        Mon, 27 Jan 2025 17:46:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET2DEchkvAQnNELLkrNVK9gn3uYD2z9aeIohcvsXyJO5BJQHgnw2J5SLRKFbhHkgwwhZorRw==
X-Received: by 2002:ac8:59d0:0:b0:466:89f8:305e with SMTP id d75a77b69052e-46e12b85de9mr659053041cf.38.1738028790077;
        Mon, 27 Jan 2025 17:46:30 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.51.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e6687f10dsm45570161cf.25.2025.01.27.17.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 17:46:29 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 1/2] tuna: extract cpu and nics determination code into a utils.py file
Date: Mon, 27 Jan 2025 20:45:47 -0500
Message-ID: <20250128014551.15058-2-jwyatt@redhat.com>
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

Extracting the code allows these previously local (global to the file)
variables and functions to be used in other files of Tuna. Reducing
the number of globals makes the code cleaner and reduces the size of
tuna-cmd.py.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tuna-cmd.py   | 34 +++++++---------------------------
 tuna/utils.py | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 27 deletions(-)
 create mode 100644 tuna/utils.py

diff --git a/tuna-cmd.py b/tuna-cmd.py
index f37e286..d0323f5 100755
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
index 0000000..9010df3
--- /dev/null
+++ b/tuna/utils.py
@@ -0,0 +1,27 @@
+# Copyright (C) 2024 John B. Wyatt IV
+# SPDX-License-Identifier: GPL-2.0-only
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
+def get_nics():
+    global nics
+    if nics != None:
+        return nics
+    nics = ethtool.get_active_devices()
+    return nics
+
+
-- 
2.48.1

