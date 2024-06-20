Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654181A4F2B
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903959; cv=none; b=l8eJcya3qd3oHCTdh1b7CB4T+V9fenSX0gyBbzCz6/+PJgK3sFC9sDufa6ksR/ss5SE8oV4eJ2PSMgGWR6HGC2kIY6k+m7x9RyG/kBy9DfU/bIxcDuO+EUENozXfpJK6E8jDPt1KsWC+9OfZQn1hFe2kRNefHsKPOgsQSa8Nwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903959; c=relaxed/simple;
	bh=JojsNdDoqtfUU+AjE38Mk1phWSmEDbMLX4gAYYovSiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DphHWUF//MIK9tlIrKuSizOXmAPyJVmCfou/3gFVe9zSDRCFNUl8ewZb9+9cK/fefD9hqiRi+T06JNcTIZH1yqxRUM+6BwjzWzzYyb+bqQIdZcMTR+/sv1xHmdS6sSH5FbfHvh8YpHOTKlBKTMoJwJ4g7nXUG1RhDcTDIJMR91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFrUKFje; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFrUKFje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718903956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2hkBOZv2r9S3fSZnAhW59l8nG8mIjRVJRjKBvYq9JMU=;
	b=TFrUKFje/YfHkMTMWK1X1x9G5DXYs6mCXWbwmlWvN9bAo620ixPJ9a+ogsj8n4RTUq08G2
	+SWarbXs/Eu/cuMUWZk6w/jlr0Y6rTwxkoMK/1GmKrm5gOvQWwPDByx3xChi6qeCfSrEsn
	EorEfYhG6RXabURy4wzAAkAFeh7rx4k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-fnVPMv86N7G6IQSeoZh6jQ-1; Thu, 20 Jun 2024 13:19:14 -0400
X-MC-Unique: fnVPMv86N7G6IQSeoZh6jQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-79784eb58cdso117263985a.0
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2024 10:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718903954; x=1719508754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hkBOZv2r9S3fSZnAhW59l8nG8mIjRVJRjKBvYq9JMU=;
        b=b1P5EStxm6yXxLYocqxXIjSjIZl3ZVr9JBu7/f6UhTT60EllvG67vD8cJBE56BOz4/
         cn9jCywpsMStSzOyj1stxurFlgDBth39X/we+/OvX5QXh7d1149tgwrGQvca41xOGlVM
         jfY7HXPz4D/TRbxR20fTaMyMBWuhPCVkkYDjlFXYTBqDWhNdih3Mucl3UE7f2fSVeHJ0
         fppxMYVjvRPjPXFqeRWO/zq6pZ+iHH32o+5wPHneCPpGhLdBJVYm6bAP7MxdLtlQf+6G
         ps/DX3p4pTHsg3zdVv2L5aXS9FXbFcD0L5aI/Ja8j7YCoqEZcs92BCGFpKLCQDgl88Qn
         XxPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZZM6adJ9T5I13Zm0ad0tlnc7652hvZhu3mPZmQr5+dZUErEEiEfVB2TWSqY6idGO8+nV7OI4qc0LBvlOuRDaMm0TSTcPiEwhVcYFzat4=
X-Gm-Message-State: AOJu0YzJK6hUWQ3d/8pl/uI9BLXZfCw/VHYU8UkXrtkNJQzYC8tt/Lc6
	70FqrwKAr4Ro23WtJqRjoueg9fNIBlBGxIhA0MgUI7Dsn2vnA6Xo8t/M0EvkqEW6XOGZhdeT1e5
	eakXBXQOj/t5ami9TpczVswxTlr8bpgK9x3H5ICtIchPqKaTMVyzrSei3WR1A79Qx
X-Received: by 2002:a05:620a:31a0:b0:797:b319:c38a with SMTP id af79cd13be357-79bb3ed46f5mr689805985a.60.1718903954207;
        Thu, 20 Jun 2024 10:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Apjs1+aQ+o8xTmalO8U409DqWJ5eTStoRIC3ZB1CbFPGYcoJfpT+7HH8JziXTMPhGx7TOg==
X-Received: by 2002:a05:620a:31a0:b0:797:b319:c38a with SMTP id af79cd13be357-79bb3ed46f5mr689803685a.60.1718903953824;
        Thu, 20 Jun 2024 10:19:13 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0ce27sm709237085a.90.2024.06.20.10.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:18:59 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:18:37 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Derek Barbosa <debarbos@redhat.com>, john.ogness@linutronix.de, 
	pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org, 
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, williams@redhat.com, 
	jlelli@redhat.com, lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
Subject: Re: [PATCH] prinkt/nbcon: Add a scheduling point to
 nbcon_kthread_func().
Message-ID: <skr5kyam73ldikhn7uc6b3ikq4cxrtd4ohd4dekkhlmtyxmnbg@mw6xlvaop6hz>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <20240620071545.Es9LoyJY@linutronix.de>
 <20240620093246.HE9XDWSZ@linutronix.de>
 <20240620094300.YJlW043f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620094300.YJlW043f@linutronix.de>

nit: s/prinkt/printk

I make that typo so often :P

On Thu, Jun 20, 2024 at 11:43:00AM GMT, Sebastian Andrzej Siewior wrote:
> Constant printing can lead to a CPU hog in nbcon_kthread_func(). The
> context is preemptible but on !PREEMPT kernels there is no explicit
> preemption point which leads softlockup warnings.
> 
> Add an explicit preemption point in nbcon_kthread_func().
> 
> Reported-by: Derek Barbosa <debarbos@redhat.com>

Acked-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com>

This survived a bunch of tests that normally would cause some lockups
etc in PREEMPT_VOLUNTARY systems. I can see that the nbcon thread successfully
migrated NUMA nodes etc during periods of overwhelming the console backlog
successfully, which without this would not work prior.

Thanks!

> Link: https://lore.kernel.org/ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/printk/nbcon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index bb9689f94d302..0813ce88a49c5 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1119,6 +1119,7 @@ static int nbcon_kthread_func(void *__console)
>  		}
>  
>  		console_srcu_read_unlock(cookie);
> +		cond_resched();
>  
>  	} while (backlog);
>  
> -- 
> 2.45.2
> 

