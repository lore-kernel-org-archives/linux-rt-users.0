Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BB1C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Mar 2022 19:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiCITVT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiCITVS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Mar 2022 14:21:18 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252F13F08
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Mar 2022 11:20:19 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a14so2725051qtx.12
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Mar 2022 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3T17eKMWoGCloDIEH19EgY4q6x2OGMVBX59ven1aPlg=;
        b=BGGsa9jEVECZiwNfn8/S+41j3fkFagLTv/bXZGRQDKVXQa7PHPu+iTXo7FWT503dbU
         Vw/36Wm0WQCQdH62YnqIWZ2u8TKCXyfRnAXO6Ac2bR9EZxDshbCOdsqJYwUmM6lo2rj1
         qv0t4c/C7QnhK8xescHx2gfv2DjvgDNripiWJmarVCwj+NhUGRD6ffKcV455/+wMqB8A
         ix7y7s4BFc+7POX4QIFi+/e6zt8Q/uWJ/RkZU5DSKfa46UBbQhtBgB30jZSkFI0u/vc0
         b4TDO3TjLfKVVOJWr58iFVQM077Ul8gFng5HramkZ+j3XVx/Y4rAn2vm9pgKYLUIEv9T
         sViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3T17eKMWoGCloDIEH19EgY4q6x2OGMVBX59ven1aPlg=;
        b=wKjXtnmVLqgXIbzagnp+KrcfMhPRN/MthfSKIFAY9PKFArRGYnClhgaAF+xj2wUhev
         2xXl1LsKY3xnVLZ26hQjnBMI0h3BgwL/03qTeQNQXNmlUYsjgeQeTmwuYLE4khGTvem4
         h+dMh5DqwiFP9N2KvQ29ZzgsZyNGzX2fK/sy2OJClaT0CW2oHkSf61lJd5IxILWIrnZX
         etE0Uu7s2NQHy9fSuWxSxHGeT88eWWwmAB++8EkpXN7V5tt/VIfmfO+NwWCt/UI069YV
         CqBwmSoSZBTnq7DZDpUMUnVEncRjlkFLac9OHsX0kYVS4D66ZMMGZQy89wTHQfkjrBpe
         cjFg==
X-Gm-Message-State: AOAM532izhT9yKjQp00e8ITI7V9oAyKEPGr4YhGLcwN5cgO877Ocoo9g
        Solj8DKggXYpPOebXTO34FJ7z0I3vHE=
X-Google-Smtp-Source: ABdhPJzBns4sRmHEw8kjRQ4dwddW7XiK76GsBRAaC8nWy9q7hkt4k28c73DMLdhW8dbWetPHmFu5qQ==
X-Received: by 2002:ac8:5dd3:0:b0:2df:e996:880f with SMTP id e19-20020ac85dd3000000b002dfe996880fmr1064235qtx.512.1646853618407;
        Wed, 09 Mar 2022 11:20:18 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id t66-20020ae9df45000000b0064915aff85fsm1338687qkf.45.2022.03.09.11.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:20:18 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rteval: Fix allmodconfig build on machines that don't allow sha1 signing
Date:   Wed,  9 Mar 2022 14:19:44 -0500
Message-Id: <20220309191944.382066-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309191944.382066-1-jkacur@redhat.com>
References: <20220309191944.382066-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval compiles the kernel using allmodconfig as a load.
This can be a problem if sha1 signing of modules is disabled.
Fix this by signing with sha512

Suggested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/kcompile.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 8f97d38eca56..367f8dc1ca86 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -66,6 +66,7 @@ class KBuildJob:
 
         self.runcmd = f"make O={self.objdir} -C {self.kdir} -j{self.jobs}"
         self.cleancmd = f"make O={self.objdir} -C {self.kdir} clean allmodconfig"
+        self.cleancmd += f"&& pushd {self.objdir} && {self.kdir}/scripts/config -d CONFIG_MODULE_SIG_SHA1 -e CONFIG_MODULE_SIG_SHA512 && popd && make O={self.objdir} -C {self.kdir} olddefconfig"
         if self.binder:
             self.runcmd = self.binder + " " + self.runcmd
             self.cleancmd = self.binder + " " + self.cleancmd
-- 
2.35.1

