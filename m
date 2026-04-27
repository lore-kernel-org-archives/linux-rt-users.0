Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B43B27E5
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2026 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288679; cv=none; b=msHdIAwsbF5UST3uGn2ycpvbMd5adA9gMFAKjyXPZMGaovFrioiDpXv0zpcW4wcZl7c0Wda8gqyad68XJvadsDoddrdUVzkSwvC0VZn1G5XPmpje0SsonoFRbULpCti37h0NddZ2JFE/gUcJkTrDqVPqjC8CjP3HOGKD8QBldUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288679; c=relaxed/simple;
	bh=U/vZvip9cWfCmhHZDQSwy4Qx89+Wl2vysHc2UyrJqS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f97K51Jhz6UX15QbTp7OIy8dYQcbOYomH6IWlQz2td+SRlsKmc13ll6xm46wOAyDMzUgYpDDGNvZ/fpmjeWdJPlgFcl1+kygNzMNtDeQzjN0/veoiAjdgpgD/v8FvLw4vFEFqZUYBCeB6ijisgU+rIs+c0HEZtf55anfNWPS8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXKLjniK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXKLjniK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777288675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLS4/FGvp1ZE0XDQYTa7xaT3k3AuVyizOxmBXLKzSqA=;
	b=XXKLjniKUEC3GGtzLlv+/rz6BAno6YC6jMp2LTMV6CsTOcAN2WsNOO94Vg3SnxGygRaRaU
	xXcX9ZQ492XEssTJs+0kyeWfxy+p6yCkLLOUA9QiMt/axOdZA0tQWCuuPzRUSxsiXx0ee3
	jsx2N1TkbtaS3qzMfPltn7fnWVPnDJA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-u89R0fdGOiCf84CFTKSkEg-1; Mon,
 27 Apr 2026 07:17:54 -0400
X-MC-Unique: u89R0fdGOiCf84CFTKSkEg-1
X-Mimecast-MFC-AGG-ID: u89R0fdGOiCf84CFTKSkEg_1777288673
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A3311944A8E;
	Mon, 27 Apr 2026 11:17:51 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E8A81801922;
	Mon, 27 Apr 2026 11:17:47 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Wiliams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld PATCH 16/23] tests: Remove redundant pkill from cleanup
Date: Mon, 27 Apr 2026 08:16:18 -0300
Message-ID: <20260427111632.24500-17-wander@redhat.com>
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

The cleanup function uses pkill -9 -f starvation_gen to kill all
starvation generator processes system-wide. This is redundant
because the CLEANUP_PIDS array already tracks every spawned
process by PID and terminates them individually.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Assisted-by: Claude Code:claude-opus-4-6[1m] [PAL]
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 757e5e0..2b744d0 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -548,10 +548,6 @@ cleanup() {
 	# Stop stalld
 	stop_stalld
 
-	# Kill any starvation generators first (these often have child processes)
-	# Use pkill which handles process trees better
-	pkill -9 -f starvation_gen 2>/dev/null || true
-
 	# Small delay to let processes terminate
 	sleep 0.2
 
-- 
2.53.0

