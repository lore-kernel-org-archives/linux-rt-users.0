Return-Path: <SRS0=ADFb=AR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7A4C433E3
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A28F206B6
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/MysEfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgGFURp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgGFURg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:36 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC374C08C5E0
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2020 13:17:35 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so30014977qtr.9
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jul 2020 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8xzUHPSofhfEJQ3TglkNf6ZSAb/WcA13/ziENEz8XI=;
        b=c/MysEfFuZDnC6yP1fv64p9NwYIMsAnkp1yOrayYij1z5NfU6e1OfjCGR27VS3CrjK
         03ULIWDUvLWjAzKoYnI5WtJmdB1MKjGlL4VPOLk/C0a65ay3LjvsPjhK1isl1xdIHy6z
         kEL1mbuzsPWnWn5dH/Q+fonMyB6hCeOC6W6TSfp/RkoIHXM43CJCkiQx0G05AkrPE6iA
         ZlUIdJ6S87hs1q9W0hgHU+JzA9YRcE+MTFFt7UbWkGS3fNj8DiexxEkKcZGiMu7eXkEe
         ppu5PIoDCkMhZn1EW/90NZBCTQS/Pt2aa4PEndDk4HDpprP5mDHhjhUEj+NmXTNUJ8eG
         25+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m8xzUHPSofhfEJQ3TglkNf6ZSAb/WcA13/ziENEz8XI=;
        b=OlLPqo6ytvO29LFdIr/eLPhsV8cZXYINQXEvKRkhX8L0HEpUd1ULifB7Bp2eE0b9qh
         8TdN6NQTb3BVYBQqEO7NUWacC5F16lkuUGsS01vzlWpnI/v7su6aiXSr6hTzRsJj64/k
         b5cGHbLPXhzX1ZsCElWPFB8vwpLo7nlv1m8+u1+MlKmGWdS1qON2Qhs4AxHufR7nhqtP
         EHWZpdev3aVoC3GNt407fm4l3XidWbLcwU5BoMKjWPPscrhgdvhgqg/OS7Y7wCxKKowA
         6zIEpOB+v39YQS6WVO1OK/flmui7mGM+MKCXD+mfWtWTAA6n8xGV3CnLNdK5kNNi+AOb
         Wu6w==
X-Gm-Message-State: AOAM530Y+XmtQEKyR7tqND58aCqUp8GEE6zkd0wzQvzeBXzBMCmiAE3V
        SMwx32YUkTkLqfhzS9JsedauH5wd7wE=
X-Google-Smtp-Source: ABdhPJwWUjUC0y81j0xMZmdrSDX4BAdlifjzVvZ8Ox5xHRADfvxJbXrlfBZ/skmfZU6bA3D6MfazzQ==
X-Received: by 2002:aed:2c87:: with SMTP id g7mr52810938qtd.346.1594066654965;
        Mon, 06 Jul 2020 13:17:34 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id 73sm21551692qkk.38.2020.07.06.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:34 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/7] rt-tests: pi_stress.8: Remove unused -t n from the manpage
Date:   Mon,  6 Jul 2020 16:17:17 -0400
Message-Id: <20200706201722.13400-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200706201722.13400-1-jkacur@redhat.com>
References: <20200706201722.13400-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The -t option was replaced with the -D, --duration=TIME option
Remove it from the manpage as well.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.8 | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/pi_tests/pi_stress.8 b/src/pi_tests/pi_stress.8
index 5e2af6189ca1..ed03ad6187e7 100644
--- a/src/pi_tests/pi_stress.8
+++ b/src/pi_tests/pi_stress.8
@@ -15,8 +15,6 @@ pi_stress \- a stress test for POSIX Priority Inheritance mutexes
 .B pi_stress
 .RB [ \-i|\-\-inversions
 .IR inversions ]
-.RB [ \-t|\-\-duration
-.IR seconds ]
 .RB [ \-g|\-\-groups
 .IR groups
 .RB [ \-d|\-\-debug ]
@@ -50,10 +48,6 @@ Run for
 .I n
 number of inversion conditions. This is the total number of inversions
 for all inversion groups. Default is \-1 for infinite.
-.IP "\-t n|\-\-duration=n"
-Run the test for 
-.I n
-seconds and then terminate.
 .IP "\-g n|\-\-groups=n"
 The number of inversion groups to run. Defaults to 10.
 .IP \-d|\-\-debug
-- 
2.21.3

