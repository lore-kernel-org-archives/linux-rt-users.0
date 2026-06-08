Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC33E16A0
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943626; cv=none; b=ZUkJC0NoYVZsiDk2lwxOC63FXOrfrhyqv9u1JqvTdtTIV/Ml+mnF3GMSUmtA9sxK5HhmiwflIlCEhzx+6/8RckyPX5+xNEK/NnpMel0nKO18r6sipT7jQJkHWD8RQMcl7sKVN+1Sei320tXovp9bnNq6PNkWSNq31OJ3uBObB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943626; c=relaxed/simple;
	bh=nlKNlqNYSW0YU4wJ6URoGCabrZyKmG/iV8WPzRwrnQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2KBeQSA2TI2dtqd8GTy61fn2d7I0b1hKr8vw/dTGB04IcDd063dkfqoF4gOSaqMujQ5GacqMIatJcHOj6pxmH7Kksl82IJ9/QPyV7Gtxvfv/Y1PWGVEsfOOwHWns2vrPaGAEL6QifoaklcHvT0b7j02rVI0wxsgRXriMq4RORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYSCirpR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYSCirpR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioh7nI/EWwzM7Fj/Kb139tyYl28Q9za02lnD0cDtZLY=;
	b=dYSCirpRZMCRJYBjWNtyF+I7rDfCJZlo7H1ovzUVySuSrm0hg3N9MouKr1PzIRgNsD2IwM
	NhZmNA6okbkIjUCxr6PVeaUQUNFMb+R0J6rWSSnhxDjwdyHDX02lzWHr6XvCP8DqltHVYp
	BkqB51EK01C5W85P/MDwRkVEvXHPytU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-GCpUBsB4NeeRh1gvwrYgWg-1; Mon,
 08 Jun 2026 14:33:43 -0400
X-MC-Unique: GCpUBsB4NeeRh1gvwrYgWg-1
X-Mimecast-MFC-AGG-ID: GCpUBsB4NeeRh1gvwrYgWg_1780943622
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7667F183044D;
	Mon,  8 Jun 2026 18:33:42 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED57B36927;
	Mon,  8 Jun 2026 18:33:39 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 32/52] tests: Fix async-signal-unsafe handler
Date: Mon,  8 Jun 2026 15:31:42 -0300
Message-ID: <20260608183206.140526-33-wander@redhat.com>
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

