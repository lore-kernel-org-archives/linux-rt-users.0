Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12C1ACEA6
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Jun 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345448; cv=none; b=P43fYmF36nuwkBMieR849p5tLkc3Xxga8V0f07ZD8AkS2o544rLHLFLoXO/j7dNbaiV876b1++cIBGKDCzKCuRkeOCT0yJUKybQ1gUzWy4MwEVNDDr5rnN3mvQXuB1ES00TlqXYkREE0A3ud0Hbr+zqIGb72TXvRurU4ouDNLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345448; c=relaxed/simple;
	bh=qCZ7A9j2+IFURQd6vW2zSWJOQ/V84OZ/Ie+U4pfijRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDJwNDVk8YfwCrsZ7QB8LTzv7AGsA4YGJyeEXbhrxr2HPCDWH114XfcmJpWOADkC/u8uETvFSOpHnjmQL3WUKB0Os6+37mfnZk4Pph/3N6mT/u1YgBlCDpEYjBBTtqMGkU3CFpxqQlYTJs7BOHAsJjCgj9n/up/jSKXCqyL1LyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so560036f8f.0
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jun 2025 08:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750345445; x=1750950245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odnpmaVs0hna/ddceXfA6Xlsag/wWDKf9XOXzxZn4+s=;
        b=viRjyK1DkQ5G5TDiADD9WgOpNagFScuVjdXcXa6f1iyj/jdW67yTB7q46C3gKDGIQz
         Sb71Vl/z4Qntmy1ms3V1REu/Hovq1DAu77GUX0/TVWas0cnrDL//R6sgaYEYPH7vGYxt
         GvSS5XgHLQOIBkdXadNgR0e69akdy92HZmFsgYTeb9icdQuI9t9J6wq+pKphOhLc896X
         X0NREXzvY9ikmAIioM1CRXJLU0mbesq0jKMi0O1fXRqT9DEEGhcL4LVu0bePkrjt+C8O
         P8j+vW+j1vp3317IIJ0hq0I5/Low5qfaHWxkXlw1ZiojAKESWaFNXlmrdBS7pYwKrbvf
         uoag==
X-Forwarded-Encrypted: i=1; AJvYcCWWgd7TvVJBL+xdjryqYEVsETg7wbi16pn8p8jZJH6w/b/rVS6KnVu52SYS9GW9s7i7t7LCeDYp5CHMPGinGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyAEOnAOeCSZnElgpj79+r/p1TAwsTPro5wkvLqduqPzUnfBt
	XVnY3C7vHGBmI5OfwTjfgiD32KqYMp9jq9jIKs5MaYqek5SGk/absYiWf8GhO2TR
X-Gm-Gg: ASbGnctkUTs1Cqh0dJtJuBlYDHLzudgpiFPsT+zhKYfnXrES6nKLRAuT+BMJMcQWJIG
	RO2LDZM/93UYPVzDrr9gdwdcqgiCopYdgwt7II5i6XEYHP1vrCpQemp0EXFrmLjJRalxm5mYTlQ
	N2JP2HXU7sAgfA6hvNo3QU+KK5vPhOSnoNaREQqVu1hDAxH9eqyYXmhpo1V85xqKTRzJfqHni2N
	3b8btAEY/VrsFxgivH9vnsc0fJByJa7sZbDDHNvWescfFrSccgP5q31si5irJDaXBzG1L7VDSCU
	YXZfDP0GmxSFUyxJhmGrbwY0zZBEXWsQbOO4PMe8i/teb7kY3mTmhKQGF+faomF2GWXxGN56Zve
	SvR4=
X-Google-Smtp-Source: AGHT+IEYM8uFXbuiT6qtBH5R22eorGIOwsfcuQo11ob6cA3O5P+SXdB/m4fFJ+F8uDMdya4QlJAtCQ==
X-Received: by 2002:a05:6000:1448:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3a6c9693a22mr2742625f8f.5.1750345443413;
        Thu, 19 Jun 2025 08:04:03 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b2371bsm19862046f8f.70.2025.06.19.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:04:02 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v3] rt-tests: hwlatdetect: Add a grouping separator to tracing_cpumask
Date: Thu, 19 Jun 2025 18:03:31 +0300
Message-ID: <20250619150331.989973-1-costa.shul@redhat.com>
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
Changes in v3:
- rename hex to num_hex
Changes in v2:
- rebased

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index dc28f38b751a..68f312db639f 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -33,6 +33,11 @@ def info(istr):
         print(istr)
 
 
+def group_sep(num_hex):
+    """ Add a comma as a grouping separator every 32 bits to a hexadecimal number. """
+    return ','.join([num_hex[max(i - 8, 0):i] for i in range(len(num_hex), 0, -8)][::-1])
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

