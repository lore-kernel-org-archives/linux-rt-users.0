Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303047D94B
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Mar 2026 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480015; cv=none; b=fpa4KMltMUTOUvsG9P4M5zWIutTQMf8uJFZhu1DEDluWs2wYiA+S6Jb3bD0DCK8OZU1RJ9hhV2kj5eCv8uKGbheD+TvJLXVruS//Z0WJ8aAYlyAiH2RoKyXZibGzY7p0oQlGvsKmgLYAdBsCxOFwXu6/TnE1ch/h2nT0hMCvJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480015; c=relaxed/simple;
	bh=wQqYtQ8jABiNJAW5/XbzrAaJov2MqJgcl56o3tKaOkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tw337TozE9ZpS5LlARvg/ECHPYGCV5937BGCgk5jp15uGN+5loGlWAIWcpEJfcC6oWJWlAj3qsOB2OoZA/xmBXcRi7KdaknDONsm+JNcL7lDdQQ9jyj2vMfdi+bBeMBOKtQ+EcgYLsXCGGhtuPoEZR8m9pwzV24V2uiVBQiori8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzWsf4TZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hx/a9YSC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzWsf4TZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx/a9YSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772480012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LGccWqku1cZdWtQ3z/PqeYXuZGsXzViCOt5xwJiCvTk=;
	b=OzWsf4TZdTcNfGbfuQajVvRaofy10UdwpnGUZ0gmasVp5AhD8+2zIHeqO8Gv+XXIHKBGgt
	gv7dVtfT7kE+zj04sUQ36w+psF9TBjf883nf9/K+J/fEBPFNdwbjBhUVg52ojWdkHGJnAE
	wf+Yqscp8mefCsldhcRLSklqM2aZlVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-4yGT13NAPye4dS90gtvNCQ-1; Mon, 02 Mar 2026 14:33:31 -0500
X-MC-Unique: 4yGT13NAPye4dS90gtvNCQ-1
X-Mimecast-MFC-AGG-ID: 4yGT13NAPye4dS90gtvNCQ_1772480010
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439af7ba802so1536994f8f.2
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2026 11:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772480010; x=1773084810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGccWqku1cZdWtQ3z/PqeYXuZGsXzViCOt5xwJiCvTk=;
        b=hx/a9YSC6+2xLK3gVFPilaYcP1hbshd4KRwBkMxtL5qJUGilehV2hGat+B//XA1SqY
         paGzJXcleVdLA173z/HYATCIXEPjYkedUbt/YmN3qOCppfc2rsziT8Eheog55/nm70Wv
         Sw5YDTeU0MlDttjbSOw31GhOIRc+HrL4Rg+w/VbbSgAMj/lImx0z8jEUTq2PCgNaHpbn
         W0YCvMn2buOX6AGE+LwpqW6PNTtUaGTI/P5ZDLkCOP7V33cyb6sYr02rbWx+ScFIVnB1
         vSXEgwJUHgLg6GEFyA7t/9Ip9DOgYq3ev++prRihupwweEhIj+J1LNHGnpPoe/M18GSN
         eTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772480010; x=1773084810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGccWqku1cZdWtQ3z/PqeYXuZGsXzViCOt5xwJiCvTk=;
        b=mBqT/QBrrveCvoCn8OsycKlwDo8MFvBZRWDTNksHkgChKFazVljxcsFcXUBUS+Dmtd
         H5cRfCN3uzlhDO1l7hUsfZKELEQzTNYq/ueOUh1IOBwOVezxbz7zAqRygTchBCyf3Z09
         4iexLu/v/MhgTJ78lUiXf1V+EMGbbESA9kt4xiM8yKfxKCgZw9clHh3VeETtS1iN7Jov
         1B8JklilqhMtrx0V0gPcb8CZlWAQ02DjEHd1Tgz74mhYdpg2HjtSfY/uFql2/7OL/xOC
         7TMNj47G0Cx4mz1a+gUoelSzEoSW+L9cdf6NfQf8pqxjyo9bLx8QS/Budzoz5O6upaBi
         aNgg==
X-Gm-Message-State: AOJu0Yw0Yb0CFK3KP9olmmQ/6gXsGVIKD4lMrE5eUw2u0UfFYbJxXMOY
	CVtodz7t58YobzkTdOT9Dw61bt79rRP0cUL76fqnrASH4NmpxCLlu8mVb3nvfMg6ZBb/C73Ii6a
	q8+HKcDt8qjNVPVweKAcfTC0bwMP4mZ21n7sb2qbLbnSwnmt2eVX8SxHFtUIy/kHwsG8U1IurLh
	maz5MZPdcuXK3glB863JlDJmqYnr/IHbdsi+F8VZTsPG4tn4nkojxEJ2Y=
X-Gm-Gg: ATEYQzwEi86vZu7xGyPshRbXuOduPwV3AFNZDgAvXJd4QCwmx31MFQGV7cNrdNCPAUR
	e2X7yqKXR6JskNwxX5G3+uqsr4rtbbwueROwR0bWMNPE2uXABSARalBx/2u/vQI9bORSqnHCAzr
	d5igdqfo4I4iTSGu/TahiXL0tj27oPnQInJt3mhpUkFFnsdc1NeD9sbS7ZlYPjoNy+Nxpss7O1N
	f0TlmuRSqmtYBhSDuibSZrCjSNPneZldaTgPiQX3ABFmfP6JXROmBUBdYQ4xdk+PUtr1CO5jALV
	ooNdu3zov1S9cOTh29PUFqCHNQz8sEtOkS+XxgRPcOBz9k81mtGgOnk/V+9k9gjRcvJy3XcWZPm
	ApdmVD2V05GR1l8tFOHNeBiiWkk8QIxH1isQCAQ==
X-Received: by 2002:a05:600c:3509:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-483c9b971aemr203826015e9.3.1772480009872;
        Mon, 02 Mar 2026 11:33:29 -0800 (PST)
X-Received: by 2002:a05:600c:3509:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-483c9b971aemr203825465e9.3.1772480009219;
        Mon, 02 Mar 2026 11:33:29 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfecb8basm138274405e9.32.2026.03.02.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:33:28 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v1] rt-tests: hwlatdetect: Add timestamp delta
Date: Mon,  2 Mar 2026 21:33:10 +0200
Message-ID: <20260302193310.1712952-1-costa.shul@redhat.com>
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

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 42b9f301718a..f95e771048f6 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -253,7 +253,8 @@     def detect(self):
 
     class Sample:
         'private class for tracer sample data'
-        __slots__ = 'cpu', 'timestamp', 'inner', 'outer', 'count'
+        __slots__ = 'cpu', 'timestamp', 'delta', 'inner', 'outer', 'count'
+        prev = 'nan'
 
         def __init__(self, line):
             fields = line.split()
@@ -276,14 +277,15 @@         def __init__(self, line):
             i, o = fields[6].split('/')
             ts = fields[7][3:]
             self.timestamp = str(ts)
+            self.delta = float(ts) - float(self.__class__.prev)
+            self.__class__.prev = ts
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

