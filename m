Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359A3E1D13
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285727; cv=none; b=Ji6/xWMRtkrAoSJfOuavhiWWiZ6TrrTPUOPMCtKdXFqmM5EXnp/pEe8TUcdK6xEikBwjTLmb05/wplg06HAs2rfrUAx5FuYSpBWJ4LfMKr/0OjdU6mEpyKb9jyQ0nR0JvbAQzCBLlnUEJMAmHfwl0RB3I+0IBc9t0VJkrtc2S8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285727; c=relaxed/simple;
	bh=WaTpPZulu5OUZLDSbZ7123KExoUgbjwDrRPhmiwU7Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaLwauUI8rNTWNCNgyOklaikidbHuYIqhRfh/aRJMcSs8m59a320G+S9Dl4NzotNXvt/1imvdlPjh+Iaus1CoQKDBSuwpb8wj0r3Z0A+WHM0YL2+kY+GTwL0VCTlTv3LVg/AHmHdo6c/YgsLQqk5K0eESZjBAcsMoiVcID64s2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tp5JlUHg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tp5JlUHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWmMvvpbBaGVjPqnYWnf3RcKIV+G3rH/pKfDQXkttr8=;
	b=Tp5JlUHgOFpgK1jArItBvzCbaH/k7PhEfLmBpTy7mEARghhR2lUVMSPslrzeUtS/e/YzyT
	buUBRtxDkUxDNjhkVY1cc3FiJVGxgSeFFHrthiNEjhXiFpUJ9B2FgER+LWkyX/Siu1DZ0x
	PFVzizo8tNJcvQjcJnV8hNZDkCwnTvk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-O6KFBYepN_WLJ8MzjqcJTw-1; Wed,
 20 May 2026 10:01:59 -0400
X-MC-Unique: O6KFBYepN_WLJ8MzjqcJTw-1
X-Mimecast-MFC-AGG-ID: O6KFBYepN_WLJ8MzjqcJTw_1779285718
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4C5B180075C;
	Wed, 20 May 2026 14:01:58 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9191A1800576;
	Wed, 20 May 2026 14:01:56 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 16/33] tests: Remove redundant pkill from cleanup
Date: Wed, 20 May 2026 11:00:43 -0300
Message-ID: <20260520140104.112142-17-wander@redhat.com>
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
2.54.0

