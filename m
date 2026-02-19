Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D37328B48
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536094; cv=none; b=aEaYIsOTEk6e9rLPAnv96KZ9Xm3l1RHtVDI1UMOLMGIF1XDbPJHyulNYndvBf/UwlSsI3qPp2vlgfpu20wy3DK7tfAtVTb3lANUtyU778TR5FBVK3Uc6ET7cs9sKRYxndaWx4bvDu+Gz7p2ExLhA88flhJSFskcSyPtEY1yRx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536094; c=relaxed/simple;
	bh=9t3Q7CimZg1IAhRgGV4dtgTXJiju/8B2KOV9vVirEg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l30LdeZRFzYkOF7nA9s4AEuERF4sH2sX2QgTqpK3c0TMpjpRX7GgOWsbkghnmiVyIGZfBdoTnbmwvfr4KctI6hN0o1acc+HPlxdboneQHnEEgl7vBCxMYW8g3S5pkfOssuRLSRP4IEIYK7gVuUaLF4DHFD2hCgtnjeRb0iYEuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOBkcTK/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOBkcTK/"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3fb47559so129546685a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771536091; x=1772140891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hb6OWIwQ6G/Xp4iai7TXPSha01kibapEQ9AWovc+r1o=;
        b=XOBkcTK/6nMB58VP5/omAlokWkCSU8LSEBmDO22aZB+lIVgPbTGv72aIUaVuJBIxuy
         Dh1JXtQ4B3h7ilMYe118lab7VCiE+5Oic3N88zyD23Rcws17SwRWSKzuYI3EDUEbO4eq
         WoTokKacRuksXVnYpecJrOPJ/r1kwJ+ZNijHvlDNP0tC7zULhcWKyxfDwxBWsnSd0xdF
         B6uOfQbtZzxvAk6ePlmzHAxy0Nbx8tSKvNrnfEfi0vKMrlfwcwzDuwpZQ1MTu0ZxxwJL
         dEyyQ1luCmaifGpWxRV7n/Np90T7bit0oZFwjEQ48YUYZwnmW6OIZay4q3FZjUkwHXvU
         EG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771536091; x=1772140891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb6OWIwQ6G/Xp4iai7TXPSha01kibapEQ9AWovc+r1o=;
        b=GSLhrYsRGhb0+BaEEpuEMuTySZwhC/+d7nSwW5TaVpGQtpmC1AY3m1TvHSRCUWP8KA
         iIW2xfN0roIwgXm17pvh7kOz3UZh/+qKJSVJAOWGtOFA3NGj5g+EhKTbWy1vwNSof+mb
         MNKfoTvyqQpVagf2J2etSRtVp2Eg3UA3fohHlsoEDKsTBSULK1jozt9zj9dQTsnsjr3c
         kWuN8HRz9DE+aASPZQZbaYxYMuHV6AGn3PVHQ5eIuWqTw8AFwBX33h7QAHvikl6RK6t5
         jCaM1dd+Ey+pNEGoSuuHN6s5NKU/3sqtxbMcLHotRQJ8QCDdwyhsUHwS0ko7Co1/1f0C
         S7Yg==
X-Gm-Message-State: AOJu0YwA25h/es1ickRM1d0Z9cmabasaWKGLFYA6xEDoUUa+v+oGJHt4
	IJuJv42crLwCeA9jGECQvCafp9ydCaj3AU809FZHEyx11LPcmIIEu2h2WQEZIx0X
X-Gm-Gg: AZuq6aJkVOWfsUMRIjFDWUayftJTM6FaWz+sTdr52ZMwor+6JttkFoJFDJGaSxVnx2H
	H6Sm3v+ChjrA+uCk5jQ9mEB0HNygU08TfXXL5eogAyhE/qf5d1K3piTpC1cKDSfV41Q5PtKGpUt
	KhDtSDrPeFZhEDzbGNiYxEnWu/wp/mQ7CUL3WbZ79ChNxcB0ubwHPyvblEs5SyvauOzbueP8Bat
	FQLgJfgoloQWNz1UPf44QxH8WbDefB10aTQpiHUCUl9Shnls87OVMhUndzhrSjKmzOqArkI3ftO
	pbozMoqw1/yPmqrEQoj4Tob1x8PeanJmtBPbJq7AXNgACfo1AnR6QvsFG3Dg3AFUgltZg59aYFz
	0S4arSwenicUYY8fvQ880WGrvqlIN4kAJs8SkJcSAemUzgCcEFQ/LiAsDt9mwwMtwhbfb/3KrKf
	qCAC9ctZyo0SRVfGkiGCearW6i6SBE/IDqMoELeXqI5OdFcHLT9iuU0ToNeyiHU9VkaAddWpS+k
	FjPK988NjLHRltsLg==
X-Received: by 2002:a05:620a:4487:b0:8cb:4db3:f6f3 with SMTP id af79cd13be357-8cb79f5cc61mr479706585a.87.1771536091036;
        Thu, 19 Feb 2026 13:21:31 -0800 (PST)
Received: from Cumhall.redhat.com ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0be6besm2142975685a.5.2026.02.19.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:21:30 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	"Claude Sonnet 4.5" <noreply@anthropic.com>
Subject: [PATCH 4/5] hwlatdetect: Add bounds checking and improve code readability
Date: Thu, 19 Feb 2026 16:21:18 -0500
Message-ID: <20260219212120.227106-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add defensive checks to the Sample.__init__ method to prevent
IndexError on malformed trace input:

- Verify fields array has at least 8 elements
- Check cpu_field is non-empty before accessing first character
- Add comments explaining the two different trace formats
- Improve code readability by using a named variable for cpu_field

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 865f62196c26..38671724f3e3 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -257,8 +257,22 @@ class Tracer(Detector):
 
         def __init__(self, line):
             fields = line.split()
+            if len(fields) < 8:
+                raise ValueError(f"Unexpected trace format: {line}")
+
             kv = key_values(fields)
-            self.cpu = int(fields[1][1:-1]) if fields[1][0] == '[' else int(fields[1][:-5])
+
+            # Parse CPU number from either [NNN] or NNd.... format
+            cpu_field = fields[1]
+            if not cpu_field:
+                raise ValueError(f"Empty CPU field in: {line}")
+
+            if cpu_field[0] == '[':
+                # nolatency-format: [007]
+                self.cpu = int(cpu_field[1:-1])
+            else:
+                # latency-format: 13d....
+                self.cpu = int(cpu_field[:-5])
             i, o = fields[6].split('/')
             ts = fields[7][3:]
             self.timestamp = str(ts)
-- 
2.53.0

