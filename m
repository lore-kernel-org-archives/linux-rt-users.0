Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A539C012
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899891; cv=none; b=lS1g3WOOTn0EOsRbw9xQVmbmnrblwuOXJemA1q1e7lOh4HEhE4bifHP9tswDPQ7ofZlAxymW4Dz1xcEbmnBNaHsTHFIwTHx8KKgxzoDSSSi8g/cpANJcOEQPowbLV5CrcCtHwhPU0vJYvFgJgxjOPKaIhgegCBXESHJZkpX2McE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899891; c=relaxed/simple;
	bh=tAoE5/pvxPjDIm4YQQy5Qtfay5K1nqRRhuBcTZldY94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKAn17n2QWUQWtg3cWO44eNeXRlWlYPPpQxWS2PLAobqPCqT4NvkBrhgFp9xqoSb/7GE/CR+IukziV/fyoOIVNG3eOM2gvxpZLO9r8lj+hKKMKUzvmwCK+OoF6uAC14w6CjdJPRWBV4JhGTPE69uSyrqtk51SKjaw3YCQdmsDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrEObrkl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrEObrkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6jsSvB403TAF3rOGheJjj8/E9mVwnFKEFkuXXqG7nQ=;
	b=MrEObrkln8Ot8OOkrh5OJ/jjCEOkfJh+GQdxkrUG3fYlGuZ9Ts9m1OW3wkuZRn/h7toSWO
	PBwuaGsRVt0UpvnEfcp5LBkIMP0FAK2aRtkKuN5ke7q8uGUWnvg1m+XJC6OjTyRJ3KsKkm
	xiURN8pqON2wPQfDWqeQjP2szb0rtXo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-FS6ILXjaPf2Uuf7D3CdhIg-1; Mon,
 30 Mar 2026 15:44:42 -0400
X-MC-Unique: FS6ILXjaPf2Uuf7D3CdhIg-1
X-Mimecast-MFC-AGG-ID: FS6ILXjaPf2Uuf7D3CdhIg_1774899881
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C793195607B;
	Mon, 30 Mar 2026 19:44:41 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4FBC1954102;
	Mon, 30 Mar 2026 19:44:38 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 02/36] tests/helpers: Fix stalld daemon detection in start_stalld()
Date: Mon, 30 Mar 2026 16:43:25 -0300
Message-ID: <20260330194410.103953-3-wander@redhat.com>
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

The start_stalld() test helper function incorrectly assumed that
daemonized processes would always have a parent PID (PPID) of 1 (init)
or 2 (kthreadd). This assumption is no longer valid on modern Linux
systems utilizing systemd, where orphaned processes are commonly
re-parented to the user's systemd session, not directly to the global
init process.

This led to failures in the test_foreground test on both sched_debug
and queue_track backends due to the helper failing to correctly
identify the daemonized stalld process.

To address this, the daemon detection logic has been refactored.
Instead of relying on PPID checks, the helper now first waits for the
initial shell background process (shell_pid) that started stalld to
exit. This exit signals that stalld has successfully performed its
double-fork and daemonized. Once the parent shell process has exited,
the helper then uses pgrep -n -x stalld to reliably find the newest
running stalld instance, which corresponds to the daemonized process.
This approach provides a more robust and platform-agnostic method for
detecting stalld when it runs in daemon mode.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 45 ++++++++++-------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index c42dab3..5a384a7 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -321,48 +321,29 @@ start_stalld() {
 				fi
 			fi
 		else
-			# Daemon mode: parent forks, child becomes daemon (ppid=1), parent exits
-			# We need to wait for and find the DAEMON child, not the exiting parent
+			# Daemon mode: stalld double-forks, so the shell_pid will exit
+			# and the daemon will be re-parented. Wait for the shell process
+			# to exit, then find the newest stalld process.
 			while [ $attempt -lt $max_attempts ]; do
 				sleep 0.5
 
-				# Get all stalld processes
-				local pids=$(pgrep -x stalld 2>/dev/null)
-
-				for pid in $pids; do
-					if kill -0 $pid 2>/dev/null; then
-						# Check parent PID - daemon should have ppid=1 (init) or ppid=2 (kthreadd)
-						local ppid=$(ps -o ppid= -p $pid 2>/dev/null | tr -d ' ')
-
-						# For daemonized processes, wait for ppid=1 or 2
-						if [ "$ppid" = "1" ] || [ "$ppid" = "2" ]; then
-							STALLD_PID=$pid
-							# Wait a bit to ensure daemon is stable
-							sleep 0.5
-							# Verify it's still running
-							if kill -0 $pid 2>/dev/null; then
-								break 2  # Break out of both loops
-							else
-								# Daemon died, keep looking
-								STALLD_PID=""
-							fi
-						fi
+				# Check if shell_pid has exited (daemonization complete)
+				if ! kill -0 ${shell_pid} 2>/dev/null; then
+					# Shell process exited, daemon should be running
+					# Use pgrep -n to find the newest stalld process
+					STALLD_PID=$(pgrep -n -x stalld 2>/dev/null)
+					if [ -n "${STALLD_PID}" ] && kill -0 ${STALLD_PID} 2>/dev/null; then
+						break
 					fi
-				done
-
-				# If we found a daemonized process, we're done
-				if [ -n "${STALLD_PID}" ]; then
-					break
 				fi
 
 				attempt=$((attempt + 1))
 			done
 
-			# Last resort: use the shell PID if nothing else worked
+			# If we still don't have a PID, try one more time
 			if [ -z "${STALLD_PID}" ]; then
-				if kill -0 ${shell_pid} 2>/dev/null; then
-					STALLD_PID=${shell_pid}
-				fi
+				sleep 1
+				STALLD_PID=$(pgrep -n -x stalld 2>/dev/null)
 			fi
 		fi
 	fi
-- 
2.53.0

