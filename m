Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E068397686
	for <linux-rt-users@vger.kernel.org>; Mon, 30 Mar 2026 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900002; cv=none; b=ZW0U6O27rB2Ct9DxD4oud8eq87fmve4H1k4+EuP7VbjuoDZFr4CQL1sSO12Yra1MBxqCy4iY2JN+bpshQCFm8k7+xnqZ22v/24/E40jT8RteaaHQp3b+HBfnGEbwK0zQ9ZIbtSrz+ztRUjssfNdkPlXT9uiPJJ/xd8H50iv9yZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900002; c=relaxed/simple;
	bh=pmw4MEdRVNGqgeZ/kbpcZ5+hIdd2Xarm/Fxum9rz8V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os/q3ZMU9VclZOjbGw5tV54pTrjRRAKJZ4xE37kZFEb1S9SuhMosSQtn9JMUK6YJebUgwsmprQi4VC17BbJG1C6cxaMXyCWVZ9tseYEQbaws6LhJLbb6khFdrZ9D/R1W9jU0CyWgCJ4RvalR2VM90UaF+oSJuxz4Sq4Jah2Ga+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCtXXX14; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCtXXX14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774900000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aM628RqjpK3qM6/rjiKSQYpjb50WV/i74ivFeblgFZ0=;
	b=WCtXXX14uvy9RjtcVvBfoo02vJQF08Am+As1bnyuzCT0fKfttTZDnklgnwriQSTW0JAxhM
	9a+LnZ4qeaUEteiCNTlsE1O842CDU6jEpion9yUNnCD5Wso/ZUMRDJjMEFc87F3/Hn+Z3m
	U4eI9Cq+Xv4Tefb/NrGaQT+lA3MFKDo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-m7mzBCdONjmp_qYSMjfYwQ-1; Mon,
 30 Mar 2026 15:46:36 -0400
X-MC-Unique: m7mzBCdONjmp_qYSMjfYwQ-1
X-Mimecast-MFC-AGG-ID: m7mzBCdONjmp_qYSMjfYwQ_1774899995
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCA8B1956055;
	Mon, 30 Mar 2026 19:46:35 +0000 (UTC)
Received: from 192.168.0.12 (unknown [10.22.65.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 373331954102;
	Mon, 30 Mar 2026 19:46:32 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	linux-rt-users@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 36/36] stalld: die on invalid CPU affinity
Date: Mon, 30 Mar 2026 16:43:59 -0300
Message-ID: <20260330194410.103953-37-wander@redhat.com>
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

set_cpu_affinity() validates the CPU list and returns -1 on error,
but main() ignored the return value, allowing stalld to run with
an invalid or empty affinity mask.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/stalld.c b/src/stalld.c
index b9372db..d95b48f 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -1166,11 +1166,9 @@ int main(int argc, char **argv)
 
 	parse_args(argc, argv);
 
-	/*
-	 * it will not die...
-	 */
 	if (config_affinity_cpus)
-		set_cpu_affinity(config_affinity_cpus);
+		if (set_cpu_affinity(config_affinity_cpus))
+			die("invalid CPU affinity: %s\n", config_affinity_cpus);
 
 	if (!check_dl_server_dir_exists())
 		log_msg("DL-server detected.\n");
-- 
2.53.0

