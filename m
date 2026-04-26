Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAE2010EE
	for <linux-rt-users@vger.kernel.org>; Sun, 26 Apr 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777212151; cv=none; b=WNy6ptLYr+fHLgukCL9GK2VLACgtxobQnURwNzQoSGlEaytHC2Bv16l9+1NzVQYQvr4/agWJpnd8arK6QUo85hc2cZr7gkLtGuj1UAHnGLudeevmFZyv4MHMBhTTTDjDyvsnhY5tWKcgPgw/83v+R9CDRdQ7YRiFblIlmMep/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777212151; c=relaxed/simple;
	bh=H16DegzFLaEPM0dlO00CtR7880pjGu0oC+r5LJvVXIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2o43ZcFv/W7MCSGJ827y134fjgRtZPssF967pBm0P8fr+maTiI/2k7usgSgh4w4RZJW3sV6TURe/McUMMTRL3qfQ9CW3b+GVJtXGUHqfaKdI2qrtPVU5wbfy1yE9haczm6L3/+5ASiQ5OfycCDZefMsnT6iJEZ2uR2OG8JHq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBUU0Je8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kHLMbR+z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBUU0Je8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kHLMbR+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777212148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4L278AyhJEMZPaor606NFUXZ/PUgTt4iWVq8k1Mkw2w=;
	b=PBUU0Je89y9Me5TRUu2ebzYAHpblEQeeFBDQ7mnXmWRlxmUgf7y7x3QiYoW5UksWOzg3t7
	/5NlXBayRUFvOvPqKyXvOy7IaifaE9N0eq4HFPBDIUOQTO/hd37Taxq+NSL9OiZw7wodGZ
	y2M+oghizd5FN1yDooufSFVFbZ3vPao=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-sUS_pQorNiuBWJk1TOkKug-1; Sun, 26 Apr 2026 10:02:27 -0400
X-MC-Unique: sUS_pQorNiuBWJk1TOkKug-1
X-Mimecast-MFC-AGG-ID: sUS_pQorNiuBWJk1TOkKug_1777212146
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b4654f9bb6so96932135ad.2
        for <linux-rt-users@vger.kernel.org>; Sun, 26 Apr 2026 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777212146; x=1777816946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4L278AyhJEMZPaor606NFUXZ/PUgTt4iWVq8k1Mkw2w=;
        b=kHLMbR+zr1wMp2xhLpO+lcJvAfDGMJAKx8Me4BraiIpyOOrq6wBR4PKh9shhIaZ3BE
         O8PXkv9JFnoeqA8xOHQQ5t6QjcLIwb38Ty81WoGHtH3wZOwYmXsGBaDbhRpAN0jicIXB
         QryRJ2AYgJCHfbikdA6EAa+6ylB1HbQOXo6TFCaJ6zdnYBj+W101iZCwVEpRS870gDdX
         RixEUR50cEYIr9r8oNKaxCwT0/BOA27mAHBIkfDApECx6n7HOomWVycbMbLiM/F8q8Bq
         /5L00mH5Fm/15eA+3JR34iqdFMJuUXLJpX35U5Gs+V+dN6KPAb+EcsMCY/kefczj5lp2
         6DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777212146; x=1777816946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4L278AyhJEMZPaor606NFUXZ/PUgTt4iWVq8k1Mkw2w=;
        b=dG/EpxV3pmDOBMLEVZHQ/tStBkh/Z61XUoDYqZb3qLGPd6Ze1VZYL3ILPSf8/iyj5B
         qSaytXtxzpzsq4uuDEKla04TEaLnXeGI/3tA9Sfm0m6JNaZe4lJWLJQhlGGYaC51tYZJ
         hEecZ/scr/qH+5EQcLI7tETy9O/NO0Ut4nEHxb6lB5W9J+f8rncCcDF5mJc4y8o1VzOu
         xC2zQ0IsYcqLlEfQc3pR6NUUZmRzI6lUT5UwU9gKvWloZMJr/QTaSAsUJsDfHRCPpovI
         yc5i0sxA3E9P4yc7AQtvJqfnd2FE4J+O7de+4z+dKKgLV+IESicx2Cua7BgWMrVj11t8
         jpRw==
X-Gm-Message-State: AOJu0YxqXqe1BH201KBrvjTwAdZxdR+jLEXFwWaCtKir6vxQG/ikUl/u
	j7yktNtrW5HVTeglMa590RpFBwL7UDxn/fpF3tgdc8OgPhGUWahz0lZ6Rv4JDy1KsS2oxC7Yl/I
	vpLWWivtJxrNseX8xGnc8rM5Xg38X2YVs/WwI/WWce6A8Iq7nzTi3M4iSCn0w4MCDb/ff/4kNCq
	6P1CxzHZi7LXOeVdXRZf7/CWBVOhcfxTHUGXpa39uRQwaEILDL0yUNgc4=
X-Gm-Gg: AeBDievzjdr9AZsGG1FJZGNqWOaoCXPeWd8ToDAbOMCdTDJQzJ3C40f+oDl5L6/E3sO
	3JOn88hsnx7d/enaZyEh90jWQ5FoO1VDdLPp/vj3BwB6uiDhmcFg0u/IxZqvNPGxR6kFazQIlgN
	KOa9TmKksw56S4U3UJZqbvDIJmwhCefGiIUXwBeHQX+7lOFazd4bB6MLcGi9XsANkE7gz7dqRkC
	OR+5w2nhCbTBtg5cn9by+p4oopWWQR7VHxcfMHynKBRbdSCWGmOzW6BwKu63ZFY8ekqJVslZXpx
	oxcv/4pZhEgg0rxqcAVkBl/HzZhcgAxzEvpE8D+d8UBK3O67HN473avNi7NZzBEyD7dgJ/eUp/m
	wfBA+YKzsUwKFHzQFax/HyJLJmrUmeVFeBfnNpaMje7qdkacT
X-Received: by 2002:a17:902:cf08:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2b5f9eaf621mr422331035ad.11.1777212145403;
        Sun, 26 Apr 2026 07:02:25 -0700 (PDT)
X-Received: by 2002:a17:902:cf08:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2b5f9eaf621mr422330785ad.11.1777212144825;
        Sun, 26 Apr 2026 07:02:24 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caf1sm294160525ad.42.2026.04.26.07.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:02:24 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v2] rt-tests: hwlatdetect: Add --time-format argument
Date: Sun, 26 Apr 2026 17:01:15 +0300
Message-ID: <20260426140115.3111177-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add --time-format argument to customize timestamp output format using
strftime directives. By default raw timestamps are output for backward
compatibility.

Add %n directive processing for nanoseconds (9 digits) since strftime
doesn't support it.

Truncate nanoseconds to 6 digits before float conversion to avoid
rounding collision.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
v2:
- Use global args instead of class variable for time_format
Address John Kacur's review comments:
- Handle timestamps without decimal point in format_timestamp()
- Refactor time_format
- Fix misleading docstring about float precision
---
 src/hwlatdetect/hwlatdetect.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 18ca930487f0..ee1e0171210d 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -14,11 +14,13 @@
 import subprocess
 import sys
 import time
+from datetime import datetime
 
 version = "0.8"
 debugging = False
 quiet = False
 watch = False
+args = None
 
 
 def debug(dstr):
@@ -284,8 +286,18 @@         def __init__(self, line):
             self.outer = int(o)
             self.count = int(kv["count"]) if "count" in kv else None
 
+        def format_timestamp(self):
+            """Format timestamp with %n (nanoseconds) support."""
+            if not args.time_format:
+                return self.timestamp
+            p = self.timestamp.split('.')
+            ns = p[1] if len(p) > 1 else '0' * 9
+            t = datetime.fromtimestamp(float(f"{p[0]}.{ns[:6]}"))
+            return t.strftime(args.time_format.replace('%n', ns))
+
         def __str__(self):
-            s = f"ts: {self.timestamp}, delta:{self.delta:.6f}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
+            s = f"ts: {self.format_timestamp()}"
+            s += f", delta:{self.delta:.6f}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
             return s if self.count is None else s + f", count:{self.count}"
 
         def display(self):
@@ -472,6 +484,9 @@     def cleanup(self):
                         dest="watch",
                         help="print sample data to stdout as it arrives")
 
+    parser.add_argument("--time-format",
+                        help="strftime format for timestamps (e.g. %%H:%%M:%%S.%%n)")
+
     args = parser.parse_args()
 
     # need these before creating detector instance
-- 
2.53.0

