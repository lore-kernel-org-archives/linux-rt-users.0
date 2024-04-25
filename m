Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309414D2B4
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068463; cv=none; b=kObz/oBjkmDva8fBLf2P+zlCZRgo1r7+biZb9TUgSCuU6raG7AAwnh6Ih6/XHJw/KZAvRirsMj5idxlj3a3IgjmLvWnZIuWSdOjF5xe3fMVGgK78jlMkLd0tdANG3/9LHRFNFy3hGUOhfBJmvex9jh/4z2bFB4VvAb5sXGWLOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068463; c=relaxed/simple;
	bh=6o7uNvE/GsvvpLIv9enSeqPYWrV5ztrOqmWNZwljm0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxFXo0YCsqumLkHrPYSmVcu6gF0w0GdQ1iFi7C7hkYNQW5W+qyr09QcKoBQGox6UJdvEABFABeUJRjZ9Kw3lAdHl/41zxDM4Dgtg+9MwDLqRaUJCt4CJHMRSpB8SRJ9abBqZngp75AMlzY2uSMQpiHNM4+0La/q92uIZ7CAV0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he2d2DVp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he2d2DVp"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-434b7ab085fso18930961cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2024 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068460; x=1714673260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Cvc9pR/9UY/A3SmU6Sf3xBAu6VfUjGLnkxGXVX/XFE8=;
        b=he2d2DVpesaGXqeICwpXiSEexUM5QoKk4G7mgLnivQH3F0yFdn3f8/FQMYsBsEpETC
         SXknOxVXMIj3Ob8+fwhIyo4nTtfO/5yOBTRtEYTAmEHU99HNwlY96W5kJlrg6CdcXPVY
         V+QraFwJc1Z5Qz82L1Bql6zergF60g5mOGVAR53+UiGvpKFnVUrAaDF18E/jwi7LjdaD
         kU9NIap5qvy/YGgCXhs+/wMfzxCp8qnhOy/L6AXBmc0MEd7xgujCqZTbNo2r5zOCCC51
         0RZVAXNO61bJafTBdIC2FvgPSHLvSJaRVO+gBJg8/a57vNjSGs2O5vn2/0eyvkym2kQ5
         c63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068460; x=1714673260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cvc9pR/9UY/A3SmU6Sf3xBAu6VfUjGLnkxGXVX/XFE8=;
        b=RWm5RaeSpUdgnQk+JdAJTcMJiujrBVeD9w/aQEIVZ9PfLA5AHpevLqCd7CrbOgC3PB
         GEx9sfu0cHVn6bH7o00CGfLgbRsLIAzK3I2XNOrB3xZQZfq5kZbgNW+jY9BDadTtU+5n
         ToHe3YuZeoqCY5s/yZrNnot2XvYleqnW/JCgD2ihmMx8tJjH4amJM9jIV8vCfAFKnjq2
         xDPQruidDv/RLQSrwnDkZdNITS2v54OBS6C2ZaM68DxIAq/nnuBM4jxmN+R4vckOWQF9
         KxwDfXFEAxnXIFa2QxrtUgKoDptSbD1qoLjaJMhSMeaRYQrxhLeevKvpYLqiOaX+oOAX
         Tg4g==
X-Gm-Message-State: AOJu0Yw1ubpn8aUEJSsq3HOaoRTybUCCgDQdF8Hk95jhcKXK7E5v7VR8
	aS1Q7eUFDtzSyp+1r+RzIH332d6HjTHf0I1mjIJKXStuuAy8LZ5+6Bk0HQ==
X-Google-Smtp-Source: AGHT+IFjipjM9a+9AZkU+bw5fjyTH8HVQM7mc4U4PsPylP9Ccr7rnm6VnrTEW3XJAcGnVJW/rtj2ZA==
X-Received: by 2002:a05:6214:c8b:b0:69b:60b6:7c5d with SMTP id r11-20020a0562140c8b00b0069b60b67c5dmr5161513qvr.18.1714068460056;
        Thu, 25 Apr 2024 11:07:40 -0700 (PDT)
Received: from fionn.redhat.com ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id n5-20020a0cdc85000000b0069b7c8ced6asm2103931qvk.12.2024.04.25.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 11:07:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Daniel Bristot de Oliveria <bristot@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/4] rteval: cyclictest.py: Fix the description in the xml report
Date: Thu, 25 Apr 2024 14:07:20 -0400
Message-ID: <20240425180723.66499-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the __type is 'system' we should add the description to the xml
The output should be something like this

<system description="(12 cores) Intel(R) Core(TM) i7-9850H CPU @ 2.60GHz">

Before this fix it was

<system description="">

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 671426e13c4d..48b86a03cbfc 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -25,7 +25,7 @@ class RunData:
         self.__id = coreid
         self.__type = datatype
         self.__priority = int(priority)
-        self.__description = ''
+        self.description = ''
         # histogram of data
         self.__samples = {}
         self.__numsamples = 0
@@ -130,7 +130,7 @@ class RunData:
     def MakeReport(self):
         rep_n = libxml2.newNode(self.__type)
         if self.__type == 'system':
-            rep_n.newProp('description', self.__description)
+            rep_n.newProp('description', self.description)
         else:
             rep_n.newProp('id', str(self.__id))
             rep_n.newProp('priority', str(self.__priority))
-- 
2.44.0

