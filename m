Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521A1EB9F2
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Apr 2025 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227111; cv=none; b=Th4AQov/+W9lNltKwnrZef+Ut9GAZfx5GCeZmNOgBgTcwrtptrYgzsddZBdvF5TjbdQ5AJEaMSYVtFGJN8O8bOceIQCjma4wJI1FrAxZaMzbVph7sJTJZqRHuuZSUmbavHR3vKsybun7/E2zPpWSLT0u8Jpk8rIp8f3WKgPWa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227111; c=relaxed/simple;
	bh=26jkvx3fziBvCkGKJy1m0n9RcY+1RVZsDZD6Fk2l2eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjVR9K9hGYIOCKwVFNyhNlFYLnzgpsnmA873eoDXTSDC7deyFDrV9dFQVU4ytvACG3o+ICcPKkrUVFw3P8yU/P3EgT2912sswbFmtYqf13QQmtN6b6F0FY4DgsYfd1yzQ7oR8CJzuAOyqZiqkTUikAUIhf0EPlYRL3EksXQYdjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3UO+w4k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3UO+w4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744227107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqMWfELrSHdzMVvj9eXFGX3CrJtmdBm8KqVMnRZ0WkY=;
	b=P3UO+w4kEiKrx1l07wvj7SEA98gsiPkpNaksmlnQOxxrRnoBTe1gu+0a3ICVg+j3wQT2zo
	sF8xTzrYRxaZ0k81v7VX2zMSaSS3FkVXomiAWoiIq2kzyI8l+GzukQ6MIFoQ/v4GX4KNro
	fi7A4EsJ+qBRREPY+/jQr1uDH70PRMI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-ZUqnzXFZN6a2MgKEukMxGQ-1; Wed, 09 Apr 2025 15:31:44 -0400
X-MC-Unique: ZUqnzXFZN6a2MgKEukMxGQ-1
X-Mimecast-MFC-AGG-ID: ZUqnzXFZN6a2MgKEukMxGQ_1744227104
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8feffbe08so171527796d6.0
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Apr 2025 12:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744227104; x=1744831904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqMWfELrSHdzMVvj9eXFGX3CrJtmdBm8KqVMnRZ0WkY=;
        b=iG5IYotc8f0xT2EmuqHuMLxtoU6GmxzFHD4ATbnA6VGGmxOqJsGL77YXD55WmJml/n
         q2HZAzKKYjRaOnK6ZAWFSzAcpNUAchWIezcDD4+7GAWE8RSuNTmqsawgJ6xW1fLXqiqy
         01WMGepCdM/xm7RFx+u+Px+8sPvq1R2VU8yyCMQdENVHLAwUAVy/t3SfRC3UhVzJ/rd7
         /noblgjxbr0/tqI861k+Cu0v9G9bO/dd6H97m2h4XvVZE0TworPNWbR4UAPp03HZDFlS
         mTw8s93vjkGv68SmCFSoOhybjCQVCovjBGRpTsy0zFvB/S8/E4pIntrdxKY5I/YTZzve
         kfPA==
X-Forwarded-Encrypted: i=1; AJvYcCXwwi9fwGWR6rTFY5Ltpc7CeYKy3i79QHRdbO6YQxnyyX3pVIyMpDR7K0C19g4y6GnF1XKg5L7gpd4HC3i9uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyq4Q4ChZ51u2p+hScJNip/KG0MFzrPTmPJG+2z6u3V5SDTTn3
	XdX0byKdY5lMx6ErSTsHTA2kmM+OjUos0Ttl73GTvgdK+3tYPNVDNgl1C9UZ3hG6yghic64aoSG
	8pmBlUIPsrhE0+dzR6+v3D4RQbwSIy49vhQ2weSCTn7Pb4BSL/xer+/XvYI19Diws
X-Gm-Gg: ASbGnctPSUIU/ZYYNrg083u70McuaH07YWsjLPOz4o5kaPBbXnmUVJlueoZ6ZaU42pA
	MWHi3LndNN0a7KrH9kaUov64V0hoWjOQ7EkVs+6O6a9/GC8dIZH7oy1Uk+OD8B/fM+lgYDawFff
	S1KlLDyOqLzPGAYNJ1mY5q7c/DZorqpSD2nCdotFjZu3RhTxBL8goT6QVWuW0+IeS5nY5NmKeGV
	XVuTj+A4ypz0iBB1fZERevq/JTQ+zYmbN2/vl9Bod8nDPEULmnG1j+2kuJONkt+bF4PPldXuAQW
	2Ur6En4SeA==
X-Received: by 2002:a05:6214:c63:b0:6e8:f3af:ed56 with SMTP id 6a1803df08f44-6f0e5aa52f0mr2850546d6.13.1744227103691;
        Wed, 09 Apr 2025 12:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2GGlewttMMuN+Gfb/rQiQ8U85fQE3Mu6zd/a744iGe25OSedf89sxtGiUPtIDcH5vBJLMiQ==
X-Received: by 2002:a05:6214:c63:b0:6e8:f3af:ed56 with SMTP id 6a1803df08f44-6f0e5aa52f0mr2850196d6.13.1744227103306;
        Wed, 09 Apr 2025 12:31:43 -0700 (PDT)
Received: from thinkpad2024.. ([71.217.69.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea08028sm10808586d6.90.2025.04.09.12.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:31:43 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v5 1/2] tuna: extract common cpu and nics determination code into a utils.py file
Date: Wed,  9 Apr 2025 15:31:32 -0400
Message-ID: <20250409193136.44411-2-jwyatt@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409193136.44411-1-jwyatt@redhat.com>
References: <20250409193136.44411-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extracting the code allows these previously local (global to the file)
variables and functions to be used in other files of tuna. Reducing
the number of globals makes the code cleaner and reduces the size of
tuna-cmd.py.

Included a suggestion by Crystal to move a function from the latter
patch into utils.py and make it dependant on get_nr_cpus() (v2).

Included a request by John Kacur to place the SPDX message at the top of
the file (v4).

Suggested-by: Crystal Wood <crwood@redhat.com>

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 tuna-cmd.py   | 34 +++++++---------------------------
 tuna/utils.py | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 27 deletions(-)
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
index 0000000..f55432d
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
2.49.0

