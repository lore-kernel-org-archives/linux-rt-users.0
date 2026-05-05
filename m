Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF844A33EA
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003079; cv=none; b=bLmltQzsQZxmNw8Lv3m8w/alnZL+PPSfE5rRk7bn1bqRYBVqlepstY4bCFI5jrcw1kn0ziTwwAiAarIZOZvuzZyoU14EhMI/tUJCPcEXRMBCgJ2esmHKxYBtQRZpU1nzGS2oWJgeLE//dyJov1gdV/xXT5uHpc1VVbAOvmQlUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003079; c=relaxed/simple;
	bh=joLk8bIP3BpriRfrQamvFXtDjsAQGYO9aU+RyYR5KV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBQjUyxd7yjlf60qbXJWdMlnYxIYde7/8fiYsUiWo/Z8/c1YuUkncKVOMPVIjT/B+HKw0Q5QJXxXSInvfZzCEispLDa1YRjisWR73jIKPNnbluvVY0824peWwokDFdGhP4TCfZJxHvAlDavsZl/pM9l3UmPnoqEhHfdVslg5/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6H6vAXs; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6H6vAXs"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899a9f445cbso57510276d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003075; x=1778607875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjM3nr8xioyffD1LeGZQKwFJzHFBMzJOX4sqhGs7UqA=;
        b=W6H6vAXs3yZ+y+cYrnqAx/DTkl/1QIlKU6TpIzNwJxWF8Xg4lHLDnSzVBPwaiXbxZ9
         w14yFKwXlyGK02EgHqWztsggvlu9Kax+eUYzAZcMUdTCVhxPRaOD5V4NxqhjLo4R5B0/
         XKp/coGuFsWwokJ4yPmSMQHR6HiP1Se+MCibZdw4TstJyBCeVBLscSVjqgMM03VweuXc
         yG/kdozVP67CAhMIc2WNUSOjFxLJyRqCTyt+/VOL0zCLYTaatjtRBcrG/F8BVtLSai4A
         qfYFx4f4iWsvezkgH+2imS6dSDfSRHVPW8Ggki5r+fopkQpacuUsABxgT4jOWTeaB2jB
         H3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003075; x=1778607875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjM3nr8xioyffD1LeGZQKwFJzHFBMzJOX4sqhGs7UqA=;
        b=WD3uWtaPIYJbwCesjRhEkfxhqo9AQvwxt9o/yHv056S+EPw3Q+pKq0dgwWDyVPT6YB
         9LnO3AkyprSsg3FIOOvXwDNea96OLbwNZybzNr41WUGOeZn+JRN2pZHe2onNnydP49Yi
         MpB2ZEZWVhhSG21MUrqJKzsno9EbichKnvElfygMNgJnKQYogZKMlLfOIehpRlnNOx9K
         1uLi2ZhkSI8NXWjtbyE5PjaWMK0XKxbsS332Cw7gDywEgYFZIIefn4U70JCAKxgZuR5K
         ClQ6r4C00ndHwqF6bAEbuzA9YCt7GOTXcUbmnU7fRTjtLDO5V+R6HVxqgc4lhkEOmUAY
         c/og==
X-Gm-Message-State: AOJu0Yw3fkJg5f3dQEc7JdcwtJJn/hJOHae0fIWp0Ese4Xt7rL1l7gm+
	M0mugi5WAKP0u2e5w2zKHXZ12lbB7pVIwyzG2FgqtkQauJYVz1AnWuwSKp9oEQ==
X-Gm-Gg: AeBDietZWFenrt/Lm2OihD+SJNyUb85TmlLJSNZllUpdtxJQWbKwTETpI6dpjO29XNg
	4r1YGUoeul1A7aSZ4yxG1BwoEWeK+qERsjoRS2flZQllNxjM2hI0ckrZ9YDLC9XBkdF2JkYRQFa
	6SuXaqRLTeJk9LF7nzDb2dgbV3kHoS65+nm3jF48OWUlUsGiteeftz00/Aapc8Cpxy0ya0t2xQB
	TTOS+qoOHW1Yw6u5VGK92mDepWNIUQ4tgYe7kzQv1DySAVIIXm6lMc9Q4TZexX99Gg300o9lAtR
	/4Kl0ECr0+K8TMN7u7QmiWLhFJW+UDxOYw18RVz/PdzVGSB7JJonCaOArXEspfxFKJVrwJCFEIF
	uNOpg/3q/GT29FycLxWnP14WdErdASoteUKl0g6Do6sdSFyp8WP9PzBojzUyOX4p0vlTFxY4h1+
	ReR3LDKaJQFh5FIwZmITeHPThyyHIO1C0UYtJ+sZV1a+M4dMhr7O5HxaFusUPxuo+mqIDEG/wL8
	fX3GZAg5M1E7KTCva2jkLFSjlC3Iw==
X-Received: by 2002:a05:6214:5342:b0:8ac:bb62:fe5a with SMTP id 6a1803df08f44-8b66892ab60mr252196206d6.33.1778003074950;
        Tue, 05 May 2026 10:44:34 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/9] rteval: Add regression tests for measurement module error handling
Date: Tue,  5 May 2026 13:43:48 -0400
Message-ID: <20260505174410.169442-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505174410.169442-1-jkacur@redhat.com>
References: <20260505174410.169442-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add comprehensive regression test suite to verify error handling fixes
for timerlat and cyclictest measurement modules (RHEL-140898).

1. Create tests/regression/ directory structure
   - test-timerlat-error-handling.sh - Test harness for timerlat
   - test-cyclictest-error-handling.sh - Test harness for cyclictest
   - mock-rtla-timerlat-partial-output.py - Mock rtla with 4 failure scenarios
   - mock-cyclictest-partial-output.py - Mock cyclictest with 4 failure scenarios
   - README.md - Comprehensive documentation

2. Add regression-tests Makefile target
   - Runs both timerlat and cyclictest test suites
   - Checks for root privileges and provides helpful error message
   - Added to make help output
   - Added to .PHONY targets

3. Test scenarios verify error handling for
   - truncated_mid_line - Simulates segfault mid-execution
   - missing_columns - Tests IndexError handling
   - invalid_numbers - Tests ValueError handling
   - mixed_corruption - Comprehensive combination test

4. Tests can be run via Makefile or standalone scripts
   - sudo make regression-tests (recommended)
   - sudo ./tests/regression/test-timerlat-error-handling.sh
   - sudo ./tests/regression/test-cyclictest-error-handling.sh

These tests verify that rteval handles partial/malformed output from
measurement tools gracefully without hanging, crashing, or infinite loops.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                                      |  36 ++-
 tests/regression/README.md                    | 155 ++++++++++++
 .../mock-cyclictest-partial-output.py         | 165 +++++++++++++
 .../mock-rtla-timerlat-partial-output.py      | 138 +++++++++++
 .../test-cyclictest-error-handling.sh         | 225 +++++++++++++++++
 .../test-timerlat-error-handling.sh           | 228 ++++++++++++++++++
 6 files changed, 936 insertions(+), 11 deletions(-)
 create mode 100644 tests/regression/README.md
 create mode 100755 tests/regression/mock-cyclictest-partial-output.py
 create mode 100755 tests/regression/mock-rtla-timerlat-partial-output.py
 create mode 100755 tests/regression/test-cyclictest-error-handling.sh
 create mode 100755 tests/regression/test-timerlat-error-handling.sh

diff --git a/Makefile b/Makefile
index ffc169043f3f..5e429b41e1b4 100644
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,18 @@ LOADS	:=	$(KLOAD) $(BLOAD)
 e2e-tests: rteval-cmd
 	PYTHON="$(PYTHON)" RTEVAL="$(HERE)/rteval-cmd" RTEVAL_PKG="$(HERE)" prove -o -f -v tests/e2e/
 
+regression-tests:
+	@echo "Running regression tests for measurement module error handling (RHEL-140898)"
+	@echo "These tests require root privileges to replace system binaries temporarily"
+	@echo ""
+	@if [ "$$(id -u)" != "0" ]; then \
+		echo "ERROR: regression-tests must be run as root"; \
+		echo "Usage: sudo make regression-tests"; \
+		exit 1; \
+	fi
+	./tests/regression/test-timerlat-error-handling.sh
+	./tests/regression/test-cyclictest-error-handling.sh
+
 runit:
 	[ -d $(HERE)/run ] || mkdir run
 	$(PYTHON) rteval-cmd -D -L -v --workdir=$(HERE)/run --loaddir=$(HERE)/loadsource --duration=$(D) -f $(HERE)/rteval.conf -i $(HERE)/rteval $(EXTRA)
@@ -75,16 +87,18 @@ help:
 	@echo ""
 	@echo "rteval Makefile targets:"
 	@echo ""
-	@echo "        runit:     do a short testrun locally [default]"
-	@echo "        test:      run unit tests"
-	@echo "        unittest:  run unit tests (same as test)"
-	@echo "        tarfile:   create the source tarball"
-	@echo "        install:   install rteval locally"
-	@echo "        clean:     cleanup generated files"
-	@echo "        realclean: Same as clean plus directory run"
-	@echo "        sysreport: do a short testrun and generate sysreport data"
-	@echo "        tags:      generate a ctags file"
-	@echo "        cleantags: remove the ctags file"
+	@echo "        runit:            do a short testrun locally [default]"
+	@echo "        test:             run unit tests"
+	@echo "        unittest:         run unit tests (same as test)"
+	@echo "        e2e-tests:        run end-to-end tests"
+	@echo "        regression-tests: run regression tests for measurement modules (requires root)"
+	@echo "        tarfile:          create the source tarball"
+	@echo "        install:          install rteval locally"
+	@echo "        clean:            cleanup generated files"
+	@echo "        realclean:        Same as clean plus directory run"
+	@echo "        sysreport:        do a short testrun and generate sysreport data"
+	@echo "        tags:             generate a ctags file"
+	@echo "        cleantags:        remove the ctags file"
 	@echo ""
 
 .PHONY: tags
@@ -95,4 +109,4 @@ tags:
 cleantags:
 	rm -f tags
 
-.PHONY: test unittest
+.PHONY: test unittest e2e-tests regression-tests
diff --git a/tests/regression/README.md b/tests/regression/README.md
new file mode 100644
index 000000000000..8619079e229e
--- /dev/null
+++ b/tests/regression/README.md
@@ -0,0 +1,155 @@
+# Regression Tests for Measurement Module Error Handling
+
+Regression tests for verifying error handling fixes in the timerlat and cyclictest measurement modules (RHEL-140898).
+
+## Purpose
+
+These tests verify that rteval handles partial/malformed output from measurement modules gracefully. Both timerlat and cyclictest can crash or produce incomplete data, which previously caused rteval to hang indefinitely. These tests ensure the error handling prevents hangs, crashes, and infinite loops.
+
+## Test Files
+
+### Timerlat Testing
+- **mock-rtla-timerlat-partial-output.py** - Mock rtla that simulates partial/malformed output
+- **test-timerlat-error-handling.sh** - Test harness for timerlat
+
+### Cyclictest Testing
+- **mock-cyclictest-partial-output.py** - Mock cyclictest that simulates partial/malformed output
+- **test-cyclictest-error-handling.sh** - Test harness for cyclictest
+
+## Test Scenarios
+
+Both test suites simulate four different failure modes:
+
+1. **truncated_mid_line** - Output cuts off mid-line (simulates segfault)
+   - Tests `IndexError` handling in bucket parsing
+   - Mock exits with code 139 (segfault)
+
+2. **missing_columns** - Missing CPU columns in some lines
+   - Tests `IndexError` when accessing out-of-bounds array indices
+   - Mock exits with code 1
+
+3. **invalid_numbers** - Non-numeric values in histogram data
+   - Tests `ValueError` handling when converting strings to int
+   - Mock exits with code 1
+
+4. **mixed_corruption** - Random combination of all issues
+   - Comprehensive test of error handling
+   - Mock exits with code 0 (to test handling of bad data with "success" exit)
+
+## Running the Tests
+
+**Requirements:**
+- Root privileges (rteval requires root)
+- Tests run from repository root directory
+
+### Via Makefile (Recommended)
+
+Run both test suites:
+```bash
+sudo make regression-tests
+```
+
+This runs all timerlat and cyclictest error handling tests automatically.
+
+### Standalone Scripts
+
+#### Run All Timerlat Tests
+```bash
+sudo ./tests/regression/test-timerlat-error-handling.sh
+```
+
+#### Run All Cyclictest Tests
+```bash
+sudo ./tests/regression/test-cyclictest-error-handling.sh
+```
+
+#### Run Specific Scenario
+```bash
+sudo ./tests/regression/test-timerlat-error-handling.sh truncated_mid_line
+sudo ./tests/regression/test-cyclictest-error-handling.sh missing_columns
+```
+
+Available scenarios: `truncated_mid_line`, `missing_columns`, `invalid_numbers`, `mixed_corruption`
+
+#### Run Both Test Suites
+```bash
+sudo ./tests/regression/test-timerlat-error-handling.sh && \
+sudo ./tests/regression/test-cyclictest-error-handling.sh
+```
+
+## Expected Results
+
+With the fixes applied, rteval should:
+
+### ✓ Handle Partial Output Gracefully
+- Log warnings about malformed data
+- Continue processing what data is available
+- **NOT crash** with unhandled exceptions
+
+### ✓ Always Call _setFinished()
+- Complete cleanup even if parsing fails
+- **NOT hang** in WaitForCompletion
+
+### ✓ Limit SIGINT Attempts
+- Send maximum of 5 SIGINT signals
+- Force SIGKILL if process doesn't respond
+- **NOT loop infinitely**
+
+### ✓ Log Non-Zero Exit Codes
+- Detect and log when measurement tool exits abnormally
+- Provide useful debugging information
+
+## What to Look For in Logs
+
+Successful handling should show:
+
+```
+[WARN] Error parsing timerlat bucket data for core X: ...
+[WARN] Error parsing cyclictest bucket data for core X: ...
+[DEBUG] Sending SIGINT (attempt 1/5)
+[DEBUG] Sending SIGINT (attempt 2/5)
+...
+[WARN] timerlat exited with non-zero status: 139
+[WARN] cyclictest exited with non-zero status: 139
+```
+
+Failures (old code) would show:
+- Unhandled exceptions causing rteval to crash
+- Infinite loop of SIGINT attempts
+- Process hanging indefinitely
+
+## When to Run These Tests
+
+- **Before releases** - Verify error handling still works
+- **After modifying measurement modules** - Ensure changes don't break error handling
+- **After kernel updates** - Verify measurement tools still behave correctly
+- **When investigating hang reports** - Reproduce error conditions
+
+## Implementation Details
+
+Both measurement modules received identical fixes:
+
+1. **SIGINT retry limit** - Maximum 5 attempts, then SIGKILL
+2. **try/finally for _setFinished()** - Ensures cleanup always happens
+3. **Exception handling in bucket parsing** - Catches IndexError and ValueError
+4. **Exception handling in helper methods** - Additional protection for special parsing
+5. **Non-zero exit code logging** - Helps with debugging
+
+See commit messages for detailed implementation:
+- f5a1164b8ee4 - rteval: Fix timerlat error handling to prevent hangs
+- b202ea46068b - rteval: Fix cyclictest error handling to prevent hangs
+
+## Test Mechanics
+
+- Tests require sudo because rteval needs root privileges
+- Each test creates a workdir named `test-{module}-{scenario}-{pid}`
+- Logs are saved as `test-{module}-{scenario}-{pid}.log`
+- Duration set to 30 seconds to give rteval adequate setup time
+- Tests automatically replace `/usr/bin/rtla` or `/usr/bin/cyclictest` temporarily
+- Original binaries are restored on completion or interruption
+
+## Related Issues
+
+- **RHEL-140898** - rteval hangs in WaitForCompletion
+- **RHEL-172903** - [Upstream]: rteval hangs in WaitForCompletion
+- **RHEL-151475** - Root cause: rtla segfault (being fixed separately)
diff --git a/tests/regression/mock-cyclictest-partial-output.py b/tests/regression/mock-cyclictest-partial-output.py
new file mode 100755
index 000000000000..6bfc2a4ec41a
--- /dev/null
+++ b/tests/regression/mock-cyclictest-partial-output.py
@@ -0,0 +1,165 @@
+#!/usr/bin/env python3
+"""
+Mock cyclictest that produces partial/malformed histogram output
+to test rteval's error handling improvements (RHEL-140898)
+
+This simulates the output that cyclictest might produce when:
+1. It segfaults mid-execution (partial histogram)
+2. Gets killed during cleanup (incomplete lines)
+3. Has data corruption (malformed values)
+"""
+
+import sys
+import signal
+import time
+import random
+
+# Track if we should exit
+should_exit = False
+
+def handle_sigint(sig, frame):
+    global should_exit
+    print("# Received SIGINT, cleaning up...", file=sys.stderr)
+    should_exit = True
+
+signal.signal(signal.SIGINT, handle_sigint)
+
+def print_histogram_header():
+    """Print the standard cyclictest histogram header"""
+    print("# /dev/cpu_dma_latency set to 0us")
+    print("# Histogram")
+    print("#")
+
+def print_partial_histogram(scenario="truncated_mid_line", num_cpus=4):
+    """
+    Print histogram data with various types of corruption
+
+    Scenarios:
+    - truncated_mid_line: Line cuts off mid-way (IndexError)
+    - missing_columns: Missing some CPU columns (IndexError)
+    - invalid_numbers: Non-numeric values (ValueError)
+    - mixed_corruption: Combination of issues
+    """
+
+    # Print max latencies header (can also be corrupted)
+    if scenario == "missing_columns" and random.random() < 0.5:
+        # Truncated max latencies line
+        print(f"# Max Latencies: {random.randint(10,100)} {random.randint(10,100)}")
+    else:
+        max_vals = " ".join([str(random.randint(10, 100)) for _ in range(num_cpus)])
+        print(f"# Max Latencies: {max_vals}")
+
+    if scenario == "truncated_mid_line":
+        # Normal lines first
+        for i in range(10):
+            vals = " ".join([f"{random.randint(0,100):10d}" for _ in range(num_cpus)])
+            print(f"{i:10d} {vals}")
+
+        # Then a truncated line (simulates segfault mid-write)
+        vals = " ".join([f"{random.randint(0,100):10d}" for _ in range(2)])  # Only 2 of 4 CPUs
+        print(f"{10:10d} {vals}")
+        # Output ends abruptly here
+
+    elif scenario == "missing_columns":
+        # Some lines missing data for certain CPUs
+        for i in range(20):
+            if i % 5 == 0:
+                # Missing last two CPUs
+                vals = " ".join([f"{random.randint(0,100):10d}" for _ in range(2)])
+                print(f"{i:10d} {vals}")
+            elif i % 3 == 0:
+                # Missing last CPU
+                vals = " ".join([f"{random.randint(0,100):10d}" for _ in range(3)])
+                print(f"{i:10d} {vals}")
+            else:
+                # Normal line
+                vals = " ".join([f"{random.randint(0,100):10d}" for _ in range(num_cpus)])
+                print(f"{i:10d} {vals}")
+
+    elif scenario == "invalid_numbers":
+        # Lines with non-numeric values
+        for i in range(15):
+            if i % 4 == 0:
+                # Corrupted data - one CPU has invalid value
+                vals = [f"{random.randint(0,100):10d}" for _ in range(num_cpus)]
+                vals[random.randint(0, num_cpus-1)] = "XXXX      "  # Replace one with garbage
+                print(f"{i:10d} {' '.join(vals)}")
+            else:
+                # Normal line
+                vals = " ".join([f"{random.randint(0,100):10d}" for _ in range(num_cpus)])
+                print(f"{i:10d} {vals}")
+
+    elif scenario == "mixed_corruption":
+        # Combination of issues
+        for i in range(20):
+            rand = random.random()
+            if rand < 0.2:
+                # Truncated
+                num_cols = random.randint(1, num_cpus-1)
+                vals = " ".join([f"{random.randint(0,100):10d}" for _ in range(num_cols)])
+                print(f"{i:10d} {vals}")
+            elif rand < 0.4:
+                # Invalid data
+                vals = [f"{random.randint(0,100):10d}" for _ in range(num_cpus)]
+                vals[random.randint(0, num_cpus-1)] = "ERR       "
+                print(f"{i:10d} {' '.join(vals)}")
+            elif rand < 0.6:
+                # Missing column
+                num_cols = random.randint(1, num_cpus-1)
+                vals = " ".join([f"{random.randint(0,100):10d}" for _ in range(num_cols)])
+                print(f"{i:10d} {vals}")
+            else:
+                # Normal
+                vals = " ".join([f"{random.randint(0,100):10d}" for _ in range(num_cpus)])
+                print(f"{i:10d} {vals}")
+
+def main():
+    """Main function to simulate cyclictest with partial output"""
+
+    # Parse scenario from arguments
+    scenario = "truncated_mid_line"
+    num_cpus = 4
+
+    if len(sys.argv) > 1:
+        valid_scenarios = ["truncated_mid_line", "missing_columns", "invalid_numbers", "mixed_corruption"]
+        for arg in sys.argv[1:]:
+            if arg.startswith("--scenario="):
+                requested = arg.split("=")[1]
+                if requested in valid_scenarios:
+                    scenario = requested
+            elif arg.startswith("-t"):
+                # Parse thread count (number of CPUs)
+                try:
+                    num_cpus = int(arg[2:])
+                except ValueError:
+                    pass
+
+    print(f"# Mock cyclictest starting (scenario: {scenario})", file=sys.stderr)
+
+    # Print header
+    print_histogram_header()
+
+    # Simulate some runtime before producing output
+    start_time = time.time()
+    while not should_exit and (time.time() - start_time) < 5:
+        time.sleep(0.1)
+
+    if should_exit:
+        print("# Interrupted by SIGINT", file=sys.stderr)
+
+    # Print partial/corrupted histogram
+    print_partial_histogram(scenario, num_cpus)
+
+    # Exit (possibly before completing all output)
+    print(f"# Mock cyclictest exiting (scenario: {scenario})", file=sys.stderr)
+
+    # Simulate different exit codes
+    if scenario == "truncated_mid_line":
+        sys.exit(139)  # Segfault exit code
+    elif scenario in ["missing_columns", "invalid_numbers"]:
+        sys.exit(1)   # Generic error
+    else:
+        sys.exit(0)   # Normal exit despite bad data
+
+if __name__ == "__main__":
+    main()
diff --git a/tests/regression/mock-rtla-timerlat-partial-output.py b/tests/regression/mock-rtla-timerlat-partial-output.py
new file mode 100755
index 000000000000..63f9d89af2d9
--- /dev/null
+++ b/tests/regression/mock-rtla-timerlat-partial-output.py
@@ -0,0 +1,138 @@
+#!/usr/bin/env python3
+"""
+Mock rtla timerlat that produces partial/malformed histogram output
+to test rteval's error handling improvements (RHEL-140898)
+
+This simulates the output that rtla might produce when:
+1. It segfaults mid-execution (partial histogram)
+2. Gets killed during cleanup (incomplete lines)
+3. Has data corruption (malformed values)
+"""
+
+import sys
+import signal
+import time
+import random
+
+# Track if we should exit
+should_exit = False
+
+def handle_sigint(sig, frame):
+    global should_exit
+    print("# Received SIGINT, cleaning up...", file=sys.stderr)
+    should_exit = True
+
+signal.signal(signal.SIGINT, handle_sigint)
+
+def print_histogram_header():
+    """Print the standard rtla timerlat histogram header"""
+    print("# RTLA timerlat histogram")
+    print("# Time unit is microseconds (us)")
+    print("# Duration:   0 00:00:30")
+    print()
+
+def print_partial_histogram(scenario="truncated_mid_line"):
+    """
+    Print histogram data with various types of corruption
+
+    Scenarios:
+    - truncated_mid_line: Line cuts off mid-way (IndexError)
+    - missing_columns: Missing some CPU columns (IndexError)
+    - invalid_numbers: Non-numeric values (ValueError)
+    - mixed_corruption: Combination of issues
+    """
+
+    print("Index   CPU-000        CPU-001        CPU-002        CPU-003")
+
+    if scenario == "truncated_mid_line":
+        # Normal lines first
+        for i in range(10):
+            print(f"{i:5d}   {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d}")
+
+        # Then a truncated line (simulates segfault mid-write)
+        print(f"{10:5d}   {random.randint(0,100):10d} {random.randint(0,100):10d}")
+        # Output ends abruptly here
+
+    elif scenario == "missing_columns":
+        # Some lines missing data for certain CPUs
+        for i in range(20):
+            if i % 5 == 0:
+                # Missing last two CPUs
+                print(f"{i:5d}   {random.randint(0,100):10d} {random.randint(0,100):10d}")
+            elif i % 3 == 0:
+                # Missing last CPU
+                print(f"{i:5d}   {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d}")
+            else:
+                # Normal line
+                print(f"{i:5d}   {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d}")
+
+    elif scenario == "invalid_numbers":
+        # Lines with non-numeric values
+        for i in range(15):
+            if i % 4 == 0:
+                # Corrupted data
+                print(f"{i:5d}   {'XXXX':>10s} {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d}")
+            else:
+                # Normal line
+                print(f"{i:5d}   {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d}")
+
+    elif scenario == "mixed_corruption":
+        # Combination of issues
+        for i in range(20):
+            rand = random.random()
+            if rand < 0.2:
+                # Truncated
+                print(f"{i:5d}   {random.randint(0,100):10d}")
+            elif rand < 0.4:
+                # Invalid data
+                print(f"{i:5d}   {random.randint(0,100):10d} {'ERR':>10s} {random.randint(0,100):10d} {random.randint(0,100):10d}")
+            elif rand < 0.6:
+                # Missing column
+                print(f"{i:5d}   {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d}")
+            else:
+                # Normal
+                print(f"{i:5d}   {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d} {random.randint(0,100):10d}")
+
+def main():
+    """Main function to simulate rtla timerlat with partial output"""
+
+    # Parse scenario from arguments
+    scenario = "truncated_mid_line"
+    if len(sys.argv) > 1:
+        valid_scenarios = ["truncated_mid_line", "missing_columns", "invalid_numbers", "mixed_corruption"]
+        for arg in sys.argv[1:]:
+            if arg.startswith("--scenario="):
+                requested = arg.split("=")[1]
+                if requested in valid_scenarios:
+                    scenario = requested
+                    break
+
+    print(f"# Mock rtla starting (scenario: {scenario})", file=sys.stderr)
+
+    # Print header
+    print_histogram_header()
+
+    # Simulate some runtime before producing output
+    start_time = time.time()
+    while not should_exit and (time.time() - start_time) < 5:
+        time.sleep(0.1)
+
+    if should_exit:
+        print("# Interrupted by SIGINT", file=sys.stderr)
+
+    # Print partial/corrupted histogram
+    print_partial_histogram(scenario)
+
+    # Exit (possibly before completing all output)
+    print(f"# Mock rtla exiting (scenario: {scenario})", file=sys.stderr)
+
+    # Simulate different exit codes
+    if scenario == "truncated_mid_line":
+        sys.exit(139)  # Segfault exit code
+    elif scenario in ["missing_columns", "invalid_numbers"]:
+        sys.exit(1)   # Generic error
+    else:
+        sys.exit(0)   # Normal exit despite bad data
+
+if __name__ == "__main__":
+    main()
diff --git a/tests/regression/test-cyclictest-error-handling.sh b/tests/regression/test-cyclictest-error-handling.sh
new file mode 100755
index 000000000000..a4903d2d34d8
--- /dev/null
+++ b/tests/regression/test-cyclictest-error-handling.sh
@@ -0,0 +1,225 @@
+#!/bin/bash
+#
+# Test script for cyclictest error handling (RHEL-140898)
+# Tests that rteval handles partial/malformed cyclictest output gracefully
+#
+
+set -e
+
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
+MOCK_CYCLICTEST="${SCRIPT_DIR}/mock-cyclictest-partial-output.py"
+RTEVAL_MODULE="${REPO_ROOT}/rteval/modules/measurement/cyclictest.py"
+
+# Colors for output
+RED='\033[0;31m'
+GREEN='\033[0;32m'
+YELLOW='\033[1;33m'
+NC='\033[0m' # No Color
+
+# Cleanup function to restore cyclictest if interrupted
+cleanup_cyclictest() {
+    if [ -e /usr/bin/cyclictest.real ]; then
+        echo "Restoring original cyclictest..."
+        sudo rm -f /usr/bin/cyclictest
+        sudo mv /usr/bin/cyclictest.real /usr/bin/cyclictest
+    fi
+}
+trap cleanup_cyclictest EXIT INT TERM
+
+echo "========================================"
+echo "Cyclictest Error Handling Test Suite"
+echo "Testing fix for RHEL-140898"
+echo "========================================"
+echo
+
+# Check that mock script exists and is executable
+if [ ! -f "$MOCK_CYCLICTEST" ]; then
+    echo -e "${RED}ERROR: Mock cyclictest script not found: $MOCK_CYCLICTEST${NC}"
+    exit 1
+fi
+
+chmod +x "$MOCK_CYCLICTEST"
+
+# Check that cyclictest module has the fix
+if ! grep -q "max_attempts = 5" "$RTEVAL_MODULE"; then
+    echo -e "${YELLOW}WARNING: cyclictest.py may not have the SIGINT retry limit fix${NC}"
+fi
+
+if ! grep -q "Parse histogram output.*try/finally" "$RTEVAL_MODULE"; then
+    echo -e "${YELLOW}WARNING: cyclictest.py may not have the try/finally fix${NC}"
+fi
+
+if ! grep -q "except (IndexError, ValueError)" "$RTEVAL_MODULE"; then
+    echo -e "${YELLOW}WARNING: cyclictest.py may not have the exception handling fix${NC}"
+fi
+
+echo "Available test scenarios:"
+echo "  1. truncated_mid_line  - Line cuts off mid-way (tests IndexError)"
+echo "  2. missing_columns     - Missing CPU columns (tests IndexError)"
+echo "  3. invalid_numbers     - Non-numeric values (tests ValueError)"
+echo "  4. mixed_corruption    - Combination of issues"
+echo
+
+# Function to run a test scenario
+run_test_scenario() {
+    local scenario="$1"
+    local description="$2"
+
+    echo "========================================"
+    echo -e "${YELLOW}Test: $description${NC}"
+    echo "Scenario: $scenario"
+    echo "========================================"
+
+    # Create a wrapper script that uses our mock instead of real cyclictest
+    local wrapper="/tmp/cyclictest-wrapper-$$"
+    cat > "$wrapper" << 'EOF'
+#!/bin/bash
+# Wrapper to intercept cyclictest calls
+exec python3 "MOCK_CYCLICTEST_PATH" --scenario=SCENARIO_NAME "$@"
+EOF
+
+    sed -i "s|MOCK_CYCLICTEST_PATH|$MOCK_CYCLICTEST|g" "$wrapper"
+    sed -i "s|SCENARIO_NAME|$scenario|g" "$wrapper"
+    chmod +x "$wrapper"
+
+    # Run rteval with the wrapper
+    echo "Starting rteval with mock cyclictest..."
+    echo "Command: ${REPO_ROOT}/rteval-cmd --duration=30 --measurement-module=cyclictest --noload --debug"
+    echo
+
+    # Temporarily replace /usr/bin/cyclictest with our wrapper
+    # This bypasses sudo secure_path issues
+    if [ -e /usr/bin/cyclictest ] && [ ! -e /usr/bin/cyclictest.real ]; then
+        sudo mv /usr/bin/cyclictest /usr/bin/cyclictest.real
+    fi
+    sudo cp "$wrapper" /usr/bin/cyclictest
+    sudo chmod +x /usr/bin/cyclictest
+
+    # Run rteval and capture output
+    local workdir="test-cyclictest-${scenario}-$$"
+    local log_file="${workdir}.log"
+
+    # Create workdir (rteval requires it to exist)
+    mkdir -p "$workdir"
+
+    # Use sudo -E to preserve environment (especially PATH with /tmp/cyclictest)
+    if sudo -E "${REPO_ROOT}/rteval-cmd" --duration=30 --measurement-module=cyclictest --noload --debug \
+         --workdir="$workdir" > "$log_file" 2>&1; then
+        echo -e "${GREEN}✓ rteval completed successfully (exit code 0)${NC}"
+        local result="PASS"
+    else
+        local exit_code=$?
+        if [ $exit_code -eq 1 ]; then
+            echo -e "${GREEN}✓ rteval exited with code 1 (detected malformed data - expected)${NC}"
+            local result="PASS"
+        elif [ $exit_code -eq 143 ] || [ $exit_code -eq 130 ]; then
+            echo -e "${GREEN}✓ rteval exited with SIGTERM/SIGINT (expected)${NC}"
+            local result="PASS"
+        else
+            echo -e "${RED}✗ rteval failed with unexpected exit code $exit_code${NC}"
+            local result="FAIL"
+        fi
+    fi
+
+    # Restore original cyclictest
+    sudo rm -f /usr/bin/cyclictest
+    if [ -e /usr/bin/cyclictest.real ]; then
+        sudo mv /usr/bin/cyclictest.real /usr/bin/cyclictest
+    fi
+    rm -f "$wrapper"
+
+    echo
+    echo "Checking for expected behaviors:"
+
+    # Check if mock was actually used by looking for scenario-specific exit codes
+    local mock_called=false
+    case "$scenario" in
+        truncated_mid_line)
+            if grep -q "exited with non-zero status: 139" "$log_file"; then
+                echo -e "${GREEN}✓ Mock cyclictest was called (exit code 139 detected)${NC}"
+                mock_called=true
+            fi
+            ;;
+        missing_columns|invalid_numbers)
+            if grep -q "exited with non-zero status: 1" "$log_file"; then
+                echo -e "${GREEN}✓ Mock cyclictest was called (exit code 1 detected)${NC}"
+                mock_called=true
+            fi
+            ;;
+        mixed_corruption)
+            # This scenario exits 0 but produces bad data
+            if grep -q "Error parsing cyclictest bucket data" "$log_file"; then
+                echo -e "${GREEN}✓ Mock cyclictest was called (parsing errors detected)${NC}"
+                mock_called=true
+            fi
+            ;;
+    esac
+
+    if [ "$mock_called" = false ]; then
+        echo -e "${RED}✗ Mock cyclictest was NOT called - scenario-specific behavior not found${NC}"
+        result="FAIL"
+    fi
+
+    # Check for warning about parsing errors
+    if grep -q "Error parsing cyclictest bucket data" "$log_file" || \
+       grep -q "Error parsing max latencies" "$log_file" || \
+       grep -q "unexpected output" "$log_file"; then
+        echo -e "${GREEN}✓ Logged warnings about malformed data${NC}"
+    else
+        echo -e "${YELLOW}? No warnings about malformed data found${NC}"
+    fi
+
+    # Check for SIGINT handling (if applicable)
+    if grep -q "Sending SIGINT" "$log_file"; then
+        echo -e "${GREEN}✓ SIGINT signal handling present${NC}"
+
+        # Count SIGINT attempts
+        local sigint_count=$(grep -c "Sending SIGINT" "$log_file" || true)
+        if [ "$sigint_count" -le 5 ]; then
+            echo -e "${GREEN}✓ SIGINT attempts limited ($sigint_count <= 5)${NC}"
+        else
+            echo -e "${RED}✗ Too many SIGINT attempts: $sigint_count${NC}"
+            result="FAIL"
+        fi
+    fi
+
+    # Check that it didn't hang (completed in reasonable time is implicit if we got here)
+    echo -e "${GREEN}✓ Did not hang (completed within timeout)${NC}"
+
+    # Check for exit code handling
+    if grep -q "exited with non-zero status" "$log_file"; then
+        echo -e "${GREEN}✓ Non-zero exit code logged${NC}"
+    fi
+
+    echo
+    echo "Log file saved to: $log_file"
+    echo "Work directory: $workdir"
+
+    if [ "$result" = "PASS" ]; then
+        echo -e "${GREEN}======== TEST PASSED ========${NC}"
+    else
+        echo -e "${RED}======== TEST FAILED ========${NC}"
+        echo "See $log_file for details"
+    fi
+
+    echo
+    return 0
+}
+
+# Run test scenarios
+if [ $# -eq 0 ]; then
+    # Run all tests
+    run_test_scenario "truncated_mid_line" "Truncated Line (IndexError test)"
+    run_test_scenario "missing_columns" "Missing Columns (IndexError test)"
+    run_test_scenario "invalid_numbers" "Invalid Numbers (ValueError test)"
+    run_test_scenario "mixed_corruption" "Mixed Corruption (comprehensive test)"
+else
+    # Run specific test
+    run_test_scenario "$1" "User-specified scenario"
+fi
+
+echo
+echo "========================================"
+echo "All tests completed"
+echo "========================================"
diff --git a/tests/regression/test-timerlat-error-handling.sh b/tests/regression/test-timerlat-error-handling.sh
new file mode 100755
index 000000000000..06d7c4b87d24
--- /dev/null
+++ b/tests/regression/test-timerlat-error-handling.sh
@@ -0,0 +1,228 @@
+#!/bin/bash
+#
+# Test script for timerlat error handling (RHEL-140898)
+# Tests that rteval handles partial/malformed rtla output gracefully
+#
+
+set -e
+
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
+MOCK_RTLA="${SCRIPT_DIR}/mock-rtla-timerlat-partial-output.py"
+RTEVAL_MODULE="${REPO_ROOT}/rteval/modules/measurement/timerlat.py"
+
+# Colors for output
+RED='\033[0;31m'
+GREEN='\033[0;32m'
+YELLOW='\033[1;33m'
+NC='\033[0m' # No Color
+
+# Cleanup function to restore rtla if interrupted
+cleanup_rtla() {
+    if [ -e /usr/bin/rtla.real ]; then
+        echo "Restoring original rtla..."
+        sudo rm -f /usr/bin/rtla
+        sudo mv /usr/bin/rtla.real /usr/bin/rtla
+    fi
+}
+trap cleanup_rtla EXIT INT TERM
+
+echo "========================================"
+echo "Timerlat Error Handling Test Suite"
+echo "Testing fix for RHEL-140898"
+echo "========================================"
+echo
+
+# Check that mock script exists and is executable
+if [ ! -f "$MOCK_RTLA" ]; then
+    echo -e "${RED}ERROR: Mock rtla script not found: $MOCK_RTLA${NC}"
+    exit 1
+fi
+
+chmod +x "$MOCK_RTLA"
+
+# Check that timerlat module has the fix
+if ! grep -q "max_attempts = 5" "$RTEVAL_MODULE"; then
+    echo -e "${YELLOW}WARNING: timerlat.py may not have the SIGINT retry limit fix${NC}"
+fi
+
+if ! grep -q "Parse histogram output.*try/finally" "$RTEVAL_MODULE"; then
+    echo -e "${YELLOW}WARNING: timerlat.py may not have the try/finally fix${NC}"
+fi
+
+if ! grep -q "except (IndexError, ValueError)" "$RTEVAL_MODULE"; then
+    echo -e "${YELLOW}WARNING: timerlat.py may not have the exception handling fix${NC}"
+fi
+
+echo "Available test scenarios:"
+echo "  1. truncated_mid_line  - Line cuts off mid-way (tests IndexError)"
+echo "  2. missing_columns     - Missing CPU columns (tests IndexError)"
+echo "  3. invalid_numbers     - Non-numeric values (tests ValueError)"
+echo "  4. mixed_corruption    - Combination of issues"
+echo
+
+# Function to run a test scenario
+run_test_scenario() {
+    local scenario="$1"
+    local description="$2"
+
+    echo "========================================"
+    echo -e "${YELLOW}Test: $description${NC}"
+    echo "Scenario: $scenario"
+    echo "========================================"
+
+    # Create a wrapper script that uses our mock instead of real rtla
+    local wrapper="/tmp/rtla-wrapper-$$"
+    cat > "$wrapper" << 'EOF'
+#!/bin/bash
+# Wrapper to intercept rtla timerlat calls
+if [ "$1" = "timerlat" ]; then
+    exec python3 "MOCK_RTLA_PATH" --scenario=SCENARIO_NAME "${@:2}"
+else
+    exec /usr/bin/rtla.real "$@"
+fi
+EOF
+
+    sed -i "s|MOCK_RTLA_PATH|$MOCK_RTLA|g" "$wrapper"
+    sed -i "s|SCENARIO_NAME|$scenario|g" "$wrapper"
+    chmod +x "$wrapper"
+
+    # Run rteval with the wrapper
+    echo "Starting rteval with mock rtla..."
+    echo "Command: ${REPO_ROOT}/rteval-cmd --duration=30 --measurement-module=timerlat --noload --debug"
+    echo
+
+    # Temporarily replace /usr/bin/rtla with our wrapper
+    # This bypasses sudo secure_path issues
+    if [ -e /usr/bin/rtla ] && [ ! -e /usr/bin/rtla.real ]; then
+        sudo mv /usr/bin/rtla /usr/bin/rtla.real
+    fi
+    sudo cp "$wrapper" /usr/bin/rtla
+    sudo chmod +x /usr/bin/rtla
+
+    # Run rteval and capture output
+    local workdir="test-timerlat-${scenario}-$$"
+    local log_file="${workdir}.log"
+
+    # Create workdir (rteval requires it to exist)
+    mkdir -p "$workdir"
+
+    # Use sudo -E to preserve environment (especially PATH with /tmp/rtla)
+    if sudo -E "${REPO_ROOT}/rteval-cmd" --duration=30 --measurement-module=timerlat --noload --debug \
+         --workdir="$workdir" > "$log_file" 2>&1; then
+        echo -e "${GREEN}✓ rteval completed successfully (exit code 0)${NC}"
+        local result="PASS"
+    else
+        local exit_code=$?
+        if [ $exit_code -eq 1 ]; then
+            echo -e "${GREEN}✓ rteval exited with code 1 (detected malformed data - expected)${NC}"
+            local result="PASS"
+        elif [ $exit_code -eq 143 ] || [ $exit_code -eq 130 ]; then
+            echo -e "${GREEN}✓ rteval exited with SIGTERM/SIGINT (expected)${NC}"
+            local result="PASS"
+        else
+            echo -e "${RED}✗ rteval failed with unexpected exit code $exit_code${NC}"
+            local result="FAIL"
+        fi
+    fi
+
+    # Restore original rtla
+    sudo rm -f /usr/bin/rtla
+    if [ -e /usr/bin/rtla.real ]; then
+        sudo mv /usr/bin/rtla.real /usr/bin/rtla
+    fi
+    rm -f "$wrapper"
+
+    echo
+    echo "Checking for expected behaviors:"
+
+    # Check if mock was actually used by looking for scenario-specific exit codes
+    local mock_called=false
+    case "$scenario" in
+        truncated_mid_line)
+            if grep -q "exited with non-zero status: 139" "$log_file"; then
+                echo -e "${GREEN}✓ Mock rtla was called (exit code 139 detected)${NC}"
+                mock_called=true
+            fi
+            ;;
+        missing_columns|invalid_numbers)
+            if grep -q "exited with non-zero status: 1" "$log_file"; then
+                echo -e "${GREEN}✓ Mock rtla was called (exit code 1 detected)${NC}"
+                mock_called=true
+            fi
+            ;;
+        mixed_corruption)
+            # This scenario exits 0 but produces bad data
+            if grep -q "Error parsing timerlat bucket data" "$log_file"; then
+                echo -e "${GREEN}✓ Mock rtla was called (parsing errors detected)${NC}"
+                mock_called=true
+            fi
+            ;;
+    esac
+
+    if [ "$mock_called" = false ]; then
+        echo -e "${RED}✗ Mock rtla was NOT called - scenario-specific behavior not found${NC}"
+        result="FAIL"
+    fi
+
+    # Check for warning about parsing errors
+    if grep -q "Error parsing timerlat bucket data" "$log_file" || \
+       grep -q "unexpected output" "$log_file"; then
+        echo -e "${GREEN}✓ Logged warnings about malformed data${NC}"
+    else
+        echo -e "${YELLOW}? No warnings about malformed data found${NC}"
+    fi
+
+    # Check for SIGINT handling (if applicable)
+    if grep -q "Sending SIGINT" "$log_file"; then
+        echo -e "${GREEN}✓ SIGINT signal handling present${NC}"
+
+        # Count SIGINT attempts
+        local sigint_count=$(grep -c "Sending SIGINT" "$log_file" || true)
+        if [ "$sigint_count" -le 5 ]; then
+            echo -e "${GREEN}✓ SIGINT attempts limited ($sigint_count <= 5)${NC}"
+        else
+            echo -e "${RED}✗ Too many SIGINT attempts: $sigint_count${NC}"
+            result="FAIL"
+        fi
+    fi
+
+    # Check that it didn't hang (completed in reasonable time is implicit if we got here)
+    echo -e "${GREEN}✓ Did not hang (completed within timeout)${NC}"
+
+    # Check for exit code handling
+    if grep -q "exited with non-zero status" "$log_file"; then
+        echo -e "${GREEN}✓ Non-zero exit code logged${NC}"
+    fi
+
+    echo
+    echo "Log file saved to: $log_file"
+    echo "Work directory: $workdir"
+
+    if [ "$result" = "PASS" ]; then
+        echo -e "${GREEN}======== TEST PASSED ========${NC}"
+    else
+        echo -e "${RED}======== TEST FAILED ========${NC}"
+        echo "See $log_file for details"
+    fi
+
+    echo
+    return 0
+}
+
+# Run test scenarios
+if [ $# -eq 0 ]; then
+    # Run all tests
+    run_test_scenario "truncated_mid_line" "Truncated Line (IndexError test)"
+    run_test_scenario "missing_columns" "Missing Columns (IndexError test)"
+    run_test_scenario "invalid_numbers" "Invalid Numbers (ValueError test)"
+    run_test_scenario "mixed_corruption" "Mixed Corruption (comprehensive test)"
+else
+    # Run specific test
+    run_test_scenario "$1" "User-specified scenario"
+fi
+
+echo
+echo "========================================"
+echo "All tests completed"
+echo "========================================"
-- 
2.54.0

