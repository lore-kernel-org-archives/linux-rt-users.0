Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE43E1200
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943647; cv=none; b=NTATeG1rfSHQ7MaymFtYF7lIVHHKxjxX+MWyQaaKg8WSAclQGkv/QVr5pjMlMtbsnkY0b2OUrFvZm1KE1R/VB5EPd4B7SH4IooofMAnTSnsRxATEt8ccaKVSNaHXiVmjFWIZa/6P2BXFSi3DSaKPvk+aqtwoGQGuZrhFOBpRm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943647; c=relaxed/simple;
	bh=vpe31do/QcUAD+pLjAOeuRF3OvTuIiELsKzHjFVI9uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcPaOTfAoAfGYX8AWnEgSarXHn3Mk5jvomFkEPZujzWghtjOOKKOQ7biJaMBHaoDfhWNE1mpkALOqEhL5I06e1RrVa0k/xb1cGNngN3w7IENz2GCv7P9eIacocdv/J/2FEjlizXaGlJMbEvLjOfV9iOtZxZIn2p6wMzDremEfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8j3THfd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8j3THfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=po3Lrv+X4mX0aT9wshmTOnqm6mbYSUNKZjmMnbfmb2w=;
	b=T8j3THfdhLlQ2cLNqCGqHwvqmVihVnMs7l/i3bMJEs10DFyPUL0lfO/iZZ2AgPn/4zsRAI
	sc7dhQ0uNdKm1YbKBKZdjZPQ1YJofWhSfwgUzvLTygWRrYLnq/C1kbL0U+zKyBY+OutKlX
	MZj8rGZyfziiZKirTVF0sdBuIVmtfCA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-3r58cZUaMUGb9RuY-ldoEw-1; Mon,
 08 Jun 2026 14:34:04 -0400
X-MC-Unique: 3r58cZUaMUGb9RuY-ldoEw-1
X-Mimecast-MFC-AGG-ID: 3r58cZUaMUGb9RuY-ldoEw_1780943643
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90BA0183044D;
	Mon,  8 Jun 2026 18:34:03 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F0B936928;
	Mon,  8 Jun 2026 18:34:01 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 40/52] stalld: check pthread_create return in conservative_main
Date: Mon,  8 Jun 2026 15:31:50 -0300
Message-ID: <20260608183206.140526-41-wander@redhat.com>
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

conservative_main() does not check whether pthread_create() succeeds.
On failure, thread_running stays set to one with no thread behind it,
so the main loop permanently skips that CPU on every subsequent cycle.

Capture the return value and, on failure, clear thread_running and log
a warning so monitoring can resume on the next iteration.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/stalld.c b/src/stalld.c
index 049e5f0..0edb30c 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -908,7 +908,11 @@ void conservative_main(struct cpu_info *cpus, int nr_cpus)
 			if (check_might_starve_tasks(cpu)) {
 				cpus[i].id = i;
 				cpus[i].thread_running = 1;
-				pthread_create(&cpus[i].thread, &dettached, cpu_main, &cpus[i]);
+				retval = pthread_create(&cpus[i].thread, &dettached, cpu_main, &cpus[i]);
+				if (retval) {
+					cpus[i].thread_running = 0;
+					warn("%s: pthread_create() failed: %d\n", __func__, retval);
+				}
 			}
 		}
 
-- 
2.54.0

