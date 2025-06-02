Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581DA21B9C7
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Jun 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880241; cv=none; b=AqOY6tlHwNJd4Az8FY2U/SxdwS84cep3w8f5+DbNgNE3mJ9mpNiBkWbe9YkF62Z3HdAIvOx+QwHrNGisGpj3n4MiK0+ZM17tNYQczU94YK3UmzsBqdAW17ecQ2WTlTZ6pJe89PIJeRLApZX5Nec0KAhtGH8uziLqCXm7+sjtBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880241; c=relaxed/simple;
	bh=MpptbqVxTPGEKtJJCBQOqWr3tfy/91zxLq6eCOKEGHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q/uOYYXLgszZwTLBLs5L92j8BBueTIwdvRnI9PfxTMnSN4gqQMGwxR/VDRkqdZTHQ6lFkk2pXnSZcm6ghltdyG7q/cXpW3uYWP/myN6D20QR8DziPmelAXl9Gwf5QhT6UD3dQDhVkX5rmt5OHaUfvFl5py3EKoNGN9j79W6n+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso31303385e9.1
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Jun 2025 09:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748880237; x=1749485037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqgWWWG/pHW0f31fu8txN99SkcdkORO2mwMHQmbLICA=;
        b=fkFD7A2DbXDuAzXzH37r0HMmDZEQC/THxqvRA+UyB+c6EAl5exj3boAHW3/dkeQonL
         PlrPihSDv0orJS+Sgl19qH5t81YMd5Kni/5NzpE0JFIdOHnD2FiivSHiQ44jU0ElhEOX
         XBTF1U9ePoZbdgOGeLHI7ynQfJjGmChzyBF0Cp0KhjGhvlgYTmPi5aXhmw05Z4SgVzxg
         YtE8Pz+MD0YV2lQlgr4klS8CTv4qZljQU1o8Lgx/lab3tg7GCo8s83wyQTTuBZSAgQYv
         w175eLJLDTHcrs2FCgLK4n4AY0IDovSi4cQwvn2XstSrjVSO6z7HFvajtSpBjtjmZ2MV
         fZug==
X-Forwarded-Encrypted: i=1; AJvYcCVzfnxj7ygqRR1nOyoqIHtVBcnnV5yIRiUtnD7IMw6lxAQ6d9IadBUv+nEDe9Vf9V7x+dU5t6yjT2vWBIOt4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRtKHy3PbweZHO5z8kmJwnSNwCQM1ADzPk8dWDMfQ2794gOjLK
	XHG3gb7N3mBRB4q8Bz6en+1Zgrdf6HKyUSvCHPGoOuwuzS2nkghTMxiWkH5IZGxc
X-Gm-Gg: ASbGnct60KlCGNSOMPiE7wcfu1SJFfLgx5bfARflBlxQDjXM+j5HsngN42aG8D9NhIF
	u2HWSLjnnkKaY2CabfCS92SVU/xiw/YByudFFKNTNAZ1rwotPXRl15AkOslhLitW3t31JlCJxvc
	Yj7kmLgluZnPdFmr6ZLNHyWB0B41xVS7TH0u+w0SRf35SqJV05+nKbSOCYNf//2TSGtZjY7j36H
	KB2RRkiUdfIF+wO4Ujoa/N1O+Arxxr1fByh+MdzutI8e/uWNTPoIucne89EoSxvkoJkYfNGodz3
	DexunaiYccNJaLru9x9/1FnFdt72+sLBLnznqDEv1l1koWL3gUEnhanlNwLRQFw3gw==
X-Google-Smtp-Source: AGHT+IFp5UfULt2mMDw5zRfb2yQZr4RFWIZKxY4iA3y/qUGKu++aGcyZL08XDC09Y0SaBkPROhvrnA==
X-Received: by 2002:a05:600c:4e4f:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-450d880a7e1mr112909145e9.5.1748880237067;
        Mon, 02 Jun 2025 09:03:57 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa249esm132127835e9.13.2025.06.02.09.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:03:56 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2] rt-tests: hwlatdetect: Add a grouping separator to tracing_cpumask
Date: Mon,  2 Jun 2025 19:03:41 +0300
Message-ID: <20250602160342.2740857-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing values longer than 32 bits without a comma results in an error:

  echo 100000000 > /sys/kernel/debug/tracing/tracing_cpumask
  bash: echo: write error: Value too large for defined data type

The bitmap_pars() kernel function specification:
"Commas group hex digits into chunks.
Each chunk defines exactly 32 bits of the resultant bitmask.
No chunk may specify a value larger than 32 bits (%-EOVERFLOW)"

Add a comma as a grouping separator every 32 bits to a hexadecimal number,
as expected by the bitmap_pars() kernel function.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
Cnahges in v2:
- rebased

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index dc28f38b751a..946bef33748b 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -33,6 +33,11 @@ def info(istr):
         print(istr)
 
 
+def group_sep(hex):
+    """ Add a comma as a grouping separator every 32 bits to a hexadecimal number. """
+    return ','.join([hex[max(i - 8, 0):i] for i in range(len(hex), 0, -8)][::-1])
+
+
 #
 # Class used to manage mounting and umounting the debugfs
 # filesystem. Note that if an instance of this class mounts
@@ -494,7 +499,7 @@ def microseconds(sval):
             for i in range(l, r + 1):
                 cpumask |= (1 << i)
         debug(f"set tracing_cpumask to {cpumask:x}")
-        detect.set("cpumask", f"{cpumask:x}")
+        detect.set("cpumask", group_sep(f"{cpumask:x}"))
 
     info(f"hwlatdetect:  test duration {detect.testduration} seconds")
     info(f"   detector: {detect.type}")
-- 
2.48.1

