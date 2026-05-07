Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A1478E5F
	for <linux-rt-users@vger.kernel.org>; Thu,  7 May 2026 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182158; cv=none; b=pv1KK0eGtxysnrT4d4DZXLdoCXnZnXAuncglsZqPlasimA3Lwt2sgfpJiiz8AsW/ezp2nzrj0QMbIfgcae0IEVHLVt/7vJUrkP05KkyX1fKao33u1LzdVXnTwrM30MqZOffbupRu4LzJZ2XUB3L09nnRXYtTofpkFKm8XRtJ6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182158; c=relaxed/simple;
	bh=CPFENy7wZp6Gl/PP05P4PEaE6UCfu0GeWW9PR0Hk9eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHbtM7ioRdL6wZNl6T9lmojekZ/bC5zF7W80fGY8RWa44lN7K+5/3YaBNUYOBYfeZQFgcja/nC19iWQMKliUo3kJchJtRpGYHXfiglQwjo9d2Oze30uVN7N9Egakwhd8soLve1j1Z+PScZXqQzJfH/qKqAM/xU9ChJXaAbe15g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzDHhjNQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzDHhjNQ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e63771eb0so10996121cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 07 May 2026 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778182156; x=1778786956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DPzYmsbOtGOg3ew69W8KI+JMmSTg0/zb8Fv7udqQBQ=;
        b=gzDHhjNQMGs+ImRbHsBDIsuSz/dp+is7rAa9Qpl/XJarsIwtKyEtAVm24J9O5Zk/0X
         PdLdlLGrHulP6CX5Dja+f9MnBlP/Rh4PFm6IX7xpx5WFspRTy1Kbw5UtjaB7+oxFqevy
         4j7xBNk/CwveORGL3RLGL4lLVFKQ2MJSeH2Y22IA5IGayYeCbK6OPGkdEicknd+UBd8/
         kq4Y8wyYudGj2sRkIvz31K63eTgvaj4hvZTch7MTxVvGcmqqpgzdaHRMbvn0D1gz6W5h
         CwlBZWUghnQ5TDfA2+9QT5FJwbwS9yrkyrluTOomp0FPYp13ub/VNfzIdL4n4hD1i5tR
         TOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778182156; x=1778786956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DPzYmsbOtGOg3ew69W8KI+JMmSTg0/zb8Fv7udqQBQ=;
        b=rb/onKSaRcEwRnWVVC31OoTRqhofX4q7NRafk0fzxz5v/8kDxMdgQ65BQzWafP9w7R
         Bq3AbloFnjUPAdeJZMt2JzNHeiIpehWR648QMxQT1KX+bU2F0bqaFeaDE/e4q3YuKfSx
         RGi0K4sgz2rVP+o7lw5vsN/2gCnbuhjy0lXB9FEXizKK1eVckYVNH00qZXwenX5yE2al
         VTNj4RgQc+nsF6gedlhfHfT0x+pHNMLPfdj8LCpy4JwEaqCrpcHn+UP/KtGIaalpXbHq
         m3HraOBHW5lAjC+n4evlD2WrcZUGtKxIVP8+V2nfQiBuhz5vfLQqquZhPcYa5eBM6re4
         lWiA==
X-Gm-Message-State: AOJu0YyGarlwPodOShsp7pu1iSjLCOtpFoPtBZvwboCWViqux1ECwYnt
	56RNAtzt6nLRmV8PL6tT5sewdiqmhjQFiuluS5vTs4vbGpIRBvvJ2Vg/7fmyYg==
X-Gm-Gg: AeBDievkh97dcbK820Nv3QsNu/pWcTShFYJg40eti+GNwCfA1C/3xwjXb7HZCW3uTNR
	hAzHR+TgzrNbhg4yc0f7UoNLhm/kvj33h9cgX8/XQ8P9BLm6ze3AwhWYqPbos/Q9r7WOP8kqt1l
	qlPLfqxAqrCjvIUhS1O3/beeWkR8txeufIxlsx9XkH7owmjPifs5LWEjrn7pBnBJVvFt+I9VWWF
	Q42DYwnCGDiL04C83B1rgEhPjkqumKaOKC3d2Oh54HVymXG992re9mqpGTZzUVC6elWQVPCAo/M
	3laWkWX1hJDz8zasTOLTpR+KqW+g3pFuGgikHgPNrOwPqQF0ALLuY4ONH7fdU6ji9/8Ck5uYRDd
	OmEAljL3Q8AUS5G/Rvsf4Sd8Kw0vyveO0WK0OQATz4quXifHa9J3baixIcXegMCrvuXjMd9h+XY
	EIgKIYY6HFtISJRxMAt147JcXtG4A5xBuVaM1U9Mj8qFWEZz31uVyCVDXRILYQF7hxcxG2udoEm
	uVK/baTnNWVeqn10wY=
X-Received: by 2002:a05:622a:408b:b0:50f:ade2:2d3 with SMTP id d75a77b69052e-51461faa8femr128109701cf.42.1778182155482;
        Thu, 07 May 2026 12:29:15 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51487d1de9esm3102711cf.27.2026.05.07.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:29:15 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 2/2] tuna: Add testing infrastructure using unittest framework
Date: Thu,  7 May 2026 15:28:58 -0400
Message-ID: <20260507192858.186090-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507192858.186090-1-jkacur@redhat.com>
References: <20260507192858.186090-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a clean testing infrastructure for tuna using Python's unittest
framework. This provides a foundation for unit tests and future test
expansion.

Structure:
- tests/ directory with unittest-based tests
- tests/run_tests.sh runner script
- Makefile targets for easy test execution
- Comprehensive README.md with examples and documentation

Testing Infrastructure:
- Runner script (run_tests.sh) that uses unittest discovery
  * Automatically finds all test_*.py files
  * Provides clean output
  * Changes to repo root before running

- Makefile targets:
  * make tests / make unit-tests - Run all unit tests
  * make test-eperm - Run specific EPERM test

- Multiple execution methods supported:
  * Via make (recommended for users)
  * Via runner script (./tests/run_tests.sh)
  * Via unittest directly (python3 -m unittest discover)

Initial Test:
- test_eperm_handling.py with 6 test methods
- Validates EPERM error handling in isolate_cpus()
- Tests verify the fix from commit 625edd878154
- All tests run without root privileges or special configuration

The infrastructure is designed for easy expansion - simply add new
test_*.py files and they're automatically discovered and run.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                     |   9 +++
 tests/README.md              | 147 +++++++++++++++++++++++++++++++++++
 tests/run_tests.sh           |  25 ++++++
 tests/test_eperm_handling.py |  87 +++++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 tests/README.md
 create mode 100755 tests/run_tests.sh
 create mode 100644 tests/test_eperm_handling.py

diff --git a/Makefile b/Makefile
index a55821a8f908..f331f4715d1c 100644
--- a/Makefile
+++ b/Makefile
@@ -20,3 +20,12 @@ cleanlogs:
 
 .PHONY: clean
 clean: pyclean
+
+.PHONY: tests unit-tests
+tests: unit-tests
+
+unit-tests:
+	@./tests/run_tests.sh
+
+test-eperm:
+	@python3 -m unittest tests.test_eperm_handling -v
diff --git a/tests/README.md b/tests/README.md
new file mode 100644
index 000000000000..aceb38d6f8f5
--- /dev/null
+++ b/tests/README.md
@@ -0,0 +1,147 @@
+# Tuna Test Suite
+
+This directory contains the test suite for tuna, using Python's `unittest` framework.
+
+## Running Tests
+
+### All Tests
+
+Run all unit tests using any of these methods:
+
+```bash
+# Using make (recommended)
+make tests
+# or
+make unit-tests
+
+# Using the test runner directly
+./tests/run_tests.sh
+
+# Using Python unittest directly
+python3 -m unittest discover -s tests -p "test_*.py" -v
+```
+
+### Specific Test File
+
+Run a specific test file:
+
+```bash
+# Using make
+make test-eperm
+
+# Using Python unittest
+python3 -m unittest tests.test_eperm_handling -v
+```
+
+### Specific Test Method
+
+Run a single test method:
+
+```bash
+python3 -m unittest tests.test_eperm_handling.TestEPERMHandling.test_eperm_constant_exists -v
+```
+
+## Test Organization
+
+Tests are organized using Python's `unittest` framework. Each test file contains:
+- A test class that inherits from `unittest.TestCase`
+- Individual test methods (prefixed with `test_`)
+- Setup/teardown methods if needed
+
+### Current Tests
+
+- **test_eperm_handling.py** - Tests for EPERM error handling in `isolate_cpus()`
+  - Verifies that Permission Denied errors are handled gracefully
+  - Ensures tuna continues processing when it can't set affinity on protected processes
+
+## Writing New Tests
+
+### Test File Structure
+
+Create a new test file following this pattern:
+
+```python
+#!/usr/bin/env python3
+"""
+Description of what this test module tests.
+"""
+
+import unittest
+import os
+import sys
+
+
+class TestSomething(unittest.TestCase):
+    """Test cases for something in tuna"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Set up test fixtures (runs once before all tests)"""
+        # Common setup for all tests in this class
+        pass
+
+    def setUp(self):
+        """Set up for each test (runs before each test method)"""
+        # Per-test setup
+        pass
+
+    def test_something(self):
+        """Test that something works correctly"""
+        # Your test code here
+        self.assertEqual(expected, actual)
+        self.assertTrue(condition)
+        self.assertIn(item, collection)
+
+    def tearDown(self):
+        """Clean up after each test (runs after each test method)"""
+        # Per-test cleanup
+        pass
+
+
+if __name__ == '__main__':
+    unittest.main()
+```
+
+### Naming Conventions
+
+- Test files: `test_*.py` (e.g., `test_affinity.py`)
+- Test classes: `Test*` (e.g., `TestAffinityFunctions`)
+- Test methods: `test_*` (e.g., `test_set_affinity_validates_input`)
+
+### Common Assertions
+
+```python
+self.assertEqual(a, b)           # a == b
+self.assertNotEqual(a, b)        # a != b
+self.assertTrue(x)               # bool(x) is True
+self.assertFalse(x)              # bool(x) is False
+self.assertIn(a, b)              # a in b
+self.assertNotIn(a, b)           # a not in b
+self.assertIsNone(x)             # x is None
+self.assertIsNotNone(x)          # x is not None
+self.assertRaises(Exception, fn) # fn() raises Exception
+```
+
+## Requirements
+
+- Python 3.6 or later
+- No additional packages required (uses Python standard library)
+
+## Test Types
+
+Currently all tests are **unit tests** that verify code behavior without requiring:
+- Root privileges
+- Special system configuration
+- External dependencies
+
+Future test categories might include:
+- **Integration tests** - Test interaction between tuna components
+- **System tests** - Tests requiring actual CPU affinity operations (need root)
+- **Regression tests** - Tests for specific bug fixes
+
+## Continuous Integration
+
+The test suite is designed to run in CI/CD environments:
+- All tests run without root privileges
+- No special system configuration required
+- Exit code 0 on success, non-zero on failure
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
new file mode 100755
index 000000000000..da048a69d5d1
--- /dev/null
+++ b/tests/run_tests.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+#   Copyright (C) 2026 John Kacur
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# run_tests.sh - Run tuna unit tests
+#
+# This script runs all unit tests in the tests/ directory using Python's
+# unittest framework.
+
+set -e
+
+# Change to repository root
+cd "$(dirname "$0")/.."
+
+echo "Running tuna unit tests..."
+echo ""
+
+# Run unittest discovery
+# -s tests: start directory
+# -p "test_*.py": pattern for test files
+# -v: verbose output
+python3 -m unittest discover -s tests -p "test_*.py" -v
+
+echo ""
+echo "All tests passed!"
diff --git a/tests/test_eperm_handling.py b/tests/test_eperm_handling.py
new file mode 100644
index 000000000000..c94a3ad6a0b4
--- /dev/null
+++ b/tests/test_eperm_handling.py
@@ -0,0 +1,87 @@
+#!/usr/bin/env python3
+#   Copyright (C) 2026 John Kacur
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Unit tests for EPERM error handling in isolate_cpus function.
+
+Tests verify that tuna properly handles Permission Denied errors when
+attempting to set CPU affinity on processes like PID 1 (systemd/init).
+"""
+
+import unittest
+import os
+import sys
+
+
+class TestEPERMHandling(unittest.TestCase):
+    """Test cases for EPERM error handling in isolate_cpus"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Set up test fixtures - read tuna.py once for all tests"""
+        tuna_path = os.path.join(os.path.dirname(__file__), '..', 'tuna', 'tuna.py')
+        with open(tuna_path, 'r') as f:
+            cls.tuna_content = f.read()
+
+        # Find isolate_cpus function bounds
+        cls.isolate_cpus_start = cls.tuna_content.find('def isolate_cpus(')
+        cls.assertNotEqual(cls.isolate_cpus_start, -1, "Could not find isolate_cpus function")
+
+        # Find next function to get the bounds
+        next_def = cls.tuna_content.find('\ndef ', cls.isolate_cpus_start + 1)
+        if next_def == -1:
+            next_def = len(cls.tuna_content)
+
+        cls.isolate_cpus_code = cls.tuna_content[cls.isolate_cpus_start:next_def]
+
+    def test_eperm_constant_exists(self):
+        """Test that errno.EPERM is referenced in the code"""
+        self.assertIn('errno.EPERM', self.tuna_content,
+                      "errno.EPERM constant not found in tuna.py")
+
+    def test_warning_message_exists(self):
+        """Test that warning message exists for unable to isolate"""
+        self.assertIn('Warning: Unable to isolate pid', self.tuna_content,
+                      "Warning message not found in tuna.py")
+
+    def test_eperm_in_isolate_cpus_function(self):
+        """Test that EPERM handling is in the isolate_cpus function"""
+        self.assertIn('errno.EPERM', self.isolate_cpus_code,
+                      "EPERM handling not found in isolate_cpus function")
+
+    def test_both_ebusy_and_eperm_handled(self):
+        """Test that both EBUSY and EPERM errors are handled"""
+        self.assertIn('errno.EBUSY', self.isolate_cpus_code,
+                      "EBUSY handling not found in isolate_cpus function")
+        self.assertIn('errno.EPERM', self.isolate_cpus_code,
+                      "EPERM handling not found in isolate_cpus function")
+
+    def test_eperm_handler_calls_continue(self):
+        """Test that EPERM handler calls continue to keep processing"""
+        eperm_block_start = self.isolate_cpus_code.find('if err.args[0] == errno.EPERM')
+        self.assertNotEqual(eperm_block_start, -1,
+                           "EPERM handling block not found")
+
+        # Check that continue is called within the next ~200 chars
+        eperm_block = self.isolate_cpus_code[eperm_block_start:eperm_block_start + 200]
+        self.assertIn('continue', eperm_block,
+                     "EPERM handler should call 'continue' to avoid crash")
+
+    def test_eperm_handler_structure(self):
+        """Test that EPERM handler has correct structure with comm extraction"""
+        eperm_block_start = self.isolate_cpus_code.find('if err.args[0] == errno.EPERM')
+        self.assertNotEqual(eperm_block_start, -1, "EPERM handling block not found")
+
+        eperm_block = self.isolate_cpus_code[eperm_block_start:eperm_block_start + 250]
+
+        # Should extract comm for the warning message
+        self.assertIn('comm = ps[pid].stat["comm"]', eperm_block,
+                     "EPERM handler should extract process name")
+
+        # Should print warning with pid and comm
+        self.assertIn('print(f\'Warning: Unable to isolate pid {pid} [{comm}]\')', eperm_block,
+                     "EPERM handler should print warning with pid and comm")
+
+
+if __name__ == '__main__':
+    unittest.main()
-- 
2.54.0

