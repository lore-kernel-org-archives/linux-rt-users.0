Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37840860D
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152980; cv=none; b=AHgDnsAx6nZmjzNVhom9AtHOP5749sxMCoqCvjr6ocWbFbQPpKN1twVzdhyE3BPW4q8LjU+2ZpUTPXxYRhJwVlx/vSr0XrwKZ/oNth2MNGPH4TXGs0Dxxbm3vL39pdt9pqkgeexOeiGhLG0ReWGLfmZnBUFrJ0ugNRdWhHEVVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152980; c=relaxed/simple;
	bh=2QFsykLcSsKdy8r9j4glov7D15teSYN3SIkoVtT3Ffs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkdMiWvjwl1s2i1nFUv5UjhGOPFJlphEJ7aaB1aSvS0ix/lwxEP7GL6I6suTIR3L+5n1roXW9zwPRnEs15HfqFYjbMRnHrReakn8xjr9iwhV6GJQ26tyYJrFpV4KjUBG2hh2Aj4ogeHQHVGZrIi59sTdodOiD31mMm16ULSS9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCZL3tkp; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCZL3tkp"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90ceab90152so10692956d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152968; x=1789757768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWDRhBnaEqfLtKXiwkCmk6lUiZa6djXk1vZN1uPKhL0=;
        b=YCZL3tkp6knkdj0L0dVciJ/TjMhgkB+B2a9JN4+ZWppTFpZCRr28myonzWAb0sfUDg
         tXGaT/lgDIJOxWsffBnki2JJZlohuHFUpCuSSaiKW1Li9Z3qbFU86+igfEhV8MzKL2cj
         LvL8MdLDbzPaA4rlGYtB6wxqC4BWR0KMFH7DKgfeX2IXDJu948MZz60dHuaSi+JWbImT
         hFYTj4+dRR25p/lnkvIeLgf6LSQTpgmF6iqcFRihlnypRGI81Ne8Em04D9H/avM8yynq
         NV8kxIJ69mQ8NUADVXc81J0KSxIpZvqxWUXIlb/XPjlQzRc5HYFWwKx1inuLrXfEA2cn
         E/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152968; x=1789757768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWDRhBnaEqfLtKXiwkCmk6lUiZa6djXk1vZN1uPKhL0=;
        b=YemQoSgkf4PkXLRoL+uh1IVboWP9rYvhDTKGgx8ilgbo1dlWK7xS8/fpk8yx+DnJ3j
         DPSmxdMy4MUtLGpi8+QRaWu4d9kTnMciZbkFGZIpHMeGC5g5bVdUBnZJb+Bzm0oDervV
         xK7vdClzih7yYgWNKjtfrM2qKimgK9iDRR3AFEoMT1LHaQT1LzyhWip2crOVxQIeVg/d
         Sz9MeSdwqzzG2nJLgn2+bj8wfcdT1GSdxjJHGufLZgkvJaN37p1iy/HLLT+nvEyT0+mJ
         L7sJ7tdJvNqHVfGtVMBJl07XCxJTIFKzW2GdWHMU2MW9bScdEOjT1RemtXZHpaEE8Rfd
         7Bzw==
X-Gm-Message-State: AFuF++kH8INl7jx7TQpkP0Tjc7+LBKtWp+CJAJJIMV1lBqLshGYSUoAX
	i2t6o1Cx+37SNfPgWiMIeMBWNNQ4hJgjo+hZWMnhEosGQ5tidECSiPTTqCyAVA==
X-Gm-Gg: AYBFou1LLySH/VQb+2zduL98V7RyX47gT66kN/G3WmxVl09WLarcvPLIMlNdsVE802B
	8vovWkou16kB4a49fTHdsjYXLZJy0EDBZE+bg0WQJT3w3+yZ8s58uN1TJZwsfS8Tuzf+pQUIteE
	kvyFes1Gl5CXl/ONc+NR5DoYazPcqMWbQIaD4P7lNKO/xIuw8CiWlvA6kd3Ft+YuT9fNoQKnWBj
	hKHhZXg+kYIHMdsfLUwaGuN8Y0NBhWzowdapT72egiiTCWH2CTMk0Dflv5X5/DQzu8B9UzDioI6
	1AJufHMh3X7oNQ1qOYQzxT0UK2Jve5zlKXv6tWtn/1KqGaWI8cJ/EE2rLh2Smw2FMg+yN32bNT6
	23pKCRRDzCcbgAfe0Y7H4QGbJoWaX+lrHImc+LVUo9RFFqlIHm2mzeQEPhmAN496fn/aToffCwB
	xm6H+yVJ7bZ9W1fsByHs9F+PGpyM2px/NZ4vv1pCtVXXjcdP/Vh75VyALKNm5vcLxZdiGCsxL2P
	A8cG07Ee7fJZrN+JPDFBVhjhDUkhzPYqweTgFDhEkOhOpY0Ed6fFnOyFaLAncAD
X-Received: by 2002:ad4:5e8b:0:b0:910:63f9:29f9 with SMTP id 6a1803df08f44-91212086712mr72338576d6.10.1789152968212;
        Fri, 11 Sep 2026 11:56:08 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:07 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 03/10] rteval: Make the unit test harness fail on test failures
Date: Fri, 11 Sep 2026 14:55:36 -0400
Message-ID: <20260911185549.604199-4-jkacur@redhat.com>
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

The legacy unit test harness (tests/unittest-legacy.py) never called
sys.exit(), so it always returned success even when a module failed to
import or its unit_test() returned a non-zero result. As a consequence
tests/run_tests.sh counted it as PASSED regardless of the actual outcome,
hiding real failures.

Make the harness exit non-zero when any module fails to import, fails its
test, or is missing a unit_test() function, so callers can detect
failures.

Some unit tests (for example the DMI sysinfo test) require root
privileges, which is how rteval itself is normally run. Rather than
distinguishing skipped-from-failed, simply require root to run the unit
tests: add a root check to tests/run_tests.sh that refuses to run with a
clear message otherwise, and note the requirement in the Makefile help.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                 | 4 ++--
 tests/run_tests.sh       | 8 ++++++++
 tests/unittest-legacy.py | 6 ++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ae033e7d73d1..fd2f68cbda5f 100644
--- a/Makefile
+++ b/Makefile
@@ -145,8 +145,8 @@ help:
 	@echo ""
 	@echo "        help:             show this help message [default]"
 	@echo "        runit:            do a short testrun locally"
-	@echo "        tests:            run unit tests (alias for unit-tests)"
-	@echo "        unit-tests:       run unit tests"
+	@echo "        tests:            run unit tests (alias for unit-tests) (requires root)"
+	@echo "        unit-tests:       run unit tests (requires root)"
 	@echo "        mcp-tests:        run MCP server tests (requires rteval result files)"
 	@echo "        test-all:         run ALL tests including root-required tests (requires root)"
 	@echo "        e2e-tests:        run end-to-end tests"
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index 2dbf9f9effb6..c241ddc11adf 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -15,6 +15,14 @@ GREEN='\033[0;32m'
 YELLOW='\033[1;33m'
 NC='\033[0m' # No Color
 
+# Some unit tests (e.g. the DMI sysinfo test) require root privileges,
+# which matches how rteval itself is normally run.
+if [ "$(id -u)" != "0" ]; then
+    echo -e "${RED}ERROR: unit tests must be run as root${NC}"
+    echo "Usage: sudo make tests   (or: sudo make unit-tests)"
+    exit 1
+fi
+
 # Get the directory where this script is located (tests/)
 SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
 # Change to repository root (parent of tests/)
diff --git a/tests/unittest-legacy.py b/tests/unittest-legacy.py
index 9e5ba3d0e831..1a92c6515770 100644
--- a/tests/unittest-legacy.py
+++ b/tests/unittest-legacy.py
@@ -118,3 +118,9 @@ if __name__ == '__main__':
     tests.RunTests()
     tests.PrintTestSummary()
 
+    # Exit non-zero if any module failed to import, failed its test, or was
+    # missing a unit_test() function, so the caller can detect failures.
+    if tests.mod_impfail or tests.mod_testfail or tests.mod_testmiss:
+        sys.exit(1)
+    sys.exit(0)
+
-- 
2.55.0

