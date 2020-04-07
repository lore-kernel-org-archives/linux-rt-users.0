Return-Path: <SRS0=ghNa=5X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624ABC2BA2B
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Apr 2020 14:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A85E20747
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Apr 2020 14:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Frennx1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgDGOxs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:53:48 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34934 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgDGOxs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Apr 2020 10:53:48 -0400
Received: by mail-qv1-f67.google.com with SMTP id q73so1950256qvq.2
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Apr 2020 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6z0NPls12wcMgwtAkXUAT3Q/BFMbbbG0KEAAze6CSBw=;
        b=Frennx1b019J1WIR99vdxURLOciSF/I3EeW+mtfGviMQHyhRhDve1c3UWv1UiSD5Kc
         8j5D77D2p//fIrR2acnruMRRhdLsa78JwzV2ojS7TyXeYLyK7Hh+PUFASNt01SyKxvp3
         h9FELwptVjM+Ozufwy9ExQx5q9r3OU+Jc8T4SQsYNzxkV2GxesX5sDikyq/DIY5ETOLR
         3AzOVffeCO6++V3LDdbxKXUsBibR/1G2d2p5cktgn0kpqB3O9V6MSAwVRrttTaxR2D0U
         Fwqg6i4nwa1+8NB7S5s+QV/uxnXnIvTTpoA7/K8wNH0bv4ixyERZ6eao1vssokiKtsl5
         /7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=6z0NPls12wcMgwtAkXUAT3Q/BFMbbbG0KEAAze6CSBw=;
        b=G5DN8G+XA0eScvhi0lnW6U33NBD4hGmP3qME6Nizf4w8ux0dZ7TsJusjdSygsKmGua
         ru5XwWW7+r+awQ8kz7ZucM+w4pfuGasivjJLuGR6+kmwdOJKT076zdbcEuQZuatTTA2t
         qp/BHP/hYzygaFuv1tybwxBs6CZBa71IDdJo3hNxFQbVjvgy/pdCJGTJXhLWimc4YbXv
         FAQkA+wa04ry4ZClzFQociUDt3p4nbZmMcOa/dBtaG0UOWCpnMrVt0nJVLkal7h7C7Uf
         XS37P5d6UiCnbVyO/0BF8kFecETIWyATkSsFNiW9N0VR2klACTI2oLuY3gmUWJc8eL+y
         ZfjQ==
X-Gm-Message-State: AGi0PuYpqrNMNM1yQhV03R8Y4jUDhYzWxjdQoKEdeDdW3vYXAsCIblpG
        OCCh554QlK6Ihw6Np06Zllo=
X-Google-Smtp-Source: APiQypK6K92gx/RzM+UKTRFHTD4rAKYeB9bM7VKNwLnHTyV5OYffmL4TqflKGMq7OEZKhze761r9uQ==
X-Received: by 2002:ad4:5141:: with SMTP id g1mr2462855qvq.79.1586271227833;
        Tue, 07 Apr 2020 07:53:47 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id b195sm800675qkg.108.2020.04.07.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:53:46 -0700 (PDT)
Date:   Tue, 7 Apr 2020 10:53:40 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Scott Wood <swood@redhat.com>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RTEVAL PATCH 1/3] Makefile: Remove non-distutil install
 leftovers
In-Reply-To: <20200406221405.3043-1-swood@redhat.com>
Message-ID: <alpine.LFD.2.21.2004071045030.6907@planxty>
References: <20200406221405.3043-1-swood@redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 6 Apr 2020, Scott Wood wrote:

> setup.py installs into /usr/local by default, but the makefile
> is still creating directories in /usr that it doesn't install
> anything into.  Worse, the uninstall target removes things
> from /usr rather than what was installed by "make install".
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  Makefile | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f784ba778bc3..f91e6e06a9a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -15,9 +15,6 @@ XMLRPCDIR := server
>  DESTDIR	:=
>  PREFIX  :=      /usr
>  DATADIR	:=	$(DESTDIR)/$(PREFIX)/share
> -CONFDIR	:=	$(DESTDIR)/etc
> -MANDIR	:=	$(DESTDIR)/$(PREFIX)/share/man
> -PYLIB	:= 	$(DESTDIR)$(shell $(PYTHON) -c 'import distutils.sysconfig;  print distutils.sysconfig.get_python_lib()')
>  LOADDIR	:=	loadsource
>  
>  KLOAD	:=	$(LOADDIR)/linux-5.1.tar.xz
> @@ -60,17 +57,6 @@ install_loads:	$(LOADS)
>  
>  installdirs:
>  	[ -d $(DATADIR)/rteval ] || mkdir -p $(DATADIR)/rteval
> -	[ -d $(CONFDIR) ] || mkdir -p $(CONFDIR)
> -	[ -d $(MANDIR)/man8 ]  || mkdir -p $(MANDIR)/man8
> -	[ -d $(PYLIB) ]   || mkdir -p $(PYLIB)
> -	[ -d $(DESTDIR)/usr/bin ] || mkdir -p $(DESTDIR)/usr/bin
> -
> -uninstall:
> -	rm -f /usr/bin/rteval
> -	rm -f $(CONFDIR)/rteval.conf
> -	rm -f $(MANDIR)/man8/rteval.8.gz
> -	rm -rf $(PYLIB)/rteval
> -	rm -rf $(DATADIR)/rteval
>  
>  tarfile: rteval-$(VERSION).tar.bz2
>  
> -- 
> 2.18.2
> 
> 

As you've probably guessed, the distribution spec file doesn't use the 
Makefile at all when installing, just setup.py
This is left over from when Clark and David were first writing this.

The default target in the Makefile is runit
Which is a great way to do sanity check after creating patches, so I
would like that to work - which your next patch does do. This stuff
should be cleaned-up though, so
 
Signed-off-by: John Kacur <jkacur@redhat.com>

For people who are reading this and don't know what rteval is, it's a 
program that runs cyclictest as a measurement thread on various cpus while 
running various programs a loads at the same time.

Mostly it works quite well, but in some spots the code is pretty rough.
Not all of the upstream code is packaged for distributing, so if you see
code that doesn't work in python3, that's probably why, it's not currently 
shipped.

This is all open source, so anyone is welcome to look at it and send us 
patches. It's available at 

git://git.kernel.org/pub/scm/utils/rteval/rteval

