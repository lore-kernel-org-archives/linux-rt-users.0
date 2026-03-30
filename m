Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418FE39C649
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899909; cv=none; b=CrmCNjoYL3XT0WDfdwISw6LfsxsxDnhu2qK8HGqjskixo+GB/cE4EwtTdT2DLYrmZT4s3TxD+Ci5AFg2kkeUnbHQtLvugmDshViK6MCd10l+QqM3rl4rCfCuh2kqvpOhx4P/az+o0w4XjXSxoXJJUFqooo9E20eA+GGDLd+rNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899909; c=relaxed/simple;
	bh=wAA91dVz+pxGwIpl9yighi6vumV/PcZ9uMxBJFm7/5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWBqskfA1jVTFhMhr5a/zfJbbjMUAOiJ7FVOFGh/+N3SaRblaBXzt1KOBSJboELGfZzNDO1PyN9S7dwFjI2HvkMOBmmlgr5dwvAl54moQCn+zf3qsW+etDoJHv7Si77S61F+R6wmtCWw5nl9uIC89uAAP0osYfdEvN0nFRDzRVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXnTap91; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXnTap91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LueNHvj17EnXMC8Dk29gK6hwed/b3K9HjlD/Sh2ZCZw=;
	b=cXnTap91BlYlK9HSepQOH2ZXvv5O/Yo3EhWj8DiTOWZIlPeRgZGKOK3bbLFqApo3nmFrWI
	Hr0aRYY4e9lxmbKjSOU4kMYm+GB5f7Aqd+kXlGtgffdHCNyLflljOns0JUTwD3C/hDpWX4
	moxefRaLnfaCyAGcqBMTDOP8EusjRPU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-orMLjcbdNQKaFUJTsitoVA-1; Mon,
 30 Mar 2026 15:45:06 -0400
X-MC-Unique: orMLjcbdNQKaFUJTsitoVA-1
X-Mimecast-MFC-AGG-ID: orMLjcbdNQKaFUJTsitoVA_1774899905
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F353119560AA;
	Mon, 30 Mar 2026 19:45:04 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 297081954102;
	Mon, 30 Mar 2026 19:45:01 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 09/36] tests/helpers: Fix relative path in backend detection functions
Date: Mon, 30 Mar 2026 16:43:32 -0300
Message-ID: <20260330194410.103953-10-wander@redhat.com>
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

detect_default_backend() and is_backend_available() use a
hardcoded relative path "../stalld" to locate the binary for
backend detection via nm. This breaks when tests are invoked from
a different working directory, such as when run_tests.sh executes
them from the project root.

Use ${TEST_ROOT}/../stalld instead, consistent with the path
resolution used in start_stalld_with_log() and
start_starvation_gen().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 1750423..8ff1b80 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -816,7 +816,7 @@ pick_test_cpu() {
 
 # Detect which backend stalld was compiled with (default)
 detect_default_backend() {
-	local stalld_bin="../stalld"
+	local stalld_bin="${TEST_ROOT}/../stalld"
 	if [ ! -x "${stalld_bin}" ]; then
 		echo "unknown"
 		return 1
@@ -839,7 +839,7 @@ detect_default_backend() {
 # Check if a specific backend is available
 is_backend_available() {
 	local backend=$1
-	local stalld_bin="../stalld"
+	local stalld_bin="${TEST_ROOT}/../stalld"
 
 	if [ ! -x "${stalld_bin}" ]; then
 		return 1
-- 
2.53.0

