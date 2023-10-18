Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957A1F95A
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jn5cYyjj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E51683
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697637828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64NQoZv/RpZSheqiA+hJnGh+MGFDcZ2ug7XNOtYHdfQ=;
	b=Jn5cYyjjrzbNOxcDRWG2SY+JWFuhT2BOFxwtsO/s7yXgcfZY60/BDYjZI/hAeGOE74/jma
	iXHt8NavYf/dCVkSw9uaMEUvNQmDf3K2NWSyL3nsp31bweEHjYCEHtcqfJkwWuUjBVFUwz
	ldyLTexWHCvPVtUJZy1XEDGzMhcDJWc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588--2I_b2GSMY6qCuURGzUiFg-1; Wed, 18 Oct 2023 10:03:36 -0400
X-MC-Unique: -2I_b2GSMY6qCuURGzUiFg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7788f23ebe7so160046885a.0
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 07:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637810; x=1698242610;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64NQoZv/RpZSheqiA+hJnGh+MGFDcZ2ug7XNOtYHdfQ=;
        b=FtMRPbCkWCcgGXP/wzc6VMHPsR/Id7pe4qNovWuizxHVAp95Nld6F+j6LCFeDDOkaw
         JTV+sn7GyuafYEO3bR73oykcqd92UJx6I40T+FgPL8ObT0JRufX/7HDB9BXH6FLW7unB
         KmG/Tp4SqAoudR3wm4xLVoCM2hsH4MMlIyXToJrd71+6dbpUPMkwjvgUIoMTykwE0/1j
         y60xENl5AhskYDA5JUHHKgEZGtJFUpFHSwgzZaT9ZrbzA4HGOwr+Npv1sKuMnujitdXe
         2dy2q737FvNmo5zpUPf3n2fe7tfRjeCXeiLQIzk0AeqVNN9IVgEa6Yv/5ZYG43U3lTrb
         zdmw==
X-Gm-Message-State: AOJu0YxzuEk3y+7IDJ6UF/jYyRhuEpdyceop+ujwAX9Hfr9qSJAATxOM
	EKtZFZkxiTVydriGJVE/DOJm4h7vOAMdhpi+AYkLDlMSVKt4NOS2ksaL9ET1PdLoIO64+1L5JZg
	adFkJtJSDFsGgqlhWZSFOfheMmheJPGNg6jg=
X-Received: by 2002:a05:620a:3955:b0:775:8e5b:2bb6 with SMTP id qs21-20020a05620a395500b007758e5b2bb6mr5799689qkn.34.1697637810591;
        Wed, 18 Oct 2023 07:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOPTB0xCMg5drw0pZxGtwMHKtInWIfPCNnzBm7ImPVVMXS/Yv7tsYjfK87Ej2GiS4TBncrtA==
X-Received: by 2002:a05:620a:3955:b0:775:8e5b:2bb6 with SMTP id qs21-20020a05620a395500b007758e5b2bb6mr5799660qkn.34.1697637810228;
        Wed, 18 Oct 2023 07:03:30 -0700 (PDT)
Received: from fionn ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id c2-20020a0ceb42000000b0064723b94a23sm1360587qvq.27.2023.10.18.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 07:03:29 -0700 (PDT)
Date: Wed, 18 Oct 2023 10:03:12 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Mathias Krause <minipli@grsecurity.net>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] Revert "rt-tests: Makefile: ctags: Change obsolete extra
 to extras"
In-Reply-To: <01a0d368-5bd5-4c63-bea7-753205d710fa@grsecurity.net>
Message-ID: <96accbe3-1755-8b4-ecb2-3dd4e7c320f1@redhat.com>
References: <20230926110409.1244298-1-minipli@grsecurity.net> <01a0d368-5bd5-4c63-bea7-753205d710fa@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On Wed, 18 Oct 2023, Mathias Krause wrote:

> On 26.09.23 13:04, Mathias Krause wrote:
> > Commit 974241c78a6f ("rt-tests: Makefile: ctags: Change obsolete extra to
> > extras") not only broke the generation of tags files -- at least for exuberant
> > ctags version 5.9 as shipped in Debian -- but it also added -Wextra to CFLAGS,
> > leading to many warnings.
> > 
> > Simply revert the commit to undo the unintended change and unbreak ctags file
> > generation.
> > 
> > Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> > ---
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 32a9f41198a4..3b9e90d528e5 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -30,7 +30,7 @@ prefix  ?= /usr/local
> >  bindir  ?= $(prefix)/bin
> >  mandir	?= $(prefix)/share/man
> >  
> > -CFLAGS ?= -Wall -Wno-nonnull -Wextra
> > +CFLAGS ?= -Wall -Wno-nonnull
> >  CPPFLAGS += -D_GNU_SOURCE -Isrc/include
> >  LDFLAGS ?=
> >  
> > @@ -253,4 +253,4 @@ help:
> >  
> >  .PHONY: tags
> >  tags:
> > -	ctags -R --extras=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
> > +	ctags -R --extra=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
> 
> 
> Ping?
> 
> Can this be merged to fix ctags, at least?:

Sorry, but the problem is that Debian is using an 
old version of ctags. You can either just edit the Makefile to build on 
Debian, or compile a more modern version of ctags by hand, I'm sure there 
are some other solutions as well.

As for the warnings, we want to see those. People including myself have 
sent in patches to fix the cause of the warnings, but simply hiding them
isn't the solution.

Thanks

John

