Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C603E5EE8
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285723; cv=none; b=bIZwbL8H4c0xTPHY1KlpDFjY9w7yZ38dEDugdu3rHry7ywg26mn8ZP880d1GhbeDaixgkhra38hhuFA67yQNaJCKlBX4I1kQCHgkAk6CvPfbHEOtDYdWzsx1pmxpUDPvx928xqfBQjzEXL0KR0pp/rDuTYrJ/0GleiSwiomhTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285723; c=relaxed/simple;
	bh=7Jikri7muA0/Nil48SbM09bjgTFSTntWcHZj8rHiip0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlJAJoV4uZ/wdHzJvbE1ZhgztOtNgpKEDXMqQswI5pcyMPz3RM25ToUyejq8biulS8zUklKycrQjUGy0plNizEeI6cAJcCuPG0PWPYwxbEcLYieeVQ+AQL4urgNst4D22gNjZcdE7ysPNWs2ZgzgJ3QBz+HfslPRpMLO5y/4UCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDIa40GI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDIa40GI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yod295gfJ+vUMXDRM1AL2QPpF6h/jJPGbx8FfghlaVo=;
	b=KDIa40GIBWNBeiZypevGfF8wm84dVXYIezxlq8ybagu/wxIbMIjwgwp/+F+lbiN6XHXruP
	VZEkiMw32bS70E3kX4MT20CEa+C6HbAJd57EMzXoqL3+nSAy5PW4+qdnzMlH0+4jztMoQr
	OBgqLZg/4OPtBTcaYsoFVw6LO9Qe+nU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-f0EEVRcMNy66F_Z2B0rxmw-1; Wed,
 20 May 2026 10:01:54 -0400
X-MC-Unique: f0EEVRcMNy66F_Z2B0rxmw-1
X-Mimecast-MFC-AGG-ID: f0EEVRcMNy66F_Z2B0rxmw_1779285713
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 841531955F11;
	Wed, 20 May 2026 14:01:53 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CF011800465;
	Wed, 20 May 2026 14:01:50 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 14/33] tests: Fix CPU selection grep substring matches
Date: Wed, 20 May 2026 11:00:41 -0300
Message-ID: <20260520140104.112142-15-wander@redhat.com>
In-Reply-To: <20260520140104.112142-1-wander@redhat.com>
References: <20260520140104.112142-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
2.54.0

