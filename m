Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8E3E1216
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943618; cv=none; b=FAGUigdwUjYootaUghZ9kB4uYBJOkFzU4sVe734A1pULr4eDFADQ6obYxVntVOuSiPOzxdykv477TRJRsNaW6vTHbVKF7bG1bNLsaikYLLFL7HVmBWezMlpNAhC/vvxy59FYYcPu39+zZZvi8E+tqXYMcQ9ojHJxFu0KnAxnLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943618; c=relaxed/simple;
	bh=Xts9B/b5Hb4LeDImpXadxS4cDJXpI9vRmcFpVLQ6L44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JX6hi2qF1chlnhcNChSc3PnX9oGZG5hDwxn9QyK6cW4K5JICdmzwaB0OVNVZohrVFMPSX5+soor6dKJbO1E4ZZ30opeX5WKHYO7DwyJeFWl9wMJiAm69N4ay4hdROdRjy9c4B3UCMbKMWqHr/AMYGH9yawcHMHg1rzVtt5fto9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDWgzmYX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDWgzmYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXQH5/EeL0wJrfvEBXFRhQ5x9PFozRAe72ZG/KjN2nc=;
	b=CDWgzmYXi3yQAClk3KcOIOhqOaxICVPgQLKTlmlTJYxOqC0sfZa+JP57dHUu83WDQSC2zW
	UJtgUc8vM3/OT+tFuz8F7Ohl5/YmnkcGYsoJlfqqKDn/zVAL2wEEF5U92jW7TEuY5va5Hy
	3wKcz2vK31UcysJE2Yi1MChcsuc83IE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-4rP-DmiQNMiyKISPU1_Fwg-1; Mon,
 08 Jun 2026 14:33:32 -0400
X-MC-Unique: 4rP-DmiQNMiyKISPU1_Fwg-1
X-Mimecast-MFC-AGG-ID: 4rP-DmiQNMiyKISPU1_Fwg_1780943611
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BACBB1835D6F;
	Mon,  8 Jun 2026 18:33:31 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49F6136929;
	Mon,  8 Jun 2026 18:33:29 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 28/52] tests: Replace init sleeps in test_affinity
Date: Mon,  8 Jun 2026 15:31:38 -0300
Message-ID: <20260608183206.140526-29-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Replace start_stalld followed by a fixed two-second sleep with
start_stalld_with_log in test_affinity.sh. The helper uses event-driven
wait_for_stalld_ready internally, returning as soon as the daemon logs
its first monitoring message rather than waiting a fixed interval.
Since stalld typically initializes in under half a second, this saves
approximately nine seconds across the six modified test sections.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_affinity.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/functional/test_affinity.sh b/tests/functional/test_affinity.sh
index 3faa199..43ab912 100755
--- a/tests/functional/test_affinity.sh
+++ b/tests/functional/test_affinity.sh
@@ -54,8 +54,8 @@ fi
 #=============================================================================
 test_section "Test 1: Default behavior (no affinity restriction)"
 
-start_stalld -f -v -l -t 5
-sleep 2
+rm -f "${STALLD_LOG}"
+start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5
 
 default_affinity=$(check_affinity "${STALLD_PID}")
 log "ℹ INFO: Default affinity: $default_affinity"
@@ -69,8 +69,8 @@ stop_stalld
 #=============================================================================
 test_section "Test 2: Single CPU affinity (-a 0)"
 
-start_stalld -f -v -l -t 5 -a 0
-sleep 2
+rm -f "${STALLD_LOG}"
+start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a 0
 
 affinity=$(check_affinity "${STALLD_PID}")
 
@@ -84,8 +84,8 @@ stop_stalld
 test_section "Test 3: Multi-CPU affinity (-a 0,2)"
 
 if [ "$num_cpus" -ge 4 ]; then
-    start_stalld -f -v -l -t 5 -a 0,2
-    sleep 2
+    rm -f "${STALLD_LOG}"
+    start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a 0,2
 
     affinity=$(check_affinity "${STALLD_PID}")
 
@@ -103,8 +103,8 @@ fi
 test_section "Test 4: CPU range affinity (-a 0-2)"
 
 if [ "$num_cpus" -ge 4 ]; then
-    start_stalld -f -v -l -t 5 -a 0-2
-    sleep 2
+    rm -f "${STALLD_LOG}"
+    start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a 0-2
 
     affinity=$(check_affinity "${STALLD_PID}")
 
@@ -123,8 +123,8 @@ test_section "Test 5: Verify stalld threads run on specified CPU"
 
 if [ "$num_cpus" -ge 2 ]; then
     test_cpu=1
-    start_stalld -f -v -l -t 5 -a "$test_cpu"
-    sleep 2
+    rm -f "${STALLD_LOG}"
+    start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a "$test_cpu"
 
     # Check affinity
     affinity=$(check_affinity "${STALLD_PID}")
@@ -174,8 +174,8 @@ assert_stalld_rejects "Invalid CPU affinity rejected with error" -f -v -l -t 5 -
 #=============================================================================
 test_section "Test 8: Verify affinity persists over time"
 
-start_stalld -f -v -l -t 5 -a 0
-sleep 2
+rm -f "${STALLD_LOG}"
+start_stalld_with_log "${STALLD_LOG}" -f -v -l -t 5 -a 0
 
 affinity_start=$(check_affinity "${STALLD_PID}")
 log "ℹ INFO: Initial affinity: $affinity_start"
-- 
2.54.0

