Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3D19995E
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Feb 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957231; cv=none; b=lPqF/cmRwsyOeQrTQMdQyItUeQvWDUMA43nsPlL2SvPMqbU7Jt0+YBajDElFdCourTkSzxIVm0P0pudqZ+hh17RitYX4jDG8KJLA55Gtzb+O0n1KAn9eH5X7fuXL/j5bFUiUM/EZpXwd9DD8q0AFvAFUspcms8YVxOo27/gxKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957231; c=relaxed/simple;
	bh=RBeJA2Fo9WSN1R+Am9Ma+Y1x6kY2WB/j6HKgm+H/zEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ht3AxbTw0aOfzoUxMBcg5ZUVihBz6Qm1ALuZ5Ds+puepXF3NMNYLnX4O/MzmhCBs5+RbettEJE043AIYMMQGpELCqfC2wnE45Fhc/AuWYaZybwZkGbM3lf8xj+A9Ei4IdjmGKc0YJAYPLtu5wG7PyU3Bcf4uyfms9mYdm6Wn8lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqMq6SPo; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqMq6SPo"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467a37a2a53so26962671cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Feb 2025 11:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738957228; x=1739562028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4sCx5HbLovmEngSUo3k9cWPwTHoicrSMEC00YGd/juQ=;
        b=VqMq6SPol5lW05nIp8YgokHz548sE5bjbF68qVymkz4G0krf7FJ1sWRMyQgpoPr14f
         cvGl71EDfkDTiRxFIiKOz1BIzzZPO3KfUlIi0wVmmMiq3bp5ePtmE4sYsFXUSpHqTf6X
         ri+P/ulPryXWZMl/OHCvLvTzzrpa1T64iYE9KYt4DI6aeoa81eS+lB/inggJlvPkKn05
         WQGBquIzv5Lm2vMx+uuzTDrmCvsi8oi8RVtEwNnnaLXOAgmc+18oGiMfpDHwaOVLPTJe
         0zZP7E2+ZEocy9T9BadgHLdLQU9GTj54yAf4bXkPQhRP+jwgJH8FgaySNuDRu2jgUO+t
         gcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957228; x=1739562028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sCx5HbLovmEngSUo3k9cWPwTHoicrSMEC00YGd/juQ=;
        b=m2YdT2H111+uEqwKqSVW+SfOERisRur2lXjMCQHAhnzeLtvY/fZrYE7NWi9zWNM5FW
         lL1LOOt9nyNJymHnNvRpLoDDIz6UIKJVcAeSmL++vLiUM77c7KPOksOf87lCCqao/vKh
         VhLlzt0ALf2rtQscrQ77lboWbg+JSxE2vwS5ahIMBAheYYHNt7ViAzygqY6tVj57eV8y
         lH0ejuGoD7rbANHYEuZPjMK6jN+2F4FYJQ5b1trHyWqxgxoFbeKuqmjLg59xFUpzzmbc
         mDdyVAqU0k+3RSZRrXL1Pdn2cqjyWDRCcCCOLdOknOOTXQmuz6BMZEo10aV4lEyOosoE
         9JvQ==
X-Gm-Message-State: AOJu0Yx6nFByCYnDzXY85gwEXx8nbyT6Ziwn5BZXzntKSEMakNTdu8lr
	PpoqtgkaIyJD7zxLsQRnp7AcO874S32ngBzycVFBr3eP1vHi1h/xt3QHYg==
X-Gm-Gg: ASbGncuBJjDkk+bpEJaOQJbniBc1Sm3lBiiLW6XkOxiDKgwBIXHGkEfMJszZm+sI8x4
	cvDhCFy1uEwC18Ez8M1YiQcnkFOBW6/oyZcXu/aqdYDUmKef05dgrn6HP0B6lVotO8FaiTtpGfF
	cW4H4MMk250jRxvKc9i+JNa3TOv4qof188pRW/qui9XHSUH5OGQwepL1Pbdzm5RRfPYFl/PpXaQ
	dGkV6Eu31xqMgUJBiFh/RN5JlT5bOruA83QmM2YYlm3oQyjn/ybHNpfwTisV0Y7rgQktuVjfxDG
	uRMB/UFlngmVKSkmNUFZ
X-Google-Smtp-Source: AGHT+IFZr1Qskw7ZJ8qrYG29Rnfi3bB183VSJPJvJ18xN1DEhFf0CJS2gm7FpG/MY2EaKuqwmrYDGQ==
X-Received: by 2002:a05:622a:44c:b0:467:68a3:4c44 with SMTP id d75a77b69052e-47167bcecd7mr66443251cf.39.1738957228344;
        Fri, 07 Feb 2025 11:40:28 -0800 (PST)
Received: from fionn.redhat.com ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492adb54sm19923641cf.39.2025.02.07.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:40:27 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rteval: Change the default interval for timerlat to 1100us
Date: Fri,  7 Feb 2025 14:39:48 -0500
Message-ID: <20250207193949.67985-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the default interval for timerlat in rteval to 1100us to make it less
likely to encounter a hang in rtla timerlat hist, until we have a better
solution.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 5bfc495217ea..fe29f34bccbd 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -509,7 +509,7 @@ class Timerlat(rtevalModulePrototype):
 def ModuleParameters():
     """ default parameters """
     return {"interval": {"descr": "Base interval or period of threads in microseconds",
-                         "default": 100,
+                         "default": 1100,
                          "metavar": "INTV_US"},
             "priority": {"descr": "Run rtla timerlat with this priority",
                          "default": 95,
-- 
2.48.1

