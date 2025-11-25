Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE32E093C
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068579; cv=none; b=t9sRdNWv4SWjlSRg31DDw4uUDuXwU7M+SmWiUo8GXvkv8RaIgFVM+cCfOfKhpMf9rXO2UzgFFlsrMd7lU4URaK5YiKaL13IoQbkiKnQzX/4xNNflj6wqBsmAt9O2gwpNqPdI3uJCCi4anIG7enDb7Rbo5aeMenGClcGbnMcC2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068579; c=relaxed/simple;
	bh=lh7Lx0PuomQ1I2hajPkDq8UIYxeaGGgBilloFYSumOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nugDF5KhpvwE45C6NObPtm3u0Nxz2BgqpzjyaY4uF/XM3N5N8QU9ytF0+ORUjw66yE7zciIZSi8bmWFd/dRn+49CvDeARy/0LmLnFjW4i4CNSLi27uczq2zEeDWj5oaxxsnC0+L0H27SqU4rHLwZQnLXacJ4EdBCgHRxxzlIGZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOnOVM5z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOnOVM5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764068575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHNucTp0LWMB8B2wMYgIgDaAx6X+niA4IjrKc4LPsLo=;
	b=jOnOVM5zPTimGswo2FMqdXnEKYj/GUcn+gxLeJXpZvYnEEyfN8GCxYypDzXRKgW9NCHlkY
	qJdsMnL9O+jY0I5E03et4+T8F95TW7stgu7Ws0NVtqrdB0J0reCjBirACR5f3LIjF01EA3
	BKJb8uVrxNlnVKLvnRUqEA0PtX+Doew=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-9jWTAfJFN3K2bw-zdq3DLw-1; Tue,
 25 Nov 2025 06:02:53 -0500
X-MC-Unique: 9jWTAfJFN3K2bw-zdq3DLw-1
X-Mimecast-MFC-AGG-ID: 9jWTAfJFN3K2bw-zdq3DLw_1764068572
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDA0C195609F
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 11:02:52 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.228])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CA0719560B2;
	Tue, 25 Nov 2025 11:02:51 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/2] rteval: Add README-tests
Date: Tue, 25 Nov 2025 12:02:39 +0100
Message-ID: <20251125110241.277542-2-tglozar@redhat.com>
In-Reply-To: <20251125110241.277542-1-tglozar@redhat.com>
References: <20251125110241.277542-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add a README-tests file describing what tests are implemented for
rteval and how to run them.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 README-tests | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 README-tests

diff --git a/README-tests b/README-tests
new file mode 100644
index 0000000..802d4eb
--- /dev/null
+++ b/README-tests
@@ -0,0 +1,102 @@
+There currently exist four kinds of tests for rteval:
+
+- Unit tests
+
+Unit tests reside in the tests/ directory. They are Python modules which import
+the Python unittest library.
+
+The Makefile target "unittest" (or, alternatively, just "test") invokes unit
+tests:
+
+$ make test
+Running unit tests...
+./run_tests.sh
+=========================================
+Running rteval Unit Tests
+=========================================
+
+Running: test_measurement_module_selection
+---
+test_argparse_rejects_invalid_module (__main__.TestMeasurementModuleSelection)
+Test that argparse rejects invalid module names ... usage: test_measurement_module_selection.py [--measurement-module {cyclictest,timerlat}]
+test_measurement_module_selection.py: error: argument --measurement-module: invalid choice: 'invalid' (choose from 'cyclictest', 'timerlat')
+ok
+...
+
+----------------------------------------------------------------------
+Ran 6 tests in 0.003s
+
+OK
+✓ PASSED: test_measurement_module_selection
+
+=========================================
+Test Summary
+=========================================
+Total tests run: 1
+Passed: 1
+Failed: 0
+
+✓ All tests passed!
+
+- End-to-end tests
+
+End-to-end tests reside in the tests/e2e subdirectory, in files with
+the .t extension. They are written in bash and produce output compatible with
+the TEP standard.
+
+To run end-to-end tests, the rteval kcompile source tarball has to be present;
+see LOADS variable in Makefile for the tarballs used by the current version of
+rteval.
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
+
+- Pre-defined rteval commands for manual testing
+
+These are accessible under the Makefile targets: "runit", "load", and
+"sysreport".
+
+"runit" tests both measurements and loads, "load" tests only loads, and
+"sysreport" runs both measurements and loads while also generating a SOS report
+at the end of the rteval run.
+
+- Legacy unit tests
+
+Legacy unit tests are embedded directly in rteval source code. The test engine
+to run them is located in tests/unittest-legacy.py, and may be run with
+the following sequence of commands (starting in the root directory):
+
+$ cd rteval/
+$ sudo python3 ../tests/unittest-legacy.py
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
+Note that some of the tests require root and will fail if run under normal
+user.
-- 
2.51.1

