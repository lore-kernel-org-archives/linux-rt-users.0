Return-Path: <SRS0=ADFb=AR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55288C433E2
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343B1206B6
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jul 2020 20:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c57q6HAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgGFURk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgGFURi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:38 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23DEC061794
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2020 13:17:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id z63so36064052qkb.8
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jul 2020 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fR+3InCSaQ946DCsdJ05eN5aIL2oKtjoaBBDeN4l5o=;
        b=c57q6HALfEQR5pz9t/j55IWHFSXsq5yIpLKS/sML9cQrK8xLPQFWC0u3A958vH/Yng
         cNKdtkZqEGbijn0tc9CjkEUkjTxo+pgFgBxKzE3lndZr+ulNHeNjahzMyfb0n1eiYhtz
         9OfE/LSLNgdPTWiEt8Wlv35avBDJ0Kz5CM0jsYxLu7ZFwTMcqGggsDvR76I+4aMk9BUw
         DEakhG/vV/SjWGDTWyUDo7bJ+M5JVYTNvzlbIAbSisZeWufGnu+/cpYPqOUQvI65Aakv
         z9Yyo1lCJhT1D2LZsAbKpny0LtUqX4wpScV5WtI6/RcANWNIG5l4wsiLckz8EAcCYVP/
         lTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+fR+3InCSaQ946DCsdJ05eN5aIL2oKtjoaBBDeN4l5o=;
        b=k8NL/afDBHOwbVEuVJr1UgnCrqj4bCATRl2rXjpAusrijFhNb6OVUCBklLwjHYzHE2
         Q+TJg/B+8BXaESmzNnzMGz0vFDfRjxTzKckdhQJigIV/feG02M3xQmhK5BId6MbCfYNJ
         05+lfpsQdUfDJraJAp9+baou1V5HIz+Jr0Tcb78vacXfqUu+SH2AqoYpRx+tmyTGESxg
         Ifqy1j86MiOLp0WgAssE1vS3eCb+245de8C/PYfvlvQ8Z3W7v7h9uE40J3RvpNv5IKUq
         HkgBX4YLa3zZDCrZO7JinOTKUZW2PZwEkr6oFlWtMHbGOY8inPWqgsrEIWlBC+vM0d1a
         qMUw==
X-Gm-Message-State: AOAM530Ee7B+gG0/oFQNhV82ab5iYmdvgaDhkNwyU5HkKVbfVcYZ25Ld
        5FkfH5Q9S8ZOefKMAWiTA4shZjx1y5U=
X-Google-Smtp-Source: ABdhPJzXMSXqfRGscwW4+A4Rk5uJG26HdjzSJ9NCOE27Ive8SqFwvt/SMJmimHuvpiCGbfwyxEprCg==
X-Received: by 2002:a05:620a:6c3:: with SMTP id 3mr48269610qky.400.1594066656777;
        Mon, 06 Jul 2020 13:17:36 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-04-70-29-134-36.dsl.bell.ca. [70.29.134.36])
        by smtp.gmail.com with ESMTPSA id 73sm21551692qkk.38.2020.07.06.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:36 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/7] rt-tests: Add a man page for get_cyclictest_snapshot
Date:   Mon,  6 Jul 2020 16:17:19 -0400
Message-Id: <20200706201722.13400-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200706201722.13400-1-jkacur@redhat.com>
References: <20200706201722.13400-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a man page for get_cyclictest_snapshot based on -h

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/get_cyclictest_snapshot.8 | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 src/cyclictest/get_cyclictest_snapshot.8

diff --git a/src/cyclictest/get_cyclictest_snapshot.8 b/src/cyclictest/get_cyclictest_snapshot.8
new file mode 100644
index 000000000000..e9251a8e821f
--- /dev/null
+++ b/src/cyclictest/get_cyclictest_snapshot.8
@@ -0,0 +1,44 @@
+.\"                                      Hey, EMACS: -*- nroff -*-
+.TH GET_CYCLICTEST_SNAPSHOT 8 "July 6, 2020"
+.\" Please adjust this date whenever revising the manpage.
+.\"
+.\" Some roff macros, for reference:
+.\" .nh        disable hyphenation
+.\" .hy        enable hyphenation
+.\" .ad l      left justify
+.\" .ad b      justify to both left and right margins
+.\" .nf        disable filling
+.\" .fi        enable filling
+.\" .br        insert line break
+.\" .sp <n>    insert n+1 empty lines
+.\" for manpage-specific macros, see man(7)
+.SH NAME
+get_cyclictest_snapshot \- Get a snapshot of running instances of cyclictest
+.SH SYNOPSIS
+.SY get_cyclictest_snapshot
+.OP [\-h]\ [\-l]\ [\-s\ [pid [pid ...]]]
+.br
+.OP [\-p\ [pid\ [pid ...]]]
+.SH OPTIONS
+Without options, this program will send USR2 to cyclictest to create a snapshot and then print it out.
+.br
+.TP
+Optional arguments:
+.TP
+.B  -h, --help
+show this help message and exit
+.TP
+.B -l, --list
+list the main pid(s) of running instances of cyclictest
+.TP
+.B -s [pid [pid ...]], --snapshot [pid [pid ...]]
+take a snapshot of running instances of cyclictest
+.br
+by sending USR2 to cyclictest
+.TP
+.B -p [pid [pid ...]], --print [pid [pid ...]]
+print the snapshots
+.SH SEE ALSO
+.BR cyclictest (8),
+.SH AUTHOR
+get_cyclictest_snapshot was written by John Kacur <jkacur at redhat dot com>
-- 
2.21.3

