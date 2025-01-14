Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711926AC3
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894323; cv=none; b=i9wFFotrOpFriIZQO5OiXTfeoAcVGSyjSySjcGz+T2Dzcthhc/FdrfBXWQTbTw55tvOJN4M9PP5ldjgTkSjdGf72ae41luhT4nduItF4K70ykgNPPA3JhU2bU5cllXmtxfysehfha2bMto0D14bGBpqAm6u7pGYyA3EQg6BJDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894323; c=relaxed/simple;
	bh=aSVRDjjnmPtvwVZIxPugQDbJ+Z0v+8Op2zPc9xk1fs0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MIUimdDZ9NwkB7/tOGyBRI4FTCgJDHbn2y//dHcvz+w0xm6pyMl+kHFuYwBgGKapkPeTxPbeAbQcfrzHALKVVHgjPsRVF9cSEQHeGMAOYEvWliVDxI/NjoptFPd+OA7yfy84nT4X/wSS+PjhPbBm7KEzKD+XNba5PYmYlTVws1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExTRFDMV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExTRFDMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736894320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjlRIedoS5PR67GPlDs+0DYzna4PK4GqREF6iFuhKYY=;
	b=ExTRFDMV+my9b+TLGiWRDxH5cuxxHnLqtY1cE378ZjSyPOQtktXHaq4fEiRCNqdXqlapXg
	+7Bh7N1OUEzDa4zLa/I6w0sCoNHyHabUHu5+6ADAz2jY5H98ZmQF1u+mEA23BP5IGUe29+
	JcTdU17v3MS+WpY0H47QxcJHm/8dick=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-LNAJj3JNMO6xedATTM2Aug-1; Tue, 14 Jan 2025 17:38:39 -0500
X-MC-Unique: LNAJj3JNMO6xedATTM2Aug-1
X-Mimecast-MFC-AGG-ID: LNAJj3JNMO6xedATTM2Aug
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467be89d064so71562801cf.3
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 14:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894319; x=1737499119;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjlRIedoS5PR67GPlDs+0DYzna4PK4GqREF6iFuhKYY=;
        b=A9aIQl7n88Dko53IOiEsZl7Bt+JfGQo6XBsCFP4QoAINxbpj6x9TsoQtbvuJQ+rwuS
         LMMy7F6Zx55YbpkpwTZ9VbpC32+3VKC2fZ6erz2SuyR/iSRgWBhDb94+qD+CSmNmV4m+
         Fb8PyNJ8+oF6Yr8+1JzqwouIaZ7xXIDx9l1RQtt7wosscf0FDIAwBDCt3eEkmf/cH/Vy
         91Kdez/AH/EuTPDGvqO1ztNcJzvUg257SP5/e+0Hw5RJDXWemwO+Os61zUJJ19DUijSU
         2VVjgm8RhlvHcGGxNBVMQYg7Bv3MHgz5uJUEYAUZaV8aJ9YDv0sLUCdeGhBy4pgqIxx1
         fjEQ==
X-Gm-Message-State: AOJu0YzGnKZrzP3l+1IpNt0KhIp7g7eZKFrFhPH+8x2QFKZ+UQHgDEUc
	bKA+BXc5Jh+2f3Sak1kU/8M9/spfI3dlNGA6CI94AIelJn6447pqzjOqDBQiBLvw7WHyPqsIQLC
	AQuJoicsVVAfJCk9mB1+htAbz/feJtXxVPuCA/VVDDte1yVwf6GPO6uqZ8x+MM10HdC3cbUMx
X-Gm-Gg: ASbGncsk628q/s2Rosn2Fz0JHQSVA+dOsxmvT5JzUiQKNtbD5DRnRdPZMXNlYqODfnZ
	SKwBdmbt4qPbDcAWZ4TPOHyFC6p5G/8KXptrtYNTZSojDSYJPmsEpoETOP/jWgQCbC6qJaQ1Hbg
	dxThPUpFPfxrLj14cxncQEuOBAU9jcbxc7dv724qIC/e0s49qSlOid0hUJ3zdoWRtHN8PG7MSVn
	gY8HCel9eaRQr5tKM/h8dGo+DhfgJQYvD43CGhh3j/v5v0=
X-Received: by 2002:ac8:5f4b:0:b0:466:b287:78a with SMTP id d75a77b69052e-46c7107ab3amr422448921cf.3.1736894318687;
        Tue, 14 Jan 2025 14:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrgrK2/FcJgCtyMidc2MK/bHY86fUytH+W6/kqajOrDjmgpWF0f3fQoqoeS0QR7FyVuCj1qQ==
X-Received: by 2002:ac8:5f4b:0:b0:466:b287:78a with SMTP id d75a77b69052e-46c7107ab3amr422448611cf.3.1736894318386;
        Tue, 14 Jan 2025 14:38:38 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873305c7sm58217381cf.21.2025.01.14.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:38:37 -0800 (PST)
Date: Tue, 14 Jan 2025 17:38:36 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/3] rt-tests: Turn off -Wunused-parameter
In-Reply-To: <20250107220229.156201-2-crwood@redhat.com>
Message-ID: <5eec5659-0b77-c2f1-d506-0d2d244f137a@redhat.com>
References: <20250107220229.156201-1-crwood@redhat.com> <20250107220229.156201-2-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 7 Jan 2025, Crystal Wood wrote:

> -Wunused-parameter (part of -Wextra) is an obnoxious warning as it flags
> perfectly reasonable code that takes unneeded parameters in order to
> comply with a function pointer interface, or where the parameter is used
> only by code inside an ifdef, etc.  This results in numerous annotations
> just to shut the compiler up, all for a warning that has relatively
> little value even in cases where it's not a false positive (where it's
> just an indication that cleanup is warranted).
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 0fa0928..dda29c3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -33,7 +33,7 @@ prefix  ?= /usr/local
>  bindir  ?= $(prefix)/bin
>  mandir	?= $(prefix)/share/man
>  
> -CFLAGS ?= -Wall -Wno-nonnull -Wextra -Wno-sign-compare
> +CFLAGS ?= -Wall -Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter
>  CPPFLAGS += -D_GNU_SOURCE -Isrc/include
>  LDFLAGS ?=
>  
> -- 
> 2.47.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@gmail.com>

