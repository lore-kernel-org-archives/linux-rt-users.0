Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC73DB635
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690756; cv=none; b=or79U//0YL/I3GHUluqhxnnzigf1qqlgWTe710gGOtRcPqFWQyLbsQTww8JLZbfPIboieTaBFNn+5Jp5B3AIvf+CkxJ2CWyjG9vwg8YCdMj5nRV0SoJafId15jMQP5TJBi1CKXFeKAkzJo1jcchhVGZ+1fqMtKB8LNOHoybUOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690756; c=relaxed/simple;
	bh=RVjifnFni3KO1cn2sPhJedk4c3eYB4s7VTUDzxKOOPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/+osWLsmXZqBnMPYIvlQ+64R3FvAnD6dy+FMfV1cQv7ww+H6hPRzuzDLrZs3zxEoKpK47uxQXxkxSGXE9Cugg9Q7Zu16k+8ziuRZZMe1mEsYk7o9EgwVjTnGguhRejOmrMJUgPnAxOWt0iXm0bh4RzoaFJ96iSuaaTy8WbO1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dap4bWA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dap4bWA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v30g2lOde11sOELNT/kAyYDUSH2z0zpquGdLKMSotYE=;
	b=dap4bWA4m/PPMo0nIzu/TrxEu9P2/P9lM3p1pj55oKE8oVFzuiGGQCnHe1CSHRxv8aDzz1
	hAg50W70uAstUAid/kQ7wuPunW5bRbDmVLyJ9cu8rCZ8dG9fhG1K0E62PLN7VcIAuSDeUO
	deYZtZW7lw5Xcbn6sZkq2YUSQaFOp9w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-fEDDThHNPZeGmcZp6cSeQw-1; Fri,
 10 Jul 2026 09:39:07 -0400
X-MC-Unique: fEDDThHNPZeGmcZp6cSeQw-1
X-Mimecast-MFC-AGG-ID: fEDDThHNPZeGmcZp6cSeQw_1783690746
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 521C718001E3;
	Fri, 10 Jul 2026 13:39:06 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42095195608E;
	Fri, 10 Jul 2026 13:39:04 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 06/11] tests: add --fail-fast flag to stop on first failure
Date: Fri, 10 Jul 2026 10:38:05 -0300
Message-ID: <20260710133810.72398-7-wander@redhat.com>
In-Reply-To: <20260710133810.72398-1-wander@redhat.com>
References: <20260710133810.72398-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a --fail-fast option to run_tests.sh that prints the test
summary and exits immediately when a test fails.  The exit
triggers the cleanup trap, so RT throttling and DL-server state
are still restored.

Use print_summary || true before exit 1 to prevent set -e from
intercepting the non-zero return of print_summary's final
[ ${FAILED_TESTS} -eq 0 ] check.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/run_tests.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index 6bfae0f..a2d50e0 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -19,6 +19,7 @@ THREADING_MODE_MATRIX=0  # Threading mode matrix testing disabled by default (en
 THREADING_MODES=("power" "adaptive" "aggressive")  # Threading modes to test
 THREADING_MODE=""  # Specific threading mode to use (empty = default)
 VERBOSE=0  # Run tests with bash -vx for trace output
+FAIL_FAST=0  # Stop on first test failure
 
 # Source test helpers for RT throttling and DL-server management
 source "${TEST_ROOT}/helpers/test_helpers.sh" 2>/dev/null || true
@@ -520,6 +521,10 @@ run_shell_test() {
 			if [ -n "${mode}" ]; then
 				MODE_FAILED["${mode}"]=$((MODE_FAILED["${mode}"] + 1))
 			fi
+			if [ ${FAIL_FAST} -eq 1 ]; then
+				print_summary || true
+				exit 1
+			fi
 		fi
 	fi
 }
@@ -609,6 +614,10 @@ while [[ $# -gt 0 ]]; do
 			VERBOSE=1
 			shift
 			;;
+		--fail-fast)
+			FAIL_FAST=1
+			shift
+			;;
 		--disable-dl-server)
 			DISABLE_DL_SERVER=1
 			shift
@@ -673,6 +682,7 @@ while [[ $# -gt 0 ]]; do
 			echo ""
 			echo "Other Options:"
 			echo "  --verbose            Run tests with bash -vx for trace output"
+			echo "  --fail-fast          Stop on first test failure"
 			echo "  --disable-dl-server  Disable DL-server before running tests"
 			echo "  -h, --help           Show this help"
 			echo ""
-- 
2.55.0

