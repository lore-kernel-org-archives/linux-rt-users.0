Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6EF3290A1
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899964; cv=none; b=FzpNhbF2irtbg8jciC8bsTYe5JodHrWFUcuhokzXJJ3vDTrEphqoJl1QqIlbw4fgT8w7kwejIRbdwNHfnHoRHM1ATWy3Xgwdfpix62fpPBLmJEtyGbGHJ6w70T1FYuTKvPDEWQRZjAZrnfnfotmqm1i7EwJY7M8BGQSRrEBcd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899964; c=relaxed/simple;
	bh=cpe8yspPdLu+0CnRJlg6+4jRova7CXo8D1KklIgzzGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkycaGWAvWUwEOvOIQwSREYBkSTg465Y6oV1T766vTlqKI//Lgt/mFjrO2mDdvqMtRF0MIKsju0N/f9GAxgjzKJtf3tDNIDyPU7X1T1XKk9d8BaAZiN/uOWgUBZ5NikPtOlEDFEg3Bh1dvImimQ5MAimxyYdLLtAniClMb307m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrQVmGWs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrQVmGWs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRStCrheRJh48LIiyzGv1+D3YjG9XACmyqS+mAXDetE=;
	b=KrQVmGWs3nCrz3WMBzLLvkg/7M3S7yre1DDHd21kX525ol/q9OVrOKqZfE6GcVbiugAmn/
	vzjJ4JMQFxg5USght6IfppsdY5iTBG9w4F9Ig3YL7ruCHtIGL5eFnF1qTJrapuzr3klbHj
	ZF3LKr+CZa0puZCXyB1DieoAmjOm+Ug=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-XDs0no4TPP2bPP3hFWOnAg-1; Mon,
 30 Mar 2026 15:45:59 -0400
X-MC-Unique: XDs0no4TPP2bPP3hFWOnAg-1
X-Mimecast-MFC-AGG-ID: XDs0no4TPP2bPP3hFWOnAg_1774899958
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11A5C19560B8;
	Mon, 30 Mar 2026 19:45:58 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36C8E195394A;
	Mon, 30 Mar 2026 19:45:54 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 25/36] tests/functional: Use wait_for_stalld_ready() in test_backend_selection
Date: Mon, 30 Mar 2026 16:43:48 -0300
Message-ID: <20260330194410.103953-26-wander@redhat.com>
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

Replace the post-startup sleep with wait_for_stalld_ready() for
event-driven readiness detection. Add -g 1 for consistency with
start_stalld_with_log().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_backend_selection.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_backend_selection.sh b/tests/functional/test_backend_selection.sh
index 5d60072..c274025 100755
--- a/tests/functional/test_backend_selection.sh
+++ b/tests/functional/test_backend_selection.sh
@@ -33,15 +33,15 @@ test_backend_flag() {
 
 	CLEANUP_FILES+=("${log_file}")
 
-	"${TEST_ROOT}/../stalld" -v -f -l -b "${backend_flag}" -t 60 \
+	"${TEST_ROOT}/../stalld" -v -f -l -g 1 -b "${backend_flag}" -t 60 \
 		> "${log_file}" 2>&1 &
 	STALLD_PID=$!
 	CLEANUP_PIDS+=("${STALLD_PID}")
-	sleep 1
 
-	if ! kill -0 ${STALLD_PID} 2>/dev/null; then
+	if ! wait_for_stalld_ready "${log_file}" 15; then
 		TEST_FAILED=$((TEST_FAILED + 1))
 		echo -e "  ${RED}FAIL${NC}: stalld failed to start (${description})"
+		stop_stalld
 		return 1
 	fi
 
-- 
2.53.0

