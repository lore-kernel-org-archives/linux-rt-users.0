Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724D1D9A54
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277869; cv=none; b=TzIkuyV2nRWuqaqZkYw9HFmXMCzX9lanEifIfUg7cEEDK5EwufmoVUwplZi21UxwbaBAAXLWRmeX6LWqPmTtnKtpBShU9MNTvEvvF4Rjzg531Mfar7vn9vnK2EsoUkVS9f/eWPgxZsUsqpV8rX/BBlvnxl/raoDx3H0VFaVZ+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277869; c=relaxed/simple;
	bh=qvNk0i3VnyiAOQkYcK0qQACswSfvLL0QRE1r5G0AVD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzpOXSFhXpzZYquv/oIWN2g47ve8wXUWHUTuLHQ+1SSEgNq43poxtoX/o1Nj5DruNqvj9mVlNvtugPqlJ3E8xkmzOEgiFOzKc4Vn9YgnlN9jUbX9fjSgNstA00foCJae3NU4QSbgSPQmHSzqS0T4CoNfMu+bQWuBqo4BXFgWxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/uUPnvJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/uUPnvJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-236192f8770so476955ad.0
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750277867; x=1750882667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsOl+Jp0rRtn0CeRVK7sb3ud7N59lbCEyefXjb6Y7PU=;
        b=J/uUPnvJfUT4GxuO7oNrSxvBuMgaESaEbAncmiVYHntyIHX9FBeztHpha4eNbuN3K1
         djF9BbQ/tD2bTvVKWNBlzgalo/N0L/oj+E3lZvpCoJsu4ONj/bCxKUAfYttWGYjPo3DK
         CQBbV4YSeQR1V6/4LwFzyOMMzPXDsD10L9AaRKDirwg0X/JHZg5CO1S9YqXBCWc0l/tz
         z4b3Ew/b2GGARTJCtNadcRFbMPkF577PiDO9F465noS9PTKGAia9t9ej4DyBADWsks9x
         QbXL3O8n1LCRMb04VMUMd539Shp2qTsJ96rJwc6uLhwA6Bil2Tbie4MbYqkKoaNTPVhJ
         HmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750277867; x=1750882667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsOl+Jp0rRtn0CeRVK7sb3ud7N59lbCEyefXjb6Y7PU=;
        b=d6st4jJqQLD4NqKgTEIWGzecmcxGcSkGH7zqVFG7N4BZ4jpzEBMEnXCnS4xfkgE4L3
         ADHAQB4o84pp+VxccVyWzw/AHh0OYJDQqn0/nw03AUIkQTpEjhJG/fNwvFlZal55PfK7
         1nhpHTKvSHPfTzQkQyYxqjAKAGJjWDHQkl3YtLRknY+CwXyCw8ZqMpJCnm77ynuzB7ul
         SurFzukCsRO14RmPYLczibHYMK20532bxhsJEdgnq8rZr9G08D+o7Dywy4tcDt4imMSE
         lFvYDfRsnIK+flLtFQiUI8pi+5nsjG29eTIU9OmIPQAFnu1Bd+ewjC5W6ab4a8lAf2L0
         68xA==
X-Gm-Message-State: AOJu0YzaDu4v8o9C956z3gKGj0HzxEAq5vCdZY78UXYtPoZXIxMAbPMx
	jCGYpH8OvYan6hUbXHTmM63kPTksmk7OOClm7dStp6cQJzsJODSYglbx
X-Gm-Gg: ASbGncvHCLLXIbBzmpL5bLaox6aBM8XR6wajN/1wGwiavSaZZZnepV/e7dUv2q9gEKJ
	KO1iUfxZuYJnKurizi3A3ZX6kKyXzwHfcXEBmUnnVUSPZNO/8uTUirP9v8RCYRcLko1z0rfCioE
	Oii0c+Du2VrNtCcFjgUR/jj1EDQhecIaxA+ZXBYovYzNSFk3Dk5pXtAJSQnso/z5f2iLHiyx/3k
	YX4b971TztKzSn9CACuL9hjeKWnzUJz0go/zFaamBc2TdrQRj8/2OvxX5EMnYgncfF2Sg4SFm6O
	dUXEheccRD4spYirzFFYsSsMvaRU8/i3YgS3GFT756N7eXhU/gFLtcdKGYRXYnGLozmk+fGnDzy
	GDix6VyqJe1J953Bu2sAofZWKqIA=
X-Google-Smtp-Source: AGHT+IF63LL8jpS9oHF/oz5nDJe+A82WpjJClF0uF8g9qveaVEUHfwWJbLUAOyNravP5bbQv49thdg==
X-Received: by 2002:a17:903:1105:b0:236:6f43:7053 with SMTP id d9443c01a7336-237cbe9b5b3mr13860665ad.2.1750277866869;
        Wed, 18 Jun 2025 13:17:46 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:920f:fb70:f9dc:d1ca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca0f8sm105358695ad.196.2025.06.18.13.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:17:46 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 1/1] Makefile: Use -Wno-error=unused-result
Date: Thu, 19 Jun 2025 04:17:38 +0800
Message-ID: <20250618201738.635735-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250618201738.635735-1-yphbchou0911@gmail.com>
References: <20250618201738.635735-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since compile warnings are treated as errors, use -Wno-error=unused-result
to avoid build failures caused by ignored return values from functions
like write(), system(), and ftruncate(). This allows the build to succeed
until proper error handling can be added where appropriate.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6215541..e3d02cd 100644
--- a/Makefile
+++ b/Makefile
@@ -33,7 +33,7 @@ prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 
-CFLAGS ?= -Wall -Werror -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-error=format-truncation=
+CFLAGS ?= -Wall -Werror -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-error=format-truncation= -Wno-error=unused-result
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
-- 
2.48.1

