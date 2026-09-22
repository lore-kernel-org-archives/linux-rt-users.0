Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5651812A
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116013; cv=none; b=I2QvECMtrlAnMSOb3+she+F3AQrgUuBz9p0tW6JEGDmqnaS7qu3NXfju5P/LhbhpV+iopZWhYW5+Kl85vnB6YPuP6cM1rsD3pXr27Ac0U+PIWA+JNYOqU0Os0bc3ve2YzspgrGtpUiP1EVYiGkyWk2cPoONNtbNDiU84Z9NIl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116013; c=relaxed/simple;
	bh=fXJ5zeDR4bJH4bhHg+TCNnaEugfCBv+LNtxcvYoCa/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4o43ocaewyW/HcWv5HVsNwq6+2B3edCLhIdbYCQ8BmCZz3Zp14kVON8Suu62JhCK5RSZRR6QBOXfCD9eALcsG269isLt4ZCYmn+8BCykWtYK2kmMKG3Qkdneyifx/7YicQjCFyC4UWUlmjglU3YE1VRAAg8U7UtGOS6K76Xx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKW0ZjoY; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKW0ZjoY"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso3080396d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115995; x=1790720795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtjKRwesU7WbiwUA98gXDlCUY1FlEqqM9HAFKOfTlJ8=;
        b=FKW0ZjoYUxTkqVEGVD7bRE2V95SIdhxVwO+A3nAFdxT1DJYbgNuQ/TexVqFYNe3r7i
         VZR4i/9nnFQrmzKKk29edtspN0QBbk/pgfoJQ+xCF0hWMB+tpBSEcRoDPzYPCUwt+QDt
         +diDv/5g8OO4FT2cj0/u3SqRsLP1WbZcJhOEck92nNx5+Zg3SX2yBgXIC/J35j3FrsR1
         FjV6xHLirrP8zNYaV8dkhZgSyW3kqMgcMWRTXGUK2emH9VCsmfbaWhS+SmowSs3LBDiI
         IQHPzLbb2DcJY/pt0nj3QMxxAs6UjTzDztoBxwwfJgNi5MOS7YzT0vXTJyy/yPn2BbV5
         tANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115995; x=1790720795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtjKRwesU7WbiwUA98gXDlCUY1FlEqqM9HAFKOfTlJ8=;
        b=hBBwPu0cqXpDDCbRyxYlF5oyK4YF4MKb5KyAoDcZ5c+1oWyI6hvxKtUK+jr47x/2Ay
         Yg2xTnhFaNhX3KG1i84KWzYgVxnV6NrsHB24tj1e85mp9wmEKXb6Mff4oVZjbBKpSoB4
         g98yarPJ27V5SzYCyMja0tMp5Ab/wW+bnpiIg21MFKPbs3hSuwZ6nRclFwFMMcuBkSPI
         yRxiTgQ8MqhuOwIIqO9Zbnzu9spWKULn7eq8dIsSU+44QoDIU6Ns0qHIIxvRMhuSSsfs
         A1eW+Q5zHdw8heuRtS6ireLX2MmJv65IVfwmfy9xH6raOOn1lVfeoKLNKrnvlMzDYhru
         0fKg==
X-Gm-Message-State: AFuF++nT3vviPEPeRnXC+3bdB6KcqzSDbXF4O0Kj7mFF5+msB70hW6xg
	ilUtKiPNDrXT8IqlmBOVtrbozTvHRkLG53LNyL2lAcSPZH2Surc0th45sDAEuw==
X-Gm-Gg: AYBFou1yyCetBha4wSjkrao3HKgzsArFaJ4peBQC7LPc8qMNBxALVkxfQL/9QD/bWwk
	OAu8BjanzqlT2uDKeS2UJiiHVlKxNaqvUFmcqzTFUakdbP4V8pKe5NhnuaqPHRbumK7qxx+wtM4
	a6umkWgkgPNtsAsdW8qA0BxBaJ8+o3PU+WpCvn3EJaZKjQuwPr1pNLq4xlShzGj2rsGYURyQowR
	5f/437/SX8fN2uDmfVGhEuhH/qbsumfiaorxTJpml0Xp2b8pWcnbCQWN4YiiTSDDsfF1YukByH5
	JUWNdHs5AMnaPS4sj8rabeNd5UcrFsHMjGEHvZ33WMELXfFHHdJMsCshrzzFKJnbc3x1nnkKjEo
	JipLzvzpnb6bEDxfbHrX81g8Lt1/khhmHUqgVgiBIwBJxJVpedMJ7Hu7VzeYzOxN0gKZsVtejj9
	g0MKBpgnHKZS1H+hoNwKAALO+S+UhiMo1xiUhz9TkEi0xmfH9PIQeeP3h6RUpsvWmkiW6mvHqKW
	i04aPMFNVPC5okaUo6ptzqC5pV0Lax+ADG/DjzDohVX1LpxscfVTLLSPerm9lSZIw==
X-Received: by 2002:a05:6214:3197:b0:910:2ffa:efe6 with SMTP id 6a1803df08f44-9140c3fa531mr13758906d6.30.1790115995258;
        Tue, 22 Sep 2026 15:26:35 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4425f3sm7552786d6.34.2026.09.22.15.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:26:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 6/8] rteval: Add tests for overlap-check gating and --measurement-member help
Date: Tue, 22 Sep 2026 18:25:50 -0400
Message-ID: <20260922222552.482102-7-jkacur@redhat.com>
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

Cover the remaining Phase 1 cpuset overlap cases:

- test_noload_skips_overlap_check: --cpusets --noload with a measurement
  subset (loads still default to all CPUs, so they overlap) must exit 0,
  guarding the 'not noload' gate that keeps the overlap check from firing
  spuriously when no loads run.
- test_onlyload_no_measurement_cpuset: --cpusets --onlyload must exit 0
  and create no rteval_measurement cpuset (no measurement runs).
- test_measurement_member_help_text: --measurement-member and
  partition=member appear in --help output.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/cpusets/test-cpusets.sh | 105 ++++++++++++++++++++++++++++++++++
 tests/test_cpusetmanager.py   |  14 +++++
 2 files changed, 119 insertions(+)

diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
index 39f837c177ae..0996d76ea1df 100755
--- a/tests/cpusets/test-cpusets.sh
+++ b/tests/cpusets/test-cpusets.sh
@@ -535,6 +535,109 @@ test_backward_compatibility() {
     fi
 }
 
+test_noload_skips_overlap_check() {
+    ((TESTS_RUN++)) || true
+    print_test "Overlap Check Skipped with --noload"
+
+    cleanup_cpusets
+
+    local cpus=$(get_test_cpus)
+    local msr_cpus=$(echo $cpus | awk '{print $2}')
+
+    local all_good=true
+
+    # With --noload only the measurement runs, but the load cpulist still
+    # defaults to all online CPUs, so measurement and loads overlap. The overlap
+    # guard must be skipped (not rtevcfg.noload); regressing that gate would make
+    # this exit non-zero.
+    print_info "Running (expect success): $RTEVAL_CMD --cpusets --noload --measurement-cpulist $msr_cpus -d $TEST_DURATION"
+
+    timeout 60s $RTEVAL_CMD --cpusets --noload --measurement-cpulist "$msr_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    if check_cpuset_exists "rteval_measurement"; then
+        print_info "rteval_measurement cpuset created: OK"
+    else
+        print_fail "rteval_measurement cpuset not created"
+        all_good=false
+    fi
+
+    wait $rteval_pid
+    local rc=$?
+    if [ "$rc" -eq 0 ]; then
+        print_info "rteval exited 0 with --noload despite overlapping cpulists: OK"
+    else
+        print_fail "rteval exited $rc with --noload (expected 0; overlap check should be skipped)"
+        all_good=false
+    fi
+
+    sleep 1
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "--noload overlap-skip test"
+    else
+        print_fail "--noload overlap-skip test"
+    fi
+}
+
+test_onlyload_no_measurement_cpuset() {
+    ((TESTS_RUN++)) || true
+    print_test "No Measurement Cpuset with --onlyload"
+
+    cleanup_cpusets
+
+    local all_good=true
+
+    # With --onlyload no measurement runs, so the overlap check is skipped and no
+    # rteval_measurement cpuset should be created (loads use taskset).
+    print_info "Running (expect success): $RTEVAL_CMD --cpusets --onlyload -d $TEST_DURATION"
+
+    timeout 60s $RTEVAL_CMD --cpusets --onlyload -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    if check_cpuset_exists "rteval_measurement"; then
+        print_fail "rteval_measurement cpuset created, but --onlyload runs no measurement"
+        all_good=false
+    else
+        print_info "No rteval_measurement cpuset created: OK"
+    fi
+
+    wait $rteval_pid
+    local rc=$?
+    if [ "$rc" -eq 0 ]; then
+        print_info "rteval exited 0 with --onlyload: OK"
+    else
+        print_fail "rteval exited $rc with --onlyload (expected 0)"
+        all_good=false
+    fi
+
+    sleep 1
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "--onlyload no-measurement-cpuset test"
+    else
+        print_fail "--onlyload no-measurement-cpuset test"
+    fi
+}
+
 test_cleanup_on_interrupt() {
     ((TESTS_RUN++)) || true
     print_test "Cleanup on Ctrl+C (Interrupt Handling)"
@@ -795,6 +898,8 @@ main() {
     test_with_housekeeping
     test_housekeeping_without_isolcpus
     test_backward_compatibility
+    test_noload_skips_overlap_check
+    test_onlyload_no_measurement_cpuset
     test_cleanup_on_interrupt
 
     # Tests that require isolcpus (will skip if not available)
diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
index 4b834a0fb218..74466be89615 100644
--- a/tests/test_cpusetmanager.py
+++ b/tests/test_cpusetmanager.py
@@ -214,6 +214,20 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
         self.assertIn('requires --cpusets', result.stderr,
                      "Error message should mention --cpusets requirement")
 
+    def test_measurement_member_help_text(self):
+        """Test that --measurement-member appears in help"""
+        result = subprocess.run(
+            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('--measurement-member', result.stdout,
+                     "--measurement-member should appear in help")
+        self.assertIn('partition=member', result.stdout,
+                     "Help should mention partition=member")
+
     def test_housekeeping_isolated_requires_housekeeping(self):
         """Test that --housekeeping-isolated requires --housekeeping"""
         result = subprocess.run(
-- 
2.55.0

