Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3143876B9
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899929; cv=none; b=ElAG0RhtCAMDPk6iMx2x0kvWFBwsLOhpXe6xvsisOR66TcfCmnwjTIKf23AI5E8IJycpzBnDue31kxVepQXy5CAFiL6pNnaMBW1WAylMi+Er6gQbiHItL4Ny1UsZw6hVLcyU8DUCy79p31RjuGrMd+Voa5eR/+Yimz9jhr5Xk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899929; c=relaxed/simple;
	bh=EPzbe5WQHKOK9JWaEJhxskio1ciacQjcpMyo2xBmf8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSeBfjUmkgkglCF/4zXzFEGolYbe46U3B8vQQJ03DZ9GbzyktKFTjYLoz9BK5qLSNEz62hnu9/2Pa9b2vZDmOK0UAZ4ePAzXa5y3iYsEmGS/JPNDfUtt6Pkb162fX1Ql+DNXc8A1XLxwskbn990mTCKo0Voa/EPSmhg5tXa8crA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDcKTRuP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDcKTRuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpJbawX7U5zIMkLLoVOLutvGh2Y1DPdX14aweqxPK8Y=;
	b=KDcKTRuPht15K1601t+YgbPpVWf69Fnrx/AWID7T7y9HJlRlPHOvdqv8M+wRg0JvIj73mh
	tGsF1/iZhLmJWNOgP4BTcTCqIHtDJgXODti4iL/7Vy2X9JvTeJ62azDQF3tNcPOZyMFeyD
	M69iTmejPBsnIfFxm0y1p3+kr1GEo8k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-5upSMZ_ZN-ySXkI10QUW7g-1; Mon,
 30 Mar 2026 15:45:25 -0400
X-MC-Unique: 5upSMZ_ZN-ySXkI10QUW7g-1
X-Mimecast-MFC-AGG-ID: 5upSMZ_ZN-ySXkI10QUW7g_1774899924
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C86D18005B9;
	Mon, 30 Mar 2026 19:45:24 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FAB71954102;
	Mon, 30 Mar 2026 19:45:21 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 15/36] tests/helpers: Flush stdout after starvation_gen startup messages
Date: Mon, 30 Mar 2026 16:43:38 -0300
Message-ID: <20260330194410.103953-16-wander@redhat.com>
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

starvation_gen prints its startup configuration (iteration target and
stop instructions) via printf, but does not flush stdout afterward.
When stdout is not connected to a terminal, libc switches to block
buffering, so these messages may not reach the test harness until the
buffer fills or the process exits.

Add an explicit fflush(stdout) after the startup printf calls to
ensure immediate delivery regardless of buffering mode.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/starvation_gen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/helpers/starvation_gen.c b/tests/helpers/starvation_gen.c
index dc0e3de..81ee714 100644
--- a/tests/helpers/starvation_gen.c
+++ b/tests/helpers/starvation_gen.c
@@ -345,6 +345,7 @@ int main(int argc, char **argv) {
 	}
 	printf("\nBlockees will complete if boosted enough to finish %lu iterations\n", cfg.work_target);
 	printf("Press Ctrl+C to stop early\n");
+	fflush(stdout);
 
 	/*
 	 * Wait for specified duration OR until all blockees complete (whichever comes first).
-- 
2.53.0

