Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70034C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43416206E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDruYcE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404489AbfHWPQC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:16:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45078 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394059AbfHWPQC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 11:16:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so8941944wrj.12
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Aug 2019 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ODT+/U9gABWnjCeKmMszPjjU9b48kuGYC8y2/yEEfuM=;
        b=RDruYcE+mmtUh214dp7OcyRv6u9FdOJdceLedKP9JjA86qAa3pzg2nSlUGeQD+iL9q
         mxikmaO3uHEwFwuBnzJH7MklC1JMoeazim2G2yJZ8ttqaPuRHEU37guZ0qY5qYbwinzU
         bDN1ro1mwhbcQgLvmAv3N7kBwurwBPJPoHVxvjGAgHd/90DHNouN0+B2AK6iuX++LqTv
         z2Pyu9F2/OgDLRHh1ZAw9sHUzWUPsOkDeQxlpTzU8weZgbHfzz5unpbZqJa9ZZnULLDw
         jp7H8mzLwq9LxvMJ2xuRS2v+FkwCu7W1V6GJgfI8yYbG/u7jbX06a1pWOFHnWD+ZEqR8
         NLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=ODT+/U9gABWnjCeKmMszPjjU9b48kuGYC8y2/yEEfuM=;
        b=WtWWd72FR31wvcpxK+X+HP65JcVmp8B2FiNzjXF4kBWQlJFVDy2ADtxBH2DxypBZ1r
         DbuBEqMGp/PXtxf4UDamZwN6aCgRqpVKPvfFr5NsS/Dk8qc6epku0QBxV7ZFjEtueXG3
         caRnRPaVI9rf2wBvRykFKu4DWfkrjCWdJgLnhGGjgtBUQEWoNfctosmpQmgtu0EYBu31
         Y+/MAOgJIQNeBqvUkCox4bjcyeXwSw1B0x7mr6mdAoNy7WjICcQMFiGNul2dAjHQdtHg
         l0fc8kNPka8LoM3CMnLKNSgtxufYrHHdpwOq8bJPybKitfmtsrfIT/5wqF226wZBmy3i
         sv9Q==
X-Gm-Message-State: APjAAAUWFbWYqleRX6Z4wIZBedeVxG0+0xt5iF6C70Dd8pXH8bts5i1s
        FRgzt5ywWuyUnOUcjJPf+6g=
X-Google-Smtp-Source: APXvYqxsSOTX50kXNi0JI5WGqHj42IFVzEzCqL/k6JaoxOxSWqWUL7l1/UNpmIClFx+6BvVSLCgrxA==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr5915806wrs.348.1566573360365;
        Fri, 23 Aug 2019 08:16:00 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id j9sm4068257wrx.66.2019.08.23.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:15:59 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:15:58 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 v1 1/4] pmqtest: Increase buffer to avoid
 overflow
In-Reply-To: <20190819064304.4676-2-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1908231709170.7154@planxty>
References: <20190819064304.4676-1-wagi@monom.org> <20190819064304.4676-2-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-1291524723-1566573359=:7154"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1291524723-1566573359=:7154
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 19 Aug 2019, Daniel Wagner wrote:

> Increase the size of the char buffer. gcc 9.1.1 reports:
> 
> src/pmqtest/pmqtest.c: In function ‘main’:
> src/pmqtest/pmqtest.c:46:21: warning: ‘%d’ directive writing between 1 and 10 bytes into a region of size 8 [-Wformat-overflow=]
>    46 | #define SYNCMQ_NAME "/syncmsg%d"
>       |                     ^~~~~~~~~~~~
> 
> src/pmqtest/pmqtest.c:445:3: note: ‘sprintf’ output between 10 and 19 bytes into a destination of size 16
>   445 |   sprintf(mqname, SYNCMQ_NAME, i);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/pmqtest/pmqtest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index a04fc49872bf..3ce799bd6319 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -440,7 +440,7 @@ int main(int argc, char *argv[])
>  		goto nomem;
>  
>  	for (i = 0; i < num_threads; i++) {
> -		char mqname[16];
> +		char mqname[19];
>  
>  		sprintf(mqname, SYNCMQ_NAME, i);
>  		receiver[i].syncmq = mq_open(mqname, oflag, 0777, &mqstat);
> @@ -567,7 +567,7 @@ int main(int argc, char *argv[])
>  	}
>  	nanosleep(&maindelay, NULL);
>  	for (i = 0; i < num_threads; i++) {
> -		char mqname[16];
> +		char mqname[19];
>  
>  		mq_close(receiver[i].syncmq);
>  		sprintf(mqname, SYNCMQ_NAME, i);
> -- 
> 2.21.0
> 

I don't love the use of "magic numbers". Also the compiler considers the 
signed integers to be −2147483648 to 2147483647 so including the sign that 
is potentially up to 11 chars, plus our string is "/syncmsg" is 8 chars
so that's where the 19 comes from. However we are using the int to 
represent threads, so we know we can't have a negative number. However 
sprintf also adds '\n' which brings us back to 19 again anyway.

This is better than what we have, so 

Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-1291524723-1566573359=:7154--
