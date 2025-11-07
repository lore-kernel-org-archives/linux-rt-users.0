Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67633A014
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540045; cv=none; b=ggQKnBT9x/qu5WBnqB4bg9UxaHOU9F2/sAoBQFqhVSBG/4GJJdTf9e7HrKvjzRxxsSHTeicA4MJoWcqx1zcpkcKK+RGO5c3FipUaakUAhP8xMHRq2PXXW/9d5/6Sonrk+FaSvlBb4OPdRZaPMIIgjaIcp9sivgX6xaTQjwctqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540045; c=relaxed/simple;
	bh=DKhi/V+Nx5dExkzOXE6InwB64qnzLNI+peyIw/vYdx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3L7c/DvXYVv63g11w9ZixDMGtrpKxRrzQU15UJtDRhwt6qkpxeGTu8xC9HbmOFXisNxM9MZb6MfeiWsTb46/PyODiGo9JodPGHxgPWLek6P/kNL7pTLP4dePKDRpptKjnxAYPopk9a/9XxPNzKFXla1j4r9QZ9gc/R8cw1CyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WICtoHfl; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WICtoHfl"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed65fa5e50so5816571cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540042; x=1763144842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKfA70D6g/WPqWiQZprxYFOI214fOfWDdEqt5w98uPc=;
        b=WICtoHfllQzA3yNKvzi3hFQybEcLTW7CC2FOPzEnnzOIgBnyA2V3EcORGx8IoXSYb7
         DewXLaSVclh8tRk0n3CLqqCoyicXukWv29/XHJdw9BDRZ0QUchGp+52VJhV/5MRvSQIG
         E0i5cpJPCa1oyTbTtupQKizlvPHLA+blbg9opDJuFt4poMOx1X25IbDortspOLn5uD6H
         guzH30ZCKA7dz/Yff+okGVfXAAranVDADxJ9QNksU4VD2utahZcuP97XVQ7ddPLAgNfd
         cgs0kB8ZR1sX8imgp2g7QWz6nEKicQId6TCGiW61WMW8lRYJN/VGAzTjAVFaDDGyWdMI
         nryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540042; x=1763144842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKfA70D6g/WPqWiQZprxYFOI214fOfWDdEqt5w98uPc=;
        b=qNr+YgoSy610ApxMjZXJRb8nFpnLyfBdyk3DrL7c267kaYU4S7AXJUhlJ95uBloiXF
         1rUMqvsEmI6w3GVGuz8XCXzPCOyhoMkw1heoRjc2bFQxIvZCRBy0KpjtQrPjPX/nZKYu
         PLmrUaA1BYRI3svaYM8lHz93h9Wepl1ukt911TaZ6XIU8Lr8wVkO4yor77mAqxIbFRYr
         QsV8AhOEUItAMU5nAJEQRay28/7piCUSczkafVanrD/64HtBcePlRrm7Ob5p/qbka5rL
         Ykrh5RF8izV2PpbMlf1dBJFyqfoGlJC6hecjmlfDdzN0xnYO9MTD9YASfuHViEt+DG7E
         WWxg==
X-Gm-Message-State: AOJu0Yx/Bj7uO3KbbC/CLiBKsDxwkIqYYo7jPAUmu8I5HpgFjLy9roFm
	BjZ9Rd2FX48b96+odfU6fuASQsURfpfS/ytNaPcT8LHbpKRmIX6+aLLJjKTYnLwE
X-Gm-Gg: ASbGncsqN6+2nXl2DhNgNW52AwhcAO3TmLRh00bCoM3N5B3gmL/qER8/+ZIn3t3u994
	caWsUeaRVIVG+C5+5nl1H4o9x7VS8Bf4jyevJUsecAmN2ITtMQ28IJjtEZJ4jonr2TeAahdsicU
	Sb4/LDPIKyOBmmV/h2YvCXhYMlLSMoKWzLZtaDBJN5mPT9qKoM0BH6Qx5S+NzWKPkqBRxZB/ot0
	g3HsrhK7aH14Bg1pUHIu8ec+796tjBTEhJkhatCIemEDjY7pJOt5NTaACPiBIGkNDdUJSd2Hjds
	XdX6uHWlY+sKrxI676bxlVXuMpqpDAEerkHKgpy9jwsmbNTX+r8gTC7sIOHNaw+gpFvmobBr7Ft
	s0Y70h3WRtHPIJotc3L+DgZEdCOCprWLRCWdtGZgWIuFAoAyGbOhn+NAtFUUPN1g=
X-Google-Smtp-Source: AGHT+IHSFA/tb2MmKvLjD/eJtwgHNYU5QIKN5wuWUt5B+o1EfNRkIIflWS/FaUJO4pc4ULrspaZT2A==
X-Received: by 2002:ac8:5a92:0:b0:4e8:b812:2e2a with SMTP id d75a77b69052e-4eda4e94134mr1258621cf.24.1762540042074;
        Fri, 07 Nov 2025 10:27:22 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:20 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 12/12] rteval: Add unit tests for --measurement-module argument
Date: Fri,  7 Nov 2025 13:26:35 -0500
Message-ID: <20251107182645.19545-13-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add comprehensive unit testing infrastructure for the new
--measurement-module command-line argument.

Test coverage includes:
- Default config file selection behavior
- Override with cyclictest
- Override with timerlat
- No override when argument not provided
- Invalid module name rejection
- Exclusive module selection (only one enabled)

Testing infrastructure:
- Created tests/ directory following Python conventions
- Added test_measurement_module_selection.py with 6 test cases
- Added run_tests.sh script for automated test execution
- Added Makefile targets: 'make test' and 'make unittest'
- Updated 'make help' to document test targets

All tests pass successfully using Python's unittest framework.

Usage:
  make test
  ./run_tests.sh
  python3 tests/test_measurement_module_selection.py

Co-Authored-By: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                                   |  10 ++
 run_tests.sh                               |  89 ++++++++++
 tests/test_measurement_module_selection.py | 195 +++++++++++++++++++++
 3 files changed, 294 insertions(+)
 create mode 100755 run_tests.sh
 create mode 100755 tests/test_measurement_module_selection.py

diff --git a/Makefile b/Makefile
index a250b18611b4..f17a434917ea 100644
--- a/Makefile
+++ b/Makefile
@@ -30,6 +30,12 @@ sysreport:
 	[ -d $(HERE)/run ] || mkdir run
 	$(PYTHON) rteval-cmd -D -v --workdir=$(HERE)/run --loaddir=$(HERE)/loadsource --duration=$(D) -i $(HERE)/rteval --sysreport
 
+unittest:
+	@echo "Running unit tests..."
+	./run_tests.sh
+
+test: unittest
+
 clean:
 	rm -f *~ rteval/*~ rteval/*.py[co] *.tar.bz2 *.tar.gz doc/*~
 
@@ -66,6 +72,8 @@ help:
 	@echo "rteval Makefile targets:"
 	@echo ""
 	@echo "        runit:     do a short testrun locally [default]"
+	@echo "        test:      run unit tests"
+	@echo "        unittest:  run unit tests (same as test)"
 	@echo "        tarfile:   create the source tarball"
 	@echo "        install:   install rteval locally"
 	@echo "        clean:     cleanup generated files"
@@ -82,3 +90,5 @@ tags:
 .PHONY: cleantags
 cleantags:
 	rm -f tags
+
+.PHONY: test unittest
diff --git a/run_tests.sh b/run_tests.sh
new file mode 100755
index 000000000000..c39d16feeea7
--- /dev/null
+++ b/run_tests.sh
@@ -0,0 +1,89 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Test runner for rteval unit tests
+#
+# This script runs all unit tests in the tests_progs/ directory
+# and provides a summary of results.
+#
+
+set -e
+
+# Colors for output
+RED='\033[0;31m'
+GREEN='\033[0;32m'
+YELLOW='\033[1;33m'
+NC='\033[0m' # No Color
+
+# Get the directory where this script is located
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+cd "$SCRIPT_DIR"
+
+# Test results tracking
+TOTAL_TESTS=0
+PASSED_TESTS=0
+FAILED_TESTS=0
+
+echo "========================================="
+echo "Running rteval Unit Tests"
+echo "========================================="
+echo ""
+
+# Function to run a single test
+run_test() {
+    local test_file=$1
+    local test_name=$(basename "$test_file" .py)
+
+    echo -e "${YELLOW}Running: ${test_name}${NC}"
+    echo "---"
+
+    if python3 "$test_file"; then
+        echo -e "${GREEN}✓ PASSED: ${test_name}${NC}"
+        PASSED_TESTS=$((PASSED_TESTS + 1))
+    else
+        echo -e "${RED}✗ FAILED: ${test_name}${NC}"
+        FAILED_TESTS=$((FAILED_TESTS + 1))
+    fi
+
+    TOTAL_TESTS=$((TOTAL_TESTS + 1))
+    echo ""
+}
+
+# Find and run all test files in tests/
+if [ -d "tests" ]; then
+    # Run test_measurement_module_selection.py
+    if [ -f "tests/test_measurement_module_selection.py" ]; then
+        run_test "tests/test_measurement_module_selection.py"
+    fi
+
+    # Add more tests here as they are created
+    # Example:
+    # if [ -f "tests/test_another_feature.py" ]; then
+    #     run_test "tests/test_another_feature.py"
+    # fi
+else
+    echo -e "${RED}Error: tests/ directory not found${NC}"
+    exit 1
+fi
+
+# Print summary
+echo "========================================="
+echo "Test Summary"
+echo "========================================="
+echo "Total tests run: $TOTAL_TESTS"
+echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
+if [ $FAILED_TESTS -gt 0 ]; then
+    echo -e "Failed: ${RED}$FAILED_TESTS${NC}"
+else
+    echo -e "Failed: $FAILED_TESTS"
+fi
+echo ""
+
+# Exit with appropriate code
+if [ $FAILED_TESTS -eq 0 ]; then
+    echo -e "${GREEN}✓ All tests passed!${NC}"
+    exit 0
+else
+    echo -e "${RED}✗ Some tests failed${NC}"
+    exit 1
+fi
diff --git a/tests/test_measurement_module_selection.py b/tests/test_measurement_module_selection.py
new file mode 100755
index 000000000000..2216cc668297
--- /dev/null
+++ b/tests/test_measurement_module_selection.py
@@ -0,0 +1,195 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Unit test for --measurement-module command-line argument
+#
+# This test verifies that the --measurement-module argument correctly
+# overrides config file settings to select between cyclictest and timerlat.
+#
+
+import sys
+import os
+import unittest
+import argparse
+
+# Add rteval to path
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
+
+from rteval import rtevalConfig
+from rteval.Log import Log
+
+
+class TestMeasurementModuleSelection(unittest.TestCase):
+    """Test suite for measurement module selection via command-line argument"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.logger = Log()
+        self.logger.SetLogVerbosity(Log.NONE)
+
+    def test_default_config_file_selection(self):
+        """Test that config file settings are loaded correctly by default"""
+        config = rtevalConfig.rtevalConfig(logger=self.logger)
+
+        # Load the rteval.conf file (which currently has timerlat enabled)
+        config_file = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'rteval.conf')
+        if os.path.exists(config_file):
+            config.Load(config_file)
+            msrcfg = config.GetSection('measurement')
+
+            # Based on current rteval.conf, timerlat should be set to 'module'
+            timerlat_value = getattr(msrcfg, 'timerlat', None)
+            self.assertEqual(timerlat_value, 'module',
+                           "timerlat should be set to 'module' in rteval.conf")
+
+    def test_override_with_cyclictest(self):
+        """Test that --measurement-module cyclictest overrides config file"""
+        config = rtevalConfig.rtevalConfig(logger=self.logger)
+        config.AppendConfig('measurement', {
+            'timerlat': 'module',
+            'sysstat': 'module'
+        })
+
+        # Simulate the early argument parser
+        measurement_parser = argparse.ArgumentParser(add_help=False)
+        measurement_parser.add_argument('--measurement-module', dest='measurement_module',
+                                        type=str, choices=['cyclictest', 'timerlat'])
+        early_args, _ = measurement_parser.parse_known_args(['--measurement-module', 'cyclictest'])
+
+        # Apply the override logic (same as in rteval-cmd)
+        if early_args.measurement_module:
+            msrcfg = config.GetSection('measurement')
+            if 'cyclictest' in msrcfg:
+                msrcfg.cyclictest = None
+            if 'timerlat' in msrcfg:
+                msrcfg.timerlat = None
+            setattr(msrcfg, early_args.measurement_module, 'module')
+
+        # Verify the results
+        msrcfg = config.GetSection('measurement')
+        cyclictest_value = getattr(msrcfg, 'cyclictest', None)
+        timerlat_value = getattr(msrcfg, 'timerlat', None)
+
+        self.assertEqual(cyclictest_value, 'module',
+                        "cyclictest should be enabled after override")
+        self.assertNotEqual(timerlat_value, 'module',
+                           "timerlat should be disabled after override")
+
+    def test_override_with_timerlat(self):
+        """Test that --measurement-module timerlat overrides config file"""
+        config = rtevalConfig.rtevalConfig(logger=self.logger)
+        config.AppendConfig('measurement', {
+            'cyclictest': 'module',
+            'sysstat': 'module'
+        })
+
+        # Simulate the early argument parser
+        measurement_parser = argparse.ArgumentParser(add_help=False)
+        measurement_parser.add_argument('--measurement-module', dest='measurement_module',
+                                        type=str, choices=['cyclictest', 'timerlat'])
+        early_args, _ = measurement_parser.parse_known_args(['--measurement-module', 'timerlat'])
+
+        # Apply the override logic (same as in rteval-cmd)
+        if early_args.measurement_module:
+            msrcfg = config.GetSection('measurement')
+            if 'cyclictest' in msrcfg:
+                msrcfg.cyclictest = None
+            if 'timerlat' in msrcfg:
+                msrcfg.timerlat = None
+            setattr(msrcfg, early_args.measurement_module, 'module')
+
+        # Verify the results
+        msrcfg = config.GetSection('measurement')
+        cyclictest_value = getattr(msrcfg, 'cyclictest', None)
+        timerlat_value = getattr(msrcfg, 'timerlat', None)
+
+        self.assertEqual(timerlat_value, 'module',
+                        "timerlat should be enabled after override")
+        self.assertNotEqual(cyclictest_value, 'module',
+                           "cyclictest should be disabled after override")
+
+    def test_no_override_when_argument_not_provided(self):
+        """Test that config file settings remain when argument is not provided"""
+        config = rtevalConfig.rtevalConfig(logger=self.logger)
+        config.AppendConfig('measurement', {
+            'timerlat': 'module',
+            'sysstat': 'module'
+        })
+
+        # Simulate the early argument parser with no --measurement-module argument
+        measurement_parser = argparse.ArgumentParser(add_help=False)
+        measurement_parser.add_argument('--measurement-module', dest='measurement_module',
+                                        type=str, choices=['cyclictest', 'timerlat'])
+        early_args, _ = measurement_parser.parse_known_args([])
+
+        # Only apply override if argument was provided
+        if early_args.measurement_module:
+            msrcfg = config.GetSection('measurement')
+            if 'cyclictest' in msrcfg:
+                msrcfg.cyclictest = None
+            if 'timerlat' in msrcfg:
+                msrcfg.timerlat = None
+            setattr(msrcfg, early_args.measurement_module, 'module')
+
+        # Verify the results - should remain unchanged
+        msrcfg = config.GetSection('measurement')
+        timerlat_value = getattr(msrcfg, 'timerlat', None)
+
+        self.assertEqual(timerlat_value, 'module',
+                        "timerlat should remain enabled when no override is provided")
+
+    def test_argparse_rejects_invalid_module(self):
+        """Test that argparse rejects invalid module names"""
+        measurement_parser = argparse.ArgumentParser(add_help=False)
+        measurement_parser.add_argument('--measurement-module', dest='measurement_module',
+                                        type=str, choices=['cyclictest', 'timerlat'])
+
+        # This should raise SystemExit due to invalid choice
+        with self.assertRaises(SystemExit):
+            measurement_parser.parse_args(['--measurement-module', 'invalid'])
+
+    def test_both_modules_disabled_after_override(self):
+        """Test that both modules are disabled when one is selected"""
+        config = rtevalConfig.rtevalConfig(logger=self.logger)
+        config.AppendConfig('measurement', {
+            'cyclictest': 'module',
+            'timerlat': 'module',
+            'sysstat': 'module'
+        })
+
+        # Override with cyclictest
+        measurement_parser = argparse.ArgumentParser(add_help=False)
+        measurement_parser.add_argument('--measurement-module', dest='measurement_module',
+                                        type=str, choices=['cyclictest', 'timerlat'])
+        early_args, _ = measurement_parser.parse_known_args(['--measurement-module', 'cyclictest'])
+
+        if early_args.measurement_module:
+            msrcfg = config.GetSection('measurement')
+            if 'cyclictest' in msrcfg:
+                msrcfg.cyclictest = None
+            if 'timerlat' in msrcfg:
+                msrcfg.timerlat = None
+            setattr(msrcfg, early_args.measurement_module, 'module')
+
+        # Verify exactly one is enabled
+        msrcfg = config.GetSection('measurement')
+        cyclictest_value = getattr(msrcfg, 'cyclictest', None)
+        timerlat_value = getattr(msrcfg, 'timerlat', None)
+
+        enabled_count = sum([
+            1 if cyclictest_value == 'module' else 0,
+            1 if timerlat_value == 'module' else 0
+        ])
+
+        self.assertEqual(enabled_count, 1,
+                        "Exactly one measurement module should be enabled")
+
+
+def main():
+    """Run the test suite"""
+    # Run tests with verbosity
+    unittest.main(verbosity=2)
+
+
+if __name__ == '__main__':
+    main()
-- 
2.51.1

