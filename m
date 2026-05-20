Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6223E6398
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285750; cv=none; b=TIKTpFVazxM+F/cWAFaNL797DJCguAoOYGSr/AzPB7u5bFBWlM1Zm4AABC+tRXV6UGVc1TVFZjaLVq3zbzk72NmsJV1pysEVFy+VR1EEfDW11LdpskifnYCgrix7VeIaTj4Zolman9bsQxMhdW0PSUHOIOnbOwD05p6q4QA4lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285750; c=relaxed/simple;
	bh=IsUlOPOosk4v3wNal78VB5TD7SpGifbkr0F+1uRkbT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swKNEgx/ypWii26XCAUURmk2FzHpIK7rvqzLfqsGRqyMYyx1sxH9s20u3DHE0MLgNL2ruwsii5dBqZ60u9OWrJBPvEAUgCl8IuqWXlPIFT7aFvjNo1P7Y8XQrklHK/YAVd3bIg3ChwFcxfPUvyxIS624imgGzU3wm8r7q1X4EdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LF6QvfQL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LF6QvfQL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1S9jdGkTM3uMMm80X287j/Zcuj0BnyHb+juEkQcOLI=;
	b=LF6QvfQLiWfvIji2tGU0nV4Tr6E92gxY4XuzMC89fj1akqg6uce3R5x1uMeB+qRewPpKKD
	2EvQUNXRdJf/MglYxWzW+W7D78fiMtVyZ1LbWqWSqWi35tfTnTIcuZ1OfdxQEsI39DWERP
	i4XL/CYDj0/se8jmTYNEYRKYLk2eJoA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-Pyb2NMtHNkGcQimrRROb_g-1; Wed,
 20 May 2026 10:02:25 -0400
X-MC-Unique: Pyb2NMtHNkGcQimrRROb_g-1
X-Mimecast-MFC-AGG-ID: Pyb2NMtHNkGcQimrRROb_g_1779285744
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F19019560AD;
	Wed, 20 May 2026 14:02:24 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF96D1800465;
	Wed, 20 May 2026 14:02:21 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 26/33] tests: Reduce default wait timeouts
Date: Wed, 20 May 2026 11:00:53 -0300
Message-ID: <20260520140104.112142-27-wander@redhat.com>
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

Failing tests currently hang for up to thirty seconds before reporting
a failure. Reduce the default wait timeouts in the stalld test helpers
to cut this failure reporting time in half. These timeouts only impact
the failure path since passing tests utilize event-driven waits that
return immediately upon matching a pattern.

Decrease the timeout from thirty to fifteen seconds for the starvation
and boost detection waits, their assertion wrappers, and the log match
helper. Reduce the stalld ready wait from fifteen to five seconds. The
new fifteen second limit provides adequate margin because all callers
relying on the default use thresholds of three to five seconds, making
detection take approximately nine seconds.

Override the timeout explicitly to twenty seconds for the third test in
test_boost_duration.sh. This specific caller uses a threshold of ten,
which makes the new fifteen second default too tight.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_boost_duration.sh |  2 +-
 tests/helpers/test_helpers.sh           | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/functional/test_boost_duration.sh b/tests/functional/test_boost_duration.sh
index 3d6a823..821dffe 100755
--- a/tests/functional/test_boost_duration.sh
+++ b/tests/functional/test_boost_duration.sh
@@ -74,7 +74,7 @@ log "Creating starvation on CPU ${TEST_CPU} for ${long_starvation}s"
 start_starvation_gen -c "${TEST_CPU}" -p 80 -n 2 -d ${long_starvation}
 
 # Wait for actual boosting
-assert_boost_detected "${STALLD_LOG}" "Boost with ${long_duration}s duration"
+assert_boost_detected "${STALLD_LOG}" "Boost with ${long_duration}s duration" 20
 
 # Cleanup
 cleanup_scenario "${STARVE_PID}"
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 5187f0f..af341e0 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -159,7 +159,7 @@ find_starved_child() {
 assert_starvation_detected() {
 	local log_file=$1
 	local message=${2:-"Starvation detected"}
-	local timeout=${3:-30}
+	local timeout=${3:-15}
 	local cpu=${4:-}
 
 	if wait_for_starvation_detected "${log_file}" "${timeout}" "${cpu}"; then
@@ -176,7 +176,7 @@ assert_starvation_detected() {
 assert_boost_detected() {
 	local log_file=$1
 	local message=${2:-"Boost detected"}
-	local timeout=${3:-30}
+	local timeout=${3:-15}
 
 	if wait_for_boost_detected "${log_file}" "${timeout}"; then
 		pass "${message}"
@@ -695,7 +695,7 @@ wait_for_log_message() {
 # Usage: wait_for_stalld_ready <log_file> [timeout]
 wait_for_stalld_ready() {
 	local log_file=$1
-	local timeout=${2:-15}
+	local timeout=${2:-5}
 	wait_for_log_message "checking cpu\|waiting tasks\|skipping" "${timeout}" "${log_file}"
 }
 
@@ -704,7 +704,7 @@ wait_for_stalld_ready() {
 # Usage: wait_for_starvation_detected <log_file> [timeout] [cpu]
 wait_for_starvation_detected() {
 	local log_file=$1
-	local timeout=${2:-30}
+	local timeout=${2:-15}
 	local cpu=${3:-}
 	local pattern="starved on CPU"
 	if [ -n "${cpu}" ]; then
@@ -718,7 +718,7 @@ wait_for_starvation_detected() {
 # Usage: wait_for_boost_detected <log_file> [timeout]
 wait_for_boost_detected() {
 	local log_file=$1
-	local timeout=${2:-30}
+	local timeout=${2:-15}
 	wait_for_log_message "boosted pid" "${timeout}" "${log_file}"
 }
 
@@ -729,7 +729,7 @@ wait_for_n_log_matches() {
 	local pattern=$1
 	local count=$2
 	local log_file=$3
-	local timeout=${4:-30}
+	local timeout=${4:-15}
 	local end=$((SECONDS + timeout))
 
 	while [ $SECONDS -lt $end ]; do
-- 
2.54.0

