Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0A27472
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Oct 2023 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDZe8DR5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CB69B
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Oct 2023 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697723249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VAjkRxoXiu2U+YVQBK1/j2F/lyOvmR8EaBpcyF8yoE=;
	b=UDZe8DR5UEck2h3T0vePlM7xUg+hQUTcIit/9b+CKteO4OepgbHn2IKKBzE0aEByEb9i+T
	jXEKGaSa3z1OzjrbsycdGC0U+K2zIB0qQg0FSpPXKHS/I5Z7vqWMY14Wt0hEwg1+LZI9jQ
	7OdHpjvXsC08em4+XH8mu7rpVip6UM8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-NH6UbWbgPcOjZ3_-v9fXxg-1; Thu, 19 Oct 2023 09:47:27 -0400
X-MC-Unique: NH6UbWbgPcOjZ3_-v9fXxg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41cc25beccaso19514831cf.1
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Oct 2023 06:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697723247; x=1698328047;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VAjkRxoXiu2U+YVQBK1/j2F/lyOvmR8EaBpcyF8yoE=;
        b=fsY/wVAJvhmWE7fTCh4ZgvWd+uBq76kjmpKphHj51OaVxfzzQCQVsZJtGbAPds/gkK
         CZQK16KRnK8eOVj3RDTLq6EM+IpHLuXgO6piuyYNztM3SkdBC3btswjH/J1WndlUpYCW
         VJ3L8fXIKjev5yOPxkwloB3lM45JM14kYglyaridx8W92R9PK27zQqyprbEjcFpn84Vb
         Cswyfk1H6GywJyUDgLAURlE9wiBcnY5dJDrAgMWwT95RnkuKsL9DxTfCHBkdAMZHheow
         FfHRcJaJoCPBA3va9vyGCSHXvgWt7lckXxMYR6dMDsUJQa/MS0WHWFT3TL3tc/8LVB8j
         G3Gg==
X-Gm-Message-State: AOJu0YwTqf3CpjL8Ln8I7higxNRt0ovpztNyvH0sQDOw2C/gsWHCUHso
	t6jZ7mfru3bQBzs28W/DzhFV9zWWVRd6oeou0xWHdLvgKKVrNJf7xyeyl7lxeZNFiU+04gNTdqu
	Dd5OOx1Euh2H9CVGblYA8ulSxobc=
X-Received: by 2002:a05:622a:83:b0:40e:6f1:3d38 with SMTP id o3-20020a05622a008300b0040e06f13d38mr2705982qtw.8.1697723246963;
        Thu, 19 Oct 2023 06:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAWVn+a6N8pZDsNyip/GoImeKV+7w46LdLdkmlkSCMKgouorzbHXd0s0OTansmE4mlksY+Qw==
X-Received: by 2002:a05:622a:83:b0:40e:6f1:3d38 with SMTP id o3-20020a05622a008300b0040e06f13d38mr2705970qtw.8.1697723246730;
        Thu, 19 Oct 2023 06:47:26 -0700 (PDT)
Received: from fionn ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id i12-20020a05622a08cc00b00403cce833eesm744071qte.27.2023.10.19.06.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:47:26 -0700 (PDT)
Date: Thu, 19 Oct 2023 09:46:50 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Mathias Krause <minipli@grsecurity.net>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: Makefile: Restore support for Exuberant
 Ctags
In-Reply-To: <20231019065328.932835-1-minipli@grsecurity.net>
Message-ID: <4be31323-8815-6261-7d5e-906171b0d66f@redhat.com>
References: <20231019065328.932835-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 19 Oct 2023, Mathias Krause wrote:

> Commit 974241c78a6f ("rt-tests: Makefile: ctags: Change obsolete extra
> to extras") is Universal Ctags specific and broke Exuberant Ctags.
> 
> Restore support for Exuberant Ctags by automatically detecting which
> variant to use.
> 
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  Makefile | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 223a839151ec..8d3268d19901 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -251,6 +251,11 @@ help:
>  	@echo "    tarball   :  make a rt-tests tarball suitable for release"
>  	@echo "    help      :  print this message"
>  
> +# Universal Ctags warns about the backward compatible option '--extra' and
> +# wants it to be called '--extras'.
> +CTAGS_BIN = ctags
> +CTAGS_EXTRA := $(shell $(CTAGS_BIN) --version 2>&1 | grep -iq universal && echo extras || echo extra)
> +
>  .PHONY: tags
>  tags:
> -	ctags -R --extras=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
> +	$(CTAGS_BIN) -R --$(CTAGS_EXTRA)=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

