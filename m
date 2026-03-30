Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C539DBC9
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899950; cv=none; b=B1o01us3SzNS0/FHOCHPAJOhcC/8mxmKgTdT9gNT0Qwa7vkaA4M7GDH1y6y8fBaEwSkhRK8zqrew0pUPuxdftOvLYJNk89SLXbx6RNn17KSUaCGqovw8YI9LkZFJYP4mT3AChvPN0sj+XephsBtevCXVfQsAi99GVnwEBsLHyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899950; c=relaxed/simple;
	bh=dfXFUca30MxkVP3jaccu4B9w2x83BcZT5zyNmGHsAjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmQ7qNqnDWHjMpzRwtgyOkPV83k3wYeAn2gyz0nZx9Y5li6IphBF+P/fK4p/r79uA7AfCyF4GHcZ8FTiIuYtiHoixiXAua4dcSOvB05fTOCvdea5Yklltmw5/TReeQNmXGJ59PgSl9Kf42RidzVGX2RBkSjwnOWPTjtowmfMn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WHZDrrnb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHZDrrnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774899947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HhKo6FxL6K2twvnuPb3HOZZrvqleieBYQhByed5SpvM=;
	b=WHZDrrnbZgC2IshAaLGykj5/JHaa5EBC2XizDGj+KoRI9XHZZ5n2+08EKODqVK5TXwrFxH
	iKpCPiVwKgni0JKuMYBzm/m9/hnWehZBePwOD+v/w3qLbD2kEWqh/2x2ql6R4JhD9mkpMx
	9Jr0OhxijCdTO66pc+LQ5ezdY1Z4bOc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-OM3v4GntNc67l7F7Pm1H9w-1; Mon,
 30 Mar 2026 15:45:43 -0400
X-MC-Unique: OM3v4GntNc67l7F7Pm1H9w-1
X-Mimecast-MFC-AGG-ID: OM3v4GntNc67l7F7Pm1H9w_1774899942
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6D30180034E;
	Mon, 30 Mar 2026 19:45:41 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 089A219540C4;
	Mon, 30 Mar 2026 19:45:38 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 20/36] tests/functional: Remove duplicated -a flag in test_fifo_priority_starvation
Date: Mon, 30 Mar 2026 16:43:43 -0300
Message-ID: <20260330194410.103953-21-wander@redhat.com>
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

The start_stalld_with_log call in Test 2 passes -a ${STALLD_CPU}
twice, which is a copy-paste error. Remove the duplicate.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/functional/test_fifo_priority_starvation.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_fifo_priority_starvation.sh b/tests/functional/test_fifo_priority_starvation.sh
index adb7b44..886357e 100755
--- a/tests/functional/test_fifo_priority_starvation.sh
+++ b/tests/functional/test_fifo_priority_starvation.sh
@@ -136,7 +136,7 @@ if [ -n "${blockee_pid}" ]; then
 fi
 
 log "Starting stalld with boosting enabled"
-start_stalld_with_log "${STALLD_LOG}" -f -v -N -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -a ${STALLD_CPU} -d ${boost_duration}
+start_stalld_with_log "${STALLD_LOG}" -f -v -N -t $threshold -c ${TEST_CPU} -a ${STALLD_CPU} -d ${boost_duration}
 
 # Wait for detection and boosting
 sleep $((threshold + boost_duration + 1))
-- 
2.53.0

