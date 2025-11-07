Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6625B69F
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532285; cv=none; b=LxTv/831B76jTld8YMjm8t4pR+42iDxzZmPi0poqCHXSFVYzRNiU7ntzSkvfuQws+X50JMdC+hQGzKOVXfU7dli0LEhItS9T+8GJTIWIVEBkeQhB0lrvI8U3JP82t0O85CsNE2SYoCOUqUiSqo6q0WrjCGsT4SNdmeNldjx0pO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532285; c=relaxed/simple;
	bh=xhzSPRR43nm1EEaBs+AUHIumTsFr6pgamwcqfhMHFB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzHaxHF59MFnNFLiuvVPgDcBCskNC/xd9sfGNsu+FWoRCsJqw+f+DICXNDUkurZ/qh2w/1ZAc+PtGL4SoMz27CGTnjjyag/K0lsR8Kq3fgDyxWPmc35P0PCBIg5lnfFQqoPRzFEIvMZ72FJchbhVCAqxxhp+ynhbKkzhxo/LLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rvcp6YeF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rvcp6YeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762532282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9P3w95CDphJByKHVrrXNnv37wXj9XPC86g0fr5dZSU=;
	b=Rvcp6YeFogXhiZ2neYgP0DbkxkxwiLQHkjAAizX6M3XDdjQi28W2ncvw3aKgcv8cMGROjL
	KMoYKzc1n16/zsB8wtwd/acyZ1scOo5D2ngV0OTyfNahVBiGVkKjKttdkyd4JfNWvaemL0
	qzjD0dmXhIwqbHAJqrSr7G1XnTvezNY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-UDRHl4oxMd23LGnoIvGG6A-1; Fri,
 07 Nov 2025 11:17:59 -0500
X-MC-Unique: UDRHl4oxMd23LGnoIvGG6A-1
X-Mimecast-MFC-AGG-ID: UDRHl4oxMd23LGnoIvGG6A_1762532278
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BC23195606E;
	Fri,  7 Nov 2025 16:17:58 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 522F33001E83;
	Fri,  7 Nov 2025 16:17:55 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH 3/3] Makefile: Explicitly run the 'test' target in the tests directory
Date: Fri,  7 Nov 2025 13:17:28 -0300
Message-ID: <20251107161729.320087-4-wander@redhat.com>
In-Reply-To: <20251107161729.320087-1-wander@redhat.com>
References: <20251107161729.320087-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The 'tests' target in the main Makefile was invoking 'make' in the
'tests' subdirectory without specifying a target. This relied on the
default target in the tests/Makefile, which is not explicit.

This commit adds the 'test' target to the make command, making the
build process clearer and more robust.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bc82858..7accd81 100644
--- a/Makefile
+++ b/Makefile
@@ -182,7 +182,7 @@ static: $(OBJ)
 	$(CC) -o stalld-static $(LDFLAGS) --static $(OBJ) $(LIBS)
 
 tests:
-	make -C tests VERSION=$(VERSION) CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"
+	make -C tests VERSION=$(VERSION) CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" test
 
 .PHONY: install
 install: stalld
-- 
2.51.1

