Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771983CCFA9
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Jun 2026 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780693627; cv=none; b=mwhT/AXbclMU+SweTOaPRgVBGT0oooTJR+7fBnf8Er8Us39uo+1tCIPJgnyZe59kdmnWqlXMjQkD/O3A3oQszyjeP0bsvE8ZVHu8fjENqOkvNaBR1A/jRBpk0/5f1QNMkmr+m990RqRS3Y7TR8XjotgZiYVtv2fYm5+sWET/eaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780693627; c=relaxed/simple;
	bh=1KObFRhlvaha2LDjjK7zu6CmEIHl8nL8t0gXat3OuM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/qmYqwhZlyzvl9ZqN1JSI9dMOHMtJjBqkQGDAuNKHHzCfQGXLvTiqijeZQb0rTBSsTbhfscCVZ4QeNNJECl5RayN3F0eFiNtX1nvbFdphJY6/9mbBlct+fTP1a6RZpDj287fPgEvXZSfhATiavURsetioHykQTqIyujRi6PHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/WzadN/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/WzadN/"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5175eab3a93so17922521cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Jun 2026 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780693625; x=1781298425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3uyaimPnj2HqSNmNNy6BRiszqBd9HeSZy9By+C1uZE=;
        b=N/WzadN/h+csM1kdmrrqLKzb8OPZOAgnDsYopaLhUArkxH+Q3rDNCmS9gOUoILwCtY
         3eIjXriViibPCMHBR3Zbbjq2qzYLrtsoU7XyHWuqwYkYmtmHtsBON1AzzBPrLblVRNZJ
         wZz85bwMDyRKO25nkBn/uWYbU+2pkMedQvwYsdm1pWaFb17OVAUqYu0GWR2ykE1MmfGC
         rQQwWn6yce6faeM5ZLjWKFmz0Zp8JutLU71i1nbbm7lhOypF25JhSygcxgXyDuKh184F
         iAweIH7dTiVuUAJdpeQvAjZoabllpypDFiWh1ZRSebRxOko816lWebbz6/jItpiVjHJW
         VNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780693625; x=1781298425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3uyaimPnj2HqSNmNNy6BRiszqBd9HeSZy9By+C1uZE=;
        b=ETpSDCC/b6zgtpbJG0Zd12cw3ZS2L89Y8RuUAt8ErT7xl90pv6AjrGsnZydQLtqx6K
         u02KFh8yUxNt5BkY1m0rQU3H08aDsaBI3DJT1KzLXttHl6IclNkubT+RkhXGTzG/soR6
         PhPGFuiGYhveg6TE+XDt8+5mwvOBOzKD3LMChjrf/a1E89u9V+64zp6KZJYpq0iyz+5x
         oEG2YJJPE9Zyh204oBNz699IJS7lRjlz3oCC8Rb4/ox5cbasqiP/QNzQ4wiKboepMuuh
         764QVXFOHHuri/GBVUfLdQWzgiWQqyc1Q2B3eD/hYhlIl0G+nqnTeN1A6LRGcQnOgBwv
         3YAA==
X-Gm-Message-State: AOJu0Yz/+keA52ZXWChtTH9Jc1qoI6QLn581w+izFtqySJ0jXvprYNxU
	v8A0S/m8u9ecm//SGS+op/GeC/UK66BLTXSA+fNF24K6MR1cvqEpRjkxR4e35Q==
X-Gm-Gg: Acq92OEbSqFHSj7aDgfEeFkBN7VNpFzRdMs8cQPh/BeNXoqzug4S3Zr87V816vkUsFl
	nh8u/VbgGfvAijImRUbPSnh5X3mn0mzaPV0Gd23ccyfO5fyXMNFdBESRUQq1mIfYMcN5ozhivM0
	PqOpqaB1qQSKb3JlrjC6+MLzkT6s1xzSimD2NamD71Dz2W7FSQiFWgEnNdPUf2aCaImp537oIQ0
	NgeK955+IKOVpeVhVJjDN+KWp/UK48wz4DXjDZCo1SFv5JtzcSC0nAf+vN/OgYvi3U+QNHzmVc7
	I5dgHkonSCWF3Ip8kQW4P49bOe2CHQQa6fvw7WSd1f/Crs/jAkPxngvCMUOMrgsIlmK6cSKpoBl
	CZ1wq3v9uDMKtu2Yk4PkrgJkj5F67HZLs5kdBk8x4dw+cPFuEr/TBDyf5KsTc30B7XXmjDh6JPF
	6OMFclOoSdsnNilLRd5E441+TCYwkJktWq8aU+j4wcTKhSdlx/Ovn1U1gC3U5wxTAuHat4sGLsf
	qMckbNJ/pyBXMoWF7bcyUoDzsg6FQ==
X-Received: by 2002:a05:622a:4296:b0:517:8aa7:4aaa with SMTP id d75a77b69052e-51795bcd7eemr83648011cf.39.1780693625486;
        Fri, 05 Jun 2026 14:07:05 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517a1be7421sm9201771cf.26.2026.06.05.14.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:07:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 2/2] rteval: timerlat: Improve handling of truncated histogram output
Date: Fri,  5 Jun 2026 17:06:48 -0400
Message-ID: <20260605210648.413231-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605210648.413231-1-jkacur@redhat.com>
References: <20260605210648.413231-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When timerlat is terminated with SIGINT during rteval shutdown, the
output buffer may not be fully flushed, resulting in an incomplete
final histogram line. This caused IndexError warnings when parsing.

Changes:
- Validate histogram lines have expected field count before parsing
  (1 index + numcores * 3 values) to skip incomplete lines early
- Downgrade parsing error from WARN to DEBUG since incomplete output
  is expected during normal process termination
- Calculate expected field count dynamically based on actual core count
  instead of using magic number 49

This eliminates confusing warnings during normal operation while still
catching unexpected parsing issues in debug logs.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index a3219e216296..7f592ea697af 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -480,6 +480,13 @@ class Timerlat(rtevalModulePrototype):
                     self._log(Log.DEBUG, f'timerlat: unexpected output: {line}')
                     continue
 
+                # Validate line has expected number of fields: 1 index + (cores * 3 values)
+                expected_fields = 1 + self.__numcores * 3
+                if len(vals) < expected_fields:
+                    self._log(Log.DEBUG, f'Skipping incomplete histogram line at bucket {index} '
+                              f'({len(vals)} fields, expected {expected_fields})')
+                    continue
+
                 for i, core in enumerate(self.__cpus):
                     # There might not be a count on every cpu if tracing invoked
                     try:
@@ -495,7 +502,8 @@ class Timerlat(rtevalModulePrototype):
                                                          int(vals[i*3+3]))
                     except (IndexError, ValueError) as e:
                         # Handle partial output from rtla (can happen on SIGINT during cleanup)
-                        self._log(Log.WARN, f"Error parsing timerlat bucket data for core {core}: {e}")
+                        self._log(Log.DEBUG, f"Skipping incomplete bucket data for core {core} "
+                                  f"(expected during process termination): {e}")
                         continue
 
                 # Generate statistics for each RunData object
-- 
2.54.0

