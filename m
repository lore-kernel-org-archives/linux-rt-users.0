Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A796C4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD3D2076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgth+Emw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgJ2RlS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgJ2RlR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:17 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ACDC0613D2
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:17 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b18so2637915qkc.9
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rx1YF9kL4W6K9pUABXMwRZkEpA20CVrgiFbxSP60S4=;
        b=Xgth+EmwwOgDEe9uk7wR0MzCYjPI3f1jn7tQLWO0t4vZlfhornvp9r5w/RJKTj+xaQ
         gTI/haodVMDhzsY47NFDFvUJyA7pd0PORpMbooCwVWXhbNJUBOLR9iV1DAInDt8K2LXK
         7cPHFOZNGMRiUrMJPeX0lDYTKVtCxkJigDIp4SL+FMiSyqZnyxzSVA1U9+3f03NagjB9
         6Eu5A6qmcvYJQaH8S1q/Z7bgdIH9LEzpM1YCwQC8wcyWa5h/GLjROoSg1kX+x+QJzWtO
         lKeGV/K1NzuPHBoN17jTy9dzDaH0VNEHcRRipfqhYWDrSEi6mcqm3AIK54dipbSclhq4
         FVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8rx1YF9kL4W6K9pUABXMwRZkEpA20CVrgiFbxSP60S4=;
        b=ufhckWyp8QD9ZhdO0+pksagxpLxOT/3CLm+oH3SWoyVjWk/emNnXzx9araDvvfW5FN
         VxRh6V206TmYGdAfZO/k/OAdJfm6C9gCtGhUedOQKU4peJJWATAq61qYAlIKlC5uLOgS
         hjPRhGZk+/mva5fGwfeaB/Gu0LHngyD9N5HN22WvZy8V8+GX4HovVML2y3aAo0mpG7eC
         D0XHOPiClfXgn1eIPuFIZAPaXOgoNQVJKXu0yFU8Qp8e1XzoWEwbh3a+ymC5be6QRraw
         b9/op66ma08jEjDBghNV4B7Go/mkFP0OEKA7A7th7YuHmK1BzO9W8lKwpJvzW8aJI41S
         UCPQ==
X-Gm-Message-State: AOAM531urSCIh6JLwcZvbPkjUmEOcfNi5ECCO7doe2vR7C9EiqAvXd/4
        XkGGCgoG2OoiVfk/LynLukSaoxPB9EuZxw==
X-Google-Smtp-Source: ABdhPJz9oyB3dy86A9pTYvkefozNccgndLROsqXFhm6ee76tgiT8ER12Iooy4L/q+3UfXoSnD+OZYg==
X-Received: by 2002:a37:ec4:: with SMTP id 187mr4948577qko.113.1603993276353;
        Thu, 29 Oct 2020 10:41:16 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:15 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 04/16] rt-tests: rt-utils.c: Correct mix of spaces and tabs in code indentation
Date:   Thu, 29 Oct 2020 13:40:45 -0400
Message-Id: <20201029174057.20033-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix the mix of spaces and tabs in the code indentation.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/rt-utils.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index f786588706cd..54a201661786 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -392,11 +392,11 @@ void open_tracemark_fd(void)
 
 int trace_file_exists(char *name)
 {
-       struct stat sbuf;
-       char *tracing_prefix = get_debugfileprefix();
-       char path[MAX_PATH];
-       strcat(strcpy(path, tracing_prefix), name);
-       return stat(path, &sbuf) ? 0 : 1;
+	struct stat sbuf;
+	char *tracing_prefix = get_debugfileprefix();
+	char path[MAX_PATH];
+	strcat(strcpy(path, tracing_prefix), name);
+	return stat(path, &sbuf) ? 0 : 1;
 }
 
 void debugfs_prepare(void)
-- 
2.26.2

