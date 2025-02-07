Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F319DF44
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Feb 2025 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957234; cv=none; b=dTbKmfzjOo/2mo2muBN1CUNPAcXZwYeUrV3b8om3ik9f0YzuLJMhKZL6dyx2cyUuHhaeZI+il9JXvNW3TlkanvCOBcgRevW8QSo+SmGF+69W5nKOe+QnUpViUS0SILR/B2sxzjejc32v92aQIEv8rEIVP6mE0dQTJKriCnBKLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957234; c=relaxed/simple;
	bh=zSk6f5Cdfhy0BxFlNfrOJ4kaBs7eslEcXx0ndwi7gQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpgFPOVLox0qnlyup5izzTBY6vXkNO+0y7Cy6K3wN37aBmKnP6zMbcyEpGpT/kDfvnCgAkp4jAiBSticsJenlbta2RQfdxqIpU/27vsfkqUnt7gyO+/os6EK5lxKZy2/RzoDfRcYxcS0kqu7dC6JxqUvH0pAg9gW1Xe61YRdJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPNhq4FN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPNhq4FN"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b7041273ddso222181985a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Feb 2025 11:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738957230; x=1739562030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/rS0IfaqBYDR17jv2fTEsgvVog3Txu57N2h8dFGeAo=;
        b=YPNhq4FNsyqV/UHNDogvj3/gBmqjgh0Jp8SAYO7dv+Vwb9CQoQHsSO3khZBJ4H2pff
         Ut+/gGPPQP/jOfYv3gkCUZNToDbymtDx21POvhZOuDVrll9X2mQ30Kr8ixQC0tXGaiIy
         njKQu+0fuHV8qiPA5HnMeOFQJycg/yf+B2B8GQD9Ux1L8SxtyxsnAAdC0SD7XkzR7Wy1
         v0DUNFXxXASnNc2NoXuhdb2AgJPr2TB4jACiSdnVFbK5goFLiUZAbB3+ALc0xyNodsq8
         GtGLUjZQ0AGSNPeioQIG3XmbZ8Sd31/ygUnt+6KgNMet8Hh6sVu3Lq/jhJCou1Sy4PmE
         FDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957230; x=1739562030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B/rS0IfaqBYDR17jv2fTEsgvVog3Txu57N2h8dFGeAo=;
        b=gB0A2WE973tejE859g12j5WeDraYgv9mCovHg3L8kI6uZI6IVOlm+m+RsfpOkA7J8r
         U6fOIJHkvhsj2uSYFIBiG7AdVNzVCbG3cRTb3ja2QOIVcaX2iLhXuCqF9MZSMIYYlAVY
         i3NJAq++6yv99m1u181WOh6ji9r6XVko2/EOIKZvHOpaRYCymAmIjy4dmZWm70xRj1H8
         NyAsqlQYKd8rozk3l4cXcDcpmgfxiIv6AF/J4OANzjVHfLpmsyyWNlQ7OGq85shxXkmr
         kMc/c+2vIEKmpTNCxKrs4Oq+xsDiDDK3EIG2M8p0esQQeRJjdUCZt6Few9CyZtdjc91x
         3xTQ==
X-Gm-Message-State: AOJu0Yxj8pQfyaogvioJAu0f02TP18v6jmrnTNYq5PyPBPXjmge9VzXv
	zHr7d583CeKlijF2eEZebCfL6BLWVimby9TaMtMu0xjZeTJccrBHzXzi6A==
X-Gm-Gg: ASbGncvJMTdZFj7tpu1MMzh+m3LgOhvZr7NyKF+nX+jOgutpO+tm/lgYKw4OMHaG9JK
	6ObmWPzycil6ZI4afYc4EGnanT3RJdnSvIGzSDToSYnmhtzSEOlD1MRmGxT2j2EuQBRWlXo+Ksl
	cO3Imhg6gdHotbqrxIdnL0/puGR+wkHgBVV3DyF+4e54EDCJQPgq33Dj03EqrQD+Sf4haMJQwcE
	t97R5I59aVVVYM+ldiUXMdLH2I7oohUFUm3DoP8FdPG1/+e0XGuKcrGjbj5yhD1U8fwUGpQK+if
	pBM91hANsloJauNcssD8
X-Google-Smtp-Source: AGHT+IEEP9gkoZEFFYEHstzDD7OHRXGLnZg9IlksGFepgIEeW1G9R0W640iD2soxL9GCMX7+XHifeA==
X-Received: by 2002:a05:620a:2952:b0:7ac:9e4d:8060 with SMTP id af79cd13be357-7c047c461efmr622952385a.58.1738957229725;
        Fri, 07 Feb 2025 11:40:29 -0800 (PST)
Received: from fionn.redhat.com ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492adb54sm19923641cf.39.2025.02.07.11.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:40:28 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rteval: Change default measurement module to cyclictest
Date: Fri,  7 Feb 2025 14:39:49 -0500
Message-ID: <20250207193949.67985-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207193949.67985-1-jkacur@redhat.com>
References: <20250207193949.67985-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the default measurement module in rteval to cyclictest
until we can fix a hang in rtla timerlat hist

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd  | 2 +-
 rteval.conf | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 9875903c0107..4e13d312a24a 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -250,7 +250,7 @@ if __name__ == '__main__':
 
         if not config.HasSection('measurement'):
             config.AppendConfig('measurement', {
-                'timerlat' : 'module',
+                'cyclictest' : 'module',
                 'sysstat' : 'module'})
 
         # Prepare log levels before loading modules, not to have unwanted log messages
diff --git a/rteval.conf b/rteval.conf
index 46a9b1743716..601410b51c28 100644
--- a/rteval.conf
+++ b/rteval.conf
@@ -6,8 +6,8 @@ duration:  60.0
 report_interval: 600
 
 [measurement]
-# cyclictest: module
-timerlat: module
+cyclictest: module
+# timerlat: module
 
 [loads]
 kcompile:  module
-- 
2.48.1

