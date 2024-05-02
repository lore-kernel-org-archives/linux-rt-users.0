Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD215E7F4
	for <linux-rt-users@vger.kernel.org>; Thu,  2 May 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670070; cv=none; b=Va2fMM+7E2XR7GtvQT0Hsx4lVHczcFi9a0gDRi0Y9n1u6VsBuXTAAZ+NYiOyVLh+hxe+4OWqLk8/P0hb8z08Rg/WygU9vsNtXwICYxqAmHKoLcpZZd/ZXvFqQdEjH+w4ELDXvJUcQNtUMVQi8LsaDZBdLcXi22jWXS2O69zZgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670070; c=relaxed/simple;
	bh=1/WjD9nDI0+dPjMKb2VGj7hTW+3i/R3XAtV+oW3nuc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVuzoWjjTzyJgTvYv9tqFZATlEgnGgJ9auTwuj5YESYF7LgmX5/A4fWVNjWscFNxJA1d/gyampoYDaBYB4/zRBrNyTDDs+X6rPzV1KQqUlvU0DO+vzNMKPwQUiYDL+URaMTD6umavRTU+dJEp4zT5AwaBaNCF075XRC96lx8xkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grQsrbAD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grQsrbAD"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-790f699eb2cso399385785a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 02 May 2024 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714670067; x=1715274867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lXYDzKT6IYkDxj35Bqd6IVjyvmtIhkPLdf4vmZl31FE=;
        b=grQsrbADmQDbv8uIejSe1aQGnwwZT2db1cfkesb1XIqkHXp5Pn5oAlpgnGOtiDliLF
         DsKE5vQfxvW3rG6lANnwBz/WgR92VIdbt4uCJ8sJPTI1BC17RL8YePhZ2iameWSVGV3X
         rDFVO2K1N4aSp6sZGoWy48LBv1E3QVBjRnoc813ZL2q1uW53KIgm84eIeSMz9l0hq2t6
         kZd62DDQ7A8DXWBOWD/6fbokqjWExS01SqEd+0CBL6mbFjfMPluFiXUGFdEYnlvA1w00
         5oS0pceFWIeFrI3qlSG0DtLAYL+hk26r9n69jzFgsktBpIMbVSoV1/7rLv8DKUqRhfaC
         8mtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670067; x=1715274867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXYDzKT6IYkDxj35Bqd6IVjyvmtIhkPLdf4vmZl31FE=;
        b=Ul7SZ5lylnaR4H6eqbwjgX1+jvqtI9jl6Ky5O84cMGqO09PwSlzclwlkN7iZz7yqfc
         2h8atV9OmfiW9pnb8k72iDAHj4JEu7WcuHrm2ufHR4ASK3QyxSP8uXAY9zU7EGvUZ3gI
         sfCODzH2DjmxBz14ZyPFtGS34/PU309qO7LGb2x50zK0T8Jm3NBAf2eDFDXCmsTkDYDk
         iyXlLQw8F65a/4ijYfTH1+jd/n4SPZGb8pRKmx3nbDO+iW/+BjoDgfYlobMgUQfQrW1/
         EjmYq/tox+14UBz35Zmm4d9HnSjAxTSFjMs1kSC8x+ZaXBKjr3vyQ3WtlnneErP1nvrI
         sWMA==
X-Gm-Message-State: AOJu0Yzpov383Qx9m4UsPjMIuvvq4ZUgIecBvs0Xl2NLYQQyj8QJGFtH
	YuZBgmPVGFWw/OlK5CwacDUNUZO5NQuOqfmLkhAsoeIHvKkTjIxlUc0mWw==
X-Google-Smtp-Source: AGHT+IHp3SZrc2PdXERTxHc4sDlC1oDc/SpfurvIDBJeEb9At5rUmI068VSgLI9tSKtFJqchQWA0tA==
X-Received: by 2002:a05:6214:2261:b0:6a0:c339:1edd with SMTP id gs1-20020a056214226100b006a0c3391eddmr197559qvb.42.1714670067541;
        Thu, 02 May 2024 10:14:27 -0700 (PDT)
Received: from localhost.localdomain ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id b10-20020a056214114a00b006a0fc572f21sm494881qvt.127.2024.05.02.10.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:14:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Use get instead of setdefault for calculating range
Date: Thu,  2 May 2024 13:14:03 -0400
Message-ID: <20240502171403.20863-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Crystal Wood <crwood@redhat.com> points out, there is no
need to setdefault when calculating the range, just use get
if there is no value.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 2 +-
 rteval/modules/measurement/timerlat.py   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 925065367eaf..3301e1b45e11 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -115,7 +115,7 @@ class RunData:
                 low = i
                 break
         high = keys[-1]
-        while high and self.__samples.setdefault(high, 0) == 0:
+        while high and self.__samples.get(high, 0) == 0:
             high -= 1
         self.__range = high - low
 
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 9fa931043e40..e8345fab1ad7 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -106,7 +106,7 @@ class TLRunData:
                 low = i
                 break
         high = keys[-1]
-        while high and self.__samples.setdefault(high, 0) == 0:
+        while high and self.__samples.get(high, 0) == 0:
             high -= 1
         self.__range = high - low
 
-- 
2.44.0

