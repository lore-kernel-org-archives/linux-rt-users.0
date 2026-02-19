Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AE328B5B
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536095; cv=none; b=iWRvnodUtUwuFryo+UUUQU3a6+fKZebsH67HOs+Lic7x4CkZpZA05zlsRDv7TewHofka7dwMEUZ0BOIIu7JPZST+sd6i22IH5MLNCqKnDx5iTiUNhHNLvEj19U+RYsk74jW8eFPelYe8D9Vy0BogcDDXhwE7VSeBEIYrOphbFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536095; c=relaxed/simple;
	bh=cgL3vJgBqhAuia9Z23fB2W4jbN7wxfcFWvM1JojBI7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx3s5qwqvaY2+GE3a9WPcmT3Mg7qGLoKYqtAC1GL/Gler13eAOg/72q0HpT4z1CYsu9JnALqu/j7Yp4EYSTujMdJD1E9Ncv5i9wQacZla356YAxKCmJesajeXbb+qeeyygfQSeO8otBR3rGQjAW2/mDELDq/XgbhtTOcgKlLzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUbzrg8a; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUbzrg8a"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c70ab3b5fcso191440385a.2
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 13:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771536093; x=1772140893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIiIWxT8Cnz1h8KfULNXjssyyP8VmLUhWTNrxp2V0tc=;
        b=DUbzrg8anq02kMt8ssZzqMatZnb3G0GvHldwyIyH/C+WzTqbiw71JrlVlWxBAz4rYk
         FGh6pZdtTZulqGniVH6OcUJTZrwl0KDwpqXWLpP55uiWBm81PhLteyI26PZFKV6MRYun
         Z5UgVo3ktCuYnAOACdkoZR2o5zy7qTxpTw3QQUGf2gl9n5nP+oN+1Bxr6ThULcrzS+2s
         7igz70TGY7H9wfj6VRXd8WGJLH6JymQij+BtFH9vdAUHDHgbrjHmQNNDM0iC55nnmYd7
         C4vTv9l3YjKm4qgEEu455hXyi4uTJGSjK1/wm0F6k7iXGrBlJ5x9Aw4W9cZ9jKlFcX4J
         9DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771536093; x=1772140893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIiIWxT8Cnz1h8KfULNXjssyyP8VmLUhWTNrxp2V0tc=;
        b=dycRL9aDMnsqUGHvMwETM6eMhqcOOK4uEmwZqEp9yyUZi0FHO68vwEZi8ozgTIux38
         1pXF1ifEoIBPaVxxkoiacicciJBH8G0kpIpsoy5Rmr91RRG8mW4mtNafVIqJf85F7OXh
         tzTn+657nYKu8Bqp+By2Z+chK/ilaE79xT/gmqqksyteFdcbWw0Xg1BTGysTYGUVgTpK
         GbVqFem7aFu1vwc9gIRWg3mLlmiwMM03yCouRPxC1opUo629UULLq3g/KpoNCZsMtJaA
         pUH+/OTwQbs3ujLrxkXAQhaKmh5CdFs6lwTmU4w+0ecsZYN/e7CLYfhYtiG7iYKnNlcP
         aPhg==
X-Gm-Message-State: AOJu0YxIRUdexISj/QJHfRicOSAbUgNF9zobiDIXDY489GtggJLB2Hhv
	YmFs8+Fl2lV2ea7SSDCNeea7liQXwfcbZhhBPDubgdUEmvSv8WrqnuNx3DfvAb2z
X-Gm-Gg: AZuq6aLjny/z3XLQw8esLJroD/ibzhtMameZ1ylh7zdM9OGRVxzvnmyACm3bOM/yAXC
	SVtCNVHhUG3VCsvUoVZeRIQk2v9Nlhkc2/JSrFWBU+lLrsMHgn3SEQ79hvNJcJK2fMzevn1xe2L
	dJxbP4j8ROKT7uNQhLcRhG+zXeS7pyxJgpnH8Ex/gCVExWu0z3l6tWM9nstpXeik6UunD1E9r6L
	sRzUghdXgSuhDMtjLovIW4whHHG6jXzx4XwZQIzrEPhImyXVTkt2fDWm50BSlDKp1AfFiKuOqm4
	HK3FVtT3noEW6dmPzUmWq9Ixypi6/P7WBmPPq93eZi0beEdPOFksMCNWeyvYhB7mP0UgB831F9s
	MqLhC10TYc1tpd3wh1IIQ1YickzmdwEPFEwzyuf1JYJjiDM4nHhyWIXDxPJWWGC8RxXXj68A93o
	OI6yfvUBZZylFDdC0ZdMgTsmJXy37Da/MKfUPgjmyQ3isWiuA4K4I+FoegY8g/nAwq6HC86kKZb
	8tINcjU0Xqt+S9u3w==
X-Received: by 2002:a05:620a:4010:b0:8b2:ea5a:4152 with SMTP id af79cd13be357-8cb4c019b85mr2439160785a.87.1771536092725;
        Thu, 19 Feb 2026 13:21:32 -0800 (PST)
Received: from Cumhall.redhat.com ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0be6besm2142975685a.5.2026.02.19.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:21:31 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	"Claude Sonnet 4.5" <noreply@anthropic.com>
Subject: [PATCH 1/5] hwlatdetect: Make count field backward compatible
Date: Thu, 19 Feb 2026 16:21:19 -0500
Message-ID: <20260219212120.227106-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219212120.227106-1-jkacur@redhat.com>
References: <20260219212120.227106-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The count field was added to hwlat trace output in kernel v5.10
(commit b396bfdebffc). Make this field optional to maintain backward
compatibility with older kernels:

- Set count to None when the field is not present in trace output
- Only include count in __str__ output when it exists
- Fall back to len(samples) in get("count") for older kernels

This allows hwlatdetect to work correctly on both kernels with and
without the count field.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index af9852cc95e8..c128f60bc8db 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -264,10 +264,12 @@ class Tracer(Detector):
             self.timestamp = str(ts)
             self.inner = int(i)
             self.outer = int(o)
-            self.count = int(kv["count"])
+            self.count = int(kv["count"]) if "count" in kv else None
 
         def __str__(self):
-            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}, count:{self.count}"
+            if self.count is not None:
+                return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}, count:{self.count}"
+            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
 
         def display(self):
             """ convert object to string and print """
@@ -299,7 +301,10 @@ class Tracer(Detector):
 
     def get(self, field):
         if field == "count":
-            return sum(s.count for s in self.samples)
+            # Use new count field if available, otherwise fall back to sample count
+            if self.samples and self.samples[0].count is not None:
+                return sum(s.count for s in self.samples)
+            return len(self.samples)
         if field == "max":
             max = 0
             for values in self.samples:
-- 
2.53.0

