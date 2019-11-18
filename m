Return-Path: <SRS0=mQuZ=ZK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115AFC432C0
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Nov 2019 19:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDAC22304
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Nov 2019 19:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW9paWlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKRTZT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:25:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36316 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKRTZT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Nov 2019 14:25:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so588468wmd.1
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Nov 2019 11:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OuxWH2uLy2195EvI4HYsdwlcOtnPs7nneBvxa7Ei8DU=;
        b=HW9paWlRJBgpT/oQBixDr8hy6r8ulsPFfUpKXpB6SSn4cELemTbokpVY/csGB2qEIw
         +NJvwMsK8BYXpiVONqfPkOeZ8A+Zf7R1KDWyB+tT6zKxLyR6T/NqOiX0NxDBG6TL4yJq
         NwLlI5ougsatOwClbcd2hJApg2ZPT3jcoUK/iKUEiNNOYobxHOr57EDCJL3r5A0QygyC
         vHnQTjt0XToOJGnONLFQIjFW51Y+xZudGdjZ4oqNmIS8OqewNpPq60fnzYgyQ3eUN/yK
         sq7mPq7TjLO3I4yhTmCIpLj5KspfKXjOlD36Iv63Osyp72EUJ7SXRcOZr+NQvm72EAPO
         Ymnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=OuxWH2uLy2195EvI4HYsdwlcOtnPs7nneBvxa7Ei8DU=;
        b=A7Gd8Y9MFRWXWNr7MxhObGozSB/an2jpiuiwHNix8bufS/yPeEl3zS/fh47wJZ+yxQ
         StvYwdPuEy843Ju8eSwsOUcQVv5CrJXRBGWB3FAwGUxxTdend0cLjU6+Odre3O5mbr+Q
         rqqdlJJsFmeDyCAxlDv49yhnzjVCoRiJ2m6HU6Wkv1rgtAMmY11joXvDZbUYZLpvbzRH
         Jm1QBjHdYbclqs7XPTgmFl99FH4tqvceDlKPmmMeSU/1VqzWFeBUooJIqlOQCF5utvjM
         Rvn7mTfrwJ1TkJWkRugzW4smJvgVZCdtFt6fvLA7D6HQgsduA0wtoJBD8cdSIypK7ppu
         lYmA==
X-Gm-Message-State: APjAAAUJRBTQXsTqfvcTH/GrcJFuR4XTxO1sn8b1wBpfeKmiWYN8WqtT
        WgsPWBAtlq6DZZmPYA8ajhY=
X-Google-Smtp-Source: APXvYqyoe9oPG8RimsnYjwN9iM066qx+Z9SW4T6DMh8qI84uAwZrcCZhEEIYv2b7AkVwuEmWQrmtEQ==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr802984wmk.133.1574105115592;
        Mon, 18 Nov 2019 11:25:15 -0800 (PST)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id f140sm387789wme.21.2019.11.18.11.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 11:25:14 -0800 (PST)
Date:   Mon, 18 Nov 2019 20:25:13 +0100 (CET)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@debian.org>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests] Makefile: don't create empty directories in
 install target
In-Reply-To: <20191117214405.28271-1-ukleinek@debian.org>
Message-ID: <alpine.LFD.2.21.1911182024470.30318@planxty>
References: <20191117214405.28271-1-ukleinek@debian.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-1740242064-1574105114=:30318"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1740242064-1574105114=:30318
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Sun, 17 Nov 2019, Uwe Kleine-König wrote:

> Both $(prefix)/src and $(prefix)/share/man/man4 are unused since commit
> 2829763fdd79 ("rt-tests: Remove install and build of backfire and
> sendme")
> ---
>  Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index b57340874213..6eee3d8f7845 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -27,7 +27,6 @@ DESTDIR	?=
>  prefix  ?= /usr/local
>  bindir  ?= $(prefix)/bin
>  mandir	?= $(prefix)/share/man
> -srcdir	?= $(prefix)/src
>  
>  CFLAGS ?= -Wall -Wno-nonnull
>  CPPFLAGS += -D_GNU_SOURCE -Isrc/include
> @@ -177,8 +176,7 @@ rebuild:
>  
>  .PHONY: install
>  install: all install_hwlatdetect
> -	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man4"
> -	mkdir -p "$(DESTDIR)$(srcdir)" "$(DESTDIR)$(mandir)/man8"
> +	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8"
>  	cp $(TARGETS) "$(DESTDIR)$(bindir)"
>  	install src/queuelat/get_cpuinfo_mhz.sh "$(DESTDIR)$(bindir)"
>  	install src/queuelat/determine_maximum_mpps.sh "${DESTDIR}${bindir}"
> -- 
> 2.24.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-1740242064-1574105114=:30318--
