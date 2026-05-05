Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEE48C8D3
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003073; cv=none; b=NBKiKz7YMxl+o1aj34X+8uAYchUIaMdaJ8rXLhZzbmk2gWFu5EgxLAaWg+0L9E01I3GPHVutZDY7nGjOyM2KXEW+Sp84dcL+pB7bZsKJ3ZrpPrDVnj55m5jhWanf7r06G0FzaEzNBoaRV418lGWdR8riTMDh2kTtUo/tSMYWj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003073; c=relaxed/simple;
	bh=cNqqscf1TBt03dAV41Lrt/y0jTQchAE6TMbP26jvFHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGwYCGcw+GavUsQ0y9Kp9Kvyo5M3+/48Es8evZcnljp/vJIQIK30miAAgkbG0qApN3YEkvr7DFronKaJJ6GDK3tAOCN4kmYjwwWDGLcDnsUyExwCmb4IxjfS1yJM70uG0ve7Z/WBVsWu5n7wXwG4c8Oh/JujT/0Mtq6B1cT5GkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYGIpV9j; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYGIpV9j"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-512f09ecc67so17267801cf.3
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003071; x=1778607871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P+LGJsI4kS9LjRVXCu/hJEGsS533Vx/Xq2GpTgZh8uk=;
        b=GYGIpV9j2irFblm4pgGUM/h2+VmGgHH4bIHe+znMNTZ1JrR3qnBxELnSVdybTNyZSA
         yUrtBMAzmQWQCPIqC3PyMyUno2HcmPs9RjLbBRXOakUbK31eqd0+g1t5fNCghYGhEWRU
         Xlkmh2Ldb9HlhHvZtBGHHrGlyEsXJ+x5mxIbE0K89BE5+/g49Ra6SfWg48AQMHvnyV6m
         tXC45ViISW0kmLPsWAYs4l3U+RdLxlFW7XjaUVXEMFfdVcc/9N4zOSFyEQMTePn8n1OC
         dYeDm097BMd+4vfNvc1+stuVCaykAa/f/FnxCaFMw/dCe3LcNW9s4Oe3XZ46WEwUhnxW
         UGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003071; x=1778607871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+LGJsI4kS9LjRVXCu/hJEGsS533Vx/Xq2GpTgZh8uk=;
        b=DCGGHsvARFc0OcnprXRPrcmRlKeozRi35IJ0CBUbTIpfD0uCLjsNYASwX6zuWHFmF1
         kekcF/eLoyDCy8JXt+/I4raOfSvaN2SH5nccJGE9IQd5RTaVLiYZoHG3TzTSeVV6dSro
         YJBeVAQqa3JO/9KF4DUAjttA8pyRs4bALPHI+EJovFrt/SbDiWxMQOQQGsJQov2xzde4
         fLwVfkXT26973bA2ysUibSd9DOjJWe0hVRzbTjJM31t4coQ/zlJPQkaSFTbRSBUgUevg
         MPL+amCiToj0TLipK/mCmnkQK+Y9gHr3AzIaP1Sew9OuE8cyRuQ/SyEJc+RgqvUcc4vk
         hE+Q==
X-Gm-Message-State: AOJu0YyJ9sfGFrZKQd/QjHcHYRx0rlQPFY1hVd9+8920fSJVMLmQMOmK
	/rcXTWcCgXLklvku8Cjk/T6ubhbf9eppqbbUP/8vOQfL6KKq2cwt+qE+7Rwmyw==
X-Gm-Gg: AeBDiev8u1IMQ67mtxT5/ZfuWACnFtC7EBUntaifvuuv+2dlBS3gURIRfBvKmONa/fS
	5y2xLIo2dYzQNyp2p7o6pyoevXXj4MPqeeM2Clt5c4O6bTCoajXgh3iDmMiYUZUKI1JSSiROeSp
	PswSbT0avde4m6L9+LfngkOKw0z++bvrz1MxV98bNw1dnk9+qXMxY749hXEI/g8q00skS4nE9G0
	BPSHODJX0d2g5zhqrcZl3Y58BmfRJdocTVEdtxNyAhPX0o8IFx/Ax06bA5cu1WBelYJcqYKXPTk
	wDxWQpI8K1CEAZkasXzlkMG3seepcTsbaVkg3QkAcyEFipIKAsbKnpPRo8mvMPaHMPMT/OTBMFf
	jP93wDeFK2ncxY75NG9FxY8NP564yaaQbB7ILmUtqcHwQtpGcdirTYWQDi671AaQzQwlyc1FrNS
	tpbPXg8L7OOKHgg2Sjd4YFh49rpZgoavB9b4ndgTlStBNEqTORPrQbtP96R+weu/l5VOtZ8kNkS
	ULTLHEroRXth8koHKoPJykwpDZ5Jw==
X-Received: by 2002:ac8:5f11:0:b0:50f:b465:94b2 with SMTP id d75a77b69052e-51461f9e8d9mr80281cf.28.1778003070811;
        Tue, 05 May 2026 10:44:30 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:30 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/9] rteval: Fix measurement module hangs and improve test infrastructure
Date: Tue,  5 May 2026 13:43:44 -0400
Message-ID: <20260505174410.169442-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses critical bug fixes in measurement module error handling
and significantly improves rteval's test infrastructure.

Patches 1-2: Critical bug fixes for measurement modules
  Fix hangs in timerlat and cyclictest when measurement tools crash or produce
  malformed output. Both modules now properly handle partial output, limit
  SIGINT retries, and ensure cleanup always completes.

Patches 3-5: Testing and configuration improvements
  Add comprehensive regression tests to verify error handling fixes, update
  config files for clarity, and fix e2e test patterns to match current output.

Patches 6-9: Test infrastructure organization
  Refactor and consolidate all tests under tests/ directory with consistent
  naming (unit-tests, e2e-tests, regression-tests, cpuset-tests). Move cpuset
  tests from local/ to tests/cpusets/ with comprehensive documentation.

Key improvements:
- Prevents rteval hangs when measurement tools crash (RHEL-140898, RHEL-172903)
- Adds regression tests with mocked failure scenarios
- Consolidates test infrastructure under tests/ directory
- Provides consistent Makefile targets for all test types
- Includes comprehensive test documentation


John Kacur (9):
  rteval: Fix timerlat error handling to prevent hangs
  rteval: Fix cyclictest error handling to prevent hangs
  rteval: Update config files to clarify measurement module selection
  rteval: Add regression tests for measurement module error handling
  rteval: Fix e2e test patterns for current rteval behavior
  rteval: Refactor core sharing validation test into proper unittest
  rteval: Rename unittest target to unit-tests for consistency
  rteval: Organize cpuset tests and make core sharing tests skip
    gracefully
  rteval: Move run_tests.sh to tests/ and remove obsolete test scripts

 Makefile                                      |  54 +-
 rteval.conf                                   |   5 +-
 rteval/modules/measurement/cyclictest.py      | 124 +--
 rteval/modules/measurement/timerlat.py        | 318 ++++----
 rteval/rteval.conf                            |  12 +
 test_full_validation.py                       | 151 ----
 tests/cpusets/README.md                       | 199 +++++
 tests/cpusets/test-cpusets.sh                 | 732 ++++++++++++++++++
 tests/e2e/loads.t                             |   6 +-
 tests/e2e/measurement.t                       |   4 +-
 tests/regression/README.md                    | 155 ++++
 .../mock-cyclictest-partial-output.py         | 165 ++++
 .../mock-rtla-timerlat-partial-output.py      | 138 ++++
 .../test-cyclictest-error-handling.sh         | 225 ++++++
 .../test-timerlat-error-handling.sh           | 228 ++++++
 run_tests.sh => tests/run_tests.sh            |  10 +-
 tests/test_core_sharing_validation.py         | 155 ++++
 17 files changed, 2318 insertions(+), 363 deletions(-)
 delete mode 100644 test_full_validation.py
 create mode 100644 tests/cpusets/README.md
 create mode 100755 tests/cpusets/test-cpusets.sh
 create mode 100644 tests/regression/README.md
 create mode 100755 tests/regression/mock-cyclictest-partial-output.py
 create mode 100755 tests/regression/mock-rtla-timerlat-partial-output.py
 create mode 100755 tests/regression/test-cyclictest-error-handling.sh
 create mode 100755 tests/regression/test-timerlat-error-handling.sh
 rename run_tests.sh => tests/run_tests.sh (87%)
 create mode 100755 tests/test_core_sharing_validation.py

--
2.54.0

