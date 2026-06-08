Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFD3E3C69
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943665; cv=none; b=UW69vE3KCEZAiet++U0KbGOD4IO6JkNg2qT9fBiCdEJds6XOXCEbrdp+yIWjgQWTOpiZRPKuwby9CVQ3ovRiiyZKgEAw/4sxFocwxsdWvyUTQz5kpABOyA8M8w65vIQaCb0RL2uTwhOVPAyQ68fA9MVsNRPDJ/Z8/mVSIuOEE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943665; c=relaxed/simple;
	bh=xg9GRkmMVQgdZscIrOjOlyIJ0ZZGGBz9w7esRm2In/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dt8azmQoSIOYEgxtbu+cEskvO8xvnwHOSp3aP+Zy6RJkv2TJKE5MEvbRXALhh/N86Zel7DDXYWvmWQkN4HYX5R1i+bi66TeMWaRl6MW9vWyzrTp4qO4iVY3g7OvYXjY0SQNjak0H6+m32srGrpraPs+ymzkkR53qQH/m9VNiT0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIJnsF8U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIJnsF8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOTKh1Rt5L4M77ll3GCM98b+DcbywGmkO3Z2cPQgsGo=;
	b=NIJnsF8Ugkfbk0EVCLCvpqAOnXKnxFTQfqWhxyD3cpf5RKlE11/lrdBDSDGU4G5axocCaa
	Y+gNqLwiAZwG+zixbCBtD+f8tr0BmDNa0RtRSrEli3kIDIdI9YR9LSs6EYG8zWL0ZzWG0J
	hSoJ8zNPup6//kTMi2gx7djJQnzpNpg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-KhujOUlCNIC3CVZ98xDGpg-1; Mon,
 08 Jun 2026 14:34:22 -0400
X-MC-Unique: KhujOUlCNIC3CVZ98xDGpg-1
X-Mimecast-MFC-AGG-ID: KhujOUlCNIC3CVZ98xDGpg_1780943661
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 644D51835D6F;
	Mon,  8 Jun 2026 18:34:21 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A8C936932;
	Mon,  8 Jun 2026 18:34:19 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 47/52] stalld: remove NULL deref in fill_waiting_task error handler
Date: Mon,  8 Jun 2026 15:31:57 -0300
Message-ID: <20260608183206.140526-48-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The defensive NULL check for cpu_info in fill_waiting_task()
dereferences the pointer it just determined to be NULL by assigning
cpu_info->starving = NULL. Remove the dead store so the error path
returns cleanly without faulting.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/sched_debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/sched_debug.c b/src/sched_debug.c
index 5ddc331..f481bb2 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -526,7 +526,6 @@ static int fill_waiting_task(char *buffer, struct cpu_info *cpu_info)
 
 	if (cpu_info == NULL) {
 		warn("NULL cpu_info pointer!\n");
-		cpu_info->starving = NULL;
 		return 0;
 	}
 
-- 
2.54.0

