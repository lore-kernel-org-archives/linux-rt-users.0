Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C013F1AB4
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152980; cv=none; b=MXpJblL8cSTEb1tozzCrqApXM0Ro0a0EHXp77A3HlAk+GH0JHgYOFeaLcvVbT3pXIsFhFqWVbj6JAZm1eYSdYS21bsHGagSoMHXF4IZ/c9uqqK0CkwcCEWYmwHW4JX021PZT8p7a6A7dTqz8l77hTKrBjPUXmYn9MKWjDdBtAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152980; c=relaxed/simple;
	bh=uru9kGIgNZR3cNt6CDitvp1/WeKSP7PrE0G975akCao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZVlxGEBR4BGxig0anMFC8uX+r8CixNKN4Bz6LK9BppQCWAhcTkl7phYXlD/raQRrJ+ZTXD5jVwNOljGKUmoPWRXih96GsiaGOrcmAm7YQmjQO+y7zKZFtMtOfOBbXMbIhBCF0OkmIlfafsqgUppBdgSJ3Vev9+9dN0VAnoXc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH3iEluR; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH3iEluR"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90e92b99ab9so8782006d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152969; x=1789757769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sEFiawXxHuKCKwDfYbHHPtZrl1SpYgTo9H6HX/SNxps=;
        b=jH3iEluRwynhdeuEx9LVEPXY6xfIh/FGkLLbPzgv5IL+4GX1tpU5l4VjIAw3R2W9fX
         3anr1JbZSvySX1f8xYV7ADB7C1wsR00XrWEcgJAPPnBX/cRx2EhPSVLg4yvu9/jcaSrj
         FAqkjSkABgf4naVj5WfPQpc89mfkO/L6TlxorIAOVb83if5kMgypZxlfIFXLL7hyosSr
         GINZFXwXD5LeF8DIKTnUnM3T5ZB4PusXnaGbLgn3yt7JZ0oLj1LVWh/wKHiLqLSC3b99
         kCuPusYC1HgMPOqSmjTyZICRQ7F65Kmjtvu6MRD7o2rXtS/v7mYvzrh1nyx5gIFFhtIU
         tkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152969; x=1789757769;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sEFiawXxHuKCKwDfYbHHPtZrl1SpYgTo9H6HX/SNxps=;
        b=d87aW+jspO1S5PyLFkp5iszlvJbHHTZDdd8etGB8Q9z2UaxvvHVDlsrO/iryES+3mF
         Rli1Ira9XxbthTdJeMlGN6H5Dga5FRjcWsNdhk7DriJp9otIFPztmpJ/5zRjnGvUEPL0
         dSATrfxp2DHzb/4iglPUyls4vdZ91wIxbXgIEKrYB0Mh52oDu6y9br3F/rXG/GCVCwcK
         KpgO0Vshv6HRagznMM6plVgMltbmWIvoqf9YH1WNrWADl3DjzsVDxD3JPfUZs/Hj0AHA
         6PrEcWWKd8LKq7Sl6UQu/P7AWVIJVx3OpCPuxG7WRJCDciXLT/D/cGhGqJlwswFGNmB9
         /+HQ==
X-Gm-Message-State: AFuF++mfdLYXcMdL5omqQ7qcfsi0B45PGaBWU1XevY/T5gF42uokpTc6
	ox82ylQaH+bFrLKZd8Ql9XZk2j3A728r55nyeyREqa1qiOWKAp0e2gi3Dq4jmA==
X-Gm-Gg: AYBFou08slCe0T3zFdTIT5uPCKcG0Q7xD9jjTFIKcIjAuCea38bAcoNEphO91Y9z5bm
	3ZvhsFNP6PpwbevWhoG2NY++zOCzBoLz7ZeQMJyaAQqLWHqMwzZYgQG/nFWgTbQb3DPpeUucj2l
	m7aYzdWnH3FPtnaT8sp5DIOOVCpftlS0DQeOA0dIJ3U5/KKJ8cYGnglAfmm7gESx4FD1ZU4XGhI
	diauoAY6rRTsefE/y2w2FHIUeqoIWFNQzti6/idQ/zr/Lh9XFIEycosojlxIl0/Kdb2sf5trK5w
	7fwJCoSW+GY94BTuOZHTS29rt2WpY5qz53UqHohCv4lY+QKyF6UtXURFK+NbGmJB0krPlbHAhMT
	diSQw+zJt3SXaZiGpMEhvGvRNl2Bqtw09d4tQVA3cq1vqgjhp3m7A7si4UigyNVKp/CHaKL/+G/
	wde5JnscVbL5XC1fkUPmVQCSd2L1zHJDrgYomqbx8GyJoRMQHPvlijfNeKsXzfl6TBRMfFDEMoN
	4GIwUYw6FJAV8bZmchmzRSumtPj6ULFNIh1JbbM32/WbIV0LKrbea/YxbgWJwHi
X-Received: by 2002:a05:6214:519b:b0:910:5967:c379 with SMTP id 6a1803df08f44-912120692b3mr76859256d6.4.1789152969171;
        Fri, 11 Sep 2026 11:56:09 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:08 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 04/10] rteval: Fix stale malformed-data log patterns in regression tests
Date: Fri, 11 Sep 2026 14:55:37 -0400
Message-ID: <20260911185549.604199-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911185549.604199-1-jkacur@redhat.com>
References: <20260911185549.604199-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The cyclictest and timerlat error-handling regression tests grepped the
run log for warning strings that the modules no longer emit:

- "Error parsing cyclictest bucket data" and "Error parsing timerlat
  bucket data" do not exist anywhere in the modules.
- When a bad value lands in a data column (rather than the row index),
  the modules log "Skipping incomplete bucket data ... (expected during
  process termination)" at DEBUG level, which none of the old patterns
  matched.

As a result the cyclictest test always reported the soft
"? No warnings about malformed data found", and the timerlat
mixed_corruption scenario could hard-fail because its "Mock rtla was
called" detection relied on a string that is never logged.

Update both tests to match the messages the modules actually emit
("Skipping incomplete bucket data", "Skipping incomplete histogram
line", "unexpected output", and the module-specific parse-error
messages), and reword the check to reflect that the module handles the
malformed data rather than warning about it.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .../test-cyclictest-error-handling.sh         | 19 +++++++++++-----
 .../test-timerlat-error-handling.sh           | 22 ++++++++++++++-----
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/tests/regression/test-cyclictest-error-handling.sh b/tests/regression/test-cyclictest-error-handling.sh
index a4903d2d34d8..436264111bdf 100755
--- a/tests/regression/test-cyclictest-error-handling.sh
+++ b/tests/regression/test-cyclictest-error-handling.sh
@@ -149,7 +149,10 @@ EOF
             ;;
         mixed_corruption)
             # This scenario exits 0 but produces bad data
-            if grep -q "Error parsing cyclictest bucket data" "$log_file"; then
+            if grep -q "Skipping incomplete bucket data" "$log_file" || \
+               grep -q "Skipping incomplete histogram line" "$log_file" || \
+               grep -q "unexpected output" "$log_file" || \
+               grep -q "Error parsing max latencies" "$log_file"; then
                 echo -e "${GREEN}✓ Mock cyclictest was called (parsing errors detected)${NC}"
                 mock_called=true
             fi
@@ -161,13 +164,19 @@ EOF
         result="FAIL"
     fi
 
-    # Check for warning about parsing errors
-    if grep -q "Error parsing cyclictest bucket data" "$log_file" || \
+    # Check that the module noticed and handled the malformed data. The
+    # messages vary by where the bad data is: a non-numeric bucket value is
+    # skipped ("Skipping incomplete bucket data"), a non-numeric row index is
+    # logged as "unexpected output", a short row as "Skipping incomplete
+    # histogram line", and a bad "# Max Latencies:" header as "Error parsing
+    # max latencies".
+    if grep -q "Skipping incomplete bucket data" "$log_file" || \
+       grep -q "Skipping incomplete histogram line" "$log_file" || \
        grep -q "Error parsing max latencies" "$log_file" || \
        grep -q "unexpected output" "$log_file"; then
-        echo -e "${GREEN}✓ Logged warnings about malformed data${NC}"
+        echo -e "${GREEN}✓ Logged handling of malformed data${NC}"
     else
-        echo -e "${YELLOW}? No warnings about malformed data found${NC}"
+        echo -e "${YELLOW}? No handling of malformed data found${NC}"
     fi
 
     # Check for SIGINT handling (if applicable)
diff --git a/tests/regression/test-timerlat-error-handling.sh b/tests/regression/test-timerlat-error-handling.sh
index 06d7c4b87d24..9883608669bf 100755
--- a/tests/regression/test-timerlat-error-handling.sh
+++ b/tests/regression/test-timerlat-error-handling.sh
@@ -153,7 +153,10 @@ EOF
             ;;
         mixed_corruption)
             # This scenario exits 0 but produces bad data
-            if grep -q "Error parsing timerlat bucket data" "$log_file"; then
+            if grep -q "Skipping incomplete bucket data" "$log_file" || \
+               grep -q "Skipping incomplete histogram line" "$log_file" || \
+               grep -q "unexpected output" "$log_file" || \
+               grep -q "Error parsing timerlat output" "$log_file"; then
                 echo -e "${GREEN}✓ Mock rtla was called (parsing errors detected)${NC}"
                 mock_called=true
             fi
@@ -165,12 +168,19 @@ EOF
         result="FAIL"
     fi
 
-    # Check for warning about parsing errors
-    if grep -q "Error parsing timerlat bucket data" "$log_file" || \
-       grep -q "unexpected output" "$log_file"; then
-        echo -e "${GREEN}✓ Logged warnings about malformed data${NC}"
+    # Check that the module noticed and handled the malformed data. The
+    # messages vary by where the bad data is: a non-numeric bucket value is
+    # skipped ("Skipping incomplete bucket data"), a non-numeric row index is
+    # logged as "unexpected output", a short row as "Skipping incomplete
+    # histogram line", and a wholesale parse failure as "Error parsing timerlat
+    # output".
+    if grep -q "Skipping incomplete bucket data" "$log_file" || \
+       grep -q "Skipping incomplete histogram line" "$log_file" || \
+       grep -q "unexpected output" "$log_file" || \
+       grep -q "Error parsing timerlat output" "$log_file"; then
+        echo -e "${GREEN}✓ Logged handling of malformed data${NC}"
     else
-        echo -e "${YELLOW}? No warnings about malformed data found${NC}"
+        echo -e "${YELLOW}? No handling of malformed data found${NC}"
     fi
 
     # Check for SIGINT handling (if applicable)
-- 
2.55.0

