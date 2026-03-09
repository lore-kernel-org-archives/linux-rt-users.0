Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9972D0C9C
	for <linux-rt-users@vger.kernel.org>; Mon,  9 Mar 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773097806; cv=none; b=nowxhomqODmUgQHyHgEvlyzSp5JE3Pnl8NqZm4mUEK6TICZ6xVs4JiXZU8DLjoW/uhNza27VVwh+hFm+w7CBbLORapb+TtePoqttJGjGbpM4+VdchVYB4TVBg0XVlw489b0SOoeJkr/awXVVjfAEYp9QG/BusB5SB1xN5IuaZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773097806; c=relaxed/simple;
	bh=Hq3484Y9dgavP72CbfG6+Rw/SWC9mNFkxfDMlbC99Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9p4lbOGFajO4BRlH6E+dX4hXZhmtSSAikYGmpX/vpDXevDdPPEA6sUtXnkuSdLcbnF85hE0OR+/wlJZo3DLlKAtI6iIttZIiBOrZziFbttwr+AoV4DyhJk+jskv4bCt1rqaEcp4tkORx1q56iW/0Q5Fv7nNEMc97ItXqacpU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFEobMmO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmEhWAC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFEobMmO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmEhWAC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773097803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mtdd9lX9v3evtbmdwcCvN1lbIvCkFdMqz0QoOxuIBKQ=;
	b=PFEobMmOdyCcm6iBfuuNl5YzuO6A1jEgzdaqg6uoQZuhhIRPnliienvW/dIkviJfVFiKwP
	y5epJnYBRir/BsY0i2wiJoPNXfjdvmc3oH6hA/5RCEj1iyLAMSE6ZzK5PXszZrBc4INjpF
	+OR37yprlJ7jv63WLBax9Cre2pyRGrs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-TWbqpNX7N5m2CpudExLYnA-1; Mon, 09 Mar 2026 19:10:02 -0400
X-MC-Unique: TWbqpNX7N5m2CpudExLYnA-1
X-Mimecast-MFC-AGG-ID: TWbqpNX7N5m2CpudExLYnA_1773097801
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4852fbfc379so27248475e9.0
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Mar 2026 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773097800; x=1773702600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtdd9lX9v3evtbmdwcCvN1lbIvCkFdMqz0QoOxuIBKQ=;
        b=KmEhWAC5vrgTSPTKVlHecphs9HJNaydELKqVTMm0SHd25BWtmvYGDtknkKbEODa9pG
         hClzanym30m3lK4Bvd9swc21JOt29qdkeZHxn2qw2Vwa0kXeXo1ney6N5N6Gs4Ycoy3S
         ozeDqhsmJYATH351IV7M5bxkOGf4f/9OohiEVVoz99Bgjdn1Ddwf2v+CpyUcLD4SFlJZ
         7is/W1qNOUXIU19Httjfb52oRgI3KaUgV4RuB2vVicd0St+eWspw566zq65/T3nxqWc/
         rWHEiNH1qZlrQvS1vou+ptp4qo58CoGoW9EnDDkCRn/f6JDcVEoFAli+ipO3BqiK+Vwk
         hNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773097800; x=1773702600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtdd9lX9v3evtbmdwcCvN1lbIvCkFdMqz0QoOxuIBKQ=;
        b=BqPQoFAVCJABXOnhK3BujozHrgWHEII3OsqHLzvr4Ob03j7QfLumz+DAaJP7B59rQe
         9G+F0r+m+7u5OmGAtDavoDSMl8ndrGS4EHndn3WDGejj7E3cACRIjCSfjAhmG2q7YMqY
         rO6zpzjwppbQEAv0CvO2feUyHfYmMVqjXCRMyIcTkFKh+Ck8p8/ZoBUAxufChAtQ2aV6
         3rtE5CagEOh8djbS4MPvLe/R6Ez+1P/LVAkkz3alKFBrQqKxtF0iwBH+W+JSJ3GNFjvl
         8OOgJR9APw1A3HcTLyu+45tLUOQRERq6CA4CGW0fRER6FPm50lUjKKxUY+KL/RsOMgRs
         w7xg==
X-Gm-Message-State: AOJu0YyWmpHY9KsRfzoGNRWeHtCfbgJuoJ2fvKIyoRo1iDge8Y53pGg9
	jS4dEfEI4tanH8SjdR1QK4s6fmgd6QA/c3Y3/FyO/FagwVkKrbVy9q794fVUgciGRq/XruFkvJQ
	8T+Gf7fCb2GKc/GUu09C+WAjNhxKTICBcU3704mBtUaItf7yWE8cJGFzjkzR7dUFKGoKm95/32t
	VgoJfX28sww6HGX9a4s9UYS3psMrlCHeY6RCEP8Q6YBdZTilzk8tZr5Q8=
X-Gm-Gg: ATEYQzyJowdwjh43ripqGa7trF8fORChq/JN6E6gTUU7LOMOwPIsTr1pLIT1aUbj0H5
	29KWtV1XzzZSsgC/V8xPuSzhfbOqrUXLbNEFO2f5kVzBAbt2BNwwEfiz6ik2/4UeE4O3LBdxwx1
	5DHhhcFhCbtWc+rm4zYxj8waPN6PGqq2wBGtuUDQiJK8OlI7W5nnMk/XKC+lMAWQlhSklr6QWhu
	Oeq6eyNjxREyPKO21VOMtt6gYSNekoD872WLaXBabICPjRAeGmPs0plTjFcHe/I07kdoTOeApjZ
	Fv+qGLOBL/nq85OuXVvMdtB8+XQaNZAYs/LAUMfkiiI3cYrmvbXrRFo0bgAxqJqceNd+enCQahT
	s+PSxBPjYN72JrsAcvZsxFWLi
X-Received: by 2002:a05:600c:4f14:b0:485:3d00:efd with SMTP id 5b1f17b1804b1-4853d0017femr65933065e9.7.1773097800603;
        Mon, 09 Mar 2026 16:10:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:485:3d00:efd with SMTP id 5b1f17b1804b1-4853d0017femr65932685e9.7.1773097800135;
        Mon, 09 Mar 2026 16:10:00 -0700 (PDT)
Received: from localhost ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852378e700sm172553705e9.0.2026.03.09.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 16:09:59 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v2] rt-tests: hwlatdetect: Add timestamp delta
Date: Tue, 10 Mar 2026 01:09:18 +0200
Message-ID: <20260309230917.464377-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add delta field that calculates the time interval between consecutive
samples. For the first sample, the previous timestamp is initialized to
'nan' (Not a Number), so the first delta is also 'nan'.

This helps identify periodic issues during hardware latency testing.

v2:
Address John Kacur's review comments:
- Use float('nan') instead of string 'nan' for prev initialization
- Compute float(ts) once and reuse for delta calculation and prev update

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 42b9f301718a..18ca930487f0 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -253,7 +253,8 @@     def detect(self):
 
     class Sample:
         'private class for tracer sample data'
-        __slots__ = 'cpu', 'timestamp', 'inner', 'outer', 'count'
+        __slots__ = 'cpu', 'timestamp', 'delta', 'inner', 'outer', 'count'
+        prev = float('nan')
 
         def __init__(self, line):
             fields = line.split()
@@ -276,14 +277,16 @@         def __init__(self, line):
             i, o = fields[6].split('/')
             ts = fields[7][3:]
             self.timestamp = str(ts)
+            ts_float = float(ts)
+            self.delta = ts_float - self.__class__.prev
+            self.__class__.prev = ts_float
             self.inner = int(i)
             self.outer = int(o)
             self.count = int(kv["count"]) if "count" in kv else None
 
         def __str__(self):
-            if self.count is not None:
-                return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}, count:{self.count}"
-            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
+            s = f"ts: {self.timestamp}, delta:{self.delta:.6f}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
+            return s if self.count is None else s + f", count:{self.count}"
 
         def display(self):
             """ convert object to string and print """
-- 
2.53.0

