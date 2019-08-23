Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE061C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910E421848
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCwG6M4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394049AbfHWPTM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:19:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38161 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391219AbfHWPTL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 11:19:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so9468216wmm.3
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Aug 2019 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4uzzEqGjcIvnhS5f6dSyk0bspvBrzc9exNi2m9ZzDLA=;
        b=RCwG6M4Kn1XRLfjKKmjezxcFXohVtW0W1g7lTabzYwUcg/LHp1aKVvaWEzEFef2ais
         WTh3gvTbdY7Hkh+u/uox5CBYRvoi2MP+rtM7p14Fyxwjyyt7NNaN1FWt3M0qpXXfyjRi
         BqkwkyQxnETWGKJInj4ag+rbk4pgoZHYroj12qVLVSizDhECW8kXbxOe40VX8UfkpOEa
         2LLsaHF6RF+Xnzjs59QLFnDTDMB327L7sS4xL24m49aZdvaqA7PSFB/pMjMIvWgiUBgN
         xIcsyU+cmfcXuGRABz/RNhLY7WqTxvnwzYZ+2eC8ORYCCMZjk6sf5po7hL9d7pNaaB2C
         sjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=4uzzEqGjcIvnhS5f6dSyk0bspvBrzc9exNi2m9ZzDLA=;
        b=IQodPI0n64oQpDOWIlrCw08cZ8WjuOts+/pSvqd3XtS2JpsTpWOUdLgYo3KPxVAKCV
         Gy/r58wmdoQklWp175zzTgk2XcinloBb7JYw5bw1Yg5WMUPzeDnCD+m7+k7PUl8Lw8xH
         FGsHWYAJAllwmaFSnpoghr+QDEFFwEwm8YJmr/vurf4Q6QvWssSeW3Ri0FJ5tw1zO27u
         nUjswqufSei2Unh5kkCrkQEuZTJab0PiPTWfIvcOWVkxTCNHIeZmJDE5jSrs8cM5EGjY
         ppTRa06p+HNN/LxpdIK5gRjsasp0v8b2c35wQ6Fkk/4GqatArRW871mFjh+wC4C3ydyP
         JIag==
X-Gm-Message-State: APjAAAUGZ/R4ttXJcebUtaqj47qK+aAdXQZzXSi6X85QqmqZNnFUEf6Q
        2LiWJGdtbLzaZq0R2jd2nmCKoKkUTDI=
X-Google-Smtp-Source: APXvYqzpy+4SQss5TXA8Q+ZHZ+tBvKRPFjWif6KpRzm4lTx4hHvrtztZon5RyU3/x3fzfeoesyibig==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr5740321wmi.106.1566573549197;
        Fri, 23 Aug 2019 08:19:09 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id x20sm7155566wrg.10.2019.08.23.08.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:19:08 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:19:07 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 v1 3/4] svsematest: Increase buffer to avoid
 overflow
In-Reply-To: <20190819064304.4676-4-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1908231718530.7154@planxty>
References: <20190819064304.4676-1-wagi@monom.org> <20190819064304.4676-4-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-611939254-1566573548=:7154"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-611939254-1566573548=:7154
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 19 Aug 2019, Daniel Wagner wrote:

> Increase the size of the char buffer. gcc 9.1.1 reports:
> 
> rc/svsematest/svsematest.c:578:24: warning: ‘%d’ directive writing between 1 and 10 bytes into a region of size 5 [-Wformat-overflow=]
>   578 |     sprintf(f_opt, "-fr%d", i);
>       |                        ^~
> src/svsematest/svsematest.c:606:5: note: ‘sprintf’ output between 5 and 14 bytes into a destination of size 8
>   606 |     sprintf(f_opt, "-fs%d", i);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/svsematest/svsematest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 8f880786ec0f..15e36af76288 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -401,7 +401,7 @@ int main(int argc, char *argv[])
>  	struct params *sender = NULL;
>  	sigset_t sigset;
>  	void *param = NULL;
> -	char f_opt[8];
> +	char f_opt[14];
>  	struct timespec launchdelay, maindelay;
>  
>  	myfile = getenv("_");
> -- 
> 2.21.0
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-611939254-1566573548=:7154--
