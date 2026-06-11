Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7D3164C5
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210341; cv=none; b=GD7cKsZRAByT7gQFMQSI76jDzUSE+UpDr1jD1O1caOxSXMEQa0p8pLXr48WG3mkPQFo8L/y0fEg0UzTkfWRE7Lt7HGXU7ctHF3swmtVmphtC2eFzE8tY+bDJsU7jpjxGr8MJrCZ4POZw82emoNFx5g72SBOIQI35bpiMlqZPttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210341; c=relaxed/simple;
	bh=qXp7WvEBLYYe/33M2IDSBTeiOT75o/Domps8CGera7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjhYPgnKSEZ1KXlZMk4AEU2OeV/P7d2SAy7cs3eQQfSuavN4BA8C5GlGcrn20oHIAzs7vSy6R87E5QPlbp+DEp9aSVqsyuVii5hJ0EYYgzfpnDCNGQSRBW1emjuzmUrz8SkzVitmBXdRpV4cCBqZzUlALUPEJkCr1GMnvbk/7hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odW6TQxv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odW6TQxv"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5176096116fso2369661cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Jun 2026 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781210336; x=1781815136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMhOBQnDW6RPijTLxuy5vseo/O0vwP5+2whIbJlILeY=;
        b=odW6TQxvUDZ7mQ0FdxAT1r9a+ah5sLDVPMPTO0TxaCa/pIOnlaXBqCI6hSNqvfHP6m
         mqQrw4J8NYqEVimicMLJ84HYb69PaG33oaDIK6A3JOdEouujUYxGLUxsz83ipiZtKGky
         s4KqLUS12xH48erpJMzqf4b3He4wKsI2VKVXsYBAP0+pWCk7LQ1QnnQBvwXRMApApqGG
         xuaGSM0TvBOqXmApoAhyPaHjmd29UTGjojOrJDgatD7NNKXjXOGCb8bYpQTOZ3j6dLSP
         ive/bq9TOH+6fcV7UcZIBB3OAcIP+sT7THjj4R770G3IWLTJbgOX0sBhnXpEQ+hQN45S
         6xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210336; x=1781815136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMhOBQnDW6RPijTLxuy5vseo/O0vwP5+2whIbJlILeY=;
        b=FhsfIMAK2T+pw9opH1e8BPw1VqS4Bk8PZiKgm39odtk5qktRfWbpsnk7/rEWlJaTut
         teSdtsM4ft3EX5Ky/5sRf2R1z0whetyd3JYFqEwr4h/hvTLlQ6xeKnyAGtyKpQi2b3XH
         YS7W7lRMjd6WXD+Q/lZ7eSleBMykLwTacb/5CVsNZWEM1gpnnBwc3SLnEAo5knnEFf5H
         AKBDMf6xBcMoI3JYJPbudlIZEUYndidH6YfjSxyXeHLzolK3VSUnlgcx3ZBWorb1vjNz
         fBMUs79sPNBvo6c6zbRuPD/joOQdiZg5vZdWQHPiB2R62iprg73vNoDvzFgsFzdZNc9X
         5Wtg==
X-Gm-Message-State: AOJu0Yyq1b6k6CHdqETGbFAcxy1hmfSkTZrMRN6kyBo5Z8ipW884tc1f
	3qzQc9eSAwJVyruC33RL0owD2GE5/cqacSKQZ7L+Fah3oE5FiUAzMN5aXmOQBQ==
X-Gm-Gg: Acq92OHnDdKUernw/YMzqILoYzoQqk4fqN8JLivuMu2ld1H1qtPEXgIGctPE/REu7Sx
	xndFJD6mHPE+QS39DK5ccUWNikfYbuQVr5YtviJAkamOlfsib5Ui/MEn0OfuCEUcUBbb5j6ZDI1
	BjRSQ73oSlJSMhXd9RHj0bOdCmFeL0qiu/YQPDzgwlZxN7H7ev45km0RkF9kttmfuLhp8ycXfRa
	AO6dWkrjriaMxBLDe+7BAn56se4Cpd7Sx4J/1Iho3mnwfk9k0Ff5Ej4EdbaYlroeXkyKxXm+D7Q
	em0nnRLQAuJziMXyH6QNksrgTWSlB9gjSKvp77DOK1fcl6w3xTkKXBIJfivfNkqpEV8VAsD2zCE
	yC6sSglu8ZqikQa5+q1cBEIkr1KDgILzWhs4Iawsbjg4x5TXE8jwXH9dbi8n0rMqJEtqyvdHzzM
	IrIZACpBViFOm44Q+AnHL8HsOmbqsu6b/+TNPwq/0pMLkkwexEXUpjA82sfnqNpUmIVxmXvB1wP
	rD0i0Rgi1bx4WVffQU=
X-Received: by 2002:a05:622a:4d1:b0:516:e062:1a83 with SMTP id d75a77b69052e-517ee267404mr68827851cf.51.1781210335862;
        Thu, 11 Jun 2026 13:38:55 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb642541sm3214051cf.10.2026.06.11.13.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:38:55 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 5/5] tuna: Add tests for converter functions and update test README
Date: Thu, 11 Jun 2026 16:38:32 -0400
Message-ID: <20260611203832.176805-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611203832.176805-1-jkacur@redhat.com>
References: <20260611203832.176805-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive unit tests for argument converter functions:
- threadstring_to_list(): 7 tests covering empty strings, numeric PIDs,
  duplicates, pattern matching, exact names, and mixed inputs
- irqstring_to_list(): 4 tests covering empty strings, numeric IRQs,
  and duplicates
- socketstring_to_list(): 1 test verifying function exists

Tests use MockPidStats to avoid requiring real procfs access, allowing
them to run without root privileges and in CI/CD environments.

Update tests/README.md with comprehensive documentation:
- How to run tests via make and unittest directly
- Examples for running specific test files, classes, and methods
- Explanation of why tests don't require root privileges
- Description of all current tests (18 total: 6 EPERM + 12 converter)
- Expected output showing successful test run
- Updated requirements and test organization

All 18 tests pass successfully without requiring root access.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md          |  85 ++++++++++++++++++++-
 tests/test_converters.py | 160 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 241 insertions(+), 4 deletions(-)
 create mode 100644 tests/test_converters.py

diff --git a/tests/README.md b/tests/README.md
index aceb38d6f8f5..9f85e6fe97c2 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -33,12 +33,22 @@ make test-eperm
 python3 -m unittest tests.test_eperm_handling -v
 ```
 
+### Specific Test Class
+
+Run a specific test class:
+
+```bash
+python3 -m unittest tests.test_converters.TestThreadstringToList -v
+python3 -m unittest tests.test_converters.TestIrqstringToList -v
+```
+
 ### Specific Test Method
 
 Run a single test method:
 
 ```bash
-python3 -m unittest tests.test_eperm_handling.TestEPERMHandling.test_eperm_constant_exists -v
+python3 -m unittest tests.test_eperm_handling.TestEPERMHandling.test_set_affinity_eperm -v
+python3 -m unittest tests.test_converters.TestThreadstringToList.test_pattern_with_mock_ps -v
 ```
 
 ## Test Organization
@@ -50,9 +60,41 @@ Tests are organized using Python's `unittest` framework. Each test file contains
 
 ### Current Tests
 
-- **test_eperm_handling.py** - Tests for EPERM error handling in `isolate_cpus()`
+- **test_eperm_handling.py** (6 tests) - Tests for EPERM error handling
   - Verifies that Permission Denied errors are handled gracefully
-  - Ensures tuna continues processing when it can't set affinity on protected processes
+  - Tests reading and setting affinity, scheduler, and priority on PID 1
+  - Ensures tuna handles permission errors without crashing
+
+- **test_converters.py** (12 tests) - Tests for argument converter functions
+  - Tests `threadstring_to_list()`: Converting thread specifications to PID lists
+  - Tests `irqstring_to_list()`: Converting IRQ specifications to IRQ number lists
+  - Tests `socketstring_to_list()`: Socket string conversion
+  - Uses MockPidStats to test without requiring real process access
+
+### Why Tests Don't Require Root
+
+The tuna program requires root privileges for operations like:
+- Setting CPU affinity on other processes
+- Changing scheduler policies and priorities
+- Moving IRQs to different CPUs
+- Isolating CPUs (system-wide CPU management)
+
+However, the tests are designed to run without root privileges:
+
+1. **EPERM tests** verify that permission errors are handled gracefully when running as non-root
+   - They intentionally trigger permission errors by trying to modify PID 1
+   - Success means the error was caught and handled properly
+
+2. **Converter tests** use mock objects instead of real system access
+   - Test pure logic: string parsing and conversion
+   - MockPidStats provides test data without accessing /proc
+   - No actual process manipulation occurs
+
+**Benefits:**
+- Developers can run tests without `sudo`
+- Tests run in CI/CD environments without elevated privileges
+- Tests are fast and don't affect the running system
+- Tests verify both happy path (with mocks) and error path (with real EPERM)
 
 ## Writing New Tests
 
@@ -125,7 +167,42 @@ self.assertRaises(Exception, fn) # fn() raises Exception
 ## Requirements
 
 - Python 3.6 or later
-- No additional packages required (uses Python standard library)
+- python3-procfs package (for importing procfs module used by converters)
+- No other external packages required (uses Python standard library and mocks)
+
+## Expected Output
+
+A successful test run with all 18 tests should look like:
+
+```
+Running tuna unit tests...
+
+test_get_affinity_eperm (test_eperm_handling.TestEPERMHandling) ... ok
+test_get_priority_eperm (test_eperm_handling.TestEPERMHandling) ... ok
+test_get_scheduler_eperm (test_eperm_handling.TestEPERMHandling) ... ok
+test_set_affinity_eperm (test_eperm_handling.TestEPERMHandling) ... ok
+test_set_priority_eperm (test_eperm_handling.TestEPERMHandling) ... ok
+test_set_scheduler_eperm (test_eperm_handling.TestEPERMHandling) ... ok
+test_duplicate_irqs_deduplicated (test_converters.TestIrqstringToList) ... ok
+test_empty_string (test_converters.TestIrqstringToList) ... ok
+test_multiple_numeric_irqs (test_converters.TestIrqstringToList) ... ok
+test_single_numeric_irq (test_converters.TestIrqstringToList) ... ok
+test_socketstring_exists (test_converters.TestSocketstringToList) ... ok
+test_duplicate_pids_deduplicated (test_converters.TestThreadstringToList) ... ok
+test_empty_string (test_converters.TestThreadstringToList) ... ok
+test_exact_name_with_mock_ps (test_converters.TestThreadstringToList) ... ok
+test_mixed_numeric_and_pattern (test_converters.TestThreadstringToList) ... ok
+test_multiple_numeric_pids (test_converters.TestThreadstringToList) ... ok
+test_pattern_with_mock_ps (test_converters.TestThreadstringToList) ... ok
+test_single_numeric_pid (test_converters.TestThreadstringToList) ... ok
+
+----------------------------------------------------------------------
+Ran 18 tests in 0.XXXs
+
+OK
+
+All tests passed!
+```
 
 ## Test Types
 
diff --git a/tests/test_converters.py b/tests/test_converters.py
new file mode 100644
index 000000000000..26ead9d43049
--- /dev/null
+++ b/tests/test_converters.py
@@ -0,0 +1,160 @@
+#!/usr/bin/env python3
+#   Copyright (C) 2026 John Kacur
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Unit tests for argument converter functions.
+
+Tests verify that threadstring_to_list, irqstring_to_list, and
+socketstring_to_list properly convert string arguments to lists.
+"""
+
+import unittest
+import sys
+import os
+
+# Add parent directory to path to import tuna-cmd
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
+
+# Import the converter functions from tuna-cmd
+import importlib.util
+spec = importlib.util.spec_from_file_location("tuna_cmd", os.path.join(os.path.dirname(os.path.dirname(__file__)), "tuna-cmd.py"))
+tuna_cmd = importlib.util.module_from_spec(spec)
+
+
+class MockPidStats:
+    """Mock procfs.pidstats() for testing"""
+
+    def __init__(self, pids=None):
+        """Initialize with dict of pid -> info"""
+        self.pids = pids or {}
+
+    def find_by_regex(self, pattern):
+        """Mock find_by_regex - returns PIDs based on pattern"""
+        import re
+        pattern_str = str(pattern)
+        # fnmatch.translate('systemd*') creates a pattern matching 'systemd' followed by anything
+        # fnmatch.translate('systemd') creates a pattern matching exactly 'systemd'
+
+        # Check if it's a wildcard pattern (contains .* from fnmatch.translate)
+        if '.*' in pattern.pattern:
+            # This is 'systemd*' or similar - return multiple PIDs
+            return [100, 101]
+        else:
+            # This is exact match 'systemd' - return single PID
+            return [100]
+
+    def find_by_name(self, name):
+        """Mock find_by_name - exact name match"""
+        if name == 'systemd':
+            return [100]
+        return []
+
+
+class TestThreadstringToList(unittest.TestCase):
+    """Test cases for threadstring_to_list() function"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Load the tuna-cmd module"""
+        spec.loader.exec_module(tuna_cmd)
+
+    def test_empty_string(self):
+        """Test empty string returns empty list and False"""
+        result, match_requested = tuna_cmd.threadstring_to_list('')
+        self.assertEqual(result, [])
+        self.assertFalse(match_requested)
+
+    def test_single_numeric_pid(self):
+        """Test single numeric PID"""
+        result, match_requested = tuna_cmd.threadstring_to_list('123')
+        self.assertEqual(result, [123])
+        self.assertTrue(match_requested)
+
+    def test_multiple_numeric_pids(self):
+        """Test multiple comma-separated numeric PIDs"""
+        result, match_requested = tuna_cmd.threadstring_to_list('1,2,3')
+        self.assertEqual(sorted(result), [1, 2, 3])
+        self.assertTrue(match_requested)
+
+    def test_duplicate_pids_deduplicated(self):
+        """Test duplicate PIDs are deduplicated"""
+        result, match_requested = tuna_cmd.threadstring_to_list('1,2,1,3,2')
+        self.assertEqual(sorted(result), [1, 2, 3])
+        self.assertTrue(match_requested)
+
+    def test_pattern_with_mock_ps(self):
+        """Test pattern matching with mock ps"""
+        mock_ps = MockPidStats()
+        result, match_requested = tuna_cmd.threadstring_to_list('systemd*', mock_ps)
+        self.assertEqual(sorted(result), [100, 101])
+        self.assertTrue(match_requested)
+
+    def test_exact_name_with_mock_ps(self):
+        """Test exact name matching with mock ps"""
+        mock_ps = MockPidStats()
+        result, match_requested = tuna_cmd.threadstring_to_list('systemd', mock_ps)
+        self.assertEqual(result, [100])
+        self.assertTrue(match_requested)
+
+    def test_mixed_numeric_and_pattern(self):
+        """Test mixed numeric PIDs and patterns"""
+        mock_ps = MockPidStats()
+        result, match_requested = tuna_cmd.threadstring_to_list('1,systemd*,5', mock_ps)
+        self.assertIn(1, result)
+        self.assertIn(5, result)
+        self.assertIn(100, result)
+        self.assertIn(101, result)
+        self.assertTrue(match_requested)
+
+
+class TestIrqstringToList(unittest.TestCase):
+    """Test cases for irqstring_to_list() function"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Load the tuna-cmd module"""
+        spec.loader.exec_module(tuna_cmd)
+
+    def test_empty_string(self):
+        """Test empty string returns empty list and False"""
+        result, match_requested = tuna_cmd.irqstring_to_list('')
+        self.assertEqual(result, [])
+        self.assertFalse(match_requested)
+
+    def test_single_numeric_irq(self):
+        """Test single numeric IRQ"""
+        result, match_requested = tuna_cmd.irqstring_to_list('42')
+        self.assertEqual(result, [42])
+        self.assertTrue(match_requested)
+
+    def test_multiple_numeric_irqs(self):
+        """Test multiple comma-separated numeric IRQs"""
+        result, match_requested = tuna_cmd.irqstring_to_list('1,2,42')
+        self.assertEqual(sorted(result), [1, 2, 42])
+        self.assertTrue(match_requested)
+
+    def test_duplicate_irqs_deduplicated(self):
+        """Test duplicate IRQs are deduplicated"""
+        result, match_requested = tuna_cmd.irqstring_to_list('1,2,1,42,2')
+        self.assertEqual(sorted(result), [1, 2, 42])
+        self.assertTrue(match_requested)
+
+
+class TestSocketstringToList(unittest.TestCase):
+    """Test cases for socketstring_to_list() function"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Load the tuna-cmd module"""
+        spec.loader.exec_module(tuna_cmd)
+
+    def test_socketstring_exists(self):
+        """Test that socketstring_to_list function exists"""
+        # Note: socketstring_to_list doesn't return match_requested tuple
+        # and requires access to sysfs.cpus() which may not be available
+        # in test environment. Just verify the function exists.
+        self.assertTrue(callable(tuna_cmd.socketstring_to_list))
+
+
+if __name__ == '__main__':
+    unittest.main()
-- 
2.54.0

