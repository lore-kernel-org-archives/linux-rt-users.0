Return-Path: <SRS0=pHM8=RH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E18C43381
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 20:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F2420830
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 20:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb9t+2vK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCDULH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:11:07 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53995 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDULG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Mar 2019 15:11:06 -0500
Received: by mail-it1-f196.google.com with SMTP id v2so721835ith.3;
        Mon, 04 Mar 2019 12:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkAvcNis1yANsM164bBt2ZIwfA7Sfa3Z1ZOJLiJAp5Q=;
        b=Wb9t+2vK2cN5b0rq89jvXYOyqsNKekYUC9aiaRMSSiOkjDb7TNiV/S/tOJOEpV3IZH
         ma/3G1ymk0zXCJNzjsO72dFtaXFCY/labXpvSb1JIHk7gBpC4eQLZje9prhNvZ1iwO5M
         rcbhsxxAnCwVlV4EU8GSl4XBOJocxYF+WOs+A+tF3A/gSOxpKOS2ROgY/7xdpTEyvqO5
         rcx4n9d1Qd6v0Bolahn894yesUHAsBSmJmmk6AuyRtSHPGnOrdR4e/OHNRI7A2qYuoPD
         b8V4vYMc+Kewl3ti373UZL9IEYVxDoq3f4EwMmovsOlctv++lzoNEJsZ4RHyJbCRj/B/
         uKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkAvcNis1yANsM164bBt2ZIwfA7Sfa3Z1ZOJLiJAp5Q=;
        b=a06Tu5THRRLsGXmy/11B2t6Ry/jfIzQk60CLVHsVEKXI/7sTaZLAyTVjXLGCfdOHxi
         GXZFoMu9f1TPyKaHGwSHYegFcRQHBv0enMVgxGhdsfC2cEj5hPEIM9ES8/hPGPlO5HX+
         RwbLjk7hEv+papOSXFui6kDt6hLXtoUvzLCPiSXSyckXLbSLbOwh4Hy8zdyj5C4qgmhO
         okq1HtbIPlhqsFCA7tq/ccV9dP43VlgXcmNi7KWuzEPWarBcxlDoPFf9NpcAEuLrw1iC
         xygT/XXDP6NXqVqeTDGEc4qhmT8WVvoCsc+4NCsgC8WNcpwKS0vEYucSNNyJ5vyDCeuX
         C7BA==
X-Gm-Message-State: APjAAAUP/ZGwy3Q/knsOsv1iY2+FZrMgkgxC7CSfyCrNF1oLPUwqZHrT
        XBcQq37UZI1qVFfoiguYUNm93owh
X-Google-Smtp-Source: APXvYqx5gpt5jtMQU7bzBy1K5yuNDrV/+NWEN3odzjoyqv66ghG3KuMMGXICgjmcT7chxCu78HoHXg==
X-Received: by 2002:a24:5c07:: with SMTP id q7mr617711itb.22.1551730265553;
        Mon, 04 Mar 2019 12:11:05 -0800 (PST)
Received: from tzanussi-mobl ([2601:246:0:7004:bd8e:3a2f:85e3:54d1])
        by smtp.googlemail.com with ESMTPSA id r65sm3685990itb.19.2019.03.04.12.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 12:11:04 -0800 (PST)
Message-ID: <1551730263.4658.1.camel@gmail.com>
Subject: Re: [PATCH 0/2] A couple hist trigger patches
From:   Tom Zanussi <tzanussi@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Date:   Mon, 04 Mar 2019 14:11:03 -0600
In-Reply-To: <cover.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Ping...

On Mon, 2019-02-04 at 15:07 -0600, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Hi,
> 
> Here are a couple miscellaneous hist trigger patches which can be
> applied independently of the onchange/snapshot patches.
> 
> The first is just an additional use of str_has_prefix() that was
> apparently missed in the original str_has_prefix() conversion, with
> an
> update suggested by Joe Perches.
> 
> The second fixes a bug I noticed when testing the onchange/snapshot
> fixes.
> 
> I pulled these out into this separate patchset because they should be
> applied regardless of what happens with the onchange/snapshot
> patchset.
> 
> Thanks,
> 
> Tom
> 
> 
> The following changes since commit
> 67748dbeaf2b1240c0b87588df4bb0fb9471a751:
> 
>   sh: ftrace: Fix missing parenthesis in WARN_ON() (2019-01-08
> 10:19:02 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-
> trace.git ftrace/hist-fixes-v1
> 
> Tom Zanussi (2):
>   tracing: Use str_has_prefix() in synth_event_create()
>   tracing: Use strncpy instead of memcpy for string keys in hist
>     triggers
> 
>  kernel/trace/trace_events_hist.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
