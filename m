Return-Path: <SRS0=2ve0=XL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A73C49ED7
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA184214AF
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 21:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWE/1u3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfIPVv1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:51:27 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:40108 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPVv1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Sep 2019 17:51:27 -0400
Received: by mail-qk1-f176.google.com with SMTP id y144so1630626qkb.7
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Sep 2019 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Zl+ABPfMxin1b5A+/Udn9JhVFS4sdewLJPhurL8hQQ=;
        b=KWE/1u3m9+1zJvH1oavSziLQWiYvGrD7T6W42ms30YXWPSykC7XdMi4kUQS/Bs3y4s
         hC1zOMIUnLNK3SgI7dzH+WEwNYxGOedDcCAMaD/9vb1te5i63r+/sGBL7NnVmIsxWqhq
         xEWoy5oF6Bqs1tyIrsvkQuG51bUVMMW/xtDDKmpHy1SzX/7kWs5nPya0KS7n7N4Q1TuU
         TO0molA+s1ukZfXY6URTPqEzV+nrXgDwKnIFbd/Pf8j5NKfiuRhyngpkudJiOZD8AL5L
         XSLFcgZ9Be1dcr+I/YqZPyYnwp6h2sNBgWwuA9N8pbVbW+Ru2DJwiuMpauFIihi+QqZr
         ye2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2Zl+ABPfMxin1b5A+/Udn9JhVFS4sdewLJPhurL8hQQ=;
        b=IoVvN8FLCyEZj+hKesMzqDId6qcKVsoJiC+xEPtcWHCoX/DFiScXr866pM3yHN6Fl7
         xVtL167QgWtZdz5FoFJJxcStWKX/+W4YgpiAwO+avJfTgEVvXu2kBD2roTHX99qik8WL
         JyfZ7XwIC4Uaa8471k9KwxUAy74p8gt2I5oJz63WV9Ub3bvSh29ox5eh3fgWTOAzn/iT
         lTKydCKQOgJu//nP79ZeBQlU3bYwFgidObc8poEXXE04Gs9eQzt8ICbSq2E037r0VFSn
         Oc0Et/kif4nIDLCmenJFbHBZeFCKdFUel2NzRxqAPukD7OntIb5rh5m2rddT4D3rCd2h
         PYnA==
X-Gm-Message-State: APjAAAXe127ldTAAObIsK+fDm8YQkM2wTUReQaScIJ4JTBrWeBZjvhNd
        AIPxj2MUjtZg+KPoyuSeVOxrOJNLfGY=
X-Google-Smtp-Source: APXvYqw5jSDybJrIiV4Qkbiw5IhY/YqPXw4TsA3Unyw3SRzC1wVPWpYOtcVHeHGi5JYuSzIbcsvCUQ==
X-Received: by 2002:ae9:ea0c:: with SMTP id f12mr504615qkg.498.1568670684474;
        Mon, 16 Sep 2019 14:51:24 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id q126sm120156qkf.47.2019.09.16.14.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:51:24 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/4] =?UTF-8?q?rt-tests:=20cyclictest:=20Fix=20=20warning:?= =?UTF-8?q?=20=E2=80=98cpu=E2=80=99=20may=20be=20used=20uninitialized?=
Date:   Mon, 16 Sep 2019 23:51:10 +0200
Message-Id: <20190916215111.10193-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916215111.10193-1-jkacur@redhat.com>
References: <20190916215111.10193-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix warning 'cpu' maybe uninitialized by giving it a default value in
the switch statement. Note, this is a false positive, but documenting
the default value in the switch statement isn't a bad thing.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 45b6041ec1c9..542e85c27a25 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1897,6 +1897,7 @@ int main(int argc, char **argv)
 				printf("Thread %d using cpu %d.\n", i, cpu);
 			break;
 		case AFFINITY_USEALL: cpu = i % max_cpus; break;
+		default: cpu = -1;
 		}
 
 		node = -1;
-- 
2.20.1

