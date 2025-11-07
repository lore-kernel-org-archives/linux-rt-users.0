Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD4304994
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523287; cv=none; b=ZRV0VfFGbTeotFx7xuYDxAwnvphnnbk2CkR+qBg2qsPgBDfI5lUvue05z5wX2Fov5xQwGTa/jzhuyRYhzHdfZmgcUZEvtvCsut8TuiARPH8yF5ETIhX6cfLRqsW72dghkabFzjwY1H9mrQ2EHbC0auyz46PJonX4c5jYfE2ltL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523287; c=relaxed/simple;
	bh=X9ae3PRFrWwXC/5B74Ihd1nYX1NMG7dloaw08mUNCmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jt0hGPMb5Mi1rHKQhG3F6XUJhQxJh8/zcwqku0z1h0JsaSMclizagFG4h15AjeU05VMH+JdjYKD5zta2XyiBMzcPuJzz9toPYFII8vhfqxYHJlCmPCTbERBQOswLUk6IwepESatGBa1nvNdbm2YajUJOxIDgjdQfBPSTB4eqiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVrpseCq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVrpseCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762523284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRUUOciZVbNLG3N0k+APo094TApV2A5A+U91uUlR8lg=;
	b=PVrpseCqxleXK17GZ+gP4brdiKIcPXeiotHpmoh1+7SiROsmJo+qRhmrf14Ryb8ZG8UJaP
	mtxOWfDIp7TzpTwMJS1VOugf6uHw2kFhtpwPPr4sfpjig3FyuO7U82+CdmGHLRLBFJaSi4
	xoFRQ9t218oSvdH0goImeNDvUp7OZkA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-A21SUnkPPhakYoUgMvTNNQ-1; Fri,
 07 Nov 2025 08:48:03 -0500
X-MC-Unique: A21SUnkPPhakYoUgMvTNNQ-1
X-Mimecast-MFC-AGG-ID: A21SUnkPPhakYoUgMvTNNQ_1762523282
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 728F3180045C
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 13:48:02 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.228])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13D403001E83;
	Fri,  7 Nov 2025 13:48:00 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 3/3] rteval: Add README-tests
Date: Fri,  7 Nov 2025 14:47:49 +0100
Message-ID: <20251107134749.257350-3-tglozar@redhat.com>
In-Reply-To: <20251107134749.257350-1-tglozar@redhat.com>
References: <20251107134749.257350-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a README-tests file describing what tests are implemented for
rteval and how to run them.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 README-tests | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 README-tests

diff --git a/README-tests b/README-tests
new file mode 100755
index 0000000..5745c30
--- /dev/null
+++ b/README-tests
@@ -0,0 +1,56 @@
+There currently exist three kinds of tests for rteval:
+
+- Pre-defined rteval commands for manual testing
+
+These are accessible under the Makefile targets: "runit", "load", and "sysreport".
+
+"runit" tests both measurements and loads, "load" tests only loads, and
+"sysreport" runs both measurements and loads while also generating a SOS report
+at the end of the rteval run.
+
+- Unit tests
+
+Unit tests are embedded directly in rteval source code. The test engine to run
+them is located in tests/unittest.py, and may be run with the following sequence
+of commands (starting in the root directory):
+
+$ cd rteval/
+$ sudo python3 ../tests/unittest.py
+...
+ --------------------
+  ** TEST SUMMARY **
+ --------------------
+
+  - Modules:
+      Declared for test:      4
+      Successfully imported:  4
+      Failed import:          0
+
+  - Tests:
+      Tests scheduled:        4
+      Sucessfully tests:      4
+      Failed tests:           0
+      Missing unit_test()     0
+
+- End-to-end tests
+
+End-to-end tests reside in the tests/e2e subdirectory, in files with
+the .t extension. They are written in bash and produce output compatible with
+the TEP standard.
+
+The Makefile target "check" invokes the end-to-end tests under Test::Harness
+via the "prove" command:
+
+$ sudo make e2e-tests
+PYTHON="python3" RTEVAL="/usr/src/rteval/rteval-cmd" RTEVAL_PKG="/usr/src/rteval" prove -o -f -v tests/e2e/
+...
+All tests successful.
+Files=3, Tests=33, 288 wallclock secs ( 0.02 usr  0.00 sys + 127.59 cusr 155.27 csys = 282.88 CPU)
+Result: PASS
+
+Test::Harness here serves the purpose of measuring time, counting the total
+number of tests, and verifying if each test suite reported the correct number
+of test results.
+
+Note: rteval requires root privileges to run. All tests, with the exception of
+a part of the unit tests, thus require root.
-- 
2.51.0

