Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB996409289
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690750; cv=none; b=P4mh9LD0bC57j62EsoIcR0sBxkGO+ZWlPVS8k+S8Mu8hxQLS0+MRyVZS6JVLAVRn1DXD6YPQn6Uofh8Y1TEmGsYYUsFHPrux0MevxwjEMj0YH8bc/lrMfASHg8vBx2HA+bmT0Ht7Bpmff5LYVg3MpmgOTUxLhjalnEwDVSOr6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690750; c=relaxed/simple;
	bh=rsPAkTcgd0YitJ1NrmdC1QZ9wM9jVUadh78BtKNSfDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxDHtxP931Xzvi5sIesTmj8xNQ0lFIU70Pp783Hda32gNv7AGXe+IUsJfTNK98/d3P4uzzzc0+dp/EDP3ghwAe1nbslnz6gB55NwJxhuIeD1q/r1pgP45fw3KD6tdVfKixczhUl+izw0FAPdJOdaLxX/ED+pZ+vds70m6rizcjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJAcYNcs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJAcYNcs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTaYiHSnp1zKCIlDQ/wS10v3lvjZ2vl3NnIhlruKOfw=;
	b=WJAcYNcstgKYckt885dMVOwmSJdZLRlwoTbugg8oi5e0ylzFUNZfUdkz75ro7uFpuj/kbM
	IZ/LsTP1a231Fm8gzfwM/cgajVUPJ1i0EBKPKX9JjdRsFGHlE7XBPqS7LkKmdj1BXK7hmP
	ghfCb15iMUWaOJfNR8vrgnJuXjX6v78=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-GDZA4E5oNeyIauL7o0ceUg-1; Fri,
 10 Jul 2026 09:39:02 -0400
X-MC-Unique: GDZA4E5oNeyIauL7o0ceUg-1
X-Mimecast-MFC-AGG-ID: GDZA4E5oNeyIauL7o0ceUg_1783690741
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14E0C18005A9;
	Fri, 10 Jul 2026 13:39:01 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B39CB195608E;
	Fri, 10 Jul 2026 13:38:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 04/11] tests: drop journal logging from test framework
Date: Fri, 10 Jul 2026 10:38:03 -0300
Message-ID: <20260710133810.72398-5-wander@redhat.com>
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

The test helper's log() function wrote every message to the system
journal via logger -t stalld, tagging entries with [TEST] to
distinguish them from real stalld output.  start_test() and
end_test() also called logger directly alongside echo.

These journal entries interfered with test_logging_destinations.sh,
which inspects journalctl for stalld's own syslog messages.  The
[TEST] entries appeared under the same stalld identifier and had
to be filtered out, making the assertions fragile and causing
spurious failures from journal flush races.

Remove the logger calls and the ANSI-stripping sed from log().
Replace the separate echo/logger pairs in start_test() and
end_test() with a single log() call each.  The test framework
now writes only to stdout, leaving the journal free of test
noise.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 12b548e..1e3d736 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -38,19 +38,13 @@ else
 	NC=''
 fi
 
-# Logging function that writes to both stdout and journal
-# This allows correlating test activities with stalld behavior in journalctl
+# Logging function that writes to stdout with a timestamp
 log() {
 	local timestamp="[$(date +'%H:%M:%S')]"
 	local message="$*"
 
 	# Echo to stdout with timestamp
 	echo -e "${timestamp} ${message}"
-
-	# Also send to journal with stalld tag for easy correlation
-	# Strip ANSI color codes before sending to journal
-	local clean_message=$(echo "${message}" | sed 's/\x1b\[[0-9;]*m//g')
-	logger -t stalld "[TEST] ${clean_message}"
 }
 
 # Parse common test options
@@ -87,20 +81,16 @@ parse_test_options() {
 # Start a test
 start_test() {
 	TEST_NAME=$1
-	echo -e "${BLUE}=== Starting test: ${TEST_NAME} ===${NC}"
-	# Log test start to journal for correlation
-	logger -t stalld "[TEST] === Starting test: ${TEST_NAME} ==="
+	log "${BLUE}=== Starting test: ${TEST_NAME} ===${NC}"
 }
 
 # End a test
 end_test() {
 	if [ ${TEST_FAILED} -eq 0 ]; then
-		echo -e "${GREEN}=== Test ${TEST_NAME}: PASSED ===${NC}"
-		logger -t stalld "[TEST] === Test ${TEST_NAME}: PASSED ==="
+		log "${GREEN}=== Test ${TEST_NAME}: PASSED ===${NC}"
 		return 0
 	else
-		echo -e "${RED}=== Test ${TEST_NAME}: FAILED ===${NC}"
-		logger -t stalld "[TEST] === Test ${TEST_NAME}: FAILED ==="
+		log "${RED}=== Test ${TEST_NAME}: FAILED ===${NC}"
 		return 1
 	fi
 }
-- 
2.55.0

