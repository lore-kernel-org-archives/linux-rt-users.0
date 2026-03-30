Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA589395273
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899968; cv=none; b=LwLZDtqQ94d3EP7DBuF3cyvtfocBiMwfDZrOLbTTFWqg2CYA3Ok1Gm1oshbiFqiG5lXEY6oTA01Q1Wf02hFAkxRVwbHZguHXsmBk32GaUifF7GactQ75QucITT6CGJkYD890PCvMoauR+bsz3z2GUkUqRwJEwxyi1BgsggmCMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899968; c=relaxed/simple;
	bh=mSw+JiCv4Y/pV0kIgN5IRm+2zuOjnjOZU+tvV7/LkEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbCiM8o+S4nmxyCoccN+7gzHRMF06gp1DISTEJMf8e44T68z2PIEfgo5Medg/IQgO/FphNKQBiTnWOFdDu0RWoWtR2M+wEwu6NTApGofOtNoFF40j/QiQTLQ0FzqNq7rtBjmI8uBLKxX00/JVY/AXpyWXbN7WUIPp1fJEIgtsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnMMUt0R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnMMUt0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6gzvBup9BhJqTECKhBHEDsKS2oAjtuIxsrcvOEuq5A=;
	b=EnMMUt0R32w5/9wDXduZ7yBoyJqzF3SrqmpcOegs+b0JKJE+SOopu1X+zhX6WZkNaly+El
	Jup/YRi4Tc786plgtCiG8N8l5D+TF7dggxtyN48wxswykK64q8Y61SgDr6bdfJS51B0CE/
	tM8Q4SACOpF0fyov/lMslPC1dqk7DFM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-X9jkEDyXOniEKv6IRV_WYA-1; Mon,
 30 Mar 2026 15:45:09 -0400
X-MC-Unique: X9jkEDyXOniEKv6IRV_WYA-1
X-Mimecast-MFC-AGG-ID: X9jkEDyXOniEKv6IRV_WYA_1774899908
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5505D18002CD;
	Mon, 30 Mar 2026 19:45:08 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 829311954102;
	Mon, 30 Mar 2026 19:45:05 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 10/36] tests/functional: Remove redundant post-stop_stalld sleeps
Date: Mon, 30 Mar 2026 16:43:33 -0300
Message-ID: <20260330194410.103953-11-wander@redhat.com>
In-Reply-To: <20260330194410.103953-1-wander@redhat.com>
References: <20260330194410.103953-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

stop_stalld() now guarantees the process is dead before returning,
making the sleep 1 calls that follow it in test scripts redundant.
Remove all 30 occurrences across test_affinity.sh,
test_boost_duration.sh, test_boost_runtime.sh, test_force_fifo.sh,
test_foreground.sh, test_pidfile.sh, and
test_starvation_threshold.sh.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_affinity.sh             | 7 -------
 tests/functional/test_boost_duration.sh       | 4 ----
 tests/functional/test_boost_runtime.sh        | 4 ----
 tests/functional/test_force_fifo.sh           | 6 ------
 tests/functional/test_foreground.sh           | 1 -
 tests/functional/test_pidfile.sh              | 5 -----
 tests/functional/test_starvation_threshold.sh | 3 ---
 7 files changed, 30 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index 90dd69f..c3888ba 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -89,7 +89,6 @@ else
 fi
 
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 2: Single CPU affinity
@@ -115,7 +114,6 @@ else
 fi
 
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 3: Multi-CPU affinity (CPU list)
@@ -143,7 +141,6 @@ if [ "$num_cpus" -ge 4 ]; then
     fi
 
     stop_stalld
-    sleep 1
 else
     log "⊘ SKIP: Test 3 requires at least 4 CPUs"
 fi
@@ -173,7 +170,6 @@ if [ "$num_cpus" -ge 4 ]; then
     fi
 
     stop_stalld
-    sleep 1
 else
     log "⊘ SKIP: Test 4 requires at least 4 CPUs"
 fi
@@ -210,7 +206,6 @@ if [ "$num_cpus" -ge 2 ]; then
     fi
 
     stop_stalld
-    sleep 1
 else
     log "⊘ SKIP: Test 5 requires at least 2 CPUs"
 fi
@@ -247,7 +242,6 @@ if [ "$num_cpus" -ge 2 ]; then
     fi
 
     stop_stalld
-    sleep 1
 else
     log "⊘ SKIP: Test 6 requires at least 2 CPUs"
 fi
@@ -318,7 +312,6 @@ else
 fi
 
 stop_stalld
-sleep 1
 
 log ""
 log "All affinity tests completed"
diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index e9f8928..4df5489 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -84,7 +84,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null || true
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 2: Short duration (1 second)
@@ -123,7 +122,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null || true
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 3: Long duration (10 seconds)
@@ -163,7 +161,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null || true
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 4: Verify task policy is restored after boost duration
@@ -201,7 +198,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null || true
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 5: Invalid duration values
diff --git a/tests/functional/test_boost_runtime.sh b/tests/functional/test_boost_runtime.sh
index 60ccdc6..0475da5 100755
--- a/tests/functional/test_boost_runtime.sh
+++ b/tests/functional/test_boost_runtime.sh
@@ -84,7 +84,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null || true
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 2: Custom runtime (10,000 ns = 10 microseconds, less than default)
@@ -123,7 +122,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null || true
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 3: Larger runtime (100,000 ns = 100 microseconds)
@@ -162,7 +160,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null || true
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 4: Runtime < period (valid configuration)
@@ -203,7 +200,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null || true
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 5: Runtime > period (should error or be rejected)
diff --git a/tests/functional/test_force_fifo.sh b/tests/functional/test_force_fifo.sh
index 704d605..cab8003 100755
--- a/tests/functional/test_force_fifo.sh
+++ b/tests/functional/test_force_fifo.sh
@@ -85,7 +85,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 2: Force FIFO mode (-F)
@@ -134,7 +133,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 3: Verify FIFO priority setting
@@ -175,7 +173,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 4: Verify FIFO emulation behavior (sleep runtime, restore, sleep remainder)
@@ -223,7 +220,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 5: Single-threaded mode with FIFO (should fail/exit)
@@ -285,7 +281,6 @@ log "ℹ INFO: SCHED_DEADLINE boosts: $deadline_boosts"
 kill -TERM "${STARVE_PID}" 2>/dev/null
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 # Run with FIFO
 STALLD_LOG_FIFO="/tmp/stalld_test_force_fifo_comparison_$$.log"
@@ -304,7 +299,6 @@ log "ℹ INFO: SCHED_FIFO boosts: $fifo_boosts"
 kill -TERM "${STARVE_PID}" 2>/dev/null
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 log "ℹ INFO: Comparison complete (DEADLINE: $deadline_boosts, FIFO: $fifo_boosts)"
 
diff --git a/tests/functional/test_foreground.sh b/tests/functional/test_foreground.sh
index 693d4b1..c5afbba 100755
--- a/tests/functional/test_foreground.sh
+++ b/tests/functional/test_foreground.sh
@@ -45,7 +45,6 @@ if assert_process_running "${STALLD_PID}" "stalld should be running"; then
 fi
 
 stop_stalld
-sleep 1
 
 # Test 2: With -f flag, stalld should stay in foreground
 echo ""
diff --git a/tests/functional/test_pidfile.sh b/tests/functional/test_pidfile.sh
index 675b15e..155855e 100755
--- a/tests/functional/test_pidfile.sh
+++ b/tests/functional/test_pidfile.sh
@@ -68,7 +68,6 @@ if [ $default_found -eq 0 ]; then
 fi
 
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 2: Custom pidfile location
@@ -112,7 +111,6 @@ fi
 log ""
 log "Test 3: Verify pidfile removed on clean shutdown"
 stop_stalld
-sleep 1
 
 if [ ! -f "${custom_pidfile}" ]; then
     log "✓ PASS: Pidfile removed on clean shutdown"
@@ -156,7 +154,6 @@ else
 fi
 
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 5: Test with foreground mode
@@ -192,7 +189,6 @@ else
 fi
 
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 6: Invalid pidfile path (permission denied)
@@ -278,7 +274,6 @@ else
 fi
 
 stop_stalld
-sleep 1
 
 log ""
 log "All pidfile tests completed"
diff --git a/tests/functional/test_starvation_threshold.sh b/tests/functional/test_starvation_threshold.sh
index c2dda57..41a2cca 100755
--- a/tests/functional/test_starvation_threshold.sh
+++ b/tests/functional/test_starvation_threshold.sh
@@ -98,7 +98,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 2: Verify no detection before threshold
@@ -149,7 +148,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 3: Shorter threshold (3 seconds)
@@ -197,7 +195,6 @@ fi
 kill -TERM "${STARVE_PID}" 2>/dev/null
 wait "${STARVE_PID}" 2>/dev/null || true
 stop_stalld
-sleep 1
 
 #=============================================================================
 # Test 4: Invalid threshold values
-- 
2.53.0

