Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B71CAA6C
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690739; cv=none; b=rKOVw2o7nKNbPYQynNTX478BbDQSLPHh/WDuYdL5aWeVoBSKL9BkNChLwaTscwW+3CWDuCgJy1gREuCrHAvRGfDDGusbJAA9qz/Cvt8o1AHiUJqxlMJPq7LicK0tGMeUGxVh2K0czzrsi1DY0vTEZxdOttIaCsH2wHNjwxlUfQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690739; c=relaxed/simple;
	bh=oZSb0u/oFNiihuOa+dLa+OD2eRE21jBO9UFeDYJyXRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjRbfTxdEkgNwRgzSLnpzqXooahX35kh3gUIWTurtpbOvWXjD/LrF4x/gG7vbMcuX4nFg8oSyP8cVztoRUC3Jv/oc5/WPmhEg6Tu7Leq3ZtCvW0YL9yt5Zxh5dSOFbXxBJczil8QsDEl/s0qZIBmLs7wPxLUMCt8FC+8pG96UQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhFhs2lr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhFhs2lr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MRjeVrnyAZlyTMKhRiwpGTDwu/oVLSH9gPt2Y6ML6k=;
	b=dhFhs2lr00UnZfNcICZba1m7c1eIN0MzCbA77jFOysgQIZsHfBC3cbRTPjUx75b1Wr1JPB
	uGhegQvTeySNmGxD+T9WtTB2fjfQqVkKItRiCw6LQ/DSIznftFLKjkhQmEE6UNbGmcETXN
	Ptik2OdYPrme+Le+kmifaYmIMONd458=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-yK9krmgePmiu0vuIGL_ODw-1; Fri,
 10 Jul 2026 09:38:54 -0400
X-MC-Unique: yK9krmgePmiu0vuIGL_ODw-1
X-Mimecast-MFC-AGG-ID: yK9krmgePmiu0vuIGL_ODw_1783690733
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1AC81955F16;
	Fri, 10 Jul 2026 13:38:52 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F523195608E;
	Fri, 10 Jul 2026 13:38:50 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 01/11] stalld: add readiness log marker for tests
Date: Fri, 10 Jul 2026 10:38:00 -0300
Message-ID: <20260710133810.72398-2-wander@redhat.com>
In-Reply-To: <20260710133810.72398-1-wander@redhat.com>
References: <20260710133810.72398-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The test helper wait_for_stalld_ready() previously matched
implementation-detail messages like "checking cpu", "waiting
tasks", or "skipping" that appear during the first monitoring
cycle. These messages depend on system state and verbose-mode
internals that could change across refactors.

Add a "monitoring started" log_msg() call at the end of main()
initialization, after write_pidfile() and before entering the
main loop. Update wait_for_stalld_ready() to match this
deterministic marker instead of the old alternation pattern.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.c                  | 2 ++
 tests/helpers/test_helpers.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/stalld.c b/src/stalld.c
index ac9800d..34b0fd0 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -1239,6 +1239,8 @@ int main(int argc, char **argv)
 
 	write_pidfile();
 
+	log_msg("monitoring started\n");
+
 	/* The less likely first. */
 	if (config_aggressive)
 		aggressive_main(cpus, config_nr_cpus);
diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index af341e0..53de276 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -696,7 +696,7 @@ wait_for_log_message() {
 wait_for_stalld_ready() {
 	local log_file=$1
 	local timeout=${2:-5}
-	wait_for_log_message "checking cpu\|waiting tasks\|skipping" "${timeout}" "${log_file}"
+	wait_for_log_message "monitoring started" "${timeout}" "${log_file}"
 }
 
 # Wait for stalld to detect a starving task.
-- 
2.55.0

