Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79F1E511
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Oct 2025 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041670; cv=none; b=FmEUqsvUhDufLTpRv4xFjX2DhgqM6HqwAWf4YltQDOKTrA8ASSMLWL/3Ugv2Tu+CphVQNVuXxKpjaQ7tPng9C72710mJA+vjUq6eXi2Qn+LRu6/W/FTWviNRli/J8TCRKbhq7hKM2YFu1Z02niC/FhD6uUdyT7mLgpLc4D4j1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041670; c=relaxed/simple;
	bh=fmQMePPaIRdxHpl/EiCPE+HlHVFieRoUbJdfTnb362o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/6eO6estUgDSxkUEhqduXQC7njYUbSaKf+qx3uogL2QKCt/j/xuyIzog2zs3jmQme1Ndkr8a5WTMrxga19LlkkOoTmO4TrSNuhI+UMOvTvYZVhU6YgbHi9t7y/CHPPZ/wOUF93lRDDdKM/M6iBWQHpthS7vUtcqrefbUOmz5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWVe9PVE; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWVe9PVE"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-796fe71deecso13114566d6.1
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Oct 2025 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760041668; x=1760646468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPBhr8VeX54MJwK5FrWVamao5N3BrOz5+/iCg7KUKvc=;
        b=RWVe9PVEkIb0BTiJjcZUt9sNrGxp6cWpaYHPKX0p0+cEqt/i0dLT2E+uXOeR43UqWq
         Voo1G5h14drZCrcyOoj5d6aR+Yar4DaAY7EmYOHRWwpITuGZwMrlVFREOjCHJvK8DwKQ
         BJOlfUNMF4YGc8XDSy91cV2rOC+NVExXosVdxxbK67ojJ6viZK8gQqviYF4ZsdfRLB/n
         mJs4F+Ah+78FW5Qb/elZlcDUOz3OumvwFNMi82Imem7aay6L33/ttgv6EYYpnDsESX+v
         NFdmQYT93GXNr7hzjvCaZXHa0K+DxheY+OeVP5g8rcbu97HXvG1KHnC8F2nZ+HaFnMeM
         6n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760041668; x=1760646468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPBhr8VeX54MJwK5FrWVamao5N3BrOz5+/iCg7KUKvc=;
        b=orp6UGxVkeN0kxssHCH7EGH7ptSC4/2zrwDIJB4YTdO4EWhNZIfVf311KG336asGi/
         GPpxZbAO7VLWcexprZFboWc2wIzp7wQV9ez6/zsetlWmIFdqWGAz2+B9/P0s7r0DnuSr
         B5zsMGY7+WtCcu0AH+Lue/QrecKxDaRjSP8INk19d9wP3hNqWUD4zmElVVFqp1iHssBs
         FKGRmWlryUqM3K4I6NWS/EnLxMgojAYGbRfpp+q2UcsjPNwaXZUpuFlttQLsQvc+r9+3
         rMW6sbEcJQLKcoEcTyOWhDWgX7eaoFDqJziTf8uzOyEqkw1bEl+63eilkuwfjxeSRclG
         nF8g==
X-Gm-Message-State: AOJu0Yys1TDz0PwzOaYwpC7dNTqPl4eG9qzT2vdTP+aNcbx51RHQQl4d
	08YPY6c90CRG3WKO8383t2ru4v0uQ9gHAxEZlD9WE9LrdL+iPdXCAFf4xg4ZTl5cu+E=
X-Gm-Gg: ASbGncuINq8akkKX0tQmWgvJsqUbnvZ1/pq6rLk1MCr1hRpbkbrAH90b/g6Gg7OtVyz
	BuG+iCDpODwpHSoZ0cVA34VyGyj/1AWyRuMkzL31AZqvUbXvoAdBfPk/88eHjrfkqx5lU6CCLdE
	y8LcOiEg9ddcp6nFXJ4z5t5mtA2kCY3nZ+5AGGSZ4LsW1IgOgqE8QC2Kt8W07EIRtWyh8xVB9o8
	EcC3GNK6NLTBycKsHJsv6QABTuN+RyyAI9DKxxijvcA1IgVIkduJoLUEMTHPWazfTfLiYifWZ8E
	dsghp2ILIBDDJaswSjN7kphhAbWZxMaP36OCdiEraXEn4wNdoh5/aVuwMR56CW1X/3YL//Gy9JG
	X8N3DUsU5b5+GLoiYN1Bf7xW5R1hWpxAQwtqRwvy6DPWaa83bzCBqVAiibTuXZq5iveFAfHSElq
	nOFX4WS3tspl5dlzuuvSuMcJf7nMdKGs0OnuplAuSNbShSYA==
X-Google-Smtp-Source: AGHT+IGSQngtU+cBerIjwG06fkC9oMZEn28UK0Bp568LWYbnGnmt5QkwmriYe/uPWoT4R/x1UHDrfQ==
X-Received: by 2002:a05:6214:1301:b0:7e7:a043:59d1 with SMTP id 6a1803df08f44-87b2ef36f58mr121497536d6.44.1760041667692;
        Thu, 09 Oct 2025 13:27:47 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35713ccsm2664286d6.37.2025.10.09.13.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:27:46 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/4] python-linux-procfs: Fix spelling mistakes in comments
Date: Thu,  9 Oct 2025 16:27:31 -0400
Message-ID: <20251009202732.57880-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009202732.57880-1-jkacur@redhat.com>
References: <20251009202732.57880-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Fix "progate" to "propagate"
- Fix "sistem" to "system"

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 procfs/procfs.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/procfs/procfs.py b/procfs/procfs.py
index 7e9459907d5f..c33aa73cd211 100755
--- a/procfs/procfs.py
+++ b/procfs/procfs.py
@@ -346,7 +346,7 @@ class process:
                 try:
                     setattr(self, attr, sclass(self.pid, self.basedir))
                 except FileNotFoundError:
-                    # The pid has disappeared, progate the error
+                    # The pid has disappeared, propagate the error
                     raise
             elif attr == "cmdline":
                 self.load_cmdline()
@@ -602,7 +602,7 @@ class interrupts:
 
     The information comes from the /proc/interrupts file, documented in
     'man procfs(5)', for instance, the 'cpu' dict is an array with one entry
-    per CPU present in the sistem, each value being the number of interrupts
+    per CPU present in the system, each value being the number of interrupts
     that took place per CPU.
 
     E.g.:
-- 
2.51.0

