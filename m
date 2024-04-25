Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252814D2B4
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068466; cv=none; b=b5QNANtcKFkkl2BubCk2ZX6KRx4qvnr5auWHm6aY9UvYeYd7OOhxe/5yvxxnPqPNZVV0VjQTfJ/UGsfrTIf/fbnNBI1pUGYzLc4Ba5QX292/tzsJUvRjgzNXxFx1Z6D+1/pMqrhn3v9zeQBsPT/MPH7jUtawhhCoqt/6qO6Erz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068466; c=relaxed/simple;
	bh=ZK1BvbMXtAbw08OTZ3c6MQtLfcAl+2AhRHB5JHKLO3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLpaZzHkJLINWtnyBl42AEK3naFlckTYxntvLgI80VHrRk6VGke4F9Zo7JBph+TFq1DW4dv0tYtxvbNIz6QXqG93J6gA4zn3cWvaMxmllk+C6aHtKA9AQYl7U/CjD1NqWgsWiaUwymCyKYsVZoRuIBMAUxkFl09Q9mu76tq+eBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWbZLyUJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWbZLyUJ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78f043eaee9so73356285a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2024 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068463; x=1714673263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ves3/vHu99sdJKzcDwdHqkLZxl0bM02aSC8+OmKsR54=;
        b=lWbZLyUJrTlX9mU26aTA3jNc03maErYkUr/s9hM2N2YMdVG/g4gL3RdSoZwIH23RpY
         6VrlXYwCjYojqaDZl4dsyUEpFbDiodApHvn6bQE03vfbV9Px0mKyULWDX5TadXPOon6l
         2gNq/FghGoBwQ5Hmbldxbdc2GuOePSzTZqRE0iws6a2+lq02ui6IcbxCwGypS3lcOJlD
         /G23e8w6Y9ob02krg5ME9MJB79qXBDF9HE08ylXHmyh4/I82hZjSaZMxqoFjFn/E4ZNU
         vZHtNP4euDpxHQTXCISbEuKyAk3SE7FLHxVPbeK+q66ncFJoozwtl5klKHdoO7x5gDNR
         qbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068463; x=1714673263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ves3/vHu99sdJKzcDwdHqkLZxl0bM02aSC8+OmKsR54=;
        b=LiaZJW8CqYgE/QnAq0T3xMS7TzzzkFfXBlTo3ZICf6GlIqasPnoUJj8dO8vUqIv1bZ
         YLTjSVSHN7Z6vHFFjXb7tO7BtT4ZJ3TQOez1EKgG3B20EpqVVx8xtKO9c8/zV4I2jzJs
         PjG0wGx2JCcX2a2ZD446MdXVEnwsDOUbcO3e4OKebR0cXkd8mWazgcwhjhMUttJIwd8D
         GfskRZHsZVUmmNayZpKGPE8zhWiJ6v62TCqGTZPcdWnQFu+fLH6MQVvPpenjG9glRz7t
         DcTitmAuD8QrVx0BycpCWD6T9NoJUtTEDUEf8A3+hiKmWKyCPRDJoENeK7xZNCjp7RP5
         40YQ==
X-Gm-Message-State: AOJu0Yyj8lo+LrqNkbUDOhhFO3qcT06gjScv50EE39Oeqr3C929Tl6pw
	hld678X6eszxDqG3YUnZ1qu3OBB7VI9Ce0YY4by1UbFMdsZ9UpldolFE7g==
X-Google-Smtp-Source: AGHT+IEki/7LhAcVxecJvENe1v8gsZ38deXowPc6YWY3Y+2X7ieZdUymemlR9crouugOtBZUlzLouQ==
X-Received: by 2002:ad4:5ca7:0:b0:6a0:48f1:6148 with SMTP id q7-20020ad45ca7000000b006a048f16148mr583679qvh.27.1714068462768;
        Thu, 25 Apr 2024 11:07:42 -0700 (PDT)
Received: from fionn.redhat.com ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id n5-20020a0cdc85000000b0069b7c8ced6asm2103931qvk.12.2024.04.25.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 11:07:42 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Daniel Bristot de Oliveria <bristot@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/4] rteval: cyclictest.py: Fix the median calculation
Date: Thu, 25 Apr 2024 14:07:22 -0400
Message-ID: <20240425180723.66499-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425180723.66499-1-jkacur@redhat.com>
References: <20240425180723.66499-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the calculation of the median in rteval for cyclictest

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 1ba8b8b2323c..cef73abd1b4b 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -80,26 +80,34 @@ class RunData:
             return
 
         self._log(Log.INFO, f"reducing {self.__id}")
-        total = 0
+        total = 0 # total number of samples
+        total_us = 0
         keys = list(self.__samples.keys())
         keys.sort()
 
-        mid = self.__numsamples / 2
+        # if numsamples is odd, then + 1 gives us the actual mid
+        # if numsamples is even, we avg mid and mid + 1, so we actually
+        # want to know mid + 1 since we will combine it with mid and
+        # the lastkey if the last key is at the end of a previous bucket
+        mid = int(self.__numsamples / 2) + 1
 
         # mean, mode, and median
         occurances = 0
         lastkey = -1
         for i in keys:
-            if mid > total and mid <= (total + self.__samples[i]):
-                if self.__numsamples & 1 and mid == total+1:
+            if mid > total and mid <= total + self.__samples[i]:
+                # Test if numsamples is even and if mid+1 is the next bucket
+                if self.__numsamples & 1 != 0 and mid == total+1:
                     self.__median = (lastkey + i) / 2
                 else:
                     self.__median = i
-            total += (i * self.__samples[i])
+            lastkey = i
+            total += self.__samples[i]
+            total_us += (i * self.__samples[i])
             if self.__samples[i] > occurances:
                 occurances = self.__samples[i]
                 self.__mode = i
-        self.__mean = float(total) / float(self.__numsamples)
+        self.__mean = float(total_us) / float(self.__numsamples)
 
         # range
         for i in keys:
-- 
2.44.0

