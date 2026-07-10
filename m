Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE42D661C
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692977; cv=none; b=tvvZNGwbdt9Y2/wb545bb1zs/OYLl0yFvlMNeXHzjhQNhzeSehOVUOgJ0HOqofOVJmoQun/OKdRomA2P/Pss8SramCJbJpzD6sopeKPwjls/ZB+5TqOgJJshbM8TxUgp8ja+MXnCQRqkZOMhH5J0AAlTty3fhhlV67VZeShNvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692977; c=relaxed/simple;
	bh=G1r9BGac/3vxktLA8rspQ58HBjbnuL8/322mdihXSS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csGlYd6+tjygYk9MK4ZskRLbGoHR7r+NArrmKry7qiOYNrt4AjC5OnifaxiFt9SJp9V1UnHNaWA+e6BJ1DKJDjDlkly02atrTwPOj39lEdrmPvwLA13XBfYppmDasavhx/u7lRu2Ijcur0c59hy7rik8UfejO65YfliXBoOg0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQHgCOyF; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQHgCOyF"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-96730906293so685381241.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692975; x=1784297775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBpyIibwQq31aKtytbdnVAYLy8gZK5RDrGTNUS+mMpU=;
        b=QQHgCOyFhiKuT/wvvctzTdObVgxzFliImkkjoObLmqhZ3UZDJ6bhp980m4b46k9/Px
         cBL53S1wkcC3zBBAsSyUwfyUR4eh1zOTmkkz7w+wfjrR1Wjc9S3U1wAgpD+7KJ9MoejY
         oKke0SxwmQKKqPxT6ZJUZl+LHoYwhaDg0ii9Cn5Za3mm1RDGPycvaP5lrmiysT1avzIT
         WzUzS184aMvrZqmRtbHI6dzRE6AanEukidb7JmgsUJXySCGdAuHnsapeE6Ph9SXf9S84
         +AUEGxgPLDxMaJSrscmc+jyWJ6lE5z8ufnVikdE9z7jouRDk/aKh8xj7qQkWf6oE1+z9
         QOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692975; x=1784297775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OBpyIibwQq31aKtytbdnVAYLy8gZK5RDrGTNUS+mMpU=;
        b=ZaiV0RYwMxFfZ5jM5EudtMFP4kJuRfNMmouRgK/YQSxPL7SRCwxYEN5sZaZeammD1S
         x2zgrjHMFs4AmzBbZzYnF8ah4TITHKCwS8mf/j/lYc28H3ESD+wXuDpkeT3uelf2baX0
         SAU4LGa5k6mRe1brCLQ6L+69++Vjo4DmNV60oJnMVRZc7/u2ntJSUrE/8lCBN+Lww3RL
         GTIYPD+n00ww4UPBVtCTPcJLP4Ov6P/Br9ER68kdDtoNblxRQbxmScSvHJd1kU63lcbf
         tjMmYkvg5bWJFnCLcHGSKEkiJN6aDgQShg1dpK9zhT6InCkBltLX9zVUdl5wwNoZl08S
         5Vnw==
X-Gm-Message-State: AOJu0YyuXPzuJcm13pMjYbVb5d7dNeVTBcFEXABFIMmCHrOE8/P6nI78
	FO5SyKoyhbgPVO+jPDnkv3AKvgoyJIf6xfiGNwBOyKI3t5ee1BmxKUDQK5UULw==
X-Gm-Gg: AfdE7cnXBfGx1QfsFWhfVMO/T8gaAgg51eNvGv3I2lg7Lt4Qx6ZAZAiqnecccXFSgaj
	l+PR84+K5gmpvYwaRhClIOxfnGsRR9ukvPQZoElQUvMRTqiJbgDADUBZrNqkxURa6ThRSdQiVeD
	dTDaTU5LTT0X1JsqTfvpVTgBHAY+iNYTqFFKfq1583BXbyuhX2wX3gkPbYm90wf8bMWF5S4XUr0
	i6g9HjyBZu9NmSkrjhTTSMKJfW4Oron0xdbXE1AS/87wzEQOVINy2JWIN8u+FXbJ3tGDRa54ClU
	260CQTj6SwiqETACWokUne1nhkTE6XXocXZYCs5EF2szcmO0y0Gefagjjm2Vwe9tF7NHQITa1DB
	4E0oD8figS8BgEmAEUEZDIphOE8TncoiKqEDGBSf6wzcLYR6phpNiSbscKKa3vBEMxFTa30Sj6R
	4woGM+hbxUP5R4/Z8RvJ1LnsleGM2dkq/oH32CyGw+A+MfWIxGMYG2Xj+4FnntVv6pWZHNwfORK
	g==
X-Received: by 2002:a05:6102:598c:b0:726:8813:2078 with SMTP id ada2fe7eead31-744dfebf3c1mr7135696137.11.1783692975267;
        Fri, 10 Jul 2026 07:16:15 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:14 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 20/36] tuna: Dynamically find free CPU for test_cpu_exclusive
Date: Fri, 10 Jul 2026 10:14:58 -0400
Message-ID: <20260710141523.36440-21-jkacur@redhat.com>
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

Update test_cpu_exclusive to dynamically find an available CPU based on
the actual system configuration instead of hardcoding CPU ranges.

The test now:
- Scans all existing cpusets to find which CPUs are exclusively allocated
- Reads actual system CPUs from /sys/fs/cgroup/cpuset.cpus.effective
- Falls back to multiprocessing.cpu_count() if needed
- Searches through actual available CPUs on the system
- Finds the first non-exclusively-allocated CPU
- Gracefully skips the test if all CPUs are exclusively allocated

This works on systems with any number of CPUs (2, 4, 8, 64, 128+) and
allows tests to run cleanly regardless of existing cpuset configuration.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_cpuset.py | 58 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/tests/test_cpuset.py b/tests/test_cpuset.py
index ca0a6b0c9ccd..92a3f833f371 100644
--- a/tests/test_cpuset.py
+++ b/tests/test_cpuset.py
@@ -200,11 +200,62 @@ class TestCpusetConfiguration(unittest.TestCase):
 
     def test_cpu_exclusive(self):
         """Test CPU exclusive (partition) setting"""
+        # Find a CPU that isn't already exclusively allocated to avoid conflicts
+        # Read all existing cpusets and their exclusive CPUs
+        used_cpus = set()
+        all_cpusets = cpuset.list_cpusets(recursive=True)
+
+        for cs_name in all_cpusets:
+            cs_path = os.path.join('/sys/fs/cgroup', cs_name)
+            partition_file = os.path.join(cs_path, 'cpuset.cpus.partition')
+
+            # Check if this cpuset has an isolated partition
+            if os.path.exists(partition_file):
+                with open(partition_file) as f:
+                    partition = f.read().strip()
+                if partition.startswith('isolated'):
+                    # This cpuset has exclusively allocated CPUs
+                    cpus_file = os.path.join(cs_path, 'cpuset.cpus')
+                    if os.path.exists(cpus_file):
+                        with open(cpus_file) as f:
+                            cpus_str = f.read().strip()
+                        if cpus_str:
+                            # Parse CPU list and add to used set
+                            from tuna import tuna
+                            try:
+                                cpu_list = tuna.expand_cpulist(cpus_str)
+                                used_cpus.update(cpu_list)
+                            except:
+                                pass
+
+        # Get actual number of CPUs on this system
+        # Read from root cgroup's effective CPUs
+        root_cpus_file = '/sys/fs/cgroup/cpuset.cpus.effective'
+        try:
+            with open(root_cpus_file) as f:
+                root_cpus_str = f.read().strip()
+            from tuna import tuna
+            available_cpus = tuna.expand_cpulist(root_cpus_str)
+        except:
+            # Fallback: use multiprocessing to get CPU count
+            import multiprocessing
+            available_cpus = list(range(multiprocessing.cpu_count()))
+
+        # Find first available CPU that isn't exclusively allocated
+        test_cpu = None
+        for cpu_num in available_cpus:
+            if cpu_num not in used_cpus:
+                test_cpu = str(cpu_num)
+                break
+
+        if test_cpu is None:
+            self.skipTest("No available CPUs found for exclusive partition test (all CPUs are exclusively allocated)")
+
         cs = cpuset.Cpuset('test_exclusive')
         self.test_cpusets.append(cs)
 
         cs.write_memnode('0')
-        cs.assign_cpus('0')
+        cs.assign_cpus(test_cpu)
 
         # Try to set exclusive (may not be supported on all kernels)
         cs.set_cpu_exclusive()
@@ -213,8 +264,9 @@ class TestCpusetConfiguration(unittest.TestCase):
         if os.path.exists(partition_file):
             with open(partition_file) as f:
                 partition = f.read().strip()
-            # Should be 'isolated' or 'root' (if not supported)
-            self.assertIn(partition, ['isolated', 'root', 'member'])
+            # Should be 'isolated', 'root', or 'member'
+            self.assertIn(partition, ['isolated', 'root', 'member'],
+                         f"Unexpected partition state: {partition}")
 
 
 @unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
-- 
2.54.0

