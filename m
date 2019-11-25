Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863A3C432C3
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 22:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534BF20740
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 22:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZxdNfcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfKYWi3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:38:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43947 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKYWi3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 17:38:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so20149149wra.10
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Nov 2019 14:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2xzy+cE4PmeTmetOaZFwaf0DAtfLL9GkqqCmendKN8=;
        b=AZxdNfcQ74vHi9Ojg7Inr2nIyfKeB0KolcPV2XY/l3zvyRHZRrh5YWQ+0PXXxMLuwG
         SXfREumEMLdx4gqwnYv3n37jTgMPjlzbBMhxkr3Ozia8nNXC9hj0EQn+TjL++jJrPF+c
         uF5njbgPEDEwBnxOjvBDlQZ/JNiaDiIEtPcZlJ7v7pQC96ITiV/XDTznYN0M4KHiXvtN
         IVoEEB9aQsIODRfLbyO2UtLpawWj3wNMh2f3lE9KsdqZiKiSNEjrU5c79n5GFjVrez2g
         WuInVFmzGJoXZga01BX+I9i4yGJDGjdQWtPSZ16R8OHbfP0Vp56koyX6T+sACBOpmutT
         o3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=c2xzy+cE4PmeTmetOaZFwaf0DAtfLL9GkqqCmendKN8=;
        b=WIgtEuNnetPQo1yUvN9f5yVMbcfAU3jhwg4Kh3YB8WPEr7DqpEg3rm/as7dI0oZ3ec
         iHg9zmU2ky6A/bHBM8aeGb5GW6CSwCJcE6+YIvQiplm+qEvaHfjjB0/zHmrxQsy9Mjq6
         leV5BQwFaqIKHtHQCeFoEDTKp0xbt4hwYeBqILqAMKmnB/nbzmQuIFUOUA7tWcdx28a/
         ppEf4KgSQJyJrweYeMdoNnk8zSPU7xy9HlSAfWvUqzkMMxfWDuNkVwa12un50mVV8GoO
         mUcLzP+GHaBypC87GaJNQpY6smmaeem0ZLkDKklLRREbCii5JQjTLY6e6J7z3HVaM7e3
         Z98A==
X-Gm-Message-State: APjAAAUlwKDEGmfYHUnPDQwBIQUV1iZuEnOxNEjuCpzsxM24hoCpzfFI
        9f7jcScYqX6rtxOXUn6cDtZXcZKkwUc=
X-Google-Smtp-Source: APXvYqzkz0l7i7otV6WrmA7Lvrxpz0GozWEca/+U50JteK3/3hj3LNJBlSD4Rs8AVboV+oZI+mRF6Q==
X-Received: by 2002:adf:d091:: with SMTP id y17mr35296807wrh.182.1574721505542;
        Mon, 25 Nov 2019 14:38:25 -0800 (PST)
Received: from planxty.redhat.com ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id 91sm12769422wrm.42.2019.11.25.14.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:38:24 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rt-tests: Add SPDX tag to hackbench.c
Date:   Mon, 25 Nov 2019 23:38:10 +0100
Message-Id: <20191125223810.16643-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191125223810.16643-1-jkacur@redhat.com>
References: <20191125223810.16643-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add SPDX tag GPL-2.0-or-later
The original author is Rusty Russell

In his mail with the following message-id, he says:
Message-ID: <200911022357.36541.rusty@rustcorp.com.au>

> ( I've Cc:-ed Rusty, the original author of hackbench.c. Rusty, the file
>   has no explicit GPLv2 compatible license - is it fine to be put
>   into GPLv2 code? )

Yep, like all my code it's standard v2 "or later".

Sounds like a good plan, thanks!
Rusty.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hackbench/hackbench.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index ba804f519950..5a883d341f2e 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * This is the latest version of hackbench.c, that tests scheduler and
  * unix-socket (or pipe) performance.
-- 
2.20.1

