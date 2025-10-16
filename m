Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112143169
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Oct 2025 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638786; cv=none; b=hOv6+LSzSOEoJkhU15OUMsoW/N+kr0FGmTqE7BGufj7Bv2Vk+9Ujnps9HA2yJev3aX44mhHrPmSm2fu1WK2/OiqF0HvhLIW7CA46USKbLs1Z4zSL1fLIhMBDQkp/kHUnBXX5KGncz1tmi3Rmjrt4ajC5m0vv9yMCkMImTahXrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638786; c=relaxed/simple;
	bh=YUq92PT9S0M3uqOOJ+cIqy/ZEbBIValbfTdlrJFF+S0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjJ2Mb5GLVeGb+QXMhaiaKLuBYXccbYrM75OT5eDdclZHFNA2VwxCLEqTzxJ5Vs2FF+OxxbvExN975Abh4W4RSz2MRErBBYqhqRbbLQ8PRKr/9HyHAck7hpkGVA4EiwqtnrxO3EpMu9PzwG6TFM0h7wQ/cpz34ZlxQZnsKk5j2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwNgINVO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwNgINVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760638783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fiovgzTgCiARs5jA3Lu8Npoy+zV1t5v9Gg7B7esB2+o=;
	b=UwNgINVOMW4EHReb3hsVmGaOrQ7wuKMTlhxTE93r4bc96dWlG3wy1+SnrwIC1CzhOA5aD5
	RQFoVR7H6T+ai4GiJsC9znLC6peJDkSWASpkILUxFqrIcKtYt8mlboBK6kQb1KLNf+iOBY
	QLzWaSTvPB5XqTYV9ZhUWNXc8pw2o18=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-DuojZnTeOvGlhY-tdD0Njw-1; Thu, 16 Oct 2025 14:19:42 -0400
X-MC-Unique: DuojZnTeOvGlhY-tdD0Njw-1
X-Mimecast-MFC-AGG-ID: DuojZnTeOvGlhY-tdD0Njw_1760638781
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee888281c3so2632217f8f.3
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Oct 2025 11:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760638780; x=1761243580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiovgzTgCiARs5jA3Lu8Npoy+zV1t5v9Gg7B7esB2+o=;
        b=Pv0duZX//CjGl7TO+o1+l8c0EHCrSaPWyQQqyemd2taAOfsEU1tgYu3d9RwNQpCIla
         zcpuE+h26P6oDK+6NNGzXwvHlDgE2YhWewWA+3vYAhdZUr+GruJQ54kYwgo2jCxrsWWN
         AmvMOx3mwVZmOt/Xu+f25BuiBtS601/FHQHGdse8YNaVT9N0KDjGhK0zVoCb2sV7sYqB
         iIj7rgpF4yGU+GBiG2E4HB8gG13scIZT9mef3ilH2XLJpwGZoYUGZIB4Hbq7FgbiDHGi
         m5bl0DRHoLLUon4UAD+SWl474w37vTUK4sv/HvHFfWVCIYfwK/poHnpNwitwRj/B++Py
         WTjw==
X-Gm-Message-State: AOJu0Yx4QTQqXgOdWpIvbTM0zDf7Sy/eS4wLVL4iwiNfmuvgw1PlrNof
	Uxj9bQTAz9R9M4WzlhwLwwEo/4RKipxx99QE/+135ZvwyL1ZHOUB7JD6ZLqneSedloRXGw/DB07
	pO5EfJl6kkkHttGBdT6iMsYuBsVOyeIkkdxgUbUhxYtGuHfo4ulixD45PLJ5CpwQ6nJ8LG6+izY
	lYCog0X0Kw9XTw9E/HU+pPU5R28ERAC9CDc9CLzxay1QN19I400RSmRII=
X-Gm-Gg: ASbGnculwM/y5xzeBY1LK4jGq9ARKkjO5AiGwUDE/wYH2uxCQcprkGtvTunvDA4h2PF
	h4F61lIFM0dev8h62f2nwVkt7leim/cD4QyFDA2YunH/pewFTb1YhLNVrEsd+eZo2yatByF7xMF
	qLmJELz2uTKnANQQSgNCUOrLttzOo2OnzqnLRDaZh+8yMIjNKPHFtk50uS91R/wi9Xp1SWUVbiQ
	N5Qo0JD22lvVvGIucRVXib/i0/POdbTRxu5OTkdR1jNZgSsk8bK4npT7MLU2K9UIGTqpeO0dRmw
	rZon33SBR5vWqguvZeUlkAep765ZXqKgNEZNLMSftVBT0jl3Ix8uGzE9gSLnPPDGDTjkTIbjGGY
	TEOiSzoAhl5aSRlpe
X-Received: by 2002:a05:6000:4010:b0:425:8502:f8c3 with SMTP id ffacd0b85a97d-42704d7e9e0mr722459f8f.1.1760638780542;
        Thu, 16 Oct 2025 11:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVLeYKbRFyKNVtOBvWkelSHwkih7o3VQgmdxtae5T98CPcItPQwi/TiItqg//2S/GXAxq2BA==
X-Received: by 2002:a05:6000:4010:b0:425:8502:f8c3 with SMTP id ffacd0b85a97d-42704d7e9e0mr722442f8f.1.1760638780074;
        Thu, 16 Oct 2025 11:19:40 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d015esm37261351f8f.33.2025.10.16.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:19:39 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
Cc: Bart Wensley <bwensley@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH RESEND v1] rt-tests: hwlatdetect: Add field count to samples output
Date: Thu, 16 Oct 2025 21:19:33 +0300
Message-ID: <20251016181933.418200-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel commit b396bfdebffc ("tracing: Have hwlat ts be first instance
and record count of instances") adds field `count`.

Add processing of `count` field to hwlatdetect.py.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 68f312db639f..af9852cc95e8 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -38,6 +38,17 @@
     return ','.join([num_hex[max(i - 8, 0):i] for i in range(len(num_hex), 0, -8)][::-1])
 
 
+def key_values(fields):
+    """ Extract key:value pairs from a list of fields and return them as a dictionary """
+    return {
+        k: v
+        for field in fields
+            if ':' in field
+                for k, v in [field.split(":", 1)]
+                    if k and v
+    }
+
+
 #
 # Class used to manage mounting and umounting the debugfs
 # filesystem. Note that if an instance of this class mounts
@@ -242,19 +253,21 @@     def detect(self):
 
     class Sample:
         'private class for tracer sample data'
-        __slots__ = 'cpu', 'timestamp', 'inner', 'outer'
+        __slots__ = 'cpu', 'timestamp', 'inner', 'outer', 'count'
 
         def __init__(self, line):
             fields = line.split()
+            kv = key_values(fields)
             self.cpu = int(fields[1][1:-1])
             i, o = fields[6].split('/')
             ts = fields[7][3:]
             self.timestamp = str(ts)
             self.inner = int(i)
             self.outer = int(o)
+            self.count = int(kv["count"])
 
         def __str__(self):
-            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
+            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}, count:{self.count}"
 
         def display(self):
             """ convert object to string and print """
@@ -286,7 +299,7 @@     def set(self, field, val):
 
     def get(self, field):
         if field == "count":
-            return len(self.samples)
+            return sum(s.count for s in self.samples)
         if field == "max":
             max = 0
             for values in self.samples:
-- 
2.51.0

