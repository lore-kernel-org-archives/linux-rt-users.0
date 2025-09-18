Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC572628
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219530; cv=none; b=F/fgIidaPabmsAm8TpwIraWADNCiFL8rT+G7oluHPFwuIF4R7kiHUfWI7g3YnG3dzHPYkErEgHDeou7oI0a3cLVE7fmNNb3KMO/cemdprVu4/2CKjD4xDOArJLbEmzKAhNBmTsagenpvOSIuX2CuBlm1MFG6IeGhyLEXurmK/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219530; c=relaxed/simple;
	bh=N4lPQUBiGci19v2+IQPkP3gWfBUKd6tsFAN4/bbM+sQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ayvh5zEYMd7xOsQBxqAr3OMGMdL4YKFO0BD7tnR0xeKn3jnxEoM+fepQ/wM0htq76fnbEHn57ApJY76Sf8ByJ84bhQB+gAjz9X2QMwZncOhjdXGhW7bSR4urErD+q/nPf6hStxSm/0P3L1xI2ymAfKYHpMoqh0zQzTF8btXnFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzYbKBSx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzYbKBSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758219528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GlIXYt9Z3MmenO+ZcrDlQadHVob4J/CUEz+NWvikro=;
	b=fzYbKBSxGwEt0rF4ldvXTvP15wK5qu8ZeyLFq6pJJw6SgoMQRw4PSOf+6KL1re67y77RNk
	Ko0E8LYOzU/RyfUbY7NLyCDJMJaHCB60redJrrpA5U8MwDhxogmkXTXeTq7GDdXqhS9GER
	y12LuDUK31VKSu2SrOhlwmIjW3FMQ78=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Yt0KZbLBMrWkjQLXSEmwnA-1; Thu, 18 Sep 2025 14:18:47 -0400
X-MC-Unique: Yt0KZbLBMrWkjQLXSEmwnA-1
X-Mimecast-MFC-AGG-ID: Yt0KZbLBMrWkjQLXSEmwnA_1758219526
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-829080582b4so241134485a.0
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Sep 2025 11:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758219526; x=1758824326;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GlIXYt9Z3MmenO+ZcrDlQadHVob4J/CUEz+NWvikro=;
        b=L1ZLOKaRQP1OSibxC45TjtS6SlAUT3AYJEVLWLBGVPJHIV3K98C+EKQGkDwfv38h0w
         6o2XSgn1ey88SVbYiY8TxlsY1r8S3Wn3FdUoE5OcTW+drXVSy2UjVB30lKLBYzdx2kEF
         NujHeruQPnZtXn7Qn5sP+aonb+JjGK/HDicAv6fiCi6HjxAnFYdEp/tWbIigVpNo1E6J
         f38QYPOQf5vQ4xNSv8qIWt3ahEdgp878ZxFA/6RGSW52ikTMoRph/qH9bCW8I7mTGJ8c
         LIam9Qhu1+97pFHu4sryx9J3w+Z3MumKKcKi5PadDTI6ZlaemDwllDKAMATotKMwpt5x
         o0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVAFfHOqaGxNDUkSYyyA8LhHTLPbUnAp6dbc3f9+51i6Kyuj2jvh6R6WfEpxWueMzye3y5LRYb3TToc11b5ig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5xHNckjHIwtddEEDfuwyAAWKysLN+r4ZsFw4G72LfHKbh3ZT
	Lw1t9HWwPD2U9nRqEAeChpApd5WJqoZwE6k4oK7nJPY5EnvR8GdFJCh69g+ILO6o2LOtWDltLXi
	b4/bjTbr4IJKZ2xD+GoU18xni5zmy5aJX+KZHlvYF30trh/yfXASMi68uhW2gGy6uoikf
X-Gm-Gg: ASbGncuQCHrURXySzDRbMRuAu62xA4cR3yhYBTCvE64GmAhwAW/EgtqEiY4tB5pUX9R
	mK7WnqfmXl9Zks5/iFXoavDBI6r7YKgfQWd8v5/AcV058OlWbiWHGaocSsz7H0BRTAbgeqe+lmQ
	PVTHAx2EjZi+kn+fVHPycdFrBp5CDVmFEfveCKO3noSajwACl3boEmRY2Vw+8b9ODATYREOJKPm
	qjIHLoTPUDlufyh7tGDvby2WHVGoGZc0wal4vrB18u98/2o0gL7XDGau7J57MpfAIAwpeBVCUe1
	ybZ5dfLGWs/9QeKbIIcpgXPeIg==
X-Received: by 2002:a05:620a:4153:b0:829:b669:c797 with SMTP id af79cd13be357-83baf29a0ebmr60391085a.74.1758219526218;
        Thu, 18 Sep 2025 11:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPosvWfcKAZivqcF5PLHhMdKlJzBHJX1lmcSICz7/B6IT4g5+eNTy41QRcTW95nPLnDqG13Q==
X-Received: by 2002:a05:620a:4153:b0:829:b669:c797 with SMTP id af79cd13be357-83baf29a0ebmr60387285a.74.1758219525656;
        Thu, 18 Sep 2025 11:18:45 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83626595d3csm203544585a.6.2025.09.18.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:18:45 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:18:34 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] tuna: Proofreading fixes
In-Reply-To: <20250904142134.41426-1-jwyatt@redhat.com>
Message-ID: <9603a273-894c-fa0a-a982-91753be6ec8c@redhat.com>
References: <20250904142134.41426-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 4 Sep 2025, John B. Wyatt IV wrote:

> Fix some small proofreading errors.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  etc/tuna/example.conf   | 2 +-
>  tuna/gui/profileview.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/etc/tuna/example.conf b/etc/tuna/example.conf
> index 7bb293e..0d3353f 100644
> --- a/etc/tuna/example.conf
> +++ b/etc/tuna/example.conf
> @@ -55,5 +55,5 @@ net.core = core
>  
>  #special section for this file description
>  [fileDescription]
> -text = This file contain some features for tunning kernel params.Mainly this is example file for demonstrate tuna new features. Params are set as default or most uses value
> +text = This file contains some features for tuning kernel params. Mainly this is an example file for demonstrating Tuna's new features. Params are set as default or the most used value.
>  
> diff --git a/tuna/gui/profileview.py b/tuna/gui/profileview.py
> index 7570bc0..e5022b8 100644
> --- a/tuna/gui/profileview.py
> +++ b/tuna/gui/profileview.py
> @@ -104,7 +104,7 @@ class profileview:
>                          "%s\n\n%s\n%s" % \
>                          (_("Config file was changed!"),
>                           _("All changes will be lost"),
> -                         _("Realy continue?"),))
> +                         _("Really continue?"),))
>                  ret = dialog.run()
>                  dialog.destroy()
>                  if ret == Gtk.ResponseType.NO:
> -- 

Thank you
Signed-off-by: John Kacur <jkacur@redhat.com>

