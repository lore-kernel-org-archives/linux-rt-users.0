Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1939934D
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899927; cv=none; b=WBD/vq9AoPrK3qA6Ns1Ot8n8kVXQMW1OsmvqDFNinkqwCt27iMj4ftUnYQIcVmr2gVqIcRC1m8UqBrrb/zoEnLx7W+xh73TcoLjkK3MFJZIpuydKyjPHz3uLSHI5kQEFugzW+F4tjgfLm+TKkQB/oiCxqJQmMQsb4vYHS2YP5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899927; c=relaxed/simple;
	bh=m0mMw/acljjxhWQ8nHDGaWR23OyXZx42AGvalfRGt0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4gvR4DGjPP//TOmwrgCqVQ3s/1z0OGMA7a1DLtnXKiF5INPSH8q5CVPRKNuGhxhW1pi/ylCgDYfkV6MVcUIHuVzU0Zup4QiMXGsDJ/yRI4cSl35gROnR0Ew8qRp4rlIAR2A3U0Bp5jAp/wIMJenHEnsYs00w8g5d7oEpwCqkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Swuzwp+b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Swuzwp+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6jzo5EeD1JHpT3mMAqqZ7QSsWYMaj1dk8D0SmWw83E=;
	b=Swuzwp+bSD/k+zpAxHjR0uy5o4+FErfVYGhMGwA+jF/dOxwM0NyVIjryLm803zorJItYDD
	Dbkz0B2z/QR2Urxu+ySwbIGSUCArgr21aZkNVUvf9gr5FfkKj90H9qBgpp4xBmmZrIfFDK
	CuO9tco2wFsZYAa0UYMbe0XVTA1M0Oc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-Er2mVyj1PEqJkGXMKfNCgg-1; Mon,
 30 Mar 2026 15:45:21 -0400
X-MC-Unique: Er2mVyj1PEqJkGXMKfNCgg-1
X-Mimecast-MFC-AGG-ID: Er2mVyj1PEqJkGXMKfNCgg_1774899921
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEC1E1800344;
	Mon, 30 Mar 2026 19:45:20 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 625F81954102;
	Mon, 30 Mar 2026 19:45:18 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 14/36] tests/helpers: Fix fractional sleep timeout bugs
Date: Mon, 30 Mar 2026 16:43:37 -0300
Message-ID: <20260330194410.103953-15-wander@redhat.com>
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

The cleanup() process termination loop and start_stalld() pidfile
wait both use fractional sleeps (0.1s and 0.5s) with integer
counters, causing the actual timeouts to be a fraction of the
nominal values. cleanup() with timeout=5 and sleep 0.1 gives only
0.5 seconds, and start_stalld() with timeout=15 and sleep 0.5
gives only 7.5 seconds.

Change both loops to use sleep 1, making the timeout arithmetic
correct. Restructure the cleanup loop to use the same two-phase
SIGTERM/SIGKILL pattern established in stop_stalld().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index e4e9b23..06c0471 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -288,7 +288,7 @@ start_stalld() {
 		local timeout=15
 		local elapsed=0
 		while [ ! -f "$pidfile" ] && [ $elapsed -lt $timeout ]; do
-			sleep 0.5
+			sleep 1
 			elapsed=$((elapsed + 1))
 		done
 
@@ -452,21 +452,23 @@ cleanup() {
 		if [ -n "${pid}" ] && [ "${pid}" -gt 0 ] 2>/dev/null; then
 			# Check if process exists
 			if kill -0 ${pid} 2>/dev/null; then
-				# Try gentle kill first
 				kill ${pid} 2>/dev/null || true
-				# Give it a moment
-				sleep 0.1
-				# Force kill if still running
-				if kill -0 ${pid} 2>/dev/null; then
-					kill -9 ${pid} 2>/dev/null || true
-				fi
-				# Poll for termination (don't use wait - might not be a child)
+
 				local timeout=5
 				local elapsed=0
 				while kill -0 ${pid} 2>/dev/null && [ ${elapsed} -lt ${timeout} ]; do
-					sleep 0.1
+					sleep 1
 					elapsed=$((elapsed + 1))
 				done
+
+				if kill -0 ${pid} 2>/dev/null; then
+					kill -9 ${pid} 2>/dev/null || true
+					elapsed=0
+					while kill -0 ${pid} 2>/dev/null && [ ${elapsed} -lt ${timeout} ]; do
+						sleep 1
+						elapsed=$((elapsed + 1))
+					done
+				fi
 			fi
 		fi
 	done
-- 
2.53.0

