Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC21304994
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523284; cv=none; b=TecZGISyPVmbwk2I7GZ6MrxkEXsJUVCHCJd4uNb+ick20vIGYpjQfnGEItpT6XfKZNYFXBDDfsqhiHC5n/25k7oTtTn+MucBvwrCNB0K/AFl1j8t3p4siGaJRXZLGagbsCGHuVwmzgioUYWbXZjlSim8gWXDY3D45x1yYd63htE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523284; c=relaxed/simple;
	bh=i6YW6IJTz2wuJbnVyw8z3mODe8SmKClXSrl71Lb77ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eknTVJKF2z8jec4pSubCo1AU59gdYVipooV6tQgLPGN53ERtKVywdc7HAJ0g9SOgBPFPASDY8Qxe9jHettw42GMq/xAP6wqD0aXvlgqDGsCZsjWcdnLUXDm+VWJsdf2s+uWeyZHBiN8QoJ4Jv9wszRUIHtmz01Isg6Iwws6v8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5iIV0wE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5iIV0wE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762523281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dvrq2Bmw34ekRPDI3MQFzCydYTMmjePi0VRwvciPbYo=;
	b=H5iIV0wEWtHzwSC0w5gEAI58d9ScWrepZ6s+qfvahP3A2zRiAPaPQ1BW9R1lRaOI0oEUSG
	zRrwy9h9eTX3k+THY2+JutBj/CsTlk89z4V4rf6DW4Gc18pGcPR9usWibNt+Oy3coQ6a2H
	C+3NAXw5PFXkW0SbqXr0nxOLlm1zoCI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-9ZKCyu8zOTiM-vzsG7Ff5w-1; Fri,
 07 Nov 2025 08:47:59 -0500
X-MC-Unique: 9ZKCyu8zOTiM-vzsG7Ff5w-1
X-Mimecast-MFC-AGG-ID: 9ZKCyu8zOTiM-vzsG7Ff5w_1762523278
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7B3F180057A
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 13:47:58 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.228])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F4893001E83;
	Fri,  7 Nov 2025 13:47:57 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 1/3] rteval: Introduce E2E tests with output checking
Date: Fri,  7 Nov 2025 14:47:47 +0100
Message-ID: <20251107134749.257350-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently, rteval has two kinds of tests:
- Unit tests, embedded directly in code, and run by
  unit-tests/unittest.py.
- Manual tests, implemented in Makefile targets runit, load, and
  sysreport.

Introduce a new test suite in folder tests/e2e that uses Test::Harness
("prove" command) together with a simple test engine adopted from RTLA.
The test suite is run using "make e2e-tests".

The test suite runs rteval in a temporary folder for each test case,
collects its exit value and output, and validates both according to the
test specification. grep is used to check the output, optionally with
custom flags. rteval.conf is generated individually based on the test
specification of each case.

Three test sets are implemented in the commit:
- "basic", running base checks without any specific modules or module
  options.
- "loads", testing various kinds of loads, including their options.
- "measurement", testing both cyclictest and timerlat.

The latter two check in rteval output whether the command run by rteval
corresponds to the rteval options and to the specified load or
measurement, if possible.

A note in README is added about the dependency of end-to-end tests on
the Perl Test::Harness package.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
v2:
- Change default period in timerlat tests to 100us.
- Enable verbose mode for Test::Harness, just like RTLA.
- Put "Output match failed" before the output, to match RTLA test output.
- Makefile target is renamed from "check" to "e2e-tests", keeping "check"
reserved for running all tests (in the future).
- Remove deprecation of runit and load. The tests added by this commit
do basic command checks, but do not check other properties of
the output. "make runit" and "make load" is still useful for that.
- Add tests to README, along with Test::Harness dependency.
- Move unittest.py to the new tests/ subdirectory.

 Makefile                |   3 ++
 README                  |   5 ++
 tests/e2e/basic.t       |  26 +++++++++++
 tests/e2e/engine.sh     |  81 ++++++++++++++++++++++++++++++++
 tests/e2e/loads.t       |  72 ++++++++++++++++++++++++++++
 tests/e2e/measurement.t | 101 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 288 insertions(+)
 create mode 100644 tests/e2e/basic.t
 create mode 100644 tests/e2e/engine.sh
 create mode 100644 tests/e2e/loads.t
 create mode 100644 tests/e2e/measurement.t

diff --git a/Makefile b/Makefile
index a250b18..e910b7a 100644
--- a/Makefile
+++ b/Makefile
@@ -18,6 +18,9 @@ KLOAD	:=	$(LOADDIR)/linux-6.12-rc4.tar.gz
 BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
 LOADS	:=	$(KLOAD) $(BLOAD)
 
+e2e-tests: rteval-cmd
+	PYTHON="$(PYTHON)" RTEVAL="$(HERE)/rteval-cmd" RTEVAL_PKG="$(HERE)" prove -o -f -v tests/e2e/
+
 runit:
 	[ -d $(HERE)/run ] || mkdir run
 	$(PYTHON) rteval-cmd -D -L -v --workdir=$(HERE)/run --loaddir=$(HERE)/loadsource --duration=$(D) -f $(HERE)/rteval.conf -i $(HERE)/rteval $(EXTRA)
diff --git a/README b/README
index 19704b4..cb2700e 100644
--- a/README
+++ b/README
@@ -28,6 +28,11 @@ libxml2-python
 rt-tests
     git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
 
+Rteval end-to-end tests additionally require the following packages:
+
+Test::Harness
+    https://metacpan.org/pod/Test::Harness
+
 Clark Williams <williams@redhat.com> wrote rteval
 
 David Sommerseth <davids@redhat.com> wrote the XML-RPC and database
diff --git a/tests/e2e/basic.t b/tests/e2e/basic.t
new file mode 100644
index 0000000..a26f211
--- /dev/null
+++ b/tests/e2e/basic.t
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source tests/e2e/engine.sh
+test_begin
+
+set_timeout 2m
+
+check "help message" \
+  "--help" 0 "usage: rteval-cmd"
+
+check "help message short" \
+  "-h" 0 "usage: rteval-cmd"
+
+check "debug" \
+  "-D -d 1" 0 '\[DEBUG\]'
+
+check "duration" \
+  "-d 5" 0 "Run duration: 5.0 seconds"
+
+check "verbose" \
+  "-v -d 5" 0 '\[INFO\]'
+
+check "quiet" \
+  "-d 5" 0 '(\[INFO\])|(\[DEBUG\])' "-v"
+
+test_end
diff --git a/tests/e2e/engine.sh b/tests/e2e/engine.sh
new file mode 100644
index 0000000..9e33be0
--- /dev/null
+++ b/tests/e2e/engine.sh
@@ -0,0 +1,81 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+load_default_config() {
+	rteval_config=$(<$RTEVAL_PKG/rteval.conf)
+}
+
+test_begin() {
+	# Count tests to allow the test harness to double-check if all were
+	# included correctly.
+	ctr=0
+	[ -z "$PYTHON" ] && PYTHON="python3"
+	[ -z "$RTEVAL" ] && RTEVAL="$PWD/rteval-cmd"
+	[ -z "$RTEVAL_PKG" ] && RTEVAL_PKG="$PWD"
+	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
+	load_default_config
+}
+
+check() {
+	test_name=$0
+	tested_command=$1
+	expected_exitcode=${3:-0}
+	expected_output=$4
+	grep_flags=$5
+	# Simple check: run rteval with given arguments and test exit code.
+	# If TEST_COUNT is set, run the test. Otherwise, just count.
+	ctr=$(($ctr + 1))
+	if [ -n "$TEST_COUNT" ]
+	then
+		# Create a temporary directory to contain rteval output
+		tmpdir=$(mktemp -d)
+		pushd $tmpdir >/dev/null
+		cat <<< $rteval_config > rteval.conf
+		# Run rteval; in case of failure, include its output as comment
+		# in the test results.
+		result=$(PYTHONPATH="$RTEVAL_PKG" stdbuf -oL $TIMEOUT $PYTHON "$RTEVAL" $2 2>&1); exitcode=$?
+		# Test if the results matches if requested
+		if [ -n "$expected_output" ]
+		then
+			grep $grep_flags -E "$expected_output" <<< "$result" > /dev/null; grep_result=$?
+		else
+			grep_result=0
+		fi
+
+		# If expected exitcode is any, allow any exit code
+		[ "$expected_exitcode" == "any" ] && expected_exitcode=$exitcode
+
+		if [ $exitcode -eq $expected_exitcode ] && [ $grep_result -eq 0 ]
+		then
+			echo "ok $ctr - $1"
+		else
+			echo "not ok $ctr - $1"
+			# Add rtla output and exit code as comments in case of failure
+			[ -n "$expected_output" ] && [ $grep_result -ne 0 ] && \
+				printf "# Output match failed: \"%s\"\n" "$expected_output"
+			echo "$result" | col -b | while read line; do echo "# $line"; done
+			printf "#\n# exit code %s\n" $exitcode
+		fi
+
+		# Remove temporary directory
+		popd >/dev/null
+		rm -r $tmpdir
+	fi
+}
+
+set_timeout() {
+	TIMEOUT="timeout -v -k 15s $1"
+}
+
+unset_timeout() {
+	unset TIMEOUT
+}
+
+test_end() {
+	# If running without TEST_COUNT, tests are not actually run, just
+	# counted. In that case, re-run the test with the correct count.
+	[ -z "$TEST_COUNT" ] && TEST_COUNT=$ctr exec bash $0 || true
+}
+
+# Avoid any environmental discrepancies
+export LC_ALL=C
+unset_timeout
diff --git a/tests/e2e/loads.t b/tests/e2e/loads.t
new file mode 100644
index 0000000..2894b12
--- /dev/null
+++ b/tests/e2e/loads.t
@@ -0,0 +1,72 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source tests/e2e/engine.sh
+test_begin
+
+set_timeout 2m
+
+# stress-ng checks
+rteval_config="[rteval]
+duration:  60.0
+report_interval: 600
+
+[measurement]
+
+[loads]
+stressng:  module
+"
+
+check "stress-ng debug" \
+    "--onlyload -D -d 1" 0 '\[DEBUG\]'
+
+check "stress-ng command" \
+    "--onlyload -D -d 1 --stressng-option procfs --stressng-arg 1" 0 \
+    'starting with stress-ng --procfs 1 --taskset'
+
+check "stress-ng command, with --loads-cpulist" \
+    "--onlyload -D -d 1 --loads-cpulist=0-2 --stressng-option procfs --stressng-arg 1" 0 \
+    'starting with stress-ng --procfs 1 --taskset 0,1,2'
+
+check "stress-ng command, with --stressng-timeout" \
+    "--onlyload -D -d 1 --stressng-option procfs --stressng-arg 1 --stressng-timeout 2" 0 \
+    'starting with stress-ng --procfs 1 --timeout 2'
+
+# hackbench checks
+rteval_config="[rteval]
+duration:  60.0
+report_interval: 600
+
+[measurement]
+
+[loads]
+hackbench:  module
+"
+
+check "hackbench command" \
+    "--onlyload --hackbench-runlowmem=True -D -d 1" 0 \
+    "starting on node 0: args = ['taskset', '-c', '[0-9|,]+', 'hackbench', '-P', '-g', '42', '-l', '1000', '-s', '1000']"
+
+check "hackbench command, with --loads-cpulist" \
+    "--onlyload --hackbench-runlowmem=True --loads-cpulist=0-2 -D -d 1" 0 \
+    "starting on node 0: args = ['taskset', '-c', '0,1,2', 'hackbench', '-P', '-g', '42', '-l', '1000', '-s', '1000']"
+
+# kcompile checks
+rteval_config="[rteval]
+duration:  60.0
+report_interval: 600
+
+[measurement]
+
+[loads]
+kcompile:  module
+"
+
+check "kcompile command" \
+    "--onlyload -D -d 1" 0 \
+    'running on node 0: taskset -c [0-9|,]+ make O=.* -C .* -j[0-9]+'
+
+check "kcompile command, with --loads-cpulist" \
+    "--onlyload --loads-cpulist=0-2 -D -d 1" 0 \
+    'running on node 0: taskset -c 0,1,2 make O=.* -C .* -j6'
+
+test_end
diff --git a/tests/e2e/measurement.t b/tests/e2e/measurement.t
new file mode 100644
index 0000000..08069c9
--- /dev/null
+++ b/tests/e2e/measurement.t
@@ -0,0 +1,101 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source tests/e2e/engine.sh
+test_begin
+
+set_timeout 2m
+
+# cyclictest checks
+rteval_config="[rteval]
+duration:  60.0
+report_interval: 600
+
+[measurement]
+cyclictest: module
+
+[loads]
+"
+
+check "cyclictest debug" \
+  "--noload -D -d 1" 0 '\[DEBUG\]'
+
+check "cyclictest duration" \
+  "--noload -d 5" 0 "Run duration: 5.0 seconds"
+
+check "cyclictest command, no extra options" \
+  "--noload -d 1" 0 'Command: cyclictest -i100 -qmu -h 3500 -p95'
+
+check "cyclictest command, with --measurement-cpulist" \
+  "--noload -d 1 --measurement-cpulist=0-1" 0 \
+  'Command: cyclictest -i100 -qmu -h 3500 -p95 -t2 -a0-1'
+
+check "cyclictest command, with --measurement-run-on-isolcpus" \
+  "--noload -d 1 --measurement-run-on-isolcpus" 0 \
+  'Command: cyclictest -i100 -qmu -h 3500 -p95'
+
+check "cyclictest command, with --cyclictest-priority" \
+  "--noload -d 1 --cyclictest-priority=80" 0 \
+  'Command: cyclictest -i100 -qmu -h 3500 -p80'
+
+check "cyclictest command, with --cyclictest-interval" \
+  "--noload -d 1 --cyclictest-interval=1000" 0 \
+  'Command: cyclictest -i1000 -qmu -h 3500 -p95'
+
+check "cyclictest command, with --cyclictest-buckets" \
+  "--noload -d 1 --cyclictest-buckets=2000" 0 \
+  'Command: cyclictest -i100 -qmu -h 2000 -p95'
+
+check "cyclictest command, with --cyclictest-breaktrace" \
+  "--noload -d 1 --cyclictest-breaktrace=1" any \
+  'Command: cyclictest -i100 -qmu -h 3500 -p95 -t[0-9]+ -a[0-9|-]+ -b1 --tracemark'
+
+check "cyclictest command, with --cyclictest-threshold" \
+  "--noload -d 1 --cyclictest-threshold=1" any \
+  'Command: cyclictest -i100 -qmu -h 3500 -p95 -t[0-9]+ -a[0-9|-]+ -b1'
+
+# timerlat checks
+rteval_config="[rteval]
+duration:  60.0
+report_interval: 600
+
+[measurement]
+timerlat: module
+
+[loads]
+"
+
+check "timerlat debug" \
+  "--noload -D -d 1" 0 '\[DEBUG\]'
+
+check "timerlat duration" \
+  "--noload -d 5" 0 "Run duration: 5.0 seconds"
+
+check "timerlat command, with --measurement-cpulist" \
+  "--noload -d 1 --measurement-cpulist=0-1" 0 \
+  'Command: rtla timerlat hist -p100 -P f:95 -u -c0-1'
+
+check "timerlat command, with --measurement-run-on-isolcpus" \
+  "--noload -d 1 --measurement-run-on-isolcpus" 0 \
+  'Command: rtla timerlat hist -p100 -P f:95 -u'
+
+check "timerlat command, with --timerlat-interval" \
+  "--noload -d 1 --timerlat-interval 2000" 0 \
+  'Command: rtla timerlat hist -p2000 -P f:95'
+
+check "timerlat command, with --timerlat-priority" \
+  "--noload -d 1 --timerlat-priority 80" 0 \
+  'Command: rtla timerlat hist -p100 -P f:80 -u'
+
+check "timerlat command, with --timerlat-buckets" \
+  "--noload -d 1 --timerlat-buckets 4000" 0 \
+  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E4000'
+
+check "timerlat command, with --timerlat-stoptrace" \
+  "--noload -d 1 --timerlat-stoptrace 1" any \
+  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary -T1'
+
+check "timerlat command, with --timerlat-trace" \
+  "--noload -d 1 --timerlat-stoptrace 1 --timerlat-trace trace.txt" any \
+  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary -T1 -t=trace.txt'
+
+test_end
-- 
2.51.0

