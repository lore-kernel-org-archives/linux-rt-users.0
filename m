Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB53277C9D
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327765; cv=none; b=bVwEPLuUzdcLitGCQF1DuYrVJ6edrvvwbgQUy/Xd17562oTG+QYwvwNnogT67AAVVTbPw1Mdyym+/KhUIgWTYDj+Vm/0W96ef/8pQmoiKl5b/BZdMOX2pf2IVUXLBLYg4Nzjodn+gS1J8bZxsKswZ6xsKHiOa/09OvVcCc2w4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327765; c=relaxed/simple;
	bh=ar2DOOKM5uq5LfH4EKIxIaMfziR4SwBQLSWN+ilPPPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afNLrqyn4iQP0t466dGtFdYnnxxHcAc7heSvPYsLO0XtXqmgihZ/6OrVIRp+cUeC/Aac2iZ55KXj4QjWx+CuQipg5B/k3tg4bVrxTDGN2uE1haKF+gUXVfRyZhJ41/obdmCFgrWi3TBC3FAayiPImWb1zvzoG1U5svQNdSP8OMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0a6JcG7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0a6JcG7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2353a2bc210so30483795ad.2
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327763; x=1752932563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJbt/ktwgfm7q3F3agsVngbHRn4UF1sNtjp/7939OU4=;
        b=F0a6JcG7DkzhPQ0UUU4M+Cpz7QRt7gjUQkS5z6SOTuWIBCQthMAxzzea9F7K94WiGy
         U26AS/RUQ576vM9bGEDxTCE5R3Ye4r4oKxUCkhgqR+uERK8wQW69aanuVrsoNMrTJ6ta
         rYTyGGj0Bb0t3XzWqENQ+A9AM4P9qD81tWnltIoJyT6LdicN4eE86yXFy4mnr3b6oSHx
         JXz4nIT6XWYidlLSM9rt5W1Ji9xhMKRSxQFbkjSi6UH8pONP+o3J9uPdj6c/mES0UIwC
         r+y+kjI/HmlpNCHMIvbdxq/BSmIipFDzc9Re7CpBVUwKaVDrUT1OwycHExBfEpbaDpaY
         qP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327763; x=1752932563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJbt/ktwgfm7q3F3agsVngbHRn4UF1sNtjp/7939OU4=;
        b=QmSfUnb1A1WfK1C9cMyEu3l4+zj+exRldiJV0mGLaipuK7JHKOJbq4PQCmS47AI6HG
         dRY+cId4urjkikhLr7N1Y6eIwbgS2q8hDoK5PTiy4QlXG1qNRnhDC9GUx5kTRpIILIiJ
         svIONekwJn9SJRP47+llnRbiEZ7f0fbfO4RBcAiSgcvqBLePBi3D1A14nuEoJlgaWlUK
         dbU6k3VeIQrYDq41s60/9cAoCYWYtpceHOf399JDoACbY6L7wWNpF+lzEvJ1xOI1qXcu
         WBUUEuf56Km1KZvhr9PfrGBic8Moi5VXW20pgmTofulrc3DBDxeerP3UOGEm9WvsbLiB
         dflA==
X-Gm-Message-State: AOJu0YzguLh1sVKmZZXD2YV0IjfZNHUHx+iKAyBfpxnfZ0Dv82Oai4Tt
	1eWGJlJVfTmKgy0OE9V7KIdEN/InxsL+wbRAMTsB46yAG6KClihG1Ryp
X-Gm-Gg: ASbGnctz1Agfy4p0D9pOeHmLaYUoksVeuKwSlXY0GwtOBnnMPuLqCpXMIwZsgSMrBRT
	TklTw/MOGhghwXympbVzs5sEkhRkW4GjLNX36kABE79asPGGiQ+21jqMWkEKn0tT5b31cOM7drF
	BkxfrlBV3XanANzDJDfzLfGQ5RY55EizIP1EQJeIjShbYQPgJe3JYBxyk7ng+07bI+DqWWVMyK8
	A8oG9tsVppyYGCFQdFiDTcBZRneT739tGVhKV3npatgT/EQ9Rd9bGwSxNgLVECLwI9jN1cRiZoG
	JqOXrFuzLxXVT282/fatuRH/1dGauTuqgHArA813po+aXcdxQfyjzir9h6akNniLn3rJULyTZQZ
	TaXmyNSJxlVNH1L255xIBE+6bd2Bt6E55XpbvaAb6JkDsqkQV67PUF6mAtqVSuzw=
X-Google-Smtp-Source: AGHT+IGNVte/qCFNVtdeuZN7/ZeMOZfY66rWZnuwmaKnrSLJQpywhXe2DKCsIS4biEtd2u0xzBWFzg==
X-Received: by 2002:a17:903:17ce:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23dede468b9mr118335405ad.16.1752327763398;
        Sat, 12 Jul 2025 06:42:43 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:90c1:8214:37cf:b3e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae865sm64193205ad.72.2025.07.12.06.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:42:43 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 3/8] ptsematest.c: Suppress warning
Date: Sat, 12 Jul 2025 21:42:08 +0800
Message-ID: <20250712134213.58582-4-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250712134213.58582-1-yphbchou0911@gmail.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 src/ptsematest/ptsematest.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index d211669..787909c 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -62,6 +62,7 @@ void *semathread(void *param)
 	cpu_set_t mask;
 	int policy = SCHED_FIFO;
 	struct sched_param schedp;
+	int ret;
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->priority;
@@ -112,7 +113,10 @@ void *semathread(void *param)
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
-					write(tracing_enabled, "0", 1);
+					ret = write(tracing_enabled, "0", 1);
+					if (ret < 0)
+						fatal("Could not write to %s: %s\n",
+						      tracing_enabled_file, strerror(errno));
 					close(tracing_enabled);
 				} else
 					fatal("Could not access %s\n",
-- 
2.48.1

