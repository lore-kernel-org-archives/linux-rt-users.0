Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F2663DF
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Oct 2023 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="mHh4X4wQ"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02936116
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 23:53:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507ad511315so5844522e87.0
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1697698419; x=1698303219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tG70djhUedPAsAwnt2zcRkO2G2Mxu4PgM5Jm6RKFFCk=;
        b=mHh4X4wQPzJdFxw1iVGnWz2dCyC3va+TdYsUF9m7lMjCV+FyzEbmxPLDbxlANTk+5A
         ihTDo/AhSvVSVX371GYesSSy3T+wS497VBPcoBIN/VTy5kYOOidQWUAA/0FG9c2KCgpb
         p91ta1BTZ55y6rg/BssK6nMkSPmSt9EuQV5J5N+GnXY3UHz/FVCKUjQEKbgoI3J9v92S
         iLtC0fhkBDkRWeElxeHoo9BEHYDiAMcGfhnWuYsaS5RTsq1ChHxzC+FYAt84AXPHBcVS
         nx/6Q61zzjBHxNcQxWelk5qg0cU4lczRG8XckOJlXPzzoqXsg5Ys3surpr5x18LS9Iwt
         UV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698419; x=1698303219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tG70djhUedPAsAwnt2zcRkO2G2Mxu4PgM5Jm6RKFFCk=;
        b=jlyQeOT6B52m2bHWPvcDrNUHqifFWFBiMRKrHEFn9KET10wSX4XRXPdCZs6pCRezc7
         pDjY8Bw1I//tY4enOV21rnLfFvqGWVJBUrrxEZmQOA/iKh732Ra0ZZ+/TvpuWS5rMpCr
         4NBZ7Pfgk1MziEoLX4jn1msePDvva+7yjWEI6KtCRoPM+uyyjREIBot6maUHrhiXFVxF
         HhChmMhV68T0/+kq77LfUlZrXxVjfvlKi4vOlamUaf50nAU3VKacoRh8ySVobqXTaUPh
         n4jfthkmrbI9x69FyCdYOWfYkkYDj4ifewVVToKrVoCrzni6Bu3mhLgXEh5rxRu3MUN1
         03qg==
X-Gm-Message-State: AOJu0YzA2IsTH58PSPLq3hv2N+87IG05n7XP/gn9ODt+Y+Vu+5EUZsDe
	aUlw2XCrYh82QMOwCMJmP3eoPMJaqyGD9M8BbiE=
X-Google-Smtp-Source: AGHT+IFs3eQZjhtCN1NY4rpQPWdlX/L7Ie/kMf/636rnKtygv27eo/lGcYBYYqgBUIJYOX6eCOhMvA==
X-Received: by 2002:ac2:41ca:0:b0:503:3781:ac32 with SMTP id d10-20020ac241ca000000b005033781ac32mr689607lfi.41.1697698419129;
        Wed, 18 Oct 2023 23:53:39 -0700 (PDT)
Received: from bell.fritz.box (p200300f6af16d50092b8d27f8e422e4b.dip0.t-ipconnect.de. [2003:f6:af16:d500:92b8:d27f:8e42:2e4b])
        by smtp.gmail.com with ESMTPSA id p20-20020a50cd94000000b0053443c8fd90sm3998894edi.24.2023.10.18.23.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:53:38 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH] rt-tests: Makefile: Restore support for Exuberant Ctags
Date: Thu, 19 Oct 2023 08:53:28 +0200
Message-Id: <20231019065328.932835-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 974241c78a6f ("rt-tests: Makefile: ctags: Change obsolete extra
to extras") is Universal Ctags specific and broke Exuberant Ctags.

Restore support for Exuberant Ctags by automatically detecting which
variant to use.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 223a839151ec..8d3268d19901 100644
--- a/Makefile
+++ b/Makefile
@@ -251,6 +251,11 @@ help:
 	@echo "    tarball   :  make a rt-tests tarball suitable for release"
 	@echo "    help      :  print this message"
 
+# Universal Ctags warns about the backward compatible option '--extra' and
+# wants it to be called '--extras'.
+CTAGS_BIN = ctags
+CTAGS_EXTRA := $(shell $(CTAGS_BIN) --version 2>&1 | grep -iq universal && echo extras || echo extra)
+
 .PHONY: tags
 tags:
-	ctags -R --extras=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
+	$(CTAGS_BIN) -R --$(CTAGS_EXTRA)=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
-- 
2.30.2

