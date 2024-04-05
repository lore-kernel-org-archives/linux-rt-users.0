Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8B174EDB
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352307; cv=none; b=H3QGN5NP09ml/X6vo6SAsZhqkWKKeoGHeNfYPhbpvKcROf9rTTMR1jEEUTqchCaga4qZdc5+7b7N8xut9rrBHCVqEUnops7U2Og6SfCUWgCQFc699XqsubDAZqFSDdq7A24PjWMPKm/GDhvqNiAPbcKFxCfKibRlf10BBQ52ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352307; c=relaxed/simple;
	bh=mJu8ljWZ7+4pVmYDYlwXfRqGOnk4Pi98L1Wj61EuKMg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K3YwPmzS5XSuNtgRkeJ/NWuZ6BBBeKXTQoceoMBFkZ0oJivE6hJ7czqfHr0AG+Bby1MYRuwj22uieSNlOV/vK8NilouN2RKbiBFEfPug7qcvlXVHDpl1Sghw+w4+Xoje6nbGX39dXvPTj06EzuzEG3Lc8m1IZzwZcePFRm0Qjs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUMjRBJc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUMjRBJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712352304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JUH7ocG8ptj9RLJIgdvI4d+u5ga4zsy57pq38Snt+5s=;
	b=HUMjRBJcBysXHUn6NQxd0FkGAu9lfd1iTUU9Ztd75TRN8ccAN/Y4luUsTrnZzqKlvZfxke
	d0l8yALPC1mDGkdgDoBWYFlisOs6Bk1qoe26XlVXReU+FK11gL63KGtSQEoztUPAqpUuiu
	a2LPnC4l2gngF8BNLtuOuBesOYbFbH0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-DDs6380xOZ2n50PNA-Hfyg-1; Fri, 05 Apr 2024 17:25:03 -0400
X-MC-Unique: DDs6380xOZ2n50PNA-Hfyg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69945e66d32so7400206d6.3
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2024 14:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352303; x=1712957103;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUH7ocG8ptj9RLJIgdvI4d+u5ga4zsy57pq38Snt+5s=;
        b=EDFPZWyVo3axVVg1mssN8bGgAtWmeu2/keDhXs+18HHU+bhoM3HrmAXT3b3AG1dJo3
         NSzMT7FZuMo/1Eq7u0v19pobSCQcEfG2TOMqVNaEA0dEfjpquoe3jKi9BOyS6Fmy9P/m
         eoy6a0zTkvAdEMlhmZT99COfW2NC/S2O2PeoHAWbKu9pPmD3F9neLJ4vsH//451QAAvX
         icD9fx13x/D/1Ft+GuwZqRNkpQaP5qD+xkjtbI54KYwdhx7jlOfXdQ0g3EWqJ3LRwkpr
         zt0QsdsTBNsgon4UAhUNNU0k5gw5uu7J9Mjhl7GzlRLql5Jhawf3xqJonuM8SS3LZYRN
         sJWA==
X-Forwarded-Encrypted: i=1; AJvYcCUIte3Rzt7HaKkh5JJGAkGHw7DKYJ2kildNt93Nz3jufM2ZcKtJeo55XuuM8gj3xWlW57497ZRborwZsZJuj6l7Upr46vm+zTO36X9smJ0=
X-Gm-Message-State: AOJu0Ywz576OTmlam04DWaoxEEnpwkkyITMKyWm7+9L3iuesKa3bto+Z
	qr6SV16+HBPBfes9fachRgu4pHFGPpj4fuhhMqNQ8zp1SbaZ211fLl5PY1cuUUJ6mXYn+Rj2I6v
	KXJmcr+6bw2owD4mQ4XjvlyfXEidLNnqW/YnsYLaXAp9SyF99AxL40IYDEAc8H9vp
X-Received: by 2002:ad4:5d63:0:b0:699:f0d:98a0 with SMTP id fn3-20020ad45d63000000b006990f0d98a0mr3412344qvb.31.1712352302849;
        Fri, 05 Apr 2024 14:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8WqgxYUnaq2lvBnio/jDL7DJL47Zck9DutHY+1/W+0FtpszUg+3VQohi3Bj1wBTLC4qvFag==
X-Received: by 2002:ad4:5d63:0:b0:699:f0d:98a0 with SMTP id fn3-20020ad45d63000000b006990f0d98a0mr3412333qvb.31.1712352302589;
        Fri, 05 Apr 2024 14:25:02 -0700 (PDT)
Received: from fionn ([184.147.142.166])
        by smtp.gmail.com with ESMTPSA id l15-20020a0ce08f000000b006986c3f3d21sm929938qvk.116.2024.04.05.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:25:02 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:24:53 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: Nam Cao <namcao@linutronix.de>, Clark Williams <williams@redhat.com>, 
    linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: hackbench: drop incorrect and unnecessary
 usage of optind
In-Reply-To: <20240405085227.1GoglMTY@linutronix.de>
Message-ID: <41c7ad34-bf2f-3034-b679-5f8eb4acfd8a@redhat.com>
References: <20240402174659.202695-1-namcao@linutronix.de> <20240405085227.1GoglMTY@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 5 Apr 2024, Sebastian Andrzej Siewior wrote:

> On 2024-04-02 19:46:59 [+0200], Nam Cao wrote:
> > Variable "optind" is used as the last argument of getopt_long(). This
> > means it "is set to the index of the long option relative to longopts"
> > (from man page). NULL check is then performed on argv[optind], which is
> > not valid, because in this case, optind is not an index to argv[].
> > 
> > There is another "optind" which is a global variable, which actually
> > holds the index to argv[]. This is likely the actual intention here. By
> > locally define another "optind", the "real optind" is shadowed in this
> > scope.
> > 
> > Furthermore, the original optind "is the index of the next element to
> > be processed in argv" (from man page), not the index to the current
> > element. So doing NULL-check on argv[optind] with the "original optind"
> > is also not valid.
> > 
> > There is no reason to do this NULL-check, since argv[optind] is not even
> > read. Only optarg is read, which is never a NULL pointer in this case.
> > 
> > Delete this incorrect and unnecessary "optind".
> > 
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Sebastian
> 
> 

Added your Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
to the patch, thanks

