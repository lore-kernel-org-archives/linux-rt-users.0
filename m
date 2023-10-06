Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DDB38BBA
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLfXWwfx"
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733D4BF
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:36 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66b024d26e2so3966946d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617695; x=1697222495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y40oMdQtzwlkLQUgqVg05OcjXTzTpZiCfOaGeN8Puk=;
        b=MLfXWwfxpInNJiiDJaiNXJavL3byl/+nynisUMGyWWjqyCwaXHIK1yACgAS57NrlUs
         /FgfR24tk6zp5gmbbWz5pjbzG76HGtgtPVVFewd5C90LAPaJ6B49i1T0M/r4++TpxLuA
         hkuQQ6/JPW6PSj7Zg9FW82vpeeamPOL/kvprDW7XJmPvcHVxBxevtZSg/rAiMq7lVORg
         IGRLxK5bc+gm1VsMzAVZmThqFwNSBk5VofgOw2JiVouFpTIyGIqdAOCy1LS3SmV+HENA
         HR3cN+bCiobBmnE0YmlBD8Fans0o9vdzdr5lAsqTru489NAyDS1ZqDKZC8pkdfN+sk3f
         DwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617695; x=1697222495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Y40oMdQtzwlkLQUgqVg05OcjXTzTpZiCfOaGeN8Puk=;
        b=ryA7gkEXcFEh/BTrfSz/MXBQ1arXrujPsQg18OeaetVFEJtTEBx+cem6feJReIreT7
         0XlSGTohW0a50QllfHkBS4iqn6KpKiZEXsjzFAEpkxhWlLHJK2aH/hfkdzrkkiDN/IO6
         nMD5wseb/Wd6HJWLtrnTNGaU8m+kArmsRLTuebqOvQc+hnneKCJVWho3YDakSyvoWc9r
         f7JUrA3h9fIE62pim7DlRbpSbeIi7bngX9l0dykJJ5hH+YzYynK6ubQyeh4eHhMoItir
         g6s/OCE6rP/8OC7cWuHna3majLp13WyxsXhrqzc5rriaImSbZA/wbF5A+XrAA8sbFohY
         9TzQ==
X-Gm-Message-State: AOJu0Ywd67e1cIWPsO0DWqjIV9VAiBFNYcV3GD5SKP8y7doLr8PPDmr0
	5FMWD8r6vDi+bPvYkQgiXK/yZfbPKV4=
X-Google-Smtp-Source: AGHT+IE1OE4zHJnDHRSapbQ6gLw2X8XcUGnljjh0YB68F+Zj1steCWoX8Q8107Rx9TMcHyrj73JdkA==
X-Received: by 2002:a0c:aadc:0:b0:65b:92c:3eee with SMTP id g28-20020a0caadc000000b0065b092c3eeemr9894541qvb.15.1696617695001;
        Fri, 06 Oct 2023 11:41:35 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 13/17] rt-tests: rt-utils: Suppress warnings about fallthrough
Date: Fri,  6 Oct 2023 14:40:07 -0400
Message-Id: <20231006184011.26699-13-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184011.26699-1-jkacur@redhat.com>
References: <20231006184011.26699-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Suppress warnings about fallthrough in a case statement where this
is intended.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/rt-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 14dac5608037..6bbd25a8ba53 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -382,12 +382,15 @@ int parse_mem_string(char *str, uint64_t *val)
 	case 'g':
 	case 'G':
 		v *= 1024;
+		__attribute__ ((fallthrough));
 	case 'm':
 	case 'M':
 		v *= 1024;
+		__attribute__ ((fallthrough));
 	case 'k':
 	case 'K':
 		v *= 1024;
+		__attribute__ ((fallthrough));
 	case 'b':
 	case 'B':
 		break;
-- 
2.40.1

