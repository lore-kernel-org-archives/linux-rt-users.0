Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074B2BF015
	for <linux-rt-users@vger.kernel.org>; Thu,  2 Oct 2025 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438531; cv=none; b=GVSIbQiYLyT3BjTwgYtGlBM3qvp1rrm7dRMviNSjGf9B74aib7+zGVk4H+L2KfFKrdCqWZaijYbn7GiawehO1gLv3so7ErfdhUqsztcqi7nfPyMJ5+CWnEEkLBrh1ie7BU6syz4y5YDa/JEOwtBXjjRELoxVxNxnT7X6++hbQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438531; c=relaxed/simple;
	bh=pXAdrwK9W1+/UGEJPZ9B4/6jXF1lsEyQLZAdhCu4xKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijuYjZkvfzmdc4/DkqjOKWrvW0Mg5ZUiHHUgOTflayDfABlkSBkUUzAL+xZ8Jr3YbYwu5HJ1E8KlDmqUxrCDCbHHN6xSb9wmI6rsa5R9mfi6UzvPWj8bKmbOr6voAxlyUlRv6G8KCZ0oFycvbDzWfOjrhpajrQcyupMkDKP5cRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TknvivDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TknvivDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759438528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BL1NSHFpK1VJ1hz/+Hh2dNQSht1Ab1JAhSqYVBpc04A=;
	b=TknvivDyXCGQcjF9QbQzwTKlxNkcLZl16VN5cFbmMrQC8O0PcASxgMw6srQoJm6dO0egeO
	AjEGk7EIW+RHC4VMR1F++GhoI3cQ6M2CXIpAuhzjzedOb96jNx0avad6YeyyqPZSGUbPp6
	Ayav9uHlVbMCMko93KItSDdtPP5wPf8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-N5BPXqMyPBqC7ZutoFK7Jg-1; Thu,
 02 Oct 2025 16:55:25 -0400
X-MC-Unique: N5BPXqMyPBqC7ZutoFK7Jg-1
X-Mimecast-MFC-AGG-ID: N5BPXqMyPBqC7ZutoFK7Jg_1759438524
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A30E819560B4;
	Thu,  2 Oct 2025 20:55:24 +0000 (UTC)
Received: from localhost (unknown [10.22.65.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48E5D180047F;
	Thu,  2 Oct 2025 20:55:24 +0000 (UTC)
From: Derek Barbosa <debarbos@redhat.com>
To: clrkwllms@kernel.org
Cc: linux-rt-users@vger.kernel.org,
	wander@redhat.com,
	debarbos@redhat.com
Subject: [PATCH 3/3] scripts: fix run-local if bashism
Date: Thu,  2 Oct 2025 16:55:15 -0400
Message-ID: <20251002205515.1299816-4-debarbos@redhat.com>
In-Reply-To: <20251002205515.1299816-1-debarbos@redhat.com>
References: <20251002205515.1299816-1-debarbos@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

In older versions of Bash, mainly 4.2.X, a semicolon (or newline) is
requied after a conditional statement and before the `then` keyword.

Add the semicolon to allow testing and quick "local runs" on legacy
kernels.

Signed-off-by: Derek Barbosa <debarbos@redhat.com>
---
 scripts/run-local.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-local.sh b/scripts/run-local.sh
index 0ce1476..e65f34d 100755
--- a/scripts/run-local.sh
+++ b/scripts/run-local.sh
@@ -44,7 +44,7 @@ parse_args()
 # script start
 #
 
-if [[ ! -x ./stalld ]] then
+if [[ ! -x ./stalld ]]; then
    echo "No stalld executable in the current directory!"
    exit 1
 fi
-- 
2.50.0

