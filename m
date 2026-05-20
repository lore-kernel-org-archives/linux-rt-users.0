Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA1325491
	for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285767; cv=none; b=VENLiluz77rknnqcDIq5QVaQV3X7ziEHTZtILgF4WKKNS6If6Fgv2+QgnJP4DxAhwDYQZeY0Se5c2JArrWkdhZCWd+smdPfukF/oiETr4Mlqb3I41OT0wApm5/8gGGciMNHOkwh2HGKNaMSUI8dfPSbmTFjh1wUXPMY067P4UMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285767; c=relaxed/simple;
	bh=nlKNlqNYSW0YU4wJ6URoGCabrZyKmG/iV8WPzRwrnQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rpi3ilbVOD55Cp7BdW57q765nlf/a9y9BRIMoUXCOBKYRSpe7myn76F5N+fpy0sIDAEFr/7KmIPDz7IrPz6UCJn3FPxgdAGJvRvcj3m4XtfAut/3oX3V4S9bEXleIVaZiJOfZUKVf7wmO3/4mNlvcnzLIZqBHNlnGU1ImdIpGLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wlzm0+7W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wlzm0+7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779285765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioh7nI/EWwzM7Fj/Kb139tyYl28Q9za02lnD0cDtZLY=;
	b=Wlzm0+7WxsG2scmzvdiljwHHaMt6PR+o7ee9JnJAZQwbByQkrDZ3+Om5jYHFaHJowClfUg
	7NN2bV0o2npt6GdbGvWG5DhpMB4afHle3FLaDvPlZxRPuLAON0IwQbWAGk8k4non4R87Jn
	FBykYB0I6srikyFuITTjktPKAg1VmQ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-aoS4gQv8Ns-i9ABa9DJ6qw-1; Wed,
 20 May 2026 10:02:40 -0400
X-MC-Unique: aoS4gQv8Ns-i9ABa9DJ6qw-1
X-Mimecast-MFC-AGG-ID: aoS4gQv8Ns-i9ABa9DJ6qw_1779285759
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E36F19560B7;
	Wed, 20 May 2026 14:02:39 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 638261800352;
	Wed, 20 May 2026 14:02:37 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [[PATCH stalld] 32/33] tests: Fix async-signal-unsafe handler
Date: Wed, 20 May 2026 11:00:59 -0300
Message-ID: <20260520140104.112142-33-wander@redhat.com>
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

Remove the printf call from the starvation_gen signal handler.
Calling printf from a signal handler is undefined behavior under
POSIX because it is not async-signal-safe. If the signal arrives
while another thread holds the internal stdout lock, the process
deadlocks. The handler now only sets the volatile running flag.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/starvation_gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/helpers/starvation_gen.c b/tests/helpers/starvation_gen.c
index 81ee714..88cedac 100644
--- a/tests/helpers/starvation_gen.c
+++ b/tests/helpers/starvation_gen.c
@@ -102,7 +102,7 @@ void *blockee_thread(void *arg) {
 }
 
 void signal_handler(int sig) {
-	printf("\nReceived signal %d, exiting...\n", sig);
+	(void)sig;
 	running = 0;
 }
 
-- 
2.54.0

