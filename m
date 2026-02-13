Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8E2116F4
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Feb 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005452; cv=none; b=CFt2mwslTxGKCmdxKdKMLXgUFR4czuH52wOU5MAIJv1Q5nF2tyvOp56ZwSCb2/1Nc6Hdf0x0ZAZ0b/i+cYLdpmSbo22JXM67oLgYrauYlrrH96T/v33QYJMHGBPQ3IGzvTBs4fgrFfpsmr3+uXBZ9ixLmvRsxe8lEcxXhCbc8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005452; c=relaxed/simple;
	bh=qU26V8rWH+uSO8bQTQ04NevkoV/+Tq5MgTxRVN9ePe0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HfJBliL5k3E+glOZ1AsXc6VHCmKPFmYlUr1aMjWGeVXbjD9uibTBKJL7UuWUeacIzHdcaHwWjvvLp+ymhghAFcYfRYQmPr/9IUhrJhIRtxHWfw3Q4GUgB/BZNr5QmBejvCvXtYASw5QJmH5YDQWXvgGgdJohlCeuvFXkt3fc6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xg/q9Mm0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg/q9Mm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771005450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=+H0W6P3HdlnDEQvnSMQIDVRyjKs4wAhorOLidS7mLik=;
	b=Xg/q9Mm0Rrl9K1Je1mqmzP4+W8htbdM8kZhdr70boRkKNtZIeG4FkBbkqZrbF1YMLMxng6
	1PwoktIyH0/erXgnhGgvyBccWTaNtNAvVWIoJEZ53PO7VjNo+WPMLhrUp0z7XSI5kj7j7I
	Ztpx18bLsZrQupEFFK1BmIauPCgVv8k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-jK-gQvWCMVyxXVqe30y_yQ-1; Fri,
 13 Feb 2026 12:57:28 -0500
X-MC-Unique: jK-gQvWCMVyxXVqe30y_yQ-1
X-Mimecast-MFC-AGG-ID: jK-gQvWCMVyxXVqe30y_yQ_1771005447
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 970AF1956067
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Feb 2026 17:57:27 +0000 (UTC)
Received: from localhost (unknown [10.22.64.105])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 252951800464;
	Fri, 13 Feb 2026 17:57:26 +0000 (UTC)
Date: Fri, 13 Feb 2026 14:57:25 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH] hwlatdetect: correctly get CPU number from different sample
 formats
Message-ID: <aY9mBeyzm5Mae7SH@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Make hwlatdetect able to get the CPU number from samples in both
'nolatency-format' (currently covered by the code) and also from
samples in 'latency-format'.

With this change the code is now able to get the CPU from samples
in the following formats:

- nolatency-format:
   <...>-3820    [007] d.... 22851.463472: #2     inner/outer(us):    0/233   ts:1770937572.925294075 count:1
   <...>-3820    [011] d.... 22855.495526: #3     inner/outer(us):  308/305   ts:1770937576.805213360 count:49

- latency-format:
   <...>-3835     13d.... 12608167us : #2     inner/outer(us):  307/299   ts:1770937629.988530678 count:49
   <...>-3835     16d.... 15632212us : #3     inner/outer(us):  308/296   ts:1770937633.322710076 count:24

Fixes: 96e780938322 ("rt-tests: hwlatdetect: Add field cpu to samples output")
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 68f312db639f..26694abe099a 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -246,7 +246,7 @@ class Tracer(Detector):
 
         def __init__(self, line):
             fields = line.split()
-            self.cpu = int(fields[1][1:-1])
+            self.cpu = int(fields[1][1:-1]) if fields[1][0] == '[' else int(fields[1][:-5])
             i, o = fields[6].split('/')
             ts = fields[7][3:]
             self.timestamp = str(ts)
-- 
2.53.0

