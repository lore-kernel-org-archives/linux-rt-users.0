Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8D8F6F
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="nigRMdPa"
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046DC6
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Oct 2023 23:29:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a98517f3so4248790e87.0
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Oct 2023 23:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1697610584; x=1698215384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvSiu7MC33cFiZeSy/oE40C9DskPqtDa2qqUTJ9zOaE=;
        b=nigRMdPabGlvdUausteRD6A+DVtEMCdcTMh49eAkErPV2kR4AuuRqqhyZIAGwXbe2A
         N8hrNg0iktiUW1j5UBoy1qfl3GPr8qSJD+nEShulpL0ks2A1U/YSz04sruNOGjVo62rO
         ccux2uNXHTMOOrV4gJWFj1lePJwLgEB5y51+gow+JDRIYUWksRRJX32xgWDPJBfrY2Eo
         BB4XMWpRL611wtDDSvp27G3ydysiFe9hJ4XzfHO/1BJ4x2wD6jD2maRhCgO40F3/D8Rq
         3J0k+BvZ0+X7XdX/8bXBfu+nqB0Z8RH/VI9B+2q1ejXnFAM4C30CWByo3wU2xl0ZdLNH
         x6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697610584; x=1698215384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvSiu7MC33cFiZeSy/oE40C9DskPqtDa2qqUTJ9zOaE=;
        b=DdiZLrhDitcea+o4PcALJdZQuMCvx9Z+EBtqhfDKdCDgL9wXAdwx1O/m8OTPZf8cmN
         LTo2IXW+C556VgjGNjnz6G4Xz+OkNCTDPjQ/GfJMxhrv5vwjTodlH8nlKl/45O9G0jBW
         BeaoZw9a45YjbcEorIffwgHPzhgoB2dP3R0gg39VePpUtCw+37afSW5EnWHIc4sXJ/Yu
         g4dZMX1sUO+UvMf3YUx6XY2gDctNbSDgDrvW56hVpyDFb8DBJ6d9b6WGw817rMjT3/BK
         iGYatLughLXkCEbzwzygIH3bmReVGrrJJPvr99DUqnL0s9sc26IkVyJmmi+diuSCaSxx
         vP5w==
X-Gm-Message-State: AOJu0YwaLE+2M5wbuGsF/L8I/6Pj9EB0xOYAIH4JgLmHf8gFMeiEoyKC
	M8PiP+1T/3+yoyN4PYLJdybifII6DxmwptCzvkQ=
X-Google-Smtp-Source: AGHT+IFTdYwB7Z8c4pqCOS29h6iCGO+z7jzZaPKcqO6zRVHKlVxEssCirLgcjTBc9iPYkQ/w8b2T+g==
X-Received: by 2002:ac2:46ec:0:b0:505:9872:7a16 with SMTP id q12-20020ac246ec000000b0050598727a16mr2591271lfo.49.1697610583843;
        Tue, 17 Oct 2023 23:29:43 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0b:9200:68d8:9102:93aa:1a23? (p200300f6af0b920068d8910293aa1a23.dip0.t-ipconnect.de. [2003:f6:af0b:9200:68d8:9102:93aa:1a23])
        by smtp.gmail.com with ESMTPSA id a18-20020a50c312000000b0053dec545c8fsm2306254edb.3.2023.10.17.23.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 23:29:43 -0700 (PDT)
Message-ID: <01a0d368-5bd5-4c63-bea7-753205d710fa@grsecurity.net>
Date: Wed, 18 Oct 2023 08:29:42 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "rt-tests: Makefile: ctags: Change obsolete extra
 to extras"
Content-Language: en-US, de-DE
To: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
References: <20230926110409.1244298-1-minipli@grsecurity.net>
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 kdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20230926110409.1244298-1-minipli@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26.09.23 13:04, Mathias Krause wrote:
> Commit 974241c78a6f ("rt-tests: Makefile: ctags: Change obsolete extra to
> extras") not only broke the generation of tags files -- at least for exuberant
> ctags version 5.9 as shipped in Debian -- but it also added -Wextra to CFLAGS,
> leading to many warnings.
> 
> Simply revert the commit to undo the unintended change and unbreak ctags file
> generation.
> 
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 32a9f41198a4..3b9e90d528e5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -30,7 +30,7 @@ prefix  ?= /usr/local
>  bindir  ?= $(prefix)/bin
>  mandir	?= $(prefix)/share/man
>  
> -CFLAGS ?= -Wall -Wno-nonnull -Wextra
> +CFLAGS ?= -Wall -Wno-nonnull
>  CPPFLAGS += -D_GNU_SOURCE -Isrc/include
>  LDFLAGS ?=
>  
> @@ -253,4 +253,4 @@ help:
>  
>  .PHONY: tags
>  tags:
> -	ctags -R --extras=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
> +	ctags -R --extra=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *


Ping?

Can this be merged to fix ctags, at least?:

minipli@bell:~/src/upstream/rt-tests ((v2.6))$ make tags
ctags -R --extras=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
ctags: Unknown option: --extras
make: *** [Makefile:256: tags] Fehler 1
minipli@bell:~/src/upstream/rt-tests ((v2.6))$ ctags --version
Exuberant Ctags 5.9~svn20110310, Copyright (C) 1996-2009 Darren Hiebert
  Addresses: <dhiebert@users.sourceforge.net>, http://ctags.sourceforge.net
  Optional compiled features: +wildcards, +regex

Thanks,
Mathias
