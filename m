Return-Path: <SRS0=qep6=D2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCBEC433E7
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C08222EA
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 19:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="st9WHAE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgJSTiL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSTiL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Oct 2020 15:38:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06493C0613CE
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2020 12:38:09 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z2so1452717ilh.11
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2020 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wl4jnvEszMJIKYodaGqMfLsIDxPjm33HgwGI+4y3hvM=;
        b=st9WHAE5+qB02q6hHiFzbK2guxu4VCsdD3nI3FbO6/8AVWd4xQ16EFPdBgnUhXSTK4
         hlQ4jV/JHK6YSC3/bt8dKNbTOPdEfUrlW59M6m4PLZooYs9HZ7/D4D/PTW5Bn3A0gpCj
         viBN7QtYRjz3RaS7W/8RpysHd8cjKaF3MlLdivrMwBkmjcHyC8x8apWEI+kWpw3niOcQ
         rv+IHIaK22SUQ0qzkRHracPaMGaUryCXqS+18GH+8Mdr9CSpMJX/1qFtLAptTEw+Xfjh
         Ce9d1pyDNtHPy/5U/yrOhjDvoUIz8rLflu4NiWWenLZyUddSwLNh8fbeOs6keaI2oQij
         KwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wl4jnvEszMJIKYodaGqMfLsIDxPjm33HgwGI+4y3hvM=;
        b=YCgR8l2SyzyToMo7e2QSL3r1BKPEgaOm3AgCWMG0cu/bKLa0ify8wCkoqeThemXJDj
         mJWr2HW8T6E9R/uXWc540DcmOZLqBo3waIZrHxUsvNN55l+XxyDePKWbrwJuhTQL0jx7
         qQEoQs2rCf/zYoTijl58XETWmYX2T7snpLxLzwso7OdOzb7QKu7sxIooNCkMsYthXC5K
         5ZZbtwBkm415LzILNjnTCVp4gGuXeP+iU5ghOpLmyjK1CKeGr+BwcBaTlXebt2AecXzN
         o17vtcdYnY10J6RIEIRicVzCMLEYalt40BqseGt70D9dw9eHBkP3gT9iQrkgMcugjQ2s
         hX/Q==
X-Gm-Message-State: AOAM533o0ks8BsqbbhA25ieMd9K3rF8KJLuKAZ3YG8TNkJXHdbYYD+NR
        Kes4hd3JdPPWCc97hku+vEnTdIrMqdJFRQ==
X-Google-Smtp-Source: ABdhPJxI25m95vXIJkTlK43JCaNuXoJNED85aePIvM7bkAwCvPUKPQE1kpGlLrG5R+sKOCiFoCTaug==
X-Received: by 2002:a05:6e02:cb4:: with SMTP id 20mr1464698ilg.176.1603136288970;
        Mon, 19 Oct 2020 12:38:08 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id i201sm618908ild.12.2020.10.19.12.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:38:08 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: makefile: undefine PYLIB if empty
Date:   Mon, 19 Oct 2020 15:37:54 -0400
Message-Id: <20201019193754.14578-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The makefile will run a shell command to determine the location of the
python libraries. If an error occurs, for example if the system doesn't
have python installed on it, undefine PYLIB

This prevents undesired side effects such as installing man pages for
utilities that will not be installed and does not interfere with other
conditionals such as if test -n "${PYLIB]"

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 5f34075a4aa1..24895b7f9697 100644
--- a/Makefile
+++ b/Makefile
@@ -35,6 +35,11 @@ LDFLAGS ?=
 
 PYLIB  ?= $(shell python3 -c 'import distutils.sysconfig;  print (distutils.sysconfig.get_python_lib())')
 
+# Check for errors, such as python3 not available
+ifeq (${PYLIB},)
+	undefine PYLIB
+endif
+
 MANPAGES = src/cyclictest/cyclictest.8 \
 	   src/pi_tests/pi_stress.8 \
 	   src/ptsematest/ptsematest.8 \
-- 
2.26.2

