Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9423F40D
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Mar 2025 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370858; cv=none; b=pOayCNWJv3Oc8VkiMyrpSJLTk/AFPFxtAjGAM3w5umUFHdv3eqkn1EFd7yPxhEESONU3ray+aIRDUzL19pkWt7yNJyNeVOOKUpozgmS13XivsBFz4l1DchseBTPapOsl/R8PSJfe8YpXmT4blVStZXkUaafOOpYYqEv1iFhOhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370858; c=relaxed/simple;
	bh=BX3a/w17JvM7eEZujtJk0HQYCfPkLy/0//301SLoZcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEFWWYKPpb2L7+ndqZN0x/M/ysIjiUA38IwpHc4TOpJhGFKOcQZjqUPGugrOuclAT5SfTef5vf5bdJq1SESfxCIZP67S0E88S+JiuSOKS0nxxsISyXFDi+kotZ8tWjqECuWAQ+cCF0qwy8JEngaFN/ZSHarylU2qCcM3c9geZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CooFDWdN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CooFDWdN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741370855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrLRnXvM1fOzuS+t87FetmX0WSJSdB6NNDcE/lYHzvE=;
	b=CooFDWdNo+kcv+dtIzpsQMEY+4v5bW+UvzxYLlI+qZd9SNLB8Lb1xq7JDszE59Qe6lcBrk
	eMWo1gCs8KTnRP1sTd3kZxt2ZXSChfdIYzLH4Xsmr4aQHHxFsA6IVs3hEratwkClK+3WWv
	z9uRkrqUefs1jtdDPm18Ywfne2ri9Ko=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-U5u6YzxzPSOcdtOCPq4A7A-1; Fri, 07 Mar 2025 13:07:34 -0500
X-MC-Unique: U5u6YzxzPSOcdtOCPq4A7A-1
X-Mimecast-MFC-AGG-ID: U5u6YzxzPSOcdtOCPq4A7A_1741370854
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-474f1de8b42so51538621cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Mar 2025 10:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370853; x=1741975653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrLRnXvM1fOzuS+t87FetmX0WSJSdB6NNDcE/lYHzvE=;
        b=Ah4S6E15BusUiHC3D9DZZQtkKVsAZQIO+DKohZhDcESbeFflAnp49hc0cG8Ku98HNj
         GgY0Ts8dOOngVfFEl+/e0ECJN2kaRzDZWqpQQSMxxDEaUWeFt6bneIuyaibdz6SQYZnc
         3hOZHPlS4T2v2uj7ri6cYRx9KD1uQF8wKc1HTQI5zVVTHUr77hS7REfmxw35KTXDwjV2
         +YIu8aGAPN49LSxZrhcic9svFZkJgLtqJWdP4WXshXdKFQjLxz6UAxiEieHe0Yp4Yg5y
         XAHTCc45+DSIhBY2y3N2L+MXy3H0FClHjdMvRVIiL8QTw8WI7bBSBAdX9CSUA7RMUOGo
         DCJw==
X-Forwarded-Encrypted: i=1; AJvYcCXxr2N9WHQtM2zoUolhinl89aiQcYZloEkHb9BODomKyzMFi2J+opGd8lm9xE49CWebCvPnHXuTiw3mq2onEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzREaqHarFe5hC8iGDDAWQikN7cx91aZ2/H8/ai1cook+z9Vdbw
	LpWFsNJEpVqJ9pulPluAH/5W+8IKOJZIujgOmEn6nuHj4DKTOjrqnBlV+BagdCwtWKXo13gvLju
	awVixePSY7r/AWsvKLYguPFdCOhZ1U0XDFhQjGjuE7aI/pS7RAFL7vLyJCUyT9xo6
X-Gm-Gg: ASbGncvOxiTRw1SWCNq3AGHFuTpTirG/Q9F/9NdvkMUNeSSviIQefNliXY7/OcpfCO8
	8tBNYLo+8v5hz1Dgx67Kn2etUg6TetHSdFVLxtdJRBYcKNh72NNK8Q1LU3nRNYQ0yR8BlCt+uiw
	oxEBmR8DH/GbhIq7I2UBx77qWxdoHTBUD/p0chQhU8PT615xiVONGOsFKLXzhQyyjDV6hL7ZulV
	hjV6Jy9y7x7uPx94uJJqIEYwaiI0pimUpXwPhmeNheOKZUtMXdeYWeo83zOhP9u+VdP/Jccg+m6
	smhocEMPPYbA3vbeGRKh2mMDaQ==
X-Received: by 2002:a05:622a:120a:b0:474:fcba:d0d6 with SMTP id d75a77b69052e-4761097a2b8mr51226621cf.12.1741370853273;
        Fri, 07 Mar 2025 10:07:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOalTK49XCb2njrtDHL3u3Z+KnTBTgq71n4cDA2Xy0hSsZPJgyhefl/jpkFxidGAt9A7FYQg==
X-Received: by 2002:a05:622a:120a:b0:474:fcba:d0d6 with SMTP id d75a77b69052e-4761097a2b8mr51226241cf.12.1741370852884;
        Fri, 07 Mar 2025 10:07:32 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751db2f15dsm22684601cf.52.2025.03.07.10.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 10:07:32 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v3 1/2] tuna: extract common cpu and nics determination code into a utils.py file
Date: Fri,  7 Mar 2025 13:07:02 -0500
Message-ID: <20250307180706.5875-2-jwyatt@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307180706.5875-1-jwyatt@redhat.com>
References: <20250307180706.5875-1-jwyatt@redhat.com>
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

