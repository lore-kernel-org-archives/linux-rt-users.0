Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981804D17BD
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116004; cv=none; b=gcgfoUyYP//WY2OgLW9jyf6pTyBzHllhm+ruO7im3S3/h2uVrKvtYKnyq+M/ni8p4RpfnUfuVoXbu53Z9nR7RLXzK01CluSBKktz52QdZn9ICHQz2i27Fc8TJ2UbpsPR52T5TN/3OB89HoAduvDZ9qIeSOMxH3u7kZc7ZZdHf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116004; c=relaxed/simple;
	bh=2CcT//5iemB4UIPQrZERndy+DURV6OL07SKwbc8mBGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rh4uVEdlBj/5tEmQR8NU+jcDqxx54uPaegAdJIymMEK/wMvia71rBwTrrCd39k1A/nWteYCRFuZ7GUW34AnvvQuwAb+zhfbw0Rl0AGrOerJ3TvBrWnJfz2G3u4FWoYEErDlJJiSBEzoeovPcTe9GZkK0vpi7NJz+bWPeOR0efIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUnpk+F2; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUnpk+F2"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91235f46716so2989866d6.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115991; x=1790720791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0faWSPdj7nbBnYUw4dhXuzn2aNje90Y8o/CDNC6f1RU=;
        b=XUnpk+F2+x1KRete3T/zpTvgT/VJMIy1J39Rpit2Awfgq2vNeurYxxHoOM/JpaEBbP
         bzCr6KDZyFZ0Q8g1ss3imkMRDtjrvT1K29qizFZ2kC/EnrOP81LgSQZpEXkD+8T4d2eg
         abgzoVdM2OX70JyJfl96xC9nRTHZDQTiu32xzJp+inP9TSCjGcFy9AKNcIPZ4O9xCIyn
         Tuk6Y2wgD1ftnvGqZ+4yhFeW+le4YTgRRu2VMV28aqGFr5Tb264kfdvtSBkri7xcVsvU
         x8SgGgHLLadlV6GiOf1xIJeN7pIwEd1+Mv3a7sf86MWWYH+b1pvYvkrj7T/MRE5Wyav9
         MIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115991; x=1790720791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0faWSPdj7nbBnYUw4dhXuzn2aNje90Y8o/CDNC6f1RU=;
        b=b7Za5FBoPSg70BT5pHw812r0U3BULunJcPrw2vITse26bflBdHDL5p4bf3uhf4mFn1
         xRapixu4OYgTttR6d2oc61WcIzrTfJbKZ4LuUqyQPt7OLhlABDAV5JLV8TOBaxtb0Jwq
         0QNggNEfEVGAGNqLduisVJtvtBfPGclUtwu5rR2Js4qcgaC2uHZi3aaVIoHwaovaeMWq
         W2MIeXsKPZdDFUhc0O4PnSas2fGjswl9Jfgg87mVUuO7zV4AUA2PA+PH8NU8996APfnc
         VEwwkWcTp0eG9wN3xgD+c8sxr0JRaMSmX4+hLS3Jzrblsxz9OT1H/RaNqCHqcMrMdasQ
         tn/g==
X-Gm-Message-State: AFuF++mu2qTyM+qFgoag+wJSwoERjiDx3Dy5W9GG7tbZISD+mRJcNHGY
	OttU1os+c/0ff48pkoxyrHKurpfRIEgWSrd0lplAkY1OEVWYMI6iZn5+TagC2g==
X-Gm-Gg: AYBFou2sJydi6heyegWvysxhK/5tHsAdA8FFftXFP21FGoAEBOpJrukvErDNFrNI6gm
	4jTEdpTYD48LQnsvxNs/9mgaqYIqKBInxQBtCOuCOrMarcokiFAMv9eYXLc+LdJmB90u1cxFs4q
	mK9vBFthX5TZAy70r1PWT470izIulwTJmSylGQ6WCw3GEclVSZ06zFmT9GQltvb7ixDXoCqt1J6
	Pcu97g/kYqnkS0nqEYZ5P7NOUnaK+BS2xvcQeMR0wg00/CaIz2LG30WTCnEKjzR8ojQ+t1R/+Uo
	oYQnFB+1VS4Oay4deJ18lCvYOc/Bn1TNTJ/aFP1QX2TE5IdcNbK1bm22+dPVpAlMaQzCOdjgzLV
	jOYAzcMpZToNe5SPSE9bM3IBs8pHoFbFeCulZVoesPbsIvGF0xkNJystsfbd9GXgoKyQHUnyvbl
	15xORbo3+P9pndbOb3jlq8mma+jFpTcTlSCl8yajqPrO+wOCMQm4jadnQ+NFTehCka84+mMSHJL
	QnBCnL2RtpBzhNPv9+8AW+vrN1ES32xrzhz6/uBnKBHmcgMgPOpDNM=
X-Received: by 2002:a05:6214:f2a:b0:912:517b:913 with SMTP id 6a1803df08f44-9140c48bd6cmr15622926d6.50.1790115990647;
        Tue, 22 Sep 2026 15:26:30 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4425f3sm7552786d6.34.2026.09.22.15.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:26:30 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 2/8] rteval: Don't create measurement cpuset with --onlyload
Date: Tue, 22 Sep 2026 18:25:46 -0400
Message-ID: <20260922222552.482102-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922222552.482102-1-jkacur@redhat.com>
References: <20260922222552.482102-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--onlyload runs the loads but no measurement threads, yet CpusetManager
always created the rteval_measurement cpuset as an isolated partition.
Nothing is ever migrated into it in this mode, so it served only to
remove its CPUs from the root cgroup where the taskset-bound loads run,
leaving those loads with fewer (or no) usable CPUs for no benefit.

Add a create_measurement parameter to CpusetManager (default True) and
skip creating the measurement cpuset when it is False. rteval-cmd passes
create_measurement=not onlyload, so --onlyload now runs loads without an
empty isolated measurement partition getting in their way.

Add a unit test asserting the measurement cpuset is not created when
create_measurement is False.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                  |  3 ++-
 rteval/cpusetmanager.py     | 22 ++++++++++++++--------
 tests/test_cpusetmanager.py | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 438ead95f843..7a8512e1a254 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -572,7 +572,8 @@ if __name__ == '__main__':
                 housekeeping_cpus=housekeeping_cpus,
                 measurement_cpus=msrcfg_cpus,
                 logger=logger,
-                housekeeping_isolated=rtevcfg.housekeeping_isolated
+                housekeeping_isolated=rtevcfg.housekeeping_isolated,
+                create_measurement=not rtevcfg.onlyload
             )
 
         # Pass cpuset_manager to RtEval (None if not using cpusets)
diff --git a/rteval/cpusetmanager.py b/rteval/cpusetmanager.py
index a204312eda9a..8b257731b4f1 100644
--- a/rteval/cpusetmanager.py
+++ b/rteval/cpusetmanager.py
@@ -23,7 +23,8 @@ class CpusetManager:
 
     Creates 1-2 cpusets based on configuration:
     - rteval_housekeeping: Only if housekeeping_cpus specified
-    - rteval_measurement: Always created for measurement workloads
+    - rteval_measurement: Created unless create_measurement is False
+      (e.g. --onlyload, which runs no measurement workloads)
 
     Load workloads use taskset for CPU affinity (no cpuset needed).
 
@@ -71,7 +72,7 @@ class CpusetManager:
             except Exception as e:
                 logger.log(Log.WARN, f"Failed to clean up {cpuset_name}: {e}")
 
-    def __init__(self, housekeeping_cpus, measurement_cpus, logger, housekeeping_isolated=False):
+    def __init__(self, housekeeping_cpus, measurement_cpus, logger, housekeeping_isolated=False, create_measurement=True):
         """
         Initialize cpuset manager
 
@@ -80,6 +81,8 @@ class CpusetManager:
             measurement_cpus: List of CPU integers for measurement workloads
             logger: rteval Log instance for logging
             housekeeping_isolated: If True, use partition=isolated for housekeeping (default: False = partition=member)
+            create_measurement: If False, skip creating the rteval_measurement cpuset
+                (e.g. --onlyload, which runs no measurement workloads; default: True)
 
         Note: Load workloads use taskset for CPU affinity and don't need cpusets.
         """
@@ -93,6 +96,7 @@ class CpusetManager:
         self.measurement_cpus = measurement_cpus
         self.logger = logger
         self.housekeeping_isolated = housekeeping_isolated
+        self.create_measurement = create_measurement
 
         # Cpuset objects (will be created in __enter__)
         self.housekeeping_cpuset = None
@@ -123,12 +127,14 @@ class CpusetManager:
             self.housekeeping_cpuset.assign_cpus(collapse_cpulist(self.housekeeping_cpus))
             self.housekeeping_cpuset.write_cpu_exclusive(self.housekeeping_isolated)  # partition=isolated if True, member if False
 
-        # Create measurement cpuset
-        self.logger.log(Log.DEBUG, f"Creating rteval_measurement cpuset with CPUs {collapse_cpulist(self.measurement_cpus)}")
-        self.measurement_cpuset = Cpuset('rteval_measurement')
-        self.measurement_cpuset.write_memnode(self.numa_nodes)
-        self.measurement_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
-        self.measurement_cpuset.write_cpu_exclusive(True)  # partition=isolated
+        # Create measurement cpuset (skipped when there are no measurement
+        # workloads, e.g. --onlyload)
+        if self.create_measurement:
+            self.logger.log(Log.DEBUG, f"Creating rteval_measurement cpuset with CPUs {collapse_cpulist(self.measurement_cpus)}")
+            self.measurement_cpuset = Cpuset('rteval_measurement')
+            self.measurement_cpuset.write_memnode(self.numa_nodes)
+            self.measurement_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
+            self.measurement_cpuset.write_cpu_exclusive(True)  # partition=isolated
 
         self.logger.log(Log.INFO, "Cpusets created successfully")
         return self
diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
index 984e0f900edf..8d69fed90443 100644
--- a/tests/test_cpusetmanager.py
+++ b/tests/test_cpusetmanager.py
@@ -132,6 +132,24 @@ class TestCpusetManagerHousekeepingPartitions(unittest.TestCase):
             self.assertTrue(os.path.exists(measurement_path),
                           "Measurement cpuset should exist")
 
+    def test_no_measurement_cpuset_created_when_create_measurement_false(self):
+        """Test that measurement cpuset is not created when create_measurement=False (e.g. --onlyload)"""
+        with CpusetManager(
+            housekeeping_cpus=[0, 1],
+            measurement_cpus=[2, 3],
+            logger=self.logger,
+            create_measurement=False
+        ) as manager:
+            # Check that measurement cpuset does NOT exist
+            measurement_path = '/sys/fs/cgroup/rteval_measurement'
+            self.assertFalse(os.path.exists(measurement_path),
+                           "Measurement cpuset should not exist when create_measurement is False")
+
+            # Check that housekeeping cpuset DOES exist
+            hk_path = '/sys/fs/cgroup/rteval_housekeeping'
+            self.assertTrue(os.path.exists(hk_path),
+                          "Housekeeping cpuset should exist")
+
 
 @unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
 @unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
-- 
2.55.0

