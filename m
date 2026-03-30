Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5EB394492
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899921; cv=none; b=hcVPe7uBwXXtCBo7N4BnbNRknGTcBxMC2CdZTIde+CJV9SGpjWYRN0UoHzSNG9LV//9zdsFJIEeR/pg1D8/FKyRpi06sNWKt7d9/aSYH2dStvc1NsxAd5RzY5tCz8Nq/y735cq4/YJG93w7v8OfjDp+4UwDC25uCRtZR36shIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899921; c=relaxed/simple;
	bh=TJqXC6ET8nYImifJU1xfYufjA2SYuXs8bqlTkJCP6XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4I+WKylvyZ4s6VNKWZrIaJ8eXLIbybps1LdLchas7NMuPyacileI95+2f2m6MB1SMX0LPAzDbK0LL2KuFRL5Nd8uf+52MSqqYhhdfWWvV6svIBZ+upwDCx0dmN8tfUjfAZdqWKjdDgS3SKEyBlWbdVYeG4jaD8O5hp62/77ao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuUk6UzX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuUk6UzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOnL+3SDG3xa13tDVrsOzWkbG4x3Y5WTJIjlEp55sUc=;
	b=MuUk6UzXPjNGMQ8/bQFKVfHwaXrFGRB/ScSAtIYx2G3LNuqCFq2SWWotmhPpIIf0xQV9OP
	/Z8ggdhTMcOww+gm+v1MGPcMJ39Cy3D1quL7jrLrB5fsE8mZwnAPesNDzm53rSCwGDvMs1
	IHtr2HwnRqfkf+ikOFKBLgaelTplltQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-WDXWtxCnOc6DdbllKCtZlw-1; Mon,
 30 Mar 2026 15:45:15 -0400
X-MC-Unique: WDXWtxCnOc6DdbllKCtZlw-1
X-Mimecast-MFC-AGG-ID: WDXWtxCnOc6DdbllKCtZlw_1774899914
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A99A01944F2F;
	Mon, 30 Mar 2026 19:45:14 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05EF31954102;
	Mon, 30 Mar 2026 19:45:11 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 12/36] tests/helpers: Rewrite wait_for_log_message() with process substitution
Date: Mon, 30 Mar 2026 16:43:35 -0300
Message-ID: <20260330194410.103953-13-wander@redhat.com>
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

wait_for_log_message() uses a 1-second polling loop to check for
a pattern in a log file, adding up to 1 second of latency even
when the message appears instantly. It also has a journalctl
fallback that is unused by any caller and a misleading default
log file parameter (/var/log/syslog).

Rewrite the function to use process substitution instead of polling.
By feeding the output of a timeout-wrapped tail -f into grep -m1 -q
via process substitution, the function returns immediately when the
pattern appears. Process substitution is specifically required here
rather than a standard pipeline. In a pipeline, bash waits for both
processes to exit. Because tail -f blocks on inotify and does not
receive SIGPIPE, a pipeline would hang for the full timeout duration
even after grep finds a match.

Additionally, remove the unused journalctl fallback and make the log
file a required parameter since all callers pass one explicitly.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 41 +++++++++++++++--------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 8ff1b80..08838a2 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -500,36 +500,31 @@ handle_signal() {
 trap cleanup EXIT
 trap handle_signal INT TERM
 
-# Parse stalld log for specific message
+# Wait for a specific message to appear in a log file.
+# Uses tail -f piped through grep for instant detection -- returns
+# immediately when the pattern appears instead of sleeping between
+# polling intervals. Replays existing file content so messages
+# written before this function is called are also matched.
+#
+# Usage: wait_for_log_message <pattern> <timeout> <log_file>
 wait_for_log_message() {
 	local pattern=$1
 	local timeout=${2:-10}
-	local log_file=${3:-/var/log/syslog}
+	local log_file=$3
 
-	# If log_file doesn't exist, try journalctl
-	if [ ! -f "${log_file}" ]; then
-		# Using journalctl instead
-		local elapsed=0
-		while [ ${elapsed} -lt ${timeout} ]; do
-			if journalctl -u stalld --since "1 minute ago" 2>/dev/null | grep -q "${pattern}"; then
-				return 0
-			fi
-			sleep 1
-			elapsed=$((elapsed + 1))
-		done
+	if [ -z "${log_file}" ]; then
+		echo -e "${RED}ERROR: wait_for_log_message requires a log file${NC}"
 		return 1
 	fi
 
-	local elapsed=0
-	while [ ${elapsed} -lt ${timeout} ]; do
-		if grep -q "${pattern}" "${log_file}"; then
-			return 0
-		fi
-		sleep 1
-		elapsed=$((elapsed + 1))
-	done
-
-	return 1
+	# Process substitution runs tail in the background so bash
+	# only waits for grep to finish. A pipeline (tail | grep)
+	# would block until timeout kills tail even after grep has
+	# matched, because tail -f is blocked on inotify and never
+	# receives SIGPIPE.
+	grep -m1 -q "${pattern}" \
+		< <(timeout "${timeout}" tail -f -n +1 "${log_file}" 2>/dev/null)
+	return $?
 }
 
 # Get thread scheduling policy
-- 
2.53.0

