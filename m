Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33C8132112
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Jul 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535152; cv=none; b=AWojcHvH81xwlOYjimtO/FpMWj260c7wunO9fprZv2CagsjaJTUkfraM77SorrXSFbkczoi4DzxHQp/COLL+dSQxnXuGkCS/iqZ1WzmvCC4TTu4qG/49hjlT9GI79y1P9SU0cUKJQkGWZ/tFHni1md4cAOlZ+Q5ByGfsa/8MrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535152; c=relaxed/simple;
	bh=6vi0Ur6tR8bc5cmi699zxM28UI+xDw0va501MYo3AHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKjmAtufaMI4gmb1BPhOIpsepEAGnvGySqxHiKuS8P2Rnlg9lXKR4FMutFiJ47qZa1lVJkwNqpGo/P+g82zJb7WsfUBTMD/PHVp/vOvTTGbkrPjhkBsgeRIcOH/W4tBbckRAJHKFxDg5w7dV9HqqsHywExZ5ygiNLXNwdNsF0yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvBKTQQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvBKTQQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720535149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zmWqRuWV0AR95gdivaJPZelCQgtlvKrKxjNZCN5pVmY=;
	b=QvBKTQQjATom6v3C8sWL4pW15byU5KTWrnAJ8CN7wPFnw8Nb3jfa4KAkDXIFWpDrbD0/Se
	CAqqMEcL3UJC6FnNZOJXvxcvH5/y/XacLiB/hQY5XjrzW7ZIQIOkRFGMRQPq1AWo5i4EnJ
	s74qZ2NiT8VY0xUVj0zhiXPbEGSp7qA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-NiIXkyrZNNef9PHGze5odA-1; Tue,
 09 Jul 2024 10:25:48 -0400
X-MC-Unique: NiIXkyrZNNef9PHGze5odA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 969FE1955F3B
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Jul 2024 14:25:47 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.9.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EA971955E70;
	Tue,  9 Jul 2024 14:25:46 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] rteval: fixed manpage to include stress-ng header
Date: Tue,  9 Jul 2024 10:25:16 -0400
Message-ID: <20240709142515.354997-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Previously stress-ng options were listed with cyclictest options.
Now they have their own section.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 doc/rteval.8 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/rteval.8 b/doc/rteval.8
index 264bf5207716..b818cbe79762 100644
--- a/doc/rteval.8
+++ b/doc/rteval.8
@@ -138,6 +138,7 @@ Send a break trace command if latency exceeds the given number of microseconds.
 .TP
 .B \-\-cyclictest-threshold=USEC
 Exit rteval if latency exceeds the given number of microseconds.
+.SH STRESS-NG OPTIONS
 .TP
 .B \-\-stressng-option=OPTION
 Pass in command line options for the stress-ng package.
-- 
2.45.2

