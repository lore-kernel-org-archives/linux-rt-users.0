Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171025F790
	for <linux-rt-users@vger.kernel.org>; Thu, 27 Feb 2025 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688911; cv=none; b=FrRhUS0RD+AkYWLp8NKYDV8HvdJ8D+K4BIfKjvIqynTBmUk4U+GgA0EStYErddRtUOn2T2xUEOMxfSPhrQTYmUecaogdOkLJ620k1dtd4Of1Np6xDUHjBqhxX213NSoJBqSQIJQDq7DQ/4vX0UzbQleCMBj5FBw3JiYn+3p62Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688911; c=relaxed/simple;
	bh=BX3a/w17JvM7eEZujtJk0HQYCfPkLy/0//301SLoZcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkA9WoW2O7dEyeJ0rmBfdd9wDusBiRVz1f4E6YcbBEDoan8PuOqg4Q8QLOnug0ErL59sZl246XKS9W7+tB+dQxgTNHWOcEc9Ua4Me9pnyUSyFXwcdJ8Ql/ZpdFKcjYM51yWLxhquXvr6He1GGwuVbx0F7UHVaAk/KCLyelWZI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZPtUsOD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZPtUsOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740688908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrLRnXvM1fOzuS+t87FetmX0WSJSdB6NNDcE/lYHzvE=;
	b=XZPtUsOD+89BMKdh+ri+0I31HX3RImeDXFMv5tGmjzuMo0TJEVYNzouvN5uMAVGPNjyEOc
	e057XBFn1LYRumcLj++q9VbzL2Z6eQJN2uZlhMzKnAz5Db+giNJ6NOQfKvcnjQqnck2GMv
	66hvFPvAknOLW+wDO6aVOFM2MGnemLw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-ZL0l4-wvP5i59mP_XA5Yfg-1; Thu, 27 Feb 2025 15:41:47 -0500
X-MC-Unique: ZL0l4-wvP5i59mP_XA5Yfg-1
X-Mimecast-MFC-AGG-ID: ZL0l4-wvP5i59mP_XA5Yfg_1740688907
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-855a51d5955so126431339f.3
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Feb 2025 12:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688907; x=1741293707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrLRnXvM1fOzuS+t87FetmX0WSJSdB6NNDcE/lYHzvE=;
        b=vxHpskhN63m9Mc2cEEnDEicDIRRbhen9huAmQfNFMNHahPCDsESAiO9M/+YV4z1hUO
         tRrgspAHSScUEl8/VO6G2f7QwktW3lmviQJgHEyhOImMQ98Xu6hyWm4lTTYm4ET627sU
         48Mf9DvkvBnXNH6//Nffo/1lFYq6UTzqF0xdA2Is7WkUdMr2TgunZ1JsbYhYVK7DH9KW
         VH1D8pgnIE7jX5Wcxwv+cMLuv6pGedI17ubNjh/Ul0qnvNE+tjBvbX7+kmtF3PnULD68
         z38uLa5FPg0bvkSyBvearvtEeHZVvfnJ9mMHRS3LPriSF9JcEdnKhW+DknDRIYhUb1Sw
         HZEg==
X-Forwarded-Encrypted: i=1; AJvYcCUIKSW97x3EWj0UhjvFNzi6id/GjFX9pDv96KoWywPJlatxlp6vS1rdyOQtRM4UnuXd2Dk35POmnETPf4N1KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/ernJC1ZHJ5mHKnRWCACijvMol4mOSY0cuBxOPqC+BSlm22X
	TPBeVluLnY3+N1jvWr7z3Fdy27sapmSzU0Cc0yqAsMuBiS9xmLTb1y2IJA0D7n5Aha64F1y+c6j
	s5r0GY1ExlzhZE4aTSlZ8lRV3mp/ma8CjBnzZ0MW/pSk0dfGHriKV6dTWFgFtqRGq
X-Gm-Gg: ASbGnctfbsf8GI6T8DSwbhvvJ7sSjZPrD4okqENepSE+F5fQxv2cojprZJb2cm+BsFw
	Q8jSvtDBZXyJZpUF0IJ656Y3eKGkYzkdUo0VJF4xbzRIyXgxzao9ZFA4afjP93ZmCA7nkaAbKqK
	V0vBSJ0cYebsbNMiXmyLBNvsXdgFqENTRtJydnpf+PLvLJ5zb3+Xyv7h+miYAh2uHRDMr7r6lTr
	KMDcNiMjafJu+zAWruRWmSYy0t2TBQ1nyXXJu06ZT+c1wDWK8crkkWLiLbeBm7yRjGQHKaTS0iJ
	bH+endcGQyGc7nXlrZsjhhZSbQ==
X-Received: by 2002:a05:6602:6b0a:b0:855:a283:8231 with SMTP id ca18e2360f4ac-85881ef860amr40458439f.1.1740688906645;
        Thu, 27 Feb 2025 12:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWLKMZ87U/O6QWCAoBP8gLpKIosZ11jLmdVA807ileKic/R6BqSSlt7p9P36nJ2tAe9N+I4w==
X-Received: by 2002:a05:6602:6b0a:b0:855:a283:8231 with SMTP id ca18e2360f4ac-85881ef860amr40456639f.1.1740688906313;
        Thu, 27 Feb 2025 12:41:46 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85875130401sm46182339f.24.2025.02.27.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:41:45 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2 1/2] tuna: extract common cpu and nics determination code into a utils.py file
Date: Thu, 27 Feb 2025 15:39:40 -0500
Message-ID: <20250227203944.23622-2-jwyatt@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227203944.23622-1-jwyatt@redhat.com>
References: <20250227203944.23622-1-jwyatt@redhat.com>
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
patch into utils.py and make it dependant on get_nr_cpus().

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
index 0000000..259c604
--- /dev/null
+++ b/tuna/utils.py
@@ -0,0 +1,28 @@
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
2.48.1

