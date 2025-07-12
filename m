Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694B277C93
	for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327764; cv=none; b=BihcTRbykdHR7XBSTRbwCKXgzOiUoDymsDJQgJ4Fs87HjlwE+yfRYDWPZWyqpFIpK33ot7vGiNT6jYP3CCG0o+g6BxbG6vetcFAt7/xOPdEtLv8/0PEoPDgIeGjZVaZjLBheOkbWRPfvWB6Q/GPFKkDexchl/DQT3rV/vjhGN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327764; c=relaxed/simple;
	bh=U8YQkgkMshDfBuubV9pLZLVYnqXDrRwFwdt1RQ64ruk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byn2yNGYQXYvsqbTnhF8qqmbky0iJmEtCPlcTLxI+S5i55c5Nw9UDVS/5aYM9BgouY3sSP5GDIz1OUqOVrVg0k4jajuMKlgSEJfbKcuhz1d79xY+4fXhYiMM7c3kbzXyWgztjb/AcbmAwJGk0zRWF7SPRNxsK2QbwMBSr6NR9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdaS/7rB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdaS/7rB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236192f8770so20449435ad.0
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Jul 2025 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752327762; x=1752932562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKneE7UcAo1yUnwfI0jYCHorqt/DSaE/PvPH0EFVytI=;
        b=hdaS/7rBaa44xZzTGu9C4UFZ2ZHNWqQg/a86AOmom36MQXLcFLARyxW6jmSr9qlbAm
         Qt9n3tO1uls2Ut18g7fYtvy5JNGDvCNLif8/hPHVQ0N8HNDs5pZTOt88/L4o13dyyqrY
         VG5aGIVwWACqmpuTC9ZHLr8gtsaQAGJR3L4VwHJsiHBflN6RXcaqVH8ul3Kx64agOnev
         VQux7DgH/tXg1Zfkzz7G9m6A83q5/x6r/TbF26zdT/FD/e6K9Qz5bVtdK8CH/d6FR29K
         SmYOyBahHQvZZ17ALjZKpCGF3SKVYkTK2JTDmnawRRFkGoQC+WYlv/xrZcatVyYtkder
         NAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752327762; x=1752932562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKneE7UcAo1yUnwfI0jYCHorqt/DSaE/PvPH0EFVytI=;
        b=DuOz2rYem0dwCQd/ccBM9ArPfmYLS0i40952ZPtGMcrQ8cDncQXl4Kiw1dMqEhH6ej
         0AEwXJpaJhYdF3oD5ipD9nSjoBO5fUjyCP12LFr0eyfbaMDmsicCDVUdqAv4R7fcBZTo
         SM3j2cyzTHcM4r009W8CnusiiFuVqdZA2ecExb2vv/KA/UeUNwYFjGATsjK8msxs3guc
         DS1VYPh0/C+psuCxu3xXI2xUStMRQpFwR3NUkHxvrIU/+mTvHoFKhiE3Mxa8FgQJXemQ
         OMxlPq9XqtwUCv8jTHDvcp/GhAU3rf9ZDL2omIUnMRW0Cd3mUxwAV4VgSgH55o3wN12H
         D58w==
X-Gm-Message-State: AOJu0YypWDLJEXrknDt9UtxPRmB8XfRHAvcmOVAQZj3Z5KOBAQ5Fd6Gc
	Sj41pVI34MHfOysvDEuwudljBi/BBGyMQAsLdjc35w/ghuWKr5QP8u4h
X-Gm-Gg: ASbGncuJoB/BP51k8yyetnlC8/hFWy/46W/nwtRjFloeznpXDWsDN5gkaWjECKxHCrG
	l9XTN+KxFRzjE2076BkBqjjDA19cKe3GOLagqBgh5MijAYlyPIcqk/tWi/Gnybn7cxGXaIbRVkt
	W6poqpGt3chUWE9JO3vLybWJNGoPWP25O4+bUqOU/0ymVbxu5+EFe67nEofXQfx6pY5e0Fmr4Ux
	EJJgNmLvrSbQDFd/KenOJE31AZoD20bQVAYu+w/NR7hILQq1ptaZRFZHee1O64/21J2XDFbY8ML
	fxEFUs+djPDX6exumsAWO8DMmUA7RpEtCeKSxDFqapu7uzNiOqJnXsLeSO8TCMPQ1ickBmmnlv8
	q00y31TUKiesT30kpMVFJQPJrYMMcYXiYYGicw89WpKzEPHIbNJBPuK/YqMPr18k=
X-Google-Smtp-Source: AGHT+IEgmUf/cniuu0fqCOpyC5Gy2Q5PZkOkwToeopkxqKktCIIzKTgkqWwQXwRRzDit5HjtIEn+4Q==
X-Received: by 2002:a17:902:f70f:b0:232:609:86c9 with SMTP id d9443c01a7336-23de2f47a50mr162091105ad.9.1752327761976;
        Sat, 12 Jul 2025 06:42:41 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:90c1:8214:37cf:b3e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ae865sm64193205ad.72.2025.07.12.06.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 06:42:41 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 2/8] pmqtest.c: Suppress warning
Date: Sat, 12 Jul 2025 21:42:07 +0800
Message-ID: <20250712134213.58582-3-yphbchou0911@gmail.com>
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
 src/pmqtest/pmqtest.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 04e36a1..eb20baa 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -75,6 +75,7 @@ void *pmqthread(void *param)
 	int policy = SCHED_FIFO;
 	struct sched_param schedp;
 	struct timespec ts;
+	int ret;
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->priority;
@@ -189,7 +190,10 @@ void *pmqthread(void *param)
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
 					fatal("Could not access %s\n", tracing_enabled_file);
-- 
2.48.1

