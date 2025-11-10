Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBD3126C9
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781005; cv=none; b=VRmEwY3fbdt5p1Pgmjy6fImdq8Xq6BVa5UQCwF7VLvEgBWwjqMNwTMNzGAASWEmto/JQELSIjJqDoGciZLp02KSt7CRVzzuQRPvQ7gL9zjxiarqsJ4vJFFsO8CZ2gp7AvgVi1zvGxL13nBjjFrld/CIxWqKtj+J1rar9o35vv/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781005; c=relaxed/simple;
	bh=00FBTqLjDbFV7DEbdtleVkG9dfQHnqCV8ngMMRvCTQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLJ6fwS7aXU0eAm/vpD/w+WA990+IdiMQiQWjEhSyn1NxkhLrEWsD5HrpiVZr0tjEyxubZoCGhfNnX0viJrinjJ6IHhqbBkvrJ9nLJbrLocttemG/scMuxL8hgHR3Lo0v907mM3dzNb9YY55T0+VirTqu/4sjtitRnPXgSR60jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7cs4NJP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7cs4NJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762781002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nda42Sc0ZkknQXtcFNS6DA+7lDEvMGa8v30Xfq833Ws=;
	b=R7cs4NJPcOFo7VHSMdrfGJdt7aWRMlFq+nRyHpMOGXE87mDwC3ZY0a3sYzmMPHMXlUChCd
	ZFiyJow8I3hyYVLcJqiXX+2CypU3ol+Y5S4PsU8vnEzFiBgUAvExp6RAbkks/FxIsYgzQA
	N8fYRm/n6py5r1ygyKtHtVE1McdEPVk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-NaIWVIwYM8S8AVFHLq_pcw-1; Mon,
 10 Nov 2025 08:23:19 -0500
X-MC-Unique: NaIWVIwYM8S8AVFHLq_pcw-1
X-Mimecast-MFC-AGG-ID: NaIWVIwYM8S8AVFHLq_pcw_1762780998
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A9731956063;
	Mon, 10 Nov 2025 13:23:18 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D1E7196FC8B;
	Mon, 10 Nov 2025 13:23:14 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [stalld v2 3/6] Makefile: Explicitly run the 'test' target in the tests directory
Date: Mon, 10 Nov 2025 10:22:38 -0300
Message-ID: <20251110132241.43685-4-wander@redhat.com>
In-Reply-To: <20251110132241.43685-1-wander@redhat.com>
References: <20251110132241.43685-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
index 23e786d..619413f 100644
--- a/Makefile
+++ b/Makefile
@@ -183,7 +183,7 @@ static: $(OBJ)
 	$(CC) -o stalld-static $(LDFLAGS) --static $(OBJ) $(LIBS)
 
 tests:
-	make -C tests VERSION=$(VERSION) CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)"
+	make -C tests VERSION=$(VERSION) CFLAGS="$(CFLAGS)" LDFLAGS="$(LDFLAGS)" test
 
 .PHONY: install
 install: stalld
-- 
2.51.1

