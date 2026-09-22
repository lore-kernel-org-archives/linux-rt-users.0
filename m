Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF645616C7
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116009; cv=none; b=JWrTE3nqP8b3DcCv+8pO+nStxvtFn5B966ojNBnnbdw9kDaGcGyEkiJ9JIXJRSi6Q5gE4ohzU+6QbcVHXWw2A+WfTZY867SZzT1cCK/jRV5vPojjiacYkVmi3jJLtxrz1tB5XF+VUVwsvfwg8IKn0f16vM4DcjZSgdK3mBa7D6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116009; c=relaxed/simple;
	bh=N/dHmFk0Hlkdn6IhVoWXx5Ul2xElkbdr8nm8vODwSWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY5baRybhkA7vR2VY94N6IGXzygixs8uRc3rhto0pykBamAdFvJc/MFVCf4G+wUsH7/+rigm+mgb3dKk2DgxPPhl9tPcQWoM9dz7C+ID3ZYdBvj4b3FNvSyCfc3JFoN/gwmMCTezd8jHMmmEdaBpocvVI48QV4IEjAkHjixozDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be1tKYJq; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be1tKYJq"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb76906adso7079141cf.0
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115993; x=1790720793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tclp+Hk1lK34X6LINUSfGAWEQgG/rRdXpZs/MsnmGZs=;
        b=Be1tKYJqyxPOC8C39NWDEr+cals6eKP9X8Im1uxZFitgqC7W+8Zm9R6PDM/A5aKOyt
         VXGhrZ+n6O283EHNsM5f9UgEc7DzDuKZhli7jIK8jLs0F8aGwJhApT5ZXAQ8jPsesRXU
         1JUctOamfYr8eSNIH3ab76eYoTBJZMBZerxLe+KohjRuqDWHPZdPSwphbUK0O+l3XbyE
         y1OEnNfWGcH57q+yVUx+0zdZAITpG02ZbOYZHg2he1HPiNsHtLAyx/BTMvQ0iZfEsNRb
         5IXgCOmNsK0jwa7n7sgWzOORcqxoOp4JgEsi2tpm186SvbFauAj4dZDpLqf4SAl3JorT
         WqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115993; x=1790720793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tclp+Hk1lK34X6LINUSfGAWEQgG/rRdXpZs/MsnmGZs=;
        b=SEoqeZK5KHBP4jhefoY6XYyU3qPMQhN9Lg/mzKLedz7EuQY11g/ycdaHLwWUe+nD93
         +nixc+IlvSdth8rpKtn5L7gnR7Kn71tdioC462uKCvSMGgJX4XYGqlZIuWOiXduH47hX
         8Du5sWB1IC3zlJ+yd/NTGDpYwHA5EUt+OPHpIb1yW04L1rawm89UU1eEX1UIZI1/BfOW
         BrSd8RLttKjhjhEU72DhGTkCh/G+tAZgFnhC+v9Nxvo4TveM/0YA5COuFMRm99SOBHIF
         cKtctE7JUCe67KO1o8G7eN4zC7rH6bw2k4EfYRPXSGP2IXCKrgR6akirntBfd5AgyO+3
         NvzA==
X-Gm-Message-State: AFuF++n1cEXT22mag6s+cHBkRrrlBj88Bj5mhLahfo/Pm+EX7KKHQUx5
	LOfPCkGDwaeOtl+LR0FFJDtkASbUlao1F20q4aS4X14734b8K1EHYL0WsneZJA==
X-Gm-Gg: AYBFou3TXoJ18BdtC6+l9KOy/GckB0a693Sjx2bFRRl0SkhoQ1Ytp7jjiJHDMfffGz9
	0lg4jy8VYUaizLr6WY1KrKxbeSDoXsckTuYriy9kAYHoJy+QjszaEFjJFX6byfZXJZdk/ibRX7W
	8wcBVHtEXZRBBXecQaoO7+esQyK/e8C/tTOIWCIsGpPGBflybOVAwSI6l3bCNiAIQyDGTIcdTv4
	mz2fmcXTVg4Xh0S0ibbxYdrFGxZySlSRe1/kU3c/jb5Lz9vdsawXXMiyr3FbMiQkfb7yWOCZxZd
	gqSqAGrAsrU73c+U/s3TUVU/V+CYr5Ite/aBYLZc2fY+O25Y+5Dy/elgq2yoCAhmvUvr7RAdkhv
	sfG8k+4wtkIgW/zBG+D1pq+EAKQKA6bPsGNyz19Hv4167Xyt0xaiwbGlHR4h5eZ4qLcvSHaHT5g
	XGBiSAL4fjtqJZq6K3rq9lbkFZXRTA19EXlXfVeJA50dMvTW7JXP0slc/3YNxMTDO386XZ51rXV
	TxSLK0iNZ3pcCDiCh8yFDLj9nUFP07ERFvnz2yoYzbnbTtF30jduVWQ6siuOTEKDA==
X-Received: by 2002:a05:6214:4b0f:b0:90e:8a5c:fb6c with SMTP id 6a1803df08f44-9140c319c2fmr16994146d6.4.1790115992587;
        Tue, 22 Sep 2026 15:26:32 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4425f3sm7552786d6.34.2026.09.22.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:26:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 4/8] rteval: Re-enable cpuset overlap tests for the new behavior
Date: Tue, 22 Sep 2026 18:25:48 -0400
Message-ID: <20260922222552.482102-5-jkacur@redhat.com>
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

Tests 2, 5, and 8 in the cpuset integration suite were skipped pending
the measurement/load overlap design decision. Re-enable them for the
new behavior:

- Test 2 (same CPUs, no housekeeping): without --measurement-member,
  assert rteval exits non-zero and the error points to
  --measurement-member; with --measurement-member, assert exit 0 and
  partition=member.
- Test 5 (housekeeping without isolcpus): without --measurement-member,
  assert early non-zero exit on the default overlap; with
  --measurement-member, assert exit 0 and the housekeeping cpuset is
  created.
- Test 8 (--measurement-run-on-isolcpus): confine loads to the
  non-isolated CPUs so measurement (isolcpus) and loads are disjoint,
  keeping the measurement cpuset an isolated partition; assert exit 0.
  Still skips when no isolcpus are configured.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/cpusets/test-cpusets.sh | 212 ++++++++++++++++++++--------------
 1 file changed, 127 insertions(+), 85 deletions(-)

diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
index 5e1293532aca..39f837c177ae 100755
--- a/tests/cpusets/test-cpusets.sh
+++ b/tests/cpusets/test-cpusets.sh
@@ -208,38 +208,42 @@ test_prerequisites() {
 
 test_same_cpus_no_housekeeping() {
     ((TESTS_RUN++)) || true
-    print_test "Same CPUs - No Housekeeping (Measurement Cpuset Only)"
+    print_test "Same CPUs - Overlap Handling (isolated fails, --measurement-member works)"
 
     cleanup_cpusets
 
-    # TODO: Temporarily skipped pending a design decision (see below).
-    # This runs measurement and loads on the SAME CPUs. The measurement cpuset
-    # is created as an isolated partition, which removes those CPUs from the root
-    # cgroup; the taskset-bound loads then cannot run there and kcompile fails,
-    # so rteval exits non-zero. (This test currently does not check rteval's exit
-    # code, so it silently "passes" today.) The fix - the measurement cpuset
-    # partition type / load CPU placement when measurement and loads overlap -
-    # is still under discussion. Re-enable (and add an rteval exit-code check)
-    # once that is resolved.
-    print_info "SKIPPED: pending design decision on measurement cpuset partition/overlap behavior"
-    ((TESTS_PASSED++)) || true
-    return 0
-
     local cpus=$(get_test_cpus)
     local msr_cpus=$(echo $cpus | awk '{print $2}')
 
-    print_info "Running: $RTEVAL_CMD --cpusets --measurement-cpulist $msr_cpus --loads-cpulist $msr_cpus -d $TEST_DURATION"
+    local all_good=true
 
-    # Run rteval in background
-    timeout 60s $RTEVAL_CMD --cpusets --measurement-cpulist "$msr_cpus" --loads-cpulist "$msr_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    # Flavor A: overlap with the default isolated measurement partition must
+    # fail early, because isolating those CPUs would leave the taskset loads
+    # with nowhere to run.
+    print_info "Running (expect early exit): $RTEVAL_CMD --cpusets --measurement-cpulist $msr_cpus --loads-cpulist $msr_cpus -d $TEST_DURATION"
+    if timeout 60s $RTEVAL_CMD --cpusets --measurement-cpulist "$msr_cpus" --loads-cpulist "$msr_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1; then
+        print_fail "rteval succeeded, but overlap with an isolated measurement partition should fail early"
+        all_good=false
+    else
+        print_info "rteval exited non-zero on overlap: OK"
+        if grep -q -- "--measurement-member" "$LOG_FILE" 2>/dev/null; then
+            print_info "Error message points to --measurement-member: OK"
+        else
+            print_fail "Overlap error message missing guidance"
+            all_good=false
+        fi
+    fi
+
+    cleanup_cpusets
+
+    # Flavor B: the same overlap with --measurement-member co-locates loads and
+    # measurement on a member partition and succeeds.
+    print_info "Running (expect success): $RTEVAL_CMD --cpusets --measurement-member --measurement-cpulist $msr_cpus --loads-cpulist $msr_cpus -d $TEST_DURATION"
+    timeout 60s $RTEVAL_CMD --cpusets --measurement-member --measurement-cpulist "$msr_cpus" --loads-cpulist "$msr_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
     local rteval_pid=$!
 
-    # Wait for cpusets to be created
     sleep 2
 
-    # Check during execution
-    local all_good=true
-
     if check_cpuset_exists "rteval_measurement"; then
         print_info "rteval_measurement cpuset created: OK"
     else
@@ -247,31 +251,22 @@ test_same_cpus_no_housekeeping() {
         all_good=false
     fi
 
-    if ! check_cpuset_exists "rteval_loads"; then
-        print_info "No rteval_loads cpuset (loads use taskset): OK"
-    else
-        print_fail "Unexpected rteval_loads cpuset found"
-        all_good=false
-    fi
-
-    if check_cpuset_cpus "rteval_measurement" "$msr_cpus"; then
-        print_info "Measurement CPU assignment correct: OK"
+    if check_cpuset_partition "rteval_measurement" "member"; then
+        print_info "Partition type is 'member': OK"
     else
-        print_fail "Measurement CPU assignment incorrect"
+        print_fail "Partition type is not 'member'"
         all_good=false
     fi
 
-    if check_cpuset_partition "rteval_measurement" "isolated"; then
-        print_info "Partition type is 'isolated': OK"
+    wait $rteval_pid
+    local rc=$?
+    if [ "$rc" -eq 0 ]; then
+        print_info "rteval exited 0 with --measurement-member: OK"
     else
-        print_fail "Partition type is not 'isolated'"
+        print_fail "rteval exited $rc with --measurement-member (expected 0)"
         all_good=false
     fi
 
-    # Wait for rteval to finish
-    wait $rteval_pid
-
-    # Check cleanup
     sleep 1
     if check_no_cpusets; then
         print_info "Cleanup successful: OK"
@@ -282,9 +277,9 @@ test_same_cpus_no_housekeeping() {
     fi
 
     if [ "$all_good" = true ]; then
-        print_pass "Measurement cpuset test"
+        print_pass "Same-CPU overlap handling test"
     else
-        print_fail "Measurement cpuset test"
+        print_fail "Same-CPU overlap handling test"
     fi
 }
 
@@ -439,18 +434,6 @@ test_housekeeping_without_isolcpus() {
 
     cleanup_cpusets
 
-    # TODO: Temporarily skipped pending a design decision.
-    # With '--cpusets --housekeeping' and no explicit --measurement-cpulist,
-    # the measurement cpuset defaults to all non-housekeeping CPUs as an
-    # isolated partition, which removes them from the root cgroup. The
-    # taskset-bound loads then have nowhere to run and kcompile fails, so
-    # rteval exits non-zero. The fix (measurement cpuset partition type /
-    # load CPU placement when measurement and loads overlap) is still under
-    # discussion. Re-enable this test once that is resolved.
-    print_info "SKIPPED: pending design decision on measurement cpuset partition/overlap behavior"
-    ((TESTS_PASSED++)) || true
-    return 0
-
     # Check if system has isolcpus
     local isolated=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
     print_info "System isolated CPUs: ${isolated:-none}"
@@ -458,22 +441,65 @@ test_housekeeping_without_isolcpus() {
     local cpus=$(get_test_cpus)
     local hk_cpus=$(echo $cpus | awk '{print $1}')
 
-    print_info "Running: $RTEVAL_CMD --cpusets --housekeeping $hk_cpus -d $TEST_DURATION"
+    local all_good=true
 
-    # This should succeed even if housekeeping CPUs are not in isolcpus
+    # Flavor A: with only --housekeeping, measurement and loads both default to
+    # the non-housekeeping CPUs, so the isolated measurement partition overlaps
+    # the loads and rteval must fail early.
+    print_info "Running (expect early exit): $RTEVAL_CMD --cpusets --housekeeping $hk_cpus -d $TEST_DURATION"
     if timeout 60s $RTEVAL_CMD --cpusets --housekeeping "$hk_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1; then
-        print_info "rteval succeeded with housekeeping without isolcpus requirement: OK"
-        sleep 1
+        print_fail "rteval succeeded, but default overlap with an isolated measurement partition should fail early"
+        all_good=false
+    else
+        print_info "rteval exited non-zero on default overlap: OK"
+    fi
 
-        if check_no_cpusets; then
-            print_info "Cleanup successful: OK"
-            print_pass "Housekeeping without isolcpus test"
-        else
-            print_fail "Cpusets not cleaned up"
-            cleanup_cpusets
-        fi
+    cleanup_cpusets
+
+    # Flavor B: adding --measurement-member co-locates loads and measurement on
+    # the non-housekeeping CPUs, so housekeeping without isolcpus succeeds.
+    print_info "Running (expect success): $RTEVAL_CMD --cpusets --housekeeping $hk_cpus --measurement-member -d $TEST_DURATION"
+    timeout 60s $RTEVAL_CMD --cpusets --housekeeping "$hk_cpus" --measurement-member -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    if check_cpuset_exists "rteval_housekeeping"; then
+        print_info "rteval_housekeeping cpuset created (no isolcpus required): OK"
     else
-        print_fail "rteval failed with housekeeping (should work with cpusets)"
+        print_fail "rteval_housekeeping cpuset not created"
+        all_good=false
+    fi
+
+    if check_cpuset_cpus "rteval_housekeeping" "$hk_cpus"; then
+        print_info "Housekeeping CPU assignment correct: OK"
+    else
+        print_fail "Housekeeping CPU assignment incorrect"
+        all_good=false
+    fi
+
+    wait $rteval_pid
+    local rc=$?
+    if [ "$rc" -eq 0 ]; then
+        print_info "rteval exited 0 with housekeeping + --measurement-member: OK"
+    else
+        print_fail "rteval exited $rc (expected 0)"
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
+        print_pass "Housekeeping without isolcpus test"
+    else
+        print_fail "Housekeeping without isolcpus test"
     fi
 }
 
@@ -545,20 +571,10 @@ test_cleanup_on_interrupt() {
 
 test_measurement_run_on_isolcpus() {
     ((TESTS_RUN++)) || true
-    print_test "Measurement Run on isolcpus Flag"
+    print_test "Measurement Run on isolcpus Flag (disjoint loads)"
 
     cleanup_cpusets
 
-    # TODO: Temporarily skipped pending a design decision.
-    # On hosts WITH isolcpus this shares the same unresolved issue as tests 2
-    # and 5: the isolated measurement cpuset (affinity + isolcpus) removes its
-    # CPUs from the root cgroup, so taskset-bound loads on the affinity subset
-    # fail and rteval exits non-zero. Re-enable once the measurement cpuset
-    # partition type / load CPU placement (overlap) design decision is made.
-    print_info "SKIPPED: pending design decision on measurement cpuset partition/overlap behavior"
-    ((TESTS_PASSED++)) || true
-    return 0
-
     # Check if system has isolcpus
     local isolated=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
     if [ -z "$isolated" ]; then
@@ -569,34 +585,60 @@ test_measurement_run_on_isolcpus() {
 
     print_info "System isolated CPUs: $isolated"
 
-    # Run with --measurement-run-on-isolcpus and --cpusets
-    print_info "Running: $RTEVAL_CMD --cpusets --measurement-run-on-isolcpus -d $TEST_DURATION"
+    # Confine loads to the non-isolated CPUs so measurement (isolcpus) and loads
+    # are disjoint; the measurement cpuset can then stay an isolated partition
+    # without colliding with the taskset loads.
+    local repo_root=$(dirname "$RTEVAL_CMD")
+    local load_cpus=$(PYTHONPATH="$repo_root" python3 -c "from rteval.cpulist_utils import CpuList, collapse_cpulist; online=CpuList(open('/sys/devices/system/cpu/online').read().strip()); print(collapse_cpulist(online.difference(CpuList('$isolated')).cpus))")
 
-    timeout 60s $RTEVAL_CMD --cpusets --measurement-run-on-isolcpus -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
-    local rteval_pid=$!
+    if [ -z "$load_cpus" ]; then
+        print_info "SKIPPED: no non-isolated CPUs available for loads"
+        ((TESTS_PASSED++)) || true
+        return 0
+    fi
 
-    sleep 2
+    print_info "Non-isolated load CPUs: $load_cpus"
 
     local all_good=true
 
+    # Run with --measurement-run-on-isolcpus and --cpusets, loads confined to
+    # the non-isolated CPUs so they don't overlap the isolated measurement cpuset
+    print_info "Running: $RTEVAL_CMD --cpusets --measurement-run-on-isolcpus --loads-cpulist $load_cpus -d $TEST_DURATION"
+
+    timeout 60s $RTEVAL_CMD --cpusets --measurement-run-on-isolcpus --loads-cpulist "$load_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
     # Should create measurement cpuset
     if check_cpuset_exists "rteval_measurement"; then
         print_info "rteval_measurement cpuset created: OK"
 
-        # Check that cpuset includes isolated CPUs
         local cpuset_cpus=$(cat /sys/fs/cgroup/rteval_measurement/cpuset.cpus 2>/dev/null)
         print_info "Measurement cpuset CPUs: $cpuset_cpus"
-
-        # Verify isolated CPUs are included (would need complex parsing, just verify cpuset exists)
-        print_info "Measurement cpuset includes access to isolated CPUs: OK"
     else
         print_fail "rteval_measurement cpuset not created"
         all_good=false
     fi
 
+    # Measurement stays an isolated partition (disjoint from loads)
+    if check_cpuset_partition "rteval_measurement" "isolated"; then
+        print_info "Partition type is 'isolated': OK"
+    else
+        print_fail "Partition type is not 'isolated'"
+        all_good=false
+    fi
+
     wait $rteval_pid
-    sleep 1
+    local rc=$?
+    if [ "$rc" -eq 0 ]; then
+        print_info "rteval exited 0 with disjoint isolcpus measurement/loads: OK"
+    else
+        print_fail "rteval exited $rc (expected 0)"
+        all_good=false
+    fi
 
+    sleep 1
     if check_no_cpusets; then
         print_info "Cleanup successful: OK"
     else
-- 
2.55.0

