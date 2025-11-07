Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2633A007
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540033; cv=none; b=nVPAcKjp/9AJLhOCJdibSypqLDs3gTUxoeB6qOGsmJmDRdOp7K9KnosVNyarokROMUdU+OB90lnII0sbvcNyEkg+mrsSIr6SRqfQVpxq31B6dXmB6LVZ3QKWPUhKB+HLneC3PUChRbcJhmlGviqtU16gyiECEus7SXN+Vgjgw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540033; c=relaxed/simple;
	bh=T9Pwh+E08hUf7gU0LRev0YwN0G/B6a6ifbFAKG0p6YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNeY9zWFEHQ/Jv9hbgf/Uk0duzPm1sr0czjUyNtTQJqpm2itpzMQ12nsAe/kxQgL0Q3BqjB2RKuahzmjNTBDwg/7E0jc3sPXb+KKuiAJzWjuMhaSLVdL5brPn+rQ1/kBRRAv6cNHz/diqZXFz7r3hJbdbW/kj0pdwXRunwV6OkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8T+O1/6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8T+O1/6"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b220ddc189so135741485a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540030; x=1763144830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPlANF4NdcKQPsMldv+VMFDKnu+scD1gsifSWj0pxlA=;
        b=S8T+O1/6QscL2yCdt7HHTgFHsCTM0uEnkX0dhIMV9wRFgU9YToeEJx6Ibnh5v0SAp6
         nG7ttu8nSSn2/IVhdIe76rFt9FHpYVL6iLgBdf/0cWvpOK6lO2VEVVifE+lotsJVCZs3
         +xixNr5MfnWEovZnIhl/NkOYD0hE4EOCvKz3JzTzlJamS4RBkNytl7wSiNbhJbubtyVu
         bakiWWMb5m2us4GE6km6XqCKjcplhNaf4MpfbSU9UQDbD3wt+cJKJ7fifvfq/4hKsCUB
         +N5fwRhai49RxGuOTifqUdbSVCudUnpg8xqVbq5Jn6g2cvPeKpOtU7x0q1LtyBZPh5oa
         R06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540030; x=1763144830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPlANF4NdcKQPsMldv+VMFDKnu+scD1gsifSWj0pxlA=;
        b=H6iKkArjnSw6lXaAI5iTfR2T2d+DW+Uw4+QQJonRJSdJ0zsI38hXCiCDiWsGOwrM2o
         fn1fKHpl9kij8cQWfmnnf9OXQnJn1BwGoI5Fj3bw5gAtPxX+StM1GBSls258xW99xKpo
         mK0a0T3cvw38MwD9pEqoEplZyJNYMbBR51WCCg76I13Vhl9e+UbcfDjAZy4gs5tVQos4
         haPMgQSpSR0PYTawuTaqd5PAqlvqq1qHtmDzcKCcBa7wnUOLO0PQVR7IJeJnZH1PJFsX
         Tbi+4Ej0I/MQMqrP0rSu6GLDh1gZUaBWij32IsHQiexN/E+sVUyky+FnTPBmIMV6o4We
         BkvA==
X-Gm-Message-State: AOJu0YyG7jdH3OXhTF6/VB4PmUVxhpmLVZ/VzqFNVnI9mm+xcyqmKDRU
	BZT48n59YxYLT9jB5AH70i5nPkl+LQNoxd6P5FnU+ZCvtsF1Ijbnc0WPVghFUNfv
X-Gm-Gg: ASbGncvUausn8jlo2qDLjSxVOc+URSFRPetgcQ2loUR9reuTf/l5ssyiQCDaH1Kdoi6
	X/1ETYWWNbmZepRvPsZeAc0hRI/t22eaQ9kRKGqnguKBTUkC7PhNA5A6uZFxK+ZkNnd0w6yew7k
	8FKUVya/FzD4obJuGZVpOB9HMVi6hQOxzpwtWccbs7/q3ON3PfdO1Bp8SqmUtLoRcN2qkXsWWiZ
	M2Daq7qMlOzYorfbsHktFpxkVzgj7p5MjzyQUtIX5PFcsHwuRhNa/4bpYoYiLbV43nfnI2M4A9v
	FAO9z8Zg7EawmWcdZo6yajZJYq/eo9kBUDeZZT3lPFM0sfjyuL9x2fR3JM9HELjFsHVcjLor/vw
	uWn1fhiK3x792Rvve8aGMZ+d8YarkCVXtBL+vZr2Z4uu5uFS8Y+sNNjLqGYTYX1c=
X-Google-Smtp-Source: AGHT+IEPkpGSe/OISuG/lnp8r0TMjRj3gYpG7dYntBOvAq+KJCa/I/KwarOzqyPVxpp4nVyzznjZLw==
X-Received: by 2002:a05:620a:3710:b0:899:d7bd:bec1 with SMTP id af79cd13be357-8b257ef5cdfmr37694385a.17.1762540030277;
        Fri, 07 Nov 2025 10:27:10 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 04/12] rteval: timerlat: Fix typo in log message
Date: Fri,  7 Nov 2025 13:26:27 -0500
Message-ID: <20251107182645.19545-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed typo 'sampples' -> 'samples' in debug log message.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 733929666784..95fb7f136c25 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -66,7 +66,7 @@ class TLRunData:
         """ Calculate statistics """
         # Check to see if we have any samples. If there are 1 or 0, return
         if self.__numsamples <= 1:
-            self._log(Log.DEBUG, f"skipping {self.__id} ({self.__numsamples} sampples)")
+            self._log(Log.DEBUG, f"skipping {self.__id} ({self.__numsamples} samples)")
             self.__mad = 0
             self.__stddev = 0
             return
-- 
2.51.1

