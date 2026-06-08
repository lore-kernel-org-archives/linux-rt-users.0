Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B23E0230
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943657; cv=none; b=rcb5yShxm57PlR45yFkDC9XKo9UYYn/0EJ9eM8NHmzWLyGAJYoztIiakFs/ZwHCLuK0txlq140ZMVlM5UTlzK/jikhvKkJaMhkbPVrurlcS8r6IATW3CeN9HzziXK5BqI1u3NJrEXSFVH92N9BOWUcaLnMFSvOMPeuZWuGBeRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943657; c=relaxed/simple;
	bh=2Dia1vTRfo9yuepdFMK/SMr7vtU+uQ7++YSwZw1atl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OESrIcx/zdKnUXlXCP0JWW2MjK2+3obzzSG1zx/Dw6+wiUf0tEaEfksLN5Xa32Fe18h10IjCrJi63yxGmDFSCphC+1xM3Tv3oshcq10zUv0PebPTQHU5kbpSQvgIoRduuOEj3nzT9Q/VX46bTJFTQR/pB6g4u8VdsA14dHngTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmNblkR3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmNblkR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vsc0JE2Ldz0XoIj2ggri9v5SB8C7axm/NNSdYZWhDQQ=;
	b=RmNblkR35VqdzVDUnrKZQ1C8uJHbed/+TFAXvZ8ZolJSohHko9L6GegJ442WqQcfHFQ/4T
	kVFC1dE0jXtJEwEbg24D+FkqM3wE1tQdr+rVRqTjpqn8tY9nx1R0UxrszYEo2Xenv8IdKb
	FIVTUeI1TJeqaSGyM/vbX3IuNr20798=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-fbcZCPLGOaiuWN8imkoZNw-1; Mon,
 08 Jun 2026 14:34:09 -0400
X-MC-Unique: fbcZCPLGOaiuWN8imkoZNw-1
X-Mimecast-MFC-AGG-ID: fbcZCPLGOaiuWN8imkoZNw_1780943648
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9461018600E1;
	Mon,  8 Jun 2026 18:34:08 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77A9C3692A;
	Mon,  8 Jun 2026 18:34:06 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 42/52] stalld: fix data race on config_buffer_size
Date: Mon,  8 Jun 2026 15:31:52 -0300
Message-ID: <20260608183206.140526-43-wander@redhat.com>
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

In aggressive mode multiple cpu_main threads execute sched_debug_get()
concurrently. Each thread may double config_buffer_size when the
sched_debug output outgrows the current buffer, and
resize_buffer_if_needed() reads the variable from every thread without
synchronization. These concurrent accesses to a plain size_t
constitute a data race under the C11 memory model.

Declare config_buffer_size as _Atomic size_t so that stores and loads
are indivisible and visible across threads.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.c | 2 +-
 src/stalld.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/stalld.c b/src/stalld.c
index 0edb30c..feb0099 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -94,7 +94,7 @@ long page_size;
  * in detect_task_format. May change over time as the
  * system gets loaded
  */
-size_t config_buffer_size;
+_Atomic size_t config_buffer_size;
 
 /*
  * Boolean for if running under systemd.
diff --git a/src/stalld.h b/src/stalld.h
index 81ce9f7..03a4ca1 100644
--- a/src/stalld.h
+++ b/src/stalld.h
@@ -243,7 +243,7 @@ extern regex_t *compiled_regex_thread;
 extern regex_t *compiled_regex_process;
 extern char *config_sched_debug_path;
 extern int config_reservation;
-extern size_t config_buffer_size;
+extern _Atomic size_t config_buffer_size;
 extern long page_size;
 extern struct stalld_backend *backend;
 extern char *config_affinity_cpus;
-- 
2.54.0

