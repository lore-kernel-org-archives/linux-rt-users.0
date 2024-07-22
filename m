Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BDE18EB8
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jul 2024 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689550; cv=none; b=nCFNiWCph+d2Chi/cenXbLhS2VmxFUbu7GU635pmwmV/8ktNKyOj3sVxHxGXbvbsyEuJYsExoyH7pybTEXNePEQqyTF06ZpXPkMF3UnusQ46KLlqoEeo5AYLqUs5EUGYCtiUSc433d6WSMTrSxyj4ZFucLbbud+jUWn6u1Lkgns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689550; c=relaxed/simple;
	bh=azkVs+k8IiJItsNnt6+7xEQwH1BZkF1Hb8U/jqQzJIc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NE0Dpg5qD1MEU6BwYC0wsEVQQ71Ie2uloBtaKokSMSGmVfdvg7jOg8sk/cfXxEb6vnA6LRuMcoaNxE4N4eh9e+VC9ys/qocMKz9OcOt278VrFvWyddigZguQ8JfvNuAKqdFGWPpY2y66A7mvEruVvGX5eWrf4ZPFERkWxqzMWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dI2J60uZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dI2J60uZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721689546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzHb5yq4xMdVIkpjYeLXU22OJC+FOuDYLjrBQmF4JOU=;
	b=dI2J60uZeu2KsXbu2Cx/lYrYbpIAc9Oc8dn1RLdu7QxRpL2PuLgR+KFh/c/ASJyx3+40CR
	AUUUr4VJlHUcEpQ/EY1Ppv2EKojfGv9+1867Y1Ng6VrnGgApWg0syzWpMj/1h1HU+lIZpq
	HZZJpjU16fsqYGMpi/mtaWAOwNXv0h4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-u658wCIVPLSaC1pE4zzoDg-1; Mon, 22 Jul 2024 19:05:45 -0400
X-MC-Unique: u658wCIVPLSaC1pE4zzoDg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b79a77f265so88918556d6.2
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Jul 2024 16:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721689544; x=1722294344;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzHb5yq4xMdVIkpjYeLXU22OJC+FOuDYLjrBQmF4JOU=;
        b=cLWqhvaEB/FG70FOg9UppagBPc6eXsu/rEBYfuUmhYW/tgr3mPeYQ02w24HGLd0i+l
         fLStTStDs2cNNi/DrcLmfjyrU2VLp12dSTP8dyqUSyDMztAaPr0f6aD7K0bVAxJAURm7
         8Ma44CK+r22tKoiaLWUIOnYrEuQF3aVKHfDHwtugLNBjz/3PjLHDtzrBLu/3ZEzXBnMu
         HT5hq4HJn5ABZSn8vmnijdM68rtsO2lbsydcyZ2CYBl/wavMZKPsEKdku+cBRdy3YJ1J
         dWcXabFprdE/8kVGFZq74C3OVNHYSDiEjtElT7ZVck+r7WvxGmNHKL/iFP0BOawxXhmS
         3apg==
X-Forwarded-Encrypted: i=1; AJvYcCU6jlP+P99jRMohmjI9VBsksHtMnpyXcGfWJPOkTMqmEiOjSuBrTzKdvTLvjJAkyJlBieboQcLCO/2q4+qTYjZXc7pzX04wgoYRZpqUvoA=
X-Gm-Message-State: AOJu0YzD++miszzio1GjRXCmqpefl+hVH98qfzw7HBsdodqVQUlRHiro
	R8Lqyf/PS6mcGMUQ3IkUJZldRxDlZnf+PYJSmWSBuuURd6qv99NySXpbXpDFjA52UHiWiYH7s4Z
	g4m+Y5zdBoAKGzB1PiXPIOhjxuer5u9XjSFjONeXTodqBwuDch8loNLS13d8U5QBJ
X-Received: by 2002:a05:6214:5192:b0:6b5:de7b:b3c6 with SMTP id 6a1803df08f44-6b95a6e8c7amr120042296d6.33.1721689544643;
        Mon, 22 Jul 2024 16:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAz+cfHl3Pht/kxuOlZAKLF02tmLoGhZifja3lhKkWdkJKzNAxTK0pn5jXM+4wrsN0Kx+gvw==
X-Received: by 2002:a05:6214:5192:b0:6b5:de7b:b3c6 with SMTP id 6a1803df08f44-6b95a6e8c7amr120042026d6.33.1721689544321;
        Mon, 22 Jul 2024 16:05:44 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acae1c93sm39893286d6.108.2024.07.22.16.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:05:43 -0700 (PDT)
Date: Mon, 22 Jul 2024 19:05:42 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Fix default measurement config
In-Reply-To: <20240719200234.88661-1-crwood@redhat.com>
Message-ID: <b4cc2f81-108d-fe3c-d3db-ed220bf48db7@redhat.com>
References: <20240719200234.88661-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 19 Jul 2024, Crystal Wood wrote:

> Commit 761741d15d08e ("rteval: rteval-cmd: Some style changes suggested by pylint-3")
> accidentally indented the check for missing measurement config, such that
> it became part of the missing load conditional.  This was harmless if
> the cnofig file was missing entirely, but not if the config file
> exists but the measurement section is empty.
> 
> Also, remove timerlat from the default as it conflicts with cyclictest,
> and we're not quite ready to make timerlat the default.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval-cmd | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index 36b167a034e5..19c82a0b64b3 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -247,11 +247,10 @@ if __name__ == '__main__':
>                  'hackbench'  : 'module',
>                  'stressng'   : 'module'})
>  
> -            if not config.HasSection('measurement'):
> -                config.AppendConfig('measurement', {
> -                    'cyclictest' : 'module',
> -                    'timerlat' : 'module',
> -                    'sysstat' : 'module'})
> +        if not config.HasSection('measurement'):
> +            config.AppendConfig('measurement', {
> +                'cyclictest' : 'module',
> +                'sysstat' : 'module'})
>  
>          # Prepare log levels before loading modules, not to have unwanted log messages
>          rtevcfg = config.GetSection('rteval')
> -- 
> 2.45.2
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

