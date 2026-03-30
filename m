Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE839C00A
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899908; cv=none; b=jtO85m9Q1Do4JmdgAIR3VlccJ/pyXNnj+K58aVgXECkO3deco8iibpOep1fuQi0Yo3ZuVznAYmlGPWOFLUPy40k0yX3dABF43sJgKn74IOYYARBoHtcWWUIGmeDf13aVz+DpyxrtPAsDl9BcO1bFDlZNQHpQPMVbrqgIeJt2lrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899908; c=relaxed/simple;
	bh=2FZz0UsUrBwtdwwjIfs4C0hTwdKLGUauY4K5MsBAJMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkjCGn3XonJt7c/ASr0bqZ/eLecODme3l6lromEE728zRZL8KOv0Gs5BhWuiih2IlTOZGhre1u/CL9ec8CuGMqd3klxa0u9tjS8h1sLKvjXlk+qjCbzsrM6DPmuoqTlB9wjGGA62TJ2bkxadtETZsYAs9AF86pk/oZzAgNiKDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EU6JW5+f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EU6JW5+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwcQI+fiM92nE2UF1nNPU0pMK6xhw/UD6PMYc0Jm6MY=;
	b=EU6JW5+foLm3CGOWZuRpQp75acjRgEVjxyVtiOz0pvYfAbIKlYtRSKqyPedEyRI3V1r7vJ
	sgXVneDrwEAq5LByNfwNlOjXeEuSe9edsV/ftROcZeNyfyxa8zaAF1ACoSeW/UV/+e2KQy
	ASC5TwCIQmVHF0QpTspnU2K+8U1jrYc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-IgagTpDXM_y8akpCA1Qv7A-1; Mon,
 30 Mar 2026 15:45:02 -0400
X-MC-Unique: IgagTpDXM_y8akpCA1Qv7A-1
X-Mimecast-MFC-AGG-ID: IgagTpDXM_y8akpCA1Qv7A_1774899901
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99888195604F;
	Mon, 30 Mar 2026 19:45:01 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C89719539A0;
	Mon, 30 Mar 2026 19:44:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 08/36] tests/helpers: Fix stop_stalld() timeout and shutdown logic
Date: Mon, 30 Mar 2026 16:43:31 -0300
Message-ID: <20260330194410.103953-9-wander@redhat.com>
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

stop_stalld() has two bugs. The polling loop after SIGKILL uses
sleep 0.1 with an integer counter, so the nominal timeout of 10
actually gives only 1 second. Additionally, SIGTERM only gets
0.2 seconds before escalating to SIGKILL, which is insufficient
for stalld to perform graceful cleanup such as removing its
pidfile or flushing logs.

Restructure stop_stalld() into two clear phases. First send
SIGTERM and poll for graceful exit with 1-second intervals for
up to 5 seconds, giving stalld time to clean up. Then escalate
to SIGKILL only if the process is still alive, and poll again
for up to 5 seconds with correct timeout arithmetic. Document
the guarantee that the process is dead before the function
returns so callers do not need post-stop sleeps.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index f6d6ce2..1750423 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -365,24 +365,33 @@ start_stalld() {
 }
 
 # Stop stalld
+# Sends SIGTERM and polls for graceful exit, then escalates to
+# SIGKILL if needed. Guarantees the process is dead before
+# returning so callers do not need post-stop sleeps.
 stop_stalld() {
 	if [ -n "${STALLD_PID}" ]; then
 		if kill -0 ${STALLD_PID} 2>/dev/null; then
-			# Try graceful shutdown first
+			# Try graceful shutdown first (SIGTERM)
 			kill ${STALLD_PID} 2>/dev/null || true
-			# Give it a moment to exit gracefully
-			sleep 0.2
-			# Force kill if still running
-			if kill -0 ${STALLD_PID} 2>/dev/null; then
-				kill -9 ${STALLD_PID} 2>/dev/null || true
-			fi
-			# Poll for process termination (don't use wait - might not be a child)
-			local timeout=10
+
+			# Poll for graceful exit (up to 5 seconds)
+			local timeout=5
 			local elapsed=0
 			while kill -0 ${STALLD_PID} 2>/dev/null && [ ${elapsed} -lt ${timeout} ]; do
-				sleep 0.1
+				sleep 1
 				elapsed=$((elapsed + 1))
 			done
+
+			# Escalate to SIGKILL if still running
+			if kill -0 ${STALLD_PID} 2>/dev/null; then
+				kill -9 ${STALLD_PID} 2>/dev/null || true
+				# Poll for forced termination (up to 5 seconds)
+				elapsed=0
+				while kill -0 ${STALLD_PID} 2>/dev/null && [ ${elapsed} -lt ${timeout} ]; do
+					sleep 1
+					elapsed=$((elapsed + 1))
+				done
+			fi
 		fi
 		STALLD_PID=""
 	fi
-- 
2.53.0

