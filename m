Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806339C003
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899893; cv=none; b=XRB7/m5IBlFe+5pVXvDr/kC9F5Fy95420A57CkcyZRNuSgQpKoxJXNscBhJL5tYMfSwoConVoelTxabdJfoA4A7fl4nGliJI+hkBrEJejW9Lb4zR5YJIUvzaGxaKavDAf4kwqGMNhiFgREVvH2n2YNfDOfVao8ZTCH248usn35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899893; c=relaxed/simple;
	bh=J5VaWR3veUL142wTrIvKL9ScAc0ELq2RzzVees/A/os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0DH4+lk6Ivybm4e5AJZwMi+T+Inoa3OWKQdcDEu6DMQBE7R1K14vmcvr0KKQy1rM21bDNkqtDOQKVVANTEVCguUypaoxjn1pp7y1GCHEVQTHpCRlf8J9xyztcC8pRKbPb6vtFlW4S0KyuvO1nfFX9+1tvtstH04ZNd89cuyADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0e0WMMG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0e0WMMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+it5bmMmkb94nXaqc0opwMi2a7m7Z8VyYyVGFrU1mI=;
	b=Z0e0WMMGz016OG0JalLxOEVype/6jcFtlH2QDdxga5+fVgnzxNEGp4qBGMvaYvRfSw137Z
	4K1C5QmpqTe8XR7NFasPC6U4YLMKDwV3F/k2DH5aNz+yYQmgH2ypmNrlgrcLlP+dK7FeCG
	vZvr5b8Runkm/e4cK6+M8/iwaLrvgbE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-fikMY44mMlC3f5kt9EOcfw-1; Mon,
 30 Mar 2026 15:44:47 -0400
X-MC-Unique: fikMY44mMlC3f5kt9EOcfw-1
X-Mimecast-MFC-AGG-ID: fikMY44mMlC3f5kt9EOcfw_1774899885
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6063180049D;
	Mon, 30 Mar 2026 19:44:44 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6B211954102;
	Mon, 30 Mar 2026 19:44:41 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 03/36] tests/helpers: Remove duplicate log() function
Date: Mon, 30 Mar 2026 16:43:26 -0300
Message-ID: <20260330194410.103953-4-wander@redhat.com>
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

test_helpers.sh defines log() twice: the full version at line 43
with journal correlation via logger, and a simplified version at
line 895 that only echoes to stdout. In bash, the second definition
shadows the first, so all tests were silently losing journal
logging that enables correlating test activities with stalld
behavior in journalctl.

Remove the duplicate to restore journal logging for all tests.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 5a384a7..3fa8d07 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -891,11 +891,6 @@ start_stalld_with_backend() {
 # Consolidated helper functions (previously duplicated across tests)
 #
 
-# Logging with timestamp (used by many functional tests)
-log() {
-	echo "[$(date +'%H:%M:%S')] $*"
-}
-
 # Get scheduling policy (0=OTHER, 1=FIFO, 2=RR, 6=DEADLINE)
 get_sched_policy() {
 	local pid=$1
-- 
2.53.0

