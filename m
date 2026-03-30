Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789939A7F6
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899903; cv=none; b=Qx8uJHhz57McYYoCfhtiSW9DCRQetROdOzvE4LfjfY8UGEvR8zKQQJeYlHxKVGB4qDL/oxisEIdYMvnDZfw2OMduNsv/aHRm2oatKnu/Z76Ax8p0TT+9CEt0CzWvT7k/i6zyWD4gI/hMIL7Nli+o+ZYn8XKjY25S9fVMFj4u914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899903; c=relaxed/simple;
	bh=f201kVP5MkpIC06WjS1inzwR9XtdZN3Rr0FcNeZis3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hH2I9egVqVsiz+e9G5AGpkm2ot3uVNbgdO0+jOj7fkazo6R439sVd0mjZOAhCudfeb6Ye7N7k+AGkARRdRpdz4Z/4UDe7I/Anl90ISNSYEidGIGTkGMMHvbYSlXjPdhWLP6hZlWYv1eD5NTnj+WFTcUmOZxILjaME0BZLBhieLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qoc97QjC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qoc97QjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htys+2ZnkkQxFAafeECyHfaPCzXIbLpnBt6FSvV3h50=;
	b=Qoc97QjCDMvIYlFUupq3JQpq17IUI4bsKCRnpet0ZpAqDk1yzQzSYCRp26ixjUOtmnoCQl
	YgjkWmJ0EuZAnMXVHwg/C3iXn0zUSoPByuE+CbShmb09oC3nDKAhMVQiifdnjxiPkUQAfX
	x24uWFjBKBfFXVl8hzDT5TU/CSE4Ces=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515--vP3V2rBMkauKaFFBxwDwA-1; Mon,
 30 Mar 2026 15:44:59 -0400
X-MC-Unique: -vP3V2rBMkauKaFFBxwDwA-1
X-Mimecast-MFC-AGG-ID: -vP3V2rBMkauKaFFBxwDwA_1774899898
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BB0A1800281;
	Mon, 30 Mar 2026 19:44:58 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E490B1954102;
	Mon, 30 Mar 2026 19:44:55 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 07/36] tests/helpers: Replace sleep with poll in start_stalld_with_log()
Date: Mon, 30 Mar 2026 16:43:30 -0300
Message-ID: <20260330194410.103953-8-wander@redhat.com>
In-Reply-To: <20260330194410.103953-1-wander@redhat.com>
References: <20260330194410.103953-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

start_stalld_with_log() uses a hardcoded sleep 1 after launching
stalld, which is both fragile and wasteful. On systems where BPF
backend initialization takes longer than one second, it is
insufficient. On fast systems, it delays every test unnecessarily.

Replace the fixed sleep with a polling loop that checks whether
stalld has started writing to the log file. A brief initial sleep
covers the fast path, then 1-second polling with a 15-second
timeout handles slow startup such as BPF initialization. On
timeout, the process is killed with SIGTERM and escalated to
SIGKILL if it does not exit within one second.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 3fa8d07..f6d6ce2 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -948,11 +948,37 @@ start_stalld_with_log() {
 		echo "Using backend: ${STALLD_TEST_BACKEND}"
 	fi
 
-	# Start stalld with output redirected
-	${TEST_ROOT}/../stalld ${stalld_args} > "${log_file}" 2>&1 &
+	# Start stalld with line-buffered output so tail -f can detect
+	# readiness immediately instead of waiting for the buffer to fill.
+	stdbuf -oL ${TEST_ROOT}/../stalld ${stalld_args} > "${log_file}" 2>&1 &
 	STALLD_PID=$!
 	CLEANUP_PIDS+=("${STALLD_PID}")
+
+	# Poll for stalld to start writing to the log file rather than
+	# using a fixed sleep. Brief initial sleep covers the fast path,
+	# then 1-second polling for slow systems (e.g. BPF init).
+	sleep 0.01
+	local timeout=15
+	local elapsed=0
+	while [ $elapsed -lt $timeout ]; do
+		if ! kill -0 ${STALLD_PID} 2>/dev/null; then
+			echo -e "${RED}ERROR: stalld exited during startup${NC}"
+			return 1
+		fi
+		if [ -s "${log_file}" ]; then
+			return 0
+		fi
+		sleep 1
+		elapsed=$((elapsed + 1))
+	done
+
+	echo -e "${RED}ERROR: stalld did not produce output within ${timeout}s${NC}"
+	kill ${STALLD_PID} 2>/dev/null
 	sleep 1
+	if kill -0 ${STALLD_PID} 2>/dev/null; then
+		kill -9 ${STALLD_PID} 2>/dev/null
+	fi
+	return 1
 }
 
 # Wait for scheduling policy to change to expected value
-- 
2.53.0

