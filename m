Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2092264A70
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Mar 2025 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725044; cv=none; b=fUT6uqhNfRXBm+ekszIJe6CNj20Y8jTFgUl1+bLa+9vUKHxv3XU9IJVG6D96IzHxqLwHQtpWiV5R7QT4SVD6V+spZaKh0A8cMTt9mIZxFRl5pFqiVPK0Vxv+LRW+8dKg9g7It6CR1zlzDW699o2Yw88YxUCt08JUxt1h5z5uop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725044; c=relaxed/simple;
	bh=SkKRuYvbeuo9JN74nFv50EF0rC3mYkTXuW1wLnJfxao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECUvJq3/VEPqK4wADQ5SMtppkMpBbMVwS1XQeTWs6yC2Lc0nR51dm1JGzEwwLEz+ZeCRt7a7rnNIKZN/C4FcDxEZa+qB8Gbywkuh8Sn8MbxCgPQ4uvIVZ17kWJXMrcHl0UoL8UTqR6vEd9PxFF7X3aq4SiyqduEa66aK1JaHjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqmSNZ/l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqmSNZ/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741725041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/fPZIOIO5b07wNwu1V1cSWYuYA+cWT13RRWhAcm9xo=;
	b=HqmSNZ/l1JHH1chGeuUb0mQBGEltAANyjJB3OZFEL+iEUVPLqb0Pl5tqO92QpjC+zyhpqS
	Mw+pxxZpAUqOXHK6Gt3IRus/kN5HxfM4TLLfNcakrGdS536pmCcDROwsxTjC6AWdvfXxg7
	PhIoNTjASQA3iQYYIQ0muXXWiLWxmM0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-nHq6lvXwOj-WKiRgG2fXtg-1; Tue, 11 Mar 2025 16:30:40 -0400
X-MC-Unique: nHq6lvXwOj-WKiRgG2fXtg-1
X-Mimecast-MFC-AGG-ID: nHq6lvXwOj-WKiRgG2fXtg_1741725040
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0922c5cfdso1056731885a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Mar 2025 13:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741725040; x=1742329840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/fPZIOIO5b07wNwu1V1cSWYuYA+cWT13RRWhAcm9xo=;
        b=o4uzCHu8+y3mjnO8NC/gmv9i2NBcgH3HyK/h1jOkU81SflyAmzSxDjR8siSYxx/bgQ
         d1QZCw6sv/E/u8AGg7BPsg8nOpfADm+UGT3KUR2jRgBrPNCoU8mlaZ6nuHx910SvYl9p
         BNAs1td83QxLaxBWZLmqNMg9uDyFzTgqqz1+X3UlKL83x7MVD7iOv/SRCUJtOlYCO1XO
         xEjY/mNRMxUfhlc6Jh96tCo2OtJsLeNZDdqz/zRxKa9eZqzB/TA5AeHQzYyakhQ96BhJ
         ugNDx6DRWyIHVGfHMATyy9Zqhy330B+TS3IVoZyQV0wI7Vwy47QyzYn+c5bHdFL1d9Co
         LE6w==
X-Forwarded-Encrypted: i=1; AJvYcCXj0RwcsPL2+/Dh7Xxk7HlGtFIvLg76OizsBJjfdu0iOnmJEWq1rIXbonpBGsCT5TeY15umPYHITWI/RbqnXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+Ksj+oi/jvs7fE1h3MYM5i87O3X8KcCxih6VQm5y32cnchVW
	yrjCREpG5NJAP3s/+kn5PZP+GdQci5R47IN6nU/tgoZFky6crzZlwH7it/YIXHf4D8oDr2hgGhb
	AgFAqC0rRVb3/Q7qWxgpgmyAQ2FI6QI5Tsv9z6PepynsvsFqQ1541QPXAulYhbyUL
X-Gm-Gg: ASbGnctJmU7BTIDfokbaehLJmBnCB7NZGmISF1UoKXIYMumofEYd0mDymdWZMUIcRVB
	IlA7vkbtDNBnFTl0qBhk/y9kcZDdV4qpV58kGbme6sVU/MBOJr04cjCcEL6cZSd9gUapIeGHBF/
	Wb3BeY4XFdn8VS95TDxQ7R46XJ+Z3lZdambNpbIJfrsmqfdykWKlNVxrWOxiU1vFtK+u5GGgwW+
	QfoVFk0KYJV3yE0u3cbpB93+3IQ/deyewwu6HJ6xQDIJ3D5bjsfr8Tkz2VxcPEKO/tUQ5oQQxBs
	/uMkBQsecvz/MBByQ+6gKmCa7g==
X-Received: by 2002:a05:620a:4883:b0:7c5:5e6b:b238 with SMTP id af79cd13be357-7c55e968f6amr886455185a.51.1741725039699;
        Tue, 11 Mar 2025 13:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/kdaeg2bUmUBBn19pVeU6MXk7ni+uV696K4n5d0YyKbWMIoxkM3Kl1vvUJ4Ss56TvD/yXzQ==
X-Received: by 2002:a05:620a:4883:b0:7c5:5e6b:b238 with SMTP id af79cd13be357-7c55e968f6amr886452085a.51.1741725039397;
        Tue, 11 Mar 2025 13:30:39 -0700 (PDT)
Received: from thinkpad2024.redhat.com ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c555b74a32sm357658585a.19.2025.03.11.13.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:30:39 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v4 1/2] tuna: extract common cpu and nics determination code into a utils.py file
Date: Tue, 11 Mar 2025 16:30:18 -0400
Message-ID: <20250311203034.8065-2-jwyatt@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311203034.8065-1-jwyatt@redhat.com>
References: <20250311203034.8065-1-jwyatt@redhat.com>
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
2.48.1

