Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF9215181
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Apr 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744237442; cv=none; b=H0ZKgahyZF/7w2demKKq2VCM/pR5uDqMiWrKi0HEp4C9gYK8DDOaoUalcvSaKrW7XV+H5JU0TXTj2rGCZUs+tdwAQvD+MBIOKr7l+lDfD8oE/rktKBJpapYgTOiHZdCH/s/zT2KiklacQG14i7q5lv4wJrGapDDdkuVAUjEhqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744237442; c=relaxed/simple;
	bh=XdETCTV4tj2Yuqqe/8N6qgJ3AtrHdXsiOZ7k8FgeGh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCf44aKgOjB8wupokWvCeLmW+sXqh0MV2gXSHAR+FUhXchKqPFyfaI+quuHCxTWZWF8WC6eMu/xxZ8FnEFwYGtYdBjZYXkCBZkE2FSlg/+bYxCD1/AKJE8m1tBVlhM9q89ppUgmojqQnWMzCvtScrFCu8w0xImcHQhmnhMH0uMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZTOglSm; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZTOglSm"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ed16ce246bso690386d6.3
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Apr 2025 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744237440; x=1744842240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lpjXP9m98gEKKB1XoxiU2wfyFLDgzfrhYMw/vqMSVXI=;
        b=dZTOglSmQ52QbU93Leq5rOfIO+0kpX0XRmyh4wJPz6hsZtYDIUYBVCAlh1TvUVKI9z
         agPxV3JWb9Y8g2/YGHK8GZ9RCJvtM1Cwy9VUkp3MYBMoB7nf8DNjoZybFJN9M/J17WCP
         2WpeuteuJzQmfpFB+OOFBpgzhISD51VK8+aemkveleJ2H8PjuqObT6ypoLTup1svGnp4
         mRTRQUSFLkNZxQylg+5H/sUt/0diF+/ejhB6KnJM2TWZf9g932GYABayxtUjrkvZQhEg
         uM3x9ffzW7yxKzM8XFvbHE+HHJHQQUBg3SOYeBgmFIUgRx6PdWnPFEo+O6E/UF2hdW2S
         ig2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744237440; x=1744842240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpjXP9m98gEKKB1XoxiU2wfyFLDgzfrhYMw/vqMSVXI=;
        b=l/Gi5ULueLzxZBgbtYuFvGjv/kTGa9luWuW7OGKdOKOYKy4xthtkX0mkRODHRCT2Is
         cgMLc8hz6h3V1vFBLGWDTvUlVsnjdXWgKNVdzy3fxsb58jWKLoHHwllcevKZDuQOjgzw
         Tl2z7LMKDX8Jj/N3a63VR5kPuoHFOSSCyRcOhJW6ypxONo/b2ghyzwLYOjFpngvaBiFO
         +fJoQRQeRM1XRJzDnFS9YNY9F3HqEriLzquTQ7sfF7pEhw9j0WCqOJ0ALNgiMSUuvwo7
         dPtxHBnzcyU2HTVjyT8tONE4n1FozzNqlvXFFLUU7SzIR9+AA8ZD+RkohJdvI/SeTSX2
         xagw==
X-Gm-Message-State: AOJu0YzijgNIMV1LEpx9ctBOt+O22VgscQ7y079nUKTOwqrIIWrjrlOn
	3MkZ81pbBkTSW0Msr8ylAIJzgai/itctgz7F1EqvJ9NqzvqX8T0r
X-Gm-Gg: ASbGncu0pLiRNBjqMG2g43dT8q/ua3XgsyzmvMmZXsvHx4PKZlqyOjDmKr/GQPcfQxB
	dYB9MmbHlGVZxwSS5tH7AOtzX8JnTbGpXiyGuO44mn194m+re0jyKksgd3sJc2TOq7rfcVqYKZD
	QpJE3h7Ei+I9/SLWZeQ6sQs5knttXiNWWbTZkQfjc13+x1tmYqC12s2JuYtJDTOJVYO8Dv6TJ45
	LUMqpXnwxLC1N2ppunmVz9HkRSK0l0iY0nBmJYX7oTe1/5/J2uPHPiL704uv+lZP49uo3yFckyV
	R4q/ftBuXFWfhi+E/4yi/8BBCEtc9AdsrXdMR+quuUg13w==
X-Google-Smtp-Source: AGHT+IFLTjNleqKYsJRTwPrPuvBeadsHY9neDxnhWWQBIoHq/D2pLxoq613fYBO6h4RhYsoqcGSLYQ==
X-Received: by 2002:ad4:576d:0:b0:6ed:1651:e8c1 with SMTP id 6a1803df08f44-6f0e5a29e65mr10330236d6.13.1744237440152;
        Wed, 09 Apr 2025 15:24:00 -0700 (PDT)
Received: from fionn.redhat.com ([142.189.102.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a11c9fbdsm123346485a.80.2025.04.09.15.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 15:23:59 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: "John B . Wyatt IV" <jwyatt@redhat.com>,
	"John B . Wyatt IV" <sageofredondo@gmail.com>
Cc: RT <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] tuna: utils: A few tweaks
Date: Wed,  9 Apr 2025 18:23:39 -0400
Message-ID: <20250409222339.65940-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Change copyright to 2025
- Use is not None instead of !=
- Add a few document strings

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna/utils.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tuna/utils.py b/tuna/utils.py
index f55432dbbbb0..75900bde3d51 100644
--- a/tuna/utils.py
+++ b/tuna/utils.py
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# Copyright (C) 2024 John B. Wyatt IV
+# Copyright (C) 2025 John B. Wyatt IV
+""" Module to return cpus and nics """
 
 import os
-
 import tuna.new_eth as ethtool
 
 # Collect a few globals and functions so they can be reused in other modules
@@ -12,17 +12,19 @@ nics = None
 def get_nr_cpus():
     """ Get all cpus including disabled cpus """
     global nr_cpus
-    if nr_cpus != None:
+    if nr_cpus is not None:
         return nr_cpus
     nr_cpus = os.sysconf('SC_NPROCESSORS_CONF')
     return nr_cpus
 
 def get_all_cpu_list():
+    """ Return a list of all cpus """
     return list(range(get_nr_cpus()))
 
 def get_nics():
+    """ Return a list of network devices """
     global nics
-    if nics != None:
+    if nics is not None:
         return nics
     nics = ethtool.get_active_devices()
     return nics
-- 
2.49.0

