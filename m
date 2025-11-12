Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B4428F50F
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2025 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969733; cv=none; b=i9OKU2SIw+vPTuH9skTE4KAJsotJJVVGoK/cx689L39TTZjeZf7YYeN4ULcoF0pIAbvk1zBxoJKSQ3A7SDCQ8gJWrMEefpyOjw8a8iasexqYzBx6HHwysdWfXG8HtNrtxGPZAlUD7jyMX68lCXY8mNZUI3Inqcp9zMATXmEEaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969733; c=relaxed/simple;
	bh=KIYHgOE5gMBUzJVfNMNe61qnHpIGAg5ZhF/KLH0TK4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl8ctI76ZVeLBxAmDu67+mgWx407YjiZTp7S5DuqZiMdX0EK95PxP44F/tBlQbEx28zlN8lJW+qmjdHCeQlE+IYdN/QeXe2D5wyn9CtWdXLJN81c2NI5+j21QFoTTUMvPNVoJUDU8vM/+5SiIik9PDfmVPbUqabwgozuxwWkSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4C9OoNo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4C9OoNo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b29ff9d18cso86492585a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2025 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762969730; x=1763574530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8lV50GRi8bc1PQa66BAUsgRZ2Zhsosh+hqZyeH4f/8=;
        b=E4C9OoNo4gZZEtpIu+3r/fLTwSdt3GD8dcaxfSz/co4TOGLH344RAg2Zf3oO5k+mzq
         frcZHcXlmyqLSpwmxZPRzLSJMLhBIJvz/xZI3L/z79ugWtiTLcigIA4p87z5xne2GjJH
         fVwDYgw5eM4OGIbtr0w9t0/IDUaXh3x8bLitphg6shiJ3EfY2m9DR4SiR9+iv41oY6/L
         Oxs5GVrm12ThrnIMPIyTGQjLdDxjRoLtr3oXexon5HRuMYhxV2Ex2YaRv0aSPjQvYU2D
         pkP3LgQdLMFRtunb5liCGx9CSk2aChG7+8NExQRfHpsQNk7GsRdKg7oQDNrwTzfiMX5a
         5OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762969730; x=1763574530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8lV50GRi8bc1PQa66BAUsgRZ2Zhsosh+hqZyeH4f/8=;
        b=MG8hdkz3fZMt9629zpLZHkbEeAE3Q6xOnhWUaOUTeweq9P4WuE5kHILfLQC1xKc00U
         ayKZevdcOeGvrWyGbBA29obN4RZD7lJTJxjE7g+SIx3d1mw6McMecPxBMY0tZOW3Wo/A
         vsVopV2N4yW+TfnDsNEPAAtHngd9PKKGwNeMskL47niZELZzws/Zxd0y1xYbufzeLEYo
         DV7Sv8z+TkM0VGThKd0RL+YQbWOI7WKYTJCCkbCSXQBqLZM2tM+70OYC6NO/QYr1GLI4
         EzFTnpymT1W+R2Bg772icNF6lflRvTYFJqLhsmemkh3eLESXtU/rpJ1oJepwlfeYgvTi
         n2/w==
X-Gm-Message-State: AOJu0YwYJc7NO3NB6HHt8u4wrSHCbswsObr9mMkaJ+X4WFimAskmSooP
	RD7Z6yZvvi8WVdiJeMHf0BLp7ZMEKtGjzTXaDa5aKxI6gipxPzYQpqPrXFfxtfoi
X-Gm-Gg: ASbGncu3GKesbSnQhu798YdcpW++4MJ5Q0jjobiyShuqvmQn1wPKddCdLYXBLd8BpgL
	9fkhvX0QyZeVH9tWES90QhBFt32ccQY1UWKpmj1DfirmABWRTS4f8Sc73WnoYMl7j2zP2JH/nVx
	KITnG8adAMVyeKBEZZCLTpDm3b+cGijNfqxSg7FF3uOGcnX83PT4tE81cO4KQvEjIgv/NgHrT2G
	+yJjgqwVlzN5eOPrqnC+kN0D464a05mFOm2dBUfwt/3OcJ+fGRoK2THlsAslHYTReeNIAwZKWxw
	ftn9KhLKkDi6OGi84pug3FKENInPqG5hY5SeMLZIQrutA2dBr+r5XZgD/NS4GSKPtsIr7MwhaMD
	C6S+ozAu4kf5l4M2jMK9S58fNc55qgE77K2uK0LzwlLSH0AwQYkXGw+i4pzcwJKP2ww5WK8eBGQ
	==
X-Google-Smtp-Source: AGHT+IGO3h+geMAb+aFOXocUIHHqcXP3z01xZh8HgAnJf66AC06o78KbI6b6JgkavK8EPPh/5SKoag==
X-Received: by 2002:a05:620a:2908:b0:8b2:2ba7:8d81 with SMTP id af79cd13be357-8b29b96d08cmr450591985a.87.1762969730595;
        Wed, 12 Nov 2025 09:48:50 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e3f09sm233619285a.36.2025.11.12.09.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:48:49 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rteval: timerlat: Disable auto-analysis with --no-aa
Date: Wed, 12 Nov 2025 12:48:35 -0500
Message-ID: <20251112174835.188210-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112174835.188210-1-jkacur@redhat.com>
References: <20251112174835.188210-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass --no-aa flag to rtla timerlat to disable auto-analysis, which
reduces CPU usage of the timerlat measurement tool.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 1c7fb1607682..7ad8997c95dc 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -231,6 +231,8 @@ class Timerlat(rtevalModulePrototype):
         self.__cmd.append(f'-c{self.__cpulist}')
         self.__cmd.append(f'-E{self.__buckets}')
         self.__cmd.append('--no-summary')
+        # Disable auto-analysis
+        self.__cmd.append('--no-aa')
 
         # Add dma-latency option if configured (default is 0)
         # If dma_latency is explicitly set to None, don't pass the option to rtla
-- 
2.51.1

