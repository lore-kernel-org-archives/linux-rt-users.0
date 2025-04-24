Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA9281501
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527738; cv=none; b=MePQVNwWjNdHF9nmzSbfP0yft/nc6My2G7IlK7FO1e7kZ1tNRDaA9Q0bW3g8jxE+4e+acMBhavxssuFJxJGfFOLrZqfBfCNUMpJLLtzUhJSbkjuXh7VFus/hISHy5RYA1+AHTWsW5jcPpykocKreozatdPU0igsy3WutqZuJabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527738; c=relaxed/simple;
	bh=t4M8AuZVbcZAFfAtYLYy713r2sckgmEACXuvLg+kkGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSqmJXccO8cZEEDPvhEzkm0LLX2t2/r9fCZP+CKuyCGxrgYFT+BePmG8K27VJYdJm2HLxLVuY8ka3wBXMwwWpPUgr42ftK1OfhJcISs2STrf5qnGP6Qndm6l0Fg1q5o0VoYlsS5pSDFIDFoAR0TO7S1CFHVkbZM46myHSmVuywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbgZ7Zn9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbgZ7Zn9"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c9376c4bddso172310785a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Apr 2025 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745527736; x=1746132536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf1wIc83Y1Y4d0i8JkTes446GX1WtJ3porzHp8xmEf0=;
        b=PbgZ7Zn9R8rpzntZC77hy5TA3uuXoU1+dC8sZyklz1w+ZAceX5mb6an3IE1M4TXMnK
         XYtSJsT27GC9vDxmYXyRhYXy08IFtnEw5ZBzLQ4U9XGn2Rdul6cbS0uD5fxRqTGAjss3
         xiImjL0WR1ZjqJO40W8BHol1TYpvyAykP/oiS02U57qOyWUNvsVDOmuvyLwbH0W2ck9c
         syTPYXBSWXldF0dBbMnZDWwkLNaMtvywB1Y+dtzB7Z372+Mxv4CFnICchDRldq1S5ANG
         oF+fDp6xv4rWJzOFfBI1kfpX9TdCk8DheF2Lnyvvlrj9hi2nM1lbJU2XzrxVzi+TAIer
         X5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527736; x=1746132536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lf1wIc83Y1Y4d0i8JkTes446GX1WtJ3porzHp8xmEf0=;
        b=pUSxSCloJxh6/EbmV1Jzk/PGLGsy9iQ0RhUbEatKmLaPhBPQ5AUeIfXsq6oFcyDm8S
         cchW+7lfDuKOPF0Mo/zkpWlpTB0iRZB062A3AJveBTsJeW9ihTbsEYoyNtl914b4it08
         8d2kGHQ7h70ms7slULXBgFNVpA0Q4QDogQJY9BNf72RgwPKSszvueIYsSeFQX5XyOuau
         8a6dcWpQwuencAJQ7khM7f1fHBj2YbmwfT3dX8fp7BXrnad932lSaQDbp4N8VwAwIu+Z
         hlUZIE+x/GC6KXk5rl80cDRpARI4b1MUp5SlQR56FTq/j7iJJBB3ElNXOrAcHY3XCPBG
         QX4A==
X-Gm-Message-State: AOJu0YxUvNkMVj5ot/uZpmVqJ39QkNDJaEzrpWx+xUFu2e4BgmfQqC77
	qZNc4tDPhqYzcBR9CB75/bjEexYQuYxAZ1rE05ewcge9D5q9FoeoYDJ8cw==
X-Gm-Gg: ASbGncs2srQXFyB04ugVCaKwWO3Grmyw6vmvAlfR2BysBSAKVghYsZ5T7qDMvVePYlo
	HkMMDnywS644f9N+n2i+ZT6CXNsTDNmWOE7WhwY5g1aAPsrNV221HQ/C8VzIy/KZfIbwodIdaFh
	wyxl0W/oRs1E5ub2rVd+B4uW1a6tgn3kgKXGdfi5bWMT8aLWeQXn65DqHegYLf5YaiVOubIYc+A
	KdzNPfxc+RZZ6iVa4LWtqndRO1sKxbUb5TTjcmDKzVSzwDv02PhkDrVUfCOeVTbT/ZNTYNrKUyd
	C0d0788ZSM4UxbE+HwnVct+mrwy1j+1HWYaMzqar3GLbKw==
X-Google-Smtp-Source: AGHT+IG4BXzL37WpB2JyEcppeaODO74q4c0Yqs2tZVqmiXwL69PjMqkNrkIBcwgYeCzALfhvRAG4Rw==
X-Received: by 2002:a05:620a:2986:b0:7c5:d1b3:d9b with SMTP id af79cd13be357-7c95eed4880mr126333785a.10.1745527735883;
        Thu, 24 Apr 2025 13:48:55 -0700 (PDT)
Received: from fionn.redhat.com ([142.189.102.216])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86c19sm130932785a.85.2025.04.24.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:48:55 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/5] Makefile: Use -Wno-error=format-truncation=
Date: Thu, 24 Apr 2025 16:48:43 -0400
Message-ID: <20250424204843.79193-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424204843.79193-1-jkacur@redhat.com>
References: <20250424204843.79193-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since compile warnings are now errors, use -Wno-error=format-truncation=
at least until we can sort out MAXPATH MAX_PATH, PATH_MAX and determine
what is needed.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 26acffed8114..6215541d2eb1 100644
--- a/Makefile
+++ b/Makefile
@@ -33,7 +33,7 @@ prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 
-CFLAGS ?= -Wall -Werror -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter
+CFLAGS ?= -Wall -Werror -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-error=format-truncation=
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
-- 
2.49.0

