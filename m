Return-Path: <SRS0=kQBB=2D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD1C3400D
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B62624776
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJc0BuFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfLMOzJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:55:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52031 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfLMOzJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Dec 2019 09:55:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so6689251wmd.1
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Dec 2019 06:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TgoQeyP5ML1k3OHc5+9n1isXC8I2pQjmkbduh9g04v8=;
        b=oJc0BuFVFIayTldkzFv+Gf+TnGRGddM9W2WwVRysG2vYq60HxsmGaV0bTjfiIUNwr5
         3WTiQ0J7Czg7mRdxEKpO5p2c2Vw0D+sMOHSzvDbxtyCvrkPSOgjzxJxsTFhNsuJKHNiU
         SeqVL+ICGewzjJ59r87Q09CtFO4gA3zo9iQfmyUfOKr4YQBPRdbLqoMJI9tTERKxUAsJ
         6mpC+zx44RLCbBI0ieBTN9H6PTQqvVjDxIRqeVyCsfhJ1BtD2jSiKmeLdODJzfB8s4c+
         yrwlHFTpofWMkEdytf9I8ce5Bn10AHFrWw5ccc2oIwDWlaMfCjcNIkGnfGsUYljboXrH
         99/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=TgoQeyP5ML1k3OHc5+9n1isXC8I2pQjmkbduh9g04v8=;
        b=JgYVxjDfNaHiYxd4g5euLaCOxpGuDezpNFiiEO2Uy8Zub5bP3Uf23z6GmY6dPmbpum
         WqWCDIdS3w4gXNwDGLVGOoogSWyBWQySy5p60/lVfr/FP9xihjNmg7irWMRhv02PHFTm
         DjHFL8/fgjrPjxjMQS+KfTeWif7IVpwg6lE3XNmlYB2b1c6+jKb1fXud9ppulZargLXf
         sByO+hNAMeygabCbS8pCSDoxBoOa2xV1u4p//v/PVF1nTwbJuck+S0eE0sVpH1eCiYW6
         f++RJfipcrSMFfxvVyAmEyA9CQgnBxhrmko8aYizoC6QUNddWkelBhrlleBVbDdF443a
         TeLQ==
X-Gm-Message-State: APjAAAW9H0sTWJxjjw1ZELlJFWQJazzS++tCb68/tiWnHFqnega8kEnp
        SlG4UdU0ARHZnRvLSJ4S+xKZHIGc
X-Google-Smtp-Source: APXvYqxwx6yAKVbnlzl92hPgdRJ3W+iStqKeqqwmeOu3y5dyNliHKw/NTv7VPB5zft0J+bUzbiYaBQ==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr13643404wml.83.1576248907068;
        Fri, 13 Dec 2019 06:55:07 -0800 (PST)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id q11sm10191940wrp.24.2019.12.13.06.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 06:55:06 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:54:48 +0100 (CET)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@debian.org>,
        Clark Williams <williams@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH rt-tests] queuelat: use ARM implementation of gettick
 also for all !x86 archs
In-Reply-To: <20191212174604.xa6p46zhhii7qrhw@linutronix.de>
Message-ID: <alpine.LFD.2.21.1912131550270.7507@planxty>
References: <20191208210625.5999-1-ukleinek@debian.org> <20191212174604.xa6p46zhhii7qrhw@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-1247980971-1576248905=:7507"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1247980971-1576248905=:7507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 12 Dec 2019, Sebastian Andrzej Siewior wrote:

> On 2019-12-08 22:06:25 [+0100], Uwe Kleine-König wrote:
> > This fixes a build error on arm64, mips*, ppc and several others
> > ---
> >  src/queuelat/queuelat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> > index cccb50ef0cc4..98346f346f82 100644
> > --- a/src/queuelat/queuelat.c
> > +++ b/src/queuelat/queuelat.c
> > @@ -283,7 +283,7 @@ static inline unsigned long long __rdtscll(void)
> >  
> >  #define gettick(val) do { (val) = __rdtscll(); } while (0)
> >  
> > -#elif defined __arm__
> > +#else
> 
> Did actually anyone look at the code? I somehow missed the queuelat
> thingy completely. Now that I look I think I need further assistance…
> 
> So what I select as frequency for the !x86 case? And why.
> 
> That freq. script reports here:
> |1555.184 1566.269 1566.498 1560.055 1593.149 1568.185 1583.807 1599.096 2574.546 2572.408 2573.849 2583.862 2619.402 1825.680 1847.264 1870.318 2552.102 1570.552 1589.650 1595.813 1590.253 1573.834 1589.438 1599.439 1770.963 1786.370 1814.918 1811.936 1828.277 1850.905 1861.976 1792.809
> 
> I guess I pick one…
> 
> Could someone please figure out the actual difference of clock_gettime()
> vs rdtsc() so we know how important it is. Based on its current
> implementation, if memmove() takes >1sec then it ends up undetected
> because only the ns of the timestamp are considered for.
> 
> >  static inline unsigned long long __clock_gettime(void)
> >  {
> > -- 
> > 2.24.0
> > 
> 
> Sebastian
> 

Adding Marcelo to the cc list
---1463804494-1247980971-1576248905=:7507--
