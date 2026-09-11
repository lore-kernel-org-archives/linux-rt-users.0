Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4D35C6A4
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152981; cv=none; b=Xjq21Ji5AJN1BgrxuIa5IDTb4T4+cE6E6UYFgK7r1r2dr+uDYPxXGeGGOEY334C+Mnqxx6bAaRaIHmslBWAZRhT9QPri8RPpudU1a/s01YdnUqzGUe/jh9mPD+pKCAkSB1b/jZSY4JC94oBRn2XT0LsRV7m0UmtxlV3mjK+NRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152981; c=relaxed/simple;
	bh=O8Z3iJv9sr7s8mkdYO8rKX1RJKFRU0k8yuuXJmvG8dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8lGallbC/oNcZGwigMBtCU1CV/oVhNrfSABVhtx4G2piw+DKk9+AUWE9kpmBkTetPPilzFN8rpgPgpkKHqKyfwx9sP6lUlh0OI/HNV9iNOmjWZed5JS8BvbYdAyj37bamOQfm/EfeL/P5sQOWmdfq/LvaenlGmVBNf1zFrj5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0hG5+48; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0hG5+48"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd6so9221685a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152975; x=1789757775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kWt4tkD7rUIqr9Qapy2gFj3vtm2RfDjhjS1Cr8I8O+4=;
        b=O0hG5+48ZNzuWd3GNGhcUKEYsZ1ndWGOitOomrYKJm4mzo4q6wchW+0/vEDbQBJT6B
         VK2Xx9oRtr+AQHx/xFG15NTo8usAJWgQ9PPJw01ofdZwLa4IrYzFuLo9rSBAAfZiFhBP
         rDxopJQo0CCvDbfuKAjy0BQoQO+xSdu0rXDm2eb0EmViTtL/nlbp1EfBqm5rxN62L0K0
         IPbkUrNtCPeJK/QBGgkdxxftUd4mayyxTiEdcolQPsVG3fQHQHtqvF/Y0aoLno39eanQ
         zwatdDutHNp3h24RIvNjWH6fQzULrVJ3ILImP7zlh9P52hJuJU9WAYPAPPhN21crJCSE
         /1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152975; x=1789757775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWt4tkD7rUIqr9Qapy2gFj3vtm2RfDjhjS1Cr8I8O+4=;
        b=DCKoxuE6wOHuxhq2SMMRQZUS2V0eWDZc2DEeFmVZyvtD8ZBEWfFVQWjeQjBzzsZqDM
         NwZdcZXAR9qseRyIqiwl1paPY4dCRPKmoL2PwNPhpSXrab+gXh1wdGTRBKm4pLrBUow2
         YGJT+fAc7HV2Rjsc6Nc3G14UR+oGmQHEc4A02km+Xy7xo/PTF8uGW+N/UBUwcjKbe/WT
         84buswDHizSiE0orrhAneU81iShcWcggxISarVNFRjPZAceaTknnWWXbIpaSM5WPecsc
         LoYqON3++S7JEOD76zsS/IJGNInmdUvcQlT7ivX2LW/Qz9/L2mFdFc+6iOBOakwg+4GK
         f3Ow==
X-Gm-Message-State: AFuF++mbqM0MfmkdSIs/xACMwc+CJh8Gf5r5VrpnhA0oPK8RQUN5yHZS
	sYmS2FjjK8u/yDsJU+LlPR6sr54/6d21LWF+HpXKKtq91vyouTWvn7ZEEY5Y6g==
X-Gm-Gg: AYBFou2rZiIIbTS11w2vMxmwubOumCIhh/3T+iDiyLl2BSbWYRVefH9mACgKIzo7AAK
	y3GAXXol1xrNuq2rucgKzDoYdA3FWIcZ4lfSc8BtqJ0doO1waR2TL2V/cLzDyikBQWYQJtIkxLN
	3+DGAc1TYKU7RVZxM+7zRZlNTm5LgGBYhO8hbINQDLnVKLcjFVTW36ml7fguf7+RaIb26h28zoa
	yOWe2rqh7AYSBAiugc+ds2NJ8Jct/jD68en/xrZdV37A6/2j9QoFToWCXS/3Clooq3poAwtt49T
	NjGSI4HmtarnO7Hj7dCEWBSLsEQElDnmQg7AUKHhki1cssXY+ACMcqxYTl5IQDxfjSf4srIGvVd
	jSKJY67tuUki/ijnVmNFO0dIgdJBXVuBSHrtrjDHFM4DLcVDb1pD/qzbADSRnxm6Rvi9ctanzVm
	j/U112qNLo8dYAZdMC7pHaFbfgfvhN/hDY4zVji1NCtAO2EWz4NtNZ5LhAISp7MtdiYbsoJ6/yF
	f4tFoll42+rgx0IeGlMSD8woB5pTbDThglQ5JGnxj9FcLW5sEFwLOEIR/TRVaXe
X-Received: by 2002:a05:620a:90cf:10b0:939:ac74:1bbf with SMTP id af79cd13be357-939ea049212mr539815185a.4.1789152974579;
        Fri, 11 Sep 2026 11:56:14 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:14 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 10/10] rteval: Write test artifacts to tests/logs/ instead of the repo root
Date: Fri, 11 Sep 2026 14:55:43 -0400
Message-ID: <20260911185549.604199-11-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911185549.604199-1-jkacur@redhat.com>
References: <20260911185549.604199-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpuset and regression test suites created their log files (and, for
the regression tests, the rteval work directories) in the current working
directory, which is the repository root when the tests are launched via
the Makefile. This littered the top of the tree with test-cpusets-*.log,
test-cyclictest-*, test-timerlat-* and their .log files.

Route all of these under tests/logs/ instead, gitignore that directory,
and add a 'test-clean' target that removes it (with 'clean' reusing it).
A run now leaves the repo root untouched and the artifacts are easy to
clean up afterwards.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore                                         | 1 +
 Makefile                                           | 8 ++++++--
 tests/cpusets/test-cpusets.sh                      | 7 +++++--
 tests/regression/test-cyclictest-error-handling.sh | 7 ++++++-
 tests/regression/test-timerlat-error-handling.sh   | 7 ++++++-
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index d00862cdeb0c..9b9b0850874e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,7 @@ tarball
 *.rpt
 *.xml
 *.log
+tests/logs/
 *.o
 *.swp
 Makefile.in
diff --git a/Makefile b/Makefile
index fd2f68cbda5f..83fad0ccd48e 100644
--- a/Makefile
+++ b/Makefile
@@ -84,10 +84,13 @@ test-all:
 	$(MAKE) regression-tests
 	$(MAKE) cpuset-tests
 
-clean:
+clean: test-clean
 	rm -f *~ rteval/*~ rteval/*.py[co] *.tar.bz2 *.tar.gz doc/*~
 	rm -rf rteval-[0-9]*-[0-9]*
 
+test-clean:
+	rm -rf tests/logs
+
 realclean: clean
 	rm -rf run
 
@@ -156,6 +159,7 @@ help:
 	@echo "        install:          install rteval locally"
 	@echo "        uninstall:        uninstall rteval"
 	@echo "        clean:            cleanup generated files"
+	@echo "        test-clean:       remove test artifacts under tests/logs"
 	@echo "        realclean:        Same as clean plus directory run"
 	@echo "        sysreport:        do a short testrun and generate sysreport data"
 	@echo "        tags:             generate a ctags file"
@@ -170,4 +174,4 @@ tags:
 cleantags:
 	rm -f tags
 
-.PHONY: help tests unit-tests mcp-tests test-all e2e-tests regression-tests cpuset-tests uninstall
+.PHONY: help tests unit-tests mcp-tests test-all e2e-tests regression-tests cpuset-tests test-clean clean realclean uninstall
diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
index 18b6af543bc5..bc7fd90e0e37 100755
--- a/tests/cpusets/test-cpusets.sh
+++ b/tests/cpusets/test-cpusets.sh
@@ -37,8 +37,11 @@ TESTS_FAILED=0
 # Test duration (short for quick testing)
 TEST_DURATION="10s"
 
-# Log file
-LOG_FILE="test-cpusets-$(date +%Y%m%d-%H%M%S).log"
+# Log file - keep test artifacts under tests/logs/ (this script lives in
+# tests/cpusets/) so they are out of the repo root and easy to clean up.
+LOG_DIR="$SCRIPT_DIR/../logs"
+mkdir -p "$LOG_DIR"
+LOG_FILE="$LOG_DIR/test-cpusets-$(date +%Y%m%d-%H%M%S).log"
 
 # Helper functions
 print_header() {
diff --git a/tests/regression/test-cyclictest-error-handling.sh b/tests/regression/test-cyclictest-error-handling.sh
index 436264111bdf..861e74480054 100755
--- a/tests/regression/test-cyclictest-error-handling.sh
+++ b/tests/regression/test-cyclictest-error-handling.sh
@@ -9,6 +9,11 @@ set -e
 SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
 MOCK_CYCLICTEST="${SCRIPT_DIR}/mock-cyclictest-partial-output.py"
+
+# Keep test artifacts (work dirs and logs) under tests/logs/ so they stay out
+# of the repo root and are easy to clean up (this script is in tests/regression/).
+LOG_DIR="${SCRIPT_DIR}/../logs"
+mkdir -p "$LOG_DIR"
 RTEVAL_MODULE="${REPO_ROOT}/rteval/modules/measurement/cyclictest.py"
 
 # Colors for output
@@ -97,7 +102,7 @@ EOF
     sudo chmod +x /usr/bin/cyclictest
 
     # Run rteval and capture output
-    local workdir="test-cyclictest-${scenario}-$$"
+    local workdir="${LOG_DIR}/test-cyclictest-${scenario}-$$"
     local log_file="${workdir}.log"
 
     # Create workdir (rteval requires it to exist)
diff --git a/tests/regression/test-timerlat-error-handling.sh b/tests/regression/test-timerlat-error-handling.sh
index 9883608669bf..7f2c99069e96 100755
--- a/tests/regression/test-timerlat-error-handling.sh
+++ b/tests/regression/test-timerlat-error-handling.sh
@@ -8,6 +8,11 @@ set -e
 
 SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
+
+# Keep test artifacts (work dirs and logs) under tests/logs/ so they stay out
+# of the repo root and are easy to clean up (this script is in tests/regression/).
+LOG_DIR="${SCRIPT_DIR}/../logs"
+mkdir -p "$LOG_DIR"
 MOCK_RTLA="${SCRIPT_DIR}/mock-rtla-timerlat-partial-output.py"
 RTEVAL_MODULE="${REPO_ROOT}/rteval/modules/measurement/timerlat.py"
 
@@ -101,7 +106,7 @@ EOF
     sudo chmod +x /usr/bin/rtla
 
     # Run rteval and capture output
-    local workdir="test-timerlat-${scenario}-$$"
+    local workdir="${LOG_DIR}/test-timerlat-${scenario}-$$"
     local log_file="${workdir}.log"
 
     # Create workdir (rteval requires it to exist)
-- 
2.55.0

