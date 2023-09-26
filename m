Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF0107B9
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 11:04:21 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589E6E5
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 04:04:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-530ce262ab2so9507425a12.1
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1695726259; x=1696331059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIhm3ufhhlrOaQsG0imwTod05oVx12WevnlLFtSJI+k=;
        b=YTdvuL5krIZ9cl4iHxLlTVXrQUDhl/tBhxxkBzJc9W+B4gFgDmVWSTgNwrb4/1ka/T
         sF6oSoyuYxVRsl3R0+wvKliW1sGeaM8O/z8+aFf850ZTv4j6BkDLBA7ORZaOwNEi4PmQ
         eAGdQaU3s91iEAtptGOj28g6qdzG/boxuNNInDlaYnNuAhgjxqIt14yI40dFw3c73HnF
         iKlnIIFBuqsOTFMp5nv4O9owaqegVZbwSKIZCfEkijm/Sg1/YdtN12XPrFSTugPnZwED
         TpTMSiceN/VRyj/ta7nbVkMCx25cKIz9Yiyl3jsE/zXqunDW867IeVhwOGk4OjrJbnum
         Q/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695726259; x=1696331059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIhm3ufhhlrOaQsG0imwTod05oVx12WevnlLFtSJI+k=;
        b=pGU3IMjbux9Kf93vLkl/ohd8C1DCMZCi/7R+IyJWyPIi17z0Qu+fV244+OyD8/UWYF
         C4/pqCgXvuCDEcVUZB3ZRy8Pp48Fa8AxrhBCdPHBL635I7OiulgNhRVRYniRpIAgnjTw
         j0hUiTPLmXiQ5SEEZN/rINLZDiuy40jIX1LTZAHpG6/rg0KXxChNDFt9plmftzKQGa9l
         v1/PKnxjrfsUDicYl9s7ztnvvcqS4Oe6lBHW/N8g91UAM5w+VOLGke5pkKXH0bch7pVs
         25Z6TNggusjXAhcm66aJDLSRqzNw8qibfYyLtRH8LrSqhItfmKmjgTdIv32IpxsJoB0y
         s4kA==
X-Gm-Message-State: AOJu0Yyy1FCqAf+F85UNwCzHXSsvtlBzP2XSyRRAwaXfibGMmkI3cxYr
	iZxtToM6/PuLiF7qlaxTOeDQvqWoPhjKJP5V0LXrcw==
X-Google-Smtp-Source: AGHT+IGfjQiA9wS1y41dlFRhiLjll6UR2mRPqM7NPfBoWn+BDCZAum66ixqPsSvYzv3Sv4RwYeTPOg==
X-Received: by 2002:a50:ef16:0:b0:532:e4d3:df83 with SMTP id m22-20020a50ef16000000b00532e4d3df83mr8195726eds.4.1695726258697;
        Tue, 26 Sep 2023 04:04:18 -0700 (PDT)
Received: from bell.fritz.box (p200300f6af251f0032faa5d007da505e.dip0.t-ipconnect.de. [2003:f6:af25:1f00:32fa:a5d0:7da:505e])
        by smtp.gmail.com with ESMTPSA id fi9-20020a056402550900b00533bab9d9f1sm4067981edb.1.2023.09.26.04.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:04:18 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH] Revert "rt-tests: Makefile: ctags: Change obsolete extra to extras"
Date: Tue, 26 Sep 2023 13:04:09 +0200
Message-Id: <20230926110409.1244298-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 974241c78a6f ("rt-tests: Makefile: ctags: Change obsolete extra to
extras") not only broke the generation of tags files -- at least for exuberant
ctags version 5.9 as shipped in Debian -- but it also added -Wextra to CFLAGS,
leading to many warnings.

Simply revert the commit to undo the unintended change and unbreak ctags file
generation.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 32a9f41198a4..3b9e90d528e5 100644
--- a/Makefile
+++ b/Makefile
@@ -30,7 +30,7 @@ prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 
-CFLAGS ?= -Wall -Wno-nonnull -Wextra
+CFLAGS ?= -Wall -Wno-nonnull
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
@@ -253,4 +253,4 @@ help:
 
 .PHONY: tags
 tags:
-	ctags -R --extras=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
+	ctags -R --extra=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
-- 
2.30.2

