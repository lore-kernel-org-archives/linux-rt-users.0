Return-Path: <SRS0=kQBB=2D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B41C5ED7E
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620F6247AC
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikCk4H4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfLMQBs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:01:48 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53719 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfLMQBs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Dec 2019 11:01:48 -0500
Received: by mail-wm1-f46.google.com with SMTP id w8so97968wmd.3
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Dec 2019 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Gv26dkqYWRZO8f7YLQx95xXyvow4XMrAx6ph3IJnIqo=;
        b=ikCk4H4II/Mn6z9Dhv0WY8+PAZS6XqAXesmLSt9nMhHX/5XJwrEQ3sfXWPeeIYh5wR
         7DXtKdxcoarYRawFdGyaTpd7iDVb153ccFICfdMzNCfJo8U4E/2HPfRJCedD3hZkcp6i
         lWGv3tEHoEUIAKRdS+bHoE4SlATg+j2Px8LgqF8ct1PMGlr/hhPqKazHy71BXnftJdtI
         Bfrapc5A5jXjbjmaMgzOLxWQhO8y8P5hF8JakNAdPBW5AW3qS+nNk1Jgud2W/uGnPXal
         QNiQWJmyNrakjIIULDog16MBYBCKUcpt/r/1/Gn73RrU23ec7dsDSrhekCi4OFLYyxjF
         ZvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=Gv26dkqYWRZO8f7YLQx95xXyvow4XMrAx6ph3IJnIqo=;
        b=OKBkOw7ukpZEqSUO4Q1+ZhBrr3mdOP7UK4EUHeS0roYBKdN+vaS3v2auzY8ZGYSXDX
         jsMpu2NQ/pUyDV9WxKb+dCJ0ilDT/4kr551aAxPJtREZvMNAedN9jaLisgpxJVqvlcAb
         r8CNIQdSUtBNDQnDbL3Yie6A1lrmrRnDq4W406XK7AY2Hq93F9vG6CzCSRE77r+OoAsn
         z+v8cEf9tnWnzBEbLVR50DacKBy738Z5pmw9x20hbPfOBNarvLnzQ+A3XaiUQKUns5t/
         fdOxpgReFYqRWfAY2w6wsnV5Fac6GkKkzwmCoEDGGQfQgAM3WPEH9R8nIZJvVs5wmO8U
         G17Q==
X-Gm-Message-State: APjAAAX2DGc2d4h5z+hdgdoPsbejFKSj5mTYFXVumZHOLkFl9nC0TDS9
        Fhxhx29+jnDMhL+NRM4gQiI=
X-Google-Smtp-Source: APXvYqwgy94nVEFcu/jIEoYlPl56SGmfpPsAMnHkDcpZ/65ujVCEDSSL9VUZ7baWOnvqw+dssFByCQ==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr14397411wmd.44.1576252905729;
        Fri, 13 Dec 2019 08:01:45 -0800 (PST)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id e16sm10248452wrs.73.2019.12.13.08.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:01:44 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:01:43 +0100 (CET)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: devel branches in rt-tests
In-Reply-To: <20191212075250.7yc36dghunlw4t6t@pengutronix.de>
Message-ID: <alpine.LFD.2.21.1912131659310.7507@planxty>
References: <20191212075250.7yc36dghunlw4t6t@pengutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-1555071258-1576252904=:7507"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1555071258-1576252904=:7507
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 12 Dec 2019, Uwe Kleine-König wrote:

> Hello John,
> 
> I wonder about the two branches
> 
> 	unstable/devel/latest (at 07a73b6ecf748c424c676f1ba8030ca678360e0e)
> 	unstable/devel/latest-devel (at c5aa9a877b146846da21e5d63597a2a09a3c96d7)
> 
> in the rt-tests.git repository.
> 
> According to
> 
> 	git range-diff origin/unstable/devel/latest...origin/unstable/devel/latest-devel
> 
> the two contain mostly identical commits. It seems to me
> unstable/devel/latest is a rebased version of
> unstable/devel/latest-devel as the commit dates are newer and two
> patches that are duplicated in .../latest-devel[1] only occur once each in
> .../latest. Also .../latest has 5 more commits.
> 
> Does that mean unstable/devel/latest-devel is the one to ignore?
> 
> Best regards
> Uwe
> 
> [1] git range-diff 97632deddf783249e0e3d34630792c7696b7d5d5...90449d993fc9973381f1c37fbda37c39a43ab503
> 
> -- 

My original intention was to do development in the devel branch, and 
update latest for new releases. I think that people have found this 
confusing though, so I'm thinking of doing away with the latest-devel 
branch. You are correct that latest is currently more up to date than 
latest-devel
---1463804494-1555071258-1576252904=:7507--
