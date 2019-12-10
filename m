Return-Path: <SRS0=srch=2A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D1DC43603
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Dec 2019 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AE120726
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Dec 2019 11:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrJN4jfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLJLU0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:20:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34697 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJLU0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Dec 2019 06:20:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so19621492wrr.1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Dec 2019 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HHxPw/4+4MI2oBxdHGAOkTtpEH2vdq4El+ho+KP1IS8=;
        b=mrJN4jfXDzozjnAMwvtQ+KVkdCSKHpst+cT11YYjNpqkt02/vLbqHIQNR/2roWCXLq
         2gvXv5M0qy7slyb6zTG551SXwTWfcbqcFJ1gU8jkrnZh1rTb592whuZQMgJUOhBvP8Sq
         DDJP7v2nJqsOvdvIDXo0WrrFyAPBMfI6RkeZHC5jsDiDcJxM0o9fgKFInrmF7Z6txOov
         uRyVcl/f3R0TJ1/iWTrhVOXmSrYB/rdxstMi8tCbPf7zfJAutGEksJg1ory3VwiZDhgh
         hbvJjXi2Rkt5UMsNg9WEZ7YqZhgAEgrK5608edP/04lg57v1NHZGm7HBjzuDo83geTb2
         wm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=HHxPw/4+4MI2oBxdHGAOkTtpEH2vdq4El+ho+KP1IS8=;
        b=DGsOPFfOl4SE1EsfcRWaegX23fw5wU75c/nAh/RfiM2JYLTGW1wKY5sZl3O57R3pZ/
         MGwhtSeJZdLNmhL1YtRcN98bcq1fFTGyfboeTZQ/78WY7KIiHamf9yG49l0+YpjUZjHq
         ZRW9Rp0LKA9sUvrI20X3E3GzP6YDrjYuU0FV38d+lbDIcuLej8CMjpgbP9wwjXwVRRfJ
         7fsxWyep7ydQY7R/QmcnBWtPCf5Cn51LndwqstgUwgmx7Iy/u5XiYRRAn3tNTO2tMf0A
         MYoA5rtw7Bk2q5dXnjIMQc9M+PI63dgWQlq5WGaM5EA+vqk3yy/s3iFJu04Ayp+Dz77x
         RFzw==
X-Gm-Message-State: APjAAAUgICF5+SbvakXojYB9BZV4Ro8Opp9f3yx44Y9/D1F+p76aekXt
        XtIz1efM+YL74XZo+aJCxSXhUlpF
X-Google-Smtp-Source: APXvYqwUiYjKR14tE4PVlraKx0R+PZ0lxGzujQOHAi1iXquhfKUlax0VUl4WvXfsfMI355s+pxFIfw==
X-Received: by 2002:a5d:44cd:: with SMTP id z13mr2663112wrr.104.1575976824160;
        Tue, 10 Dec 2019 03:20:24 -0800 (PST)
Received: from planxty.fritz.box ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id d19sm2731851wmd.38.2019.12.10.03.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 03:20:23 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:20:16 +0100 (CET)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty.fritz.box
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@debian.org>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick
 also for all !x86 archs
In-Reply-To: <20191208210625.5999-1-ukleinek@debian.org>
Message-ID: <alpine.LFD.2.21.1912101219560.4472@planxty.fritz.box>
References: <20191208210625.5999-1-ukleinek@debian.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-1659572807-1575976823=:4472"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1659572807-1575976823=:4472
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Sun, 8 Dec 2019, Uwe Kleine-König wrote:

> This fixes a build error on arm64, mips*, ppc and several others
> ---
>  src/queuelat/queuelat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> index cccb50ef0cc4..98346f346f82 100644
> --- a/src/queuelat/queuelat.c
> +++ b/src/queuelat/queuelat.c
> @@ -283,7 +283,7 @@ static inline unsigned long long __rdtscll(void)
>  
>  #define gettick(val) do { (val) = __rdtscll(); } while (0)
>  
> -#elif defined __arm__
> +#else
>  
>  static inline unsigned long long __clock_gettime(void)
>  {
> -- 
> 2.24.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-1659572807-1575976823=:4472--
