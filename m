Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF24D4887
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116004; cv=none; b=DA8kdpPV+uG+e55fOcOUoa7jmKR5CCH3SUQBYQs4STcFAtZi3B4rySi5BEI7kV9as/y36MsgzGSihE7a0WmiP3Ce3lM6RPfWch0ZN9e16ZftowOZpRPY8xZ1cnR4oPTMdql6pbwpFdfFzEkfRPzKIMdL1xkyAbhfk7T/FO1EgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116004; c=relaxed/simple;
	bh=CzI/ua3UZtIw7WkPY4Rt2YWIHFufExG1ZhLtow10+OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeKjVRRFmXSRUCnWrepcce5Uvns1ZfeNj3n8beQEiDplzrT2rGMzZMV4nupfg9CACXgBIL9qJyGRvvYnkMPX7rHpYeyFVU9fnyET1VAZN7oT/lByq/6VnJjmfeWX5qh5MdLSG/JRGTcTJ2qUePqM5o//c35r7VdL+H5mpIETzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqlsM1N4; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqlsM1N4"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d8a00bcdso2862981cf.2
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115992; x=1790720792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kpF07ANF9YjmoHtyxKDG5HXt/kxsIIgMJ5WDpqPuVTI=;
        b=QqlsM1N4zw2wdnEdTxu6S11esoGgSfCfnNHj9XVg3GeMX1pHoaK+7ZLjKn5vZkJHxh
         DyRjtGQIzlwzMkAqAHLfb8htf0Q5ysdTIHfXDnv4lEt4H6uGUdSofyqHP8QqoFWwThUp
         +sthh3+JtFpYjzuT6NfkClQX/Dmam99WBTAncEj6zHeqWL74hoFniISAyAmF2/PIa6oR
         wZPM8YPFkQkrN0M4xHnqf33myqa/gkY5Tis3XqcPhKtkHlbC3vyql+AbK36LaEpZ/tJw
         ST/Ah3xqX133J7z9BwLI6Gq7mGwlh5LdAVyORAjcQ9E/FJpHipEq0CCMCyivw4N34cJ7
         RZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115992; x=1790720792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpF07ANF9YjmoHtyxKDG5HXt/kxsIIgMJ5WDpqPuVTI=;
        b=Ib078kx1l/dC2a9u14pPYJV3u/1gIeVpTCY9VF5M14i8uY306a/81U8S1UyMUjNspY
         DTGtQrMRjHf68i4dNcYd74r001QxbnIfCy3Ma8umUfXbvG7HdJzzgwFg8eOR6JlQs1+5
         7YV2VB9h0uV6OQK8m3cagm4+0m5maVf+wi0/1/a1LNeTVnYa1lywqgweH+V34BDuxvWK
         jQXySOjlcH0qHRyMc+U/ddbgjpunVV76+8gdv2yKpKcuNzutnOIOtnhfygGBB4Zy84xA
         dWyj6aWp34Ei6y/QUrc7tSwcE838cejSB0cKqyZbgwE7n0orMf4hmegcy2VrUDd+kE8h
         euQw==
X-Gm-Message-State: AFuF++mC3XZUZhBZckXcMPtsNL2Jy4FT3ZEKU5KnrA6dbDCoR4S+jouT
	av1rmDuflfm+dPKYkg9tXS/6eJ4QcCNwyvh/d4WFneJ7RhCj7+3ICoaKOXGgCw==
X-Gm-Gg: AYBFou1UaL3rwIOZu3nhuhZjnXZJ8MEGYmbrESCPsAUyGlFRYS88nRbMlTuCdIZFcRh
	Ab/d0iNaVmYXJoEbmJP5jCkB+2nd1PC7LDFVoaEz2NR66TVAsvVOsSatqn5dUUmE5XoH1+L1u74
	DdRpSYRcE/vtpCQaMcoUIzRE0rWIV0fcZl7Rte6jg4oGhkwD0K0oibZLaZfTzjyJMb9kkR2fsqk
	OG2p11OCCw6lVPW3iUwj7TMdpi7d6ZYhg15d4l3QbjInVdP8Oz87Zjp3jjku+ISmvHsBaqEqrgd
	MV/mgBv4ACrjZ/F9WknDYoY4UQa7QkhBXeeYD0lOpRuH4fIOXm0WK4NJz6dWEiRfL+NCrKgUk0u
	GozifmVC0DrNplfGy2SXoK317cX+GfKqtbFu1Fng3ik1T9oZmV3k53gU+Wt+78E1mdUPqOoPS1b
	E7uIPAsGeSB1VfFTQ4bxspgVBQvlfcza8B/4GawsjcAXa6zlMXtA/PfxCFXODftBanvPTjNjcYO
	lLV1fQUxzUtSvdha2eSOaqMnA2vNAhdt/zJGR+O9Yjq+unF2pbvk9Y=
X-Received: by 2002:a05:622a:190c:b0:52e:3a14:9022 with SMTP id d75a77b69052e-532eac5b9c0mr16577581cf.27.1790115991580;
        Tue, 22 Sep 2026 15:26:31 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4425f3sm7552786d6.34.2026.09.22.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:26:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 3/8] rteval: Add --measurement-member and guard against measurement/load overlap
Date: Tue, 22 Sep 2026 18:25:47 -0400
Message-ID: <20260922222552.482102-4-jkacur@redhat.com>
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

By default, --cpusets creates the rteval_measurement cpuset as a cgroup
v2 isolated partition, which removes its CPUs from the root cgroup where
the taskset-bound loads run. When the measurement and load CPU lists
overlap (as they do by default, when both cover all online CPUs), the
loads are left with no usable CPUs and the run fails in a confusing way.

Add a --measurement-member option that flips the measurement cpuset to a
member partition, letting loads and measurement share CPUs (co-location).
Like --housekeeping-isolated, it requires --cpusets. The partition type
is threaded through to CpusetManager via a measurement_member parameter,
replacing the previously hardcoded isolated partition.

When --cpusets is used with an isolated measurement partition and the
measurement and load CPU lists overlap, fail loud with a message that
points to the two ways forward: add --measurement-member to co-locate,
or supply disjoint --measurement-cpulist and --loads-cpulist. The check
is skipped when no loads run (--noload) or no measurement runs
(--onlyload), since neither can produce the collision.

Add unit tests for the member partition type and the --cpusets guard.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                  | 30 +++++++++++++++++++++++++++++-
 rteval/cpusetmanager.py     | 10 +++++++---
 tests/test_cpusetmanager.py | 29 +++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 7a8512e1a254..46a09c9de3c6 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -126,6 +126,9 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("--housekeeping-isolated", dest="rteval___housekeeping_isolated",
                       action="store_true", default=False,
                       help="make housekeeping cpuset use partition=isolated instead of member (requires --cpusets and --housekeeping)")
+    parser.add_argument("--measurement-member", dest="rteval___measurement_member",
+                      action="store_true", default=False,
+                      help="make measurement cpuset use partition=member instead of isolated, allowing loads and measurement to share CPUs (requires --cpusets)")
     parser.add_argument("--warn-non-isolated-core-sharing", dest="rteval___warn_non_isolated_core_sharing",
                       action="store_true", default=False,
                       help="warn about measurement and load CPUs sharing cores even when neither is isolated")
@@ -420,6 +423,11 @@ if __name__ == '__main__':
             if not rtevcfg.housekeeping:
                 raise RuntimeError("--housekeeping-isolated requires --housekeeping")
 
+        # Validate --measurement-member usage
+        if rtevcfg.measurement_member:
+            if not rtevcfg.cpusets:
+                raise RuntimeError("--measurement-member requires --cpusets")
+
         # Validate and process housekeeping CPUs
         housekeeping_cpus = []
         if rtevcfg.housekeeping:
@@ -517,6 +525,25 @@ if __name__ == '__main__':
         for warning in core_warnings:
             logger.log(Log.WARN, warning)
 
+        # With cpusets, the measurement cpuset is an isolated partition by
+        # default, which removes its CPUs from the root cgroup where the
+        # taskset-bound loads run. If the measurement and load CPUs overlap,
+        # the loads are left with no usable CPUs. Fail loud unless the user
+        # opts into a shared (member) measurement partition. Skipped when no
+        # loads run (--noload) or no measurement runs (--onlyload).
+        if rtevcfg.cpusets and not rtevcfg.measurement_member \
+                and not rtevcfg.noload and not rtevcfg.onlyload:
+            overlap = CpuList(msrcfg_cpus).intersection(ldcfg_cpus)
+            if overlap:
+                raise RuntimeError(
+                    f"Measurement CPUs {CpuList(msrcfg_cpus)} and load CPUs "
+                    f"{CpuList(ldcfg_cpus)} overlap on {overlap}, but the measurement "
+                    "cpuset is an isolated partition, which would remove those CPUs "
+                    "from the loads. Either add --measurement-member to co-locate "
+                    "loads and measurement on the same CPUs, or supply disjoint "
+                    "--measurement-cpulist and --loads-cpulist."
+                )
+
         # if --summarize was specified then just parse the XML, print it and exit
         if cmd_opts.rteval___summarize:
             for xmlfile in cmd_opts.rteval___summarize:
@@ -573,7 +600,8 @@ if __name__ == '__main__':
                 measurement_cpus=msrcfg_cpus,
                 logger=logger,
                 housekeeping_isolated=rtevcfg.housekeeping_isolated,
-                create_measurement=not rtevcfg.onlyload
+                create_measurement=not rtevcfg.onlyload,
+                measurement_member=rtevcfg.measurement_member
             )
 
         # Pass cpuset_manager to RtEval (None if not using cpusets)
diff --git a/rteval/cpusetmanager.py b/rteval/cpusetmanager.py
index 8b257731b4f1..0c99744b42cf 100644
--- a/rteval/cpusetmanager.py
+++ b/rteval/cpusetmanager.py
@@ -72,7 +72,7 @@ class CpusetManager:
             except Exception as e:
                 logger.log(Log.WARN, f"Failed to clean up {cpuset_name}: {e}")
 
-    def __init__(self, housekeeping_cpus, measurement_cpus, logger, housekeeping_isolated=False, create_measurement=True):
+    def __init__(self, housekeeping_cpus, measurement_cpus, logger, housekeeping_isolated=False, create_measurement=True, measurement_member=False):
         """
         Initialize cpuset manager
 
@@ -83,6 +83,8 @@ class CpusetManager:
             housekeeping_isolated: If True, use partition=isolated for housekeeping (default: False = partition=member)
             create_measurement: If False, skip creating the rteval_measurement cpuset
                 (e.g. --onlyload, which runs no measurement workloads; default: True)
+            measurement_member: If True, use partition=member for measurement, allowing
+                loads and measurement to share CPUs (default: False = partition=isolated)
 
         Note: Load workloads use taskset for CPU affinity and don't need cpusets.
         """
@@ -97,6 +99,7 @@ class CpusetManager:
         self.logger = logger
         self.housekeeping_isolated = housekeeping_isolated
         self.create_measurement = create_measurement
+        self.measurement_member = measurement_member
 
         # Cpuset objects (will be created in __enter__)
         self.housekeeping_cpuset = None
@@ -130,11 +133,12 @@ class CpusetManager:
         # Create measurement cpuset (skipped when there are no measurement
         # workloads, e.g. --onlyload)
         if self.create_measurement:
-            self.logger.log(Log.DEBUG, f"Creating rteval_measurement cpuset with CPUs {collapse_cpulist(self.measurement_cpus)}")
+            partition_type = "member" if self.measurement_member else "isolated"
+            self.logger.log(Log.DEBUG, f"Creating rteval_measurement cpuset with CPUs {collapse_cpulist(self.measurement_cpus)} (partition={partition_type})")
             self.measurement_cpuset = Cpuset('rteval_measurement')
             self.measurement_cpuset.write_memnode(self.numa_nodes)
             self.measurement_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
-            self.measurement_cpuset.write_cpu_exclusive(True)  # partition=isolated
+            self.measurement_cpuset.write_cpu_exclusive(not self.measurement_member)  # partition=isolated unless member
 
         self.logger.log(Log.INFO, "Cpusets created successfully")
         return self
diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
index 8d69fed90443..4b834a0fb218 100644
--- a/tests/test_cpusetmanager.py
+++ b/tests/test_cpusetmanager.py
@@ -114,6 +114,20 @@ class TestCpusetManagerHousekeepingPartitions(unittest.TestCase):
             self.assertEqual(partition, 'isolated',
                            "Measurement cpuset should always be partition=isolated")
 
+    def test_measurement_member_flag(self):
+        """Test that measurement_member=True makes measurement partition=member"""
+        with CpusetManager(
+            housekeeping_cpus=[0, 1],
+            measurement_cpus=[2, 3],
+            logger=self.logger,
+            measurement_member=True
+        ) as manager:
+            measurement_partition_file = '/sys/fs/cgroup/rteval_measurement/cpuset.cpus.partition'
+            with open(measurement_partition_file) as f:
+                partition = f.read().strip()
+            self.assertEqual(partition, 'member',
+                           "Measurement cpuset should have partition=member when measurement_member is True")
+
     def test_no_housekeeping_cpuset_created_when_empty(self):
         """Test that housekeeping cpuset is not created when housekeeping_cpus is empty"""
         with CpusetManager(
@@ -185,6 +199,21 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
         self.assertIn('requires --cpusets', result.stderr,
                      "Error message should mention --cpusets requirement")
 
+    def test_measurement_member_requires_cpusets(self):
+        """Test that --measurement-member requires --cpusets"""
+        result = subprocess.run(
+            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+             '--measurement-member',
+             '--duration', '1', '--onlyload'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertNotEqual(result.returncode, 0,
+                          "--measurement-member without --cpusets should fail")
+        self.assertIn('requires --cpusets', result.stderr,
+                     "Error message should mention --cpusets requirement")
+
     def test_housekeeping_isolated_requires_housekeeping(self):
         """Test that --housekeeping-isolated requires --housekeeping"""
         result = subprocess.run(
-- 
2.55.0

