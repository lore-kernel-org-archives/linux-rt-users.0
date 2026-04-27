Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E13B7754
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288666; cv=none; b=dTerpzzImSFhUqlccUrCJ+IhE7Ldmen1XhYfP1RPtt6naKLOrgzfM1f0FeK8Fu8jTYojQb0mGO3w3n5wdZYkbR5RdYpIJM2OqmuHl3jspEwEvf/84mxt7wfND71bPVNesmQBEHap6lzbPHJGooqhDmi2Cvs0fLQmVb6x/0gUNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288666; c=relaxed/simple;
	bh=P9K2Xn9iiFSiPSIV71t49Ny6QP5qODcNm58opMmIa+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSg1USC8GeJP/+iSeh+MU9t40WA5z7htp2UNfY1NEH+Fg6ZpWrLN8TqdJszSVAa5gtPNV8WwKB3nL7e2dbobB0mYPDyd/2QC+s9Pvqf9FYaijaDhfMIZNKlK6Bky5vcejIC7Y1aNNgWqXUA70qHkvhQDywD7Gdw6kMb9AtyLB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFiIK1+3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFiIK1+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlIbHKFZ8bHd+j8YAo7821X06Vu4xHS+dwrLH5GBh4g=;
	b=GFiIK1+3Vkr+JKcg7B3FB0nDis8F5gI8Gc3KxIqp0Sqy16FQ+gXF54auVKr3MsFFuTBzGa
	58fOVA22wda9xauWDIgmDFLI4wx3zlWe6GLExGL4sRP8i+l8O9fPMwJWSe08+4jJjz35ef
	KMAPbf90zJDnZw4giV7F1BK2RSUU2VE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-kqcBiNRcOAygC3RmTcZZig-1; Mon,
 27 Apr 2026 07:17:42 -0400
X-MC-Unique: kqcBiNRcOAygC3RmTcZZig-1
X-Mimecast-MFC-AGG-ID: kqcBiNRcOAygC3RmTcZZig_1777288662
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFD4E1955D53;
	Mon, 27 Apr 2026 11:17:41 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C954E1800348;
	Mon, 27 Apr 2026 11:17:39 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 14/23] tests: Fix CPU selection grep substring matches
Date: Mon, 27 Apr 2026 08:16:16 -0300
Message-ID: <20260427111632.24500-15-wander@redhat.com>
In-Reply-To: <20260427111632.24500-1-wander@redhat.com>
References: <20260427111632.24500-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The CPU selection test uses grep patterns like "cpu 1" which can
match "cpu 10" or "cpu 12" on systems with more than 9 CPUs. This
causes false positives where the test passes even when the wrong
CPUs are being monitored.

Introduce a local is_cpu_monitored() helper that greps for the
exact stalld log format "adding cpu N$" with an end-of-line anchor,
preventing substring matches.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_cpu_selection.sh | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tests/functional/test_cpu_selection.sh b/tests/functional/test_cpu_selection.sh
index 32cbe79..ff5b879 100755
--- a/tests/functional/test_cpu_selection.sh
+++ b/tests/functional/test_cpu_selection.sh
@@ -13,6 +13,10 @@ source "${TEST_ROOT}/helpers/test_helpers.sh"
 # Parse command-line options
 parse_test_options "$@" || exit $?
 
+is_cpu_monitored() {
+    grep -q "adding cpu ${1}$" "$STALLD_LOG"
+}
+
 start_test "CPU Selection (-c option)"
 
 # Setup test environment
@@ -40,7 +44,7 @@ rm -f "${STALLD_LOG}"
 start_stalld_with_log "${STALLD_LOG}" -f -v -c 0 -l -t 5
 
 # Check that stalld mentions CPU 0
-if grep -q "cpu 0" "$STALLD_LOG"; then
+if is_cpu_monitored 0; then
     pass "stalld monitoring CPU 0"
 else
     fail "stalld not monitoring CPU 0"
@@ -57,10 +61,10 @@ if [ "$num_cpus" -ge 4 ]; then
     # Check for CPU 0 and CPU 2 in output
     cpu0_found=0
     cpu2_found=0
-    if grep -q "cpu 0" "$STALLD_LOG"; then
+    if is_cpu_monitored 0; then
         cpu0_found=1
     fi
-    if grep -q "cpu 2" "$STALLD_LOG"; then
+    if is_cpu_monitored 2; then
         cpu2_found=1
     fi
 
@@ -85,13 +89,13 @@ if [ "$num_cpus" -ge 4 ]; then
     cpu0_found=0
     cpu1_found=0
     cpu2_found=0
-    if grep -q "cpu 0" "$STALLD_LOG"; then
+    if is_cpu_monitored 0; then
         cpu0_found=1
     fi
-    if grep -q "cpu 1" "$STALLD_LOG"; then
+    if is_cpu_monitored 1; then
         cpu1_found=1
     fi
-    if grep -q "cpu 2" "$STALLD_LOG"; then
+    if is_cpu_monitored 2; then
         cpu2_found=1
     fi
 
@@ -115,7 +119,7 @@ if [ "$num_cpus" -ge 6 ]; then
     # Should monitor CPUs 0, 2, 3, 4
     monitored_cpus=0
     for cpu in 0 2 3 4; do
-        if grep -q "cpu $cpu" "$STALLD_LOG"; then
+        if is_cpu_monitored ${cpu}; then
             ((monitored_cpus++))
         fi
     done
@@ -143,8 +147,8 @@ if [ "$num_cpus" -ge 2 ]; then
     rm -f "${STALLD_LOG}"
     start_stalld_with_log "${STALLD_LOG}" -f -v -c 0 -l -t 5
 
-    # Check that CPU 1 is NOT mentioned (or mentioned as "not monitoring")
-    if ! grep -q "cpu 1" "$STALLD_LOG" || grep -q "not monitoring.*cpu 1" "$STALLD_LOG"; then
+    # Check that CPU 1 is NOT being monitored
+    if ! is_cpu_monitored 1; then
         pass "stalld not monitoring non-selected CPU 1"
     else
         fail "stalld appears to be monitoring CPU 1 when only CPU 0 selected"
-- 
2.53.0

