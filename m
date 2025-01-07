Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF119DF9A
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jan 2025 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287367; cv=none; b=Q0hbGg4v2yboHzAEuKdZ11fs8c574JVdWgub9ZjLeSYEUNjdqiGpNlIpSWQRX6AimUvt/5s6/8mAMhu01so1pzlC+XqXWCdw5WrxutsABCDAmGpznRbxcNVLOaOXBgq9uQmWsvRLri9CGasLL+5StULDA2ZkQ6B0ckBmDifpxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287367; c=relaxed/simple;
	bh=WIshMjBshiVdvsKLu61y7KNj5Zj8JarOWsoiwbWPgG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVgxa7MkyzNRvkKuAZpBxlr6t/sspr6W7d8mvfcZMsUsm1duLkOrqEngm8Aoodyyx+A63nO0lhrDsi+4xwYoJ6yiERypy9zGM5XOSUdM5psQd7tZzOnUU5YnzUXimwf8+xQZSrM/lE72tHCcaGpk6F/GVlm4hKiBqRHTSIkJvuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlZQFDZj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlZQFDZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736287364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+y0nMXzKl6jmrauR2GYkpOFYJzWkVU1olmfnmUmGxCU=;
	b=NlZQFDZj+RgE4rjKYm8033fmA+8hlqiWhL3lGdZMPIGm9VsrMvH7yjyMpilgSN+AbG8xXu
	E5AT6EEma8kpbmozaRDxoqrbfTZs3SiIK0IffYBHE8bF/FdNwsl3SR9ylzKk5xzyp8ZaGQ
	3whbxpEsA0caEQUfsa0eVMjlvPQ1BZA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6--yNwE1tOP6mErB3IQk-msQ-1; Tue, 07 Jan 2025 17:02:40 -0500
X-MC-Unique: -yNwE1tOP6mErB3IQk-msQ-1
X-Mimecast-MFC-AGG-ID: -yNwE1tOP6mErB3IQk-msQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-468f80df8caso343089971cf.2
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Jan 2025 14:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287360; x=1736892160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y0nMXzKl6jmrauR2GYkpOFYJzWkVU1olmfnmUmGxCU=;
        b=thIdn8dXH04yT7+uqAVs+W6vxAEG+EynFWzL4V8sLlAFQFYpRNJmXeOThR9nYKZt8a
         o+MXWQUP+YrDNPpLZhiWsh/BkByxFcONChIOTAa2I+NDDq9VFk/mecam7U11kp50NNKf
         yRR975gTDoEOtLUKxY4KiBsuPjCOh6kKM1hTxy+ULEQ+8eg7OhPKbX97LkLasssHQGmy
         506GCuKn2RwjGXquqdADGHB3jWa229X5UM1NQnn6a/TCO2m7uwTQVp/dcyKMb1f2WaWF
         8ovAc/f/nOfARGnn6GQE7nHCcroMWwfgTXG+yS1A89suB3PA59HIEnU9j6OxnU1Ai9MS
         9nAA==
X-Gm-Message-State: AOJu0YwH4YcHZOjTmtFWAi16rUHY62kqmfReuZvJKnadfw/+HsG06i7H
	HrIZ610DG3MbqsPtE4Te/1gbDU8+VLRwGAW+QNI55sesmgwXc2Sl9bH1EQyaw2C1RqJne24veDM
	XssiU88vINsEaj5mEUTxiF7n3AiyPmpuNoUHMnwYH3k781VESRITTMK9mIC1l+gPu
X-Gm-Gg: ASbGncvgndmO2Fu0y7cbMoGN/0DzJWlmwH5VH+b81E+VM+dmjlME1pRPVTy5zdYuoZ8
	KVMUnpWZ1XK2iDUtgbJ4A2DMaVksa5D8p2CQkV1F5c4H/KAkGB95NDRumxNBUVeh35m18wRgccU
	A1WXMNf9mpe5dBX2zmLd68Job/RW2tTUWdWyuIXMNV16/oZSb8W4rcr0OynErlycHR48uwZ51C1
	xm/n7DBL9jm7Zw1FVoW09xjlE/QaavHK4PuCo/V5x8aRAiA+68b28uSqDfrIzM3EPtlYAW1yLVy
	E3ttJYBQPIdBkCB432L5E/LNa8yMD1HhcJj/eyn2LTHAuQ==
X-Received: by 2002:a05:622a:1996:b0:467:672a:abb8 with SMTP id d75a77b69052e-46c7107e0d5mr6782621cf.5.1736287360376;
        Tue, 07 Jan 2025 14:02:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWEkOSqSG82qtp520UJut5AQ0lSB7bjO/dVqN9ckrkS79BUJhZd+6mUE/mnenwevouFewiRg==
X-Received: by 2002:a05:622a:1996:b0:467:672a:abb8 with SMTP id d75a77b69052e-46c7107e0d5mr6782331cf.5.1736287360105;
        Tue, 07 Jan 2025 14:02:40 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6ada4fsm189884261cf.52.2025.01.07.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:02:39 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 2/3] rt-tests: Enable -Werror
Date: Tue,  7 Jan 2025 17:02:28 -0500
Message-ID: <20250107220229.156201-3-crwood@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107220229.156201-1-crwood@redhat.com>
References: <20250107220229.156201-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the most obvious nuisance warnings have been disabled, don't let
the actual bad stuff slip in.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dda29c3..26acffe 100644
--- a/Makefile
+++ b/Makefile
@@ -33,7 +33,7 @@ prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 
-CFLAGS ?= -Wall -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter
+CFLAGS ?= -Wall -Werror -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
-- 
2.47.1

