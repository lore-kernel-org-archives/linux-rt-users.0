Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353B2E401
	for <linux-rt-users@vger.kernel.org>; Fri,  3 Jan 2025 05:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735882444; cv=none; b=H94IYTu9hhhRFBVujvHl0wJrCpCWy1rEujvcBUzNYo1/jkFsjkCmx/yzvpi8lEva0aHfnPKsauBe4qae4+kXWDWlMu9XNVbZxNcxxGsJyb0/f0DMmW+HqIPtFG5icPa2Kdf3gf+H7FIQ9Z64ZCtM50BIed7EBh25ASVe70DAJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735882444; c=relaxed/simple;
	bh=rxpuz37uhq5vmVNcyDYQn15YCIvqNM9YxvdrLlNSBmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=js0BAbqOunwJbvRbPF7uyEK+xZXEJQOjcKKZYF0Qsy0rL1BjBv3qImCRSeAGL+szdImaRlZ/NPzcaP4zWSnPsNNlsBpTUZKtnhz1pHrZV1Hlb8oKY2W0od3Ajmm9WRzT9Svo/So7/XAnt5XiJ148mvjBEUW3YphRKL6/KiafqKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43618283d48so86680525e9.1
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Jan 2025 21:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735882441; x=1736487241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UWEruq9HWjezg2Xs8Mx4A75I0/vzzOx3KpALey9zZE=;
        b=l65qCf4k6W7PjUfmjdQ0a7pEs6MQP2u9Uo+Ukalx1rai0/Qi62upmXx7zq/axl7OUE
         /PKYF8GlSCBaGgpPbJKqOOeDbyb/bsBOAUF5zob8Fd6qgICwmejkqbqyrMek7y2M6+Zi
         I9rpPforv00tSQQhjT5Ztb5pGyN1+mokCpjMdMvYXyrOKvjHB7D1wUt7lUBDQdbHXRJX
         +UwES807s3E6FK5xJn+YQMo+4CkL3HW3eqwFf0r6ichZQVxThgUakO3y0woU4YlUFCjj
         xi4srqo++Az5jAg7t8xN97/wTuEHbQYoY08rMAy/X3q0kwK9wgWWwv/yeI8soXfLka0m
         xZXw==
X-Forwarded-Encrypted: i=1; AJvYcCUlGomePCEnb0H9aC0RNJTIGiTj4SeJhS3unAYRvpiCPYTmwjZVlF9g5Rwn9veCPBit5wl1PtgFwBsu+WZ06Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BqYznTlbRWzCztrRGcIFD0RblB6MUNGHxlgkQr7sPVRv2JTl
	Y4s0LIpNHIvIjF9qX0s0BLoGCSp+sJJcP7Pquszj3HaNcmuss0Mh
X-Gm-Gg: ASbGncuXWO4UBh8G84uiKvfjRyj36VhTAP4hs1gTloZuoDV1zI74r7HC+Nlm/wf94si
	dfUnzgpv8f4XDSm9QszxWRrRZaEeryG9bmFN8K8Wz54csJJPVlbf7LzFE379tdM4iqDcsHs692V
	ZTzlDAFQ4dVIPH7AK8j7x8tBaRWgQ2/BRxP9wDG42Jxqeasor3/gQvAD21DtwIZwnCxxW4eOcwU
	91rKMcomqQWv311FappBAnoLs1yRqZf/qAJKc0vIAiZVZ7/7F/DFuQ7gzxMIAqHDOrbZOg=
X-Google-Smtp-Source: AGHT+IHxqZ01TRthGix1fN1/OOHHbjcJ5YWbmeGWkB5gHP2mKio7htvARwd+aUNAdDRJHkhbwRiaSg==
X-Received: by 2002:a05:6000:704:b0:385:fd24:3303 with SMTP id ffacd0b85a97d-38a221687cbmr41100096f8f.0.1735882440852;
        Thu, 02 Jan 2025 21:34:00 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8ace0esm39223500f8f.106.2025.01.02.21.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 21:33:59 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Bart Wensley <bwensley@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH v1] rt-tests: hwlatdetect: Add a grouping separator to tracing_cpumask
Date: Fri,  3 Jan 2025 07:32:45 +0200
Message-ID: <20250103053244.3228028-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
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
 src/hwlatdetect/hwlatdetect.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 352abb6..87e4ee5 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -35,6 +35,11 @@ def info(istr):
         sys.stdout.flush()
 
 
+def group_sep(hex):
+    """ Add a comma as a grouping separator every 32 bits to a hexadecimal number. """
+    return ','.join([hex[max(i - 8, 0):i] for i in range(len(hex), 0, -8)][::-1])
+
+
 #
 # Class used to manage mounting and umounting the debugfs
 # filesystem. Note that if an instance of this class mounts
@@ -497,7 +502,7 @@ def microseconds(sval):
             for i in range(l, r + 1):
                 cpumask |= (1 << i)
         debug(f"set tracing_cpumask to {cpumask:x}")
-        detect.set("cpumask", f"{cpumask:x}")
+        detect.set("cpumask", group_sep(f"{cpumask:x}"))
 
     info(f"hwlatdetect:  test duration {detect.testduration} seconds")
     info(f"   detector: {detect.type}")
-- 
2.47.0

