Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369CD64A9B
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Feb 2024 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205586; cv=none; b=FLkgCFgG04eeKUS26L9S7fc8rc1GyVDz3/hb4W85cMPJFId3mu2wMJRrFL20ftBE5Rb1O4+Lmlk3JVOf+ovf+eWVdDtNIJ4NSgCgykcBKhoDgCnBUNpKUFFHd2xS8DQ35UiYAveQsobzr7jRaVyDUFkGk0YlSSCAXEvo0L0l/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205586; c=relaxed/simple;
	bh=CrfqeJfglTo/ajTyw1Gwgn0fWvXeO8/9hjzuKoGnGV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK6gRbEOe3ofj7rN8g0guIV1aAAXtCp4A8KkuFvPmB9XpbHdXwQWJecIXKnbQjtB+moVaOIGcTWOXD+2GGLXuEEpeJg8gje2fL6dpb3HAYJpBwueUaU400XriWt+Ly3DjKOD0OqFEPncdIHF9qJfddu4ydp6gyE3BqF9gptM4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqa1zfhZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqa1zfhZ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a43dba50bb7so115752966b.0
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Feb 2024 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709205582; x=1709810382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z3D5o73PHWTzmlfs+M2Cnag+Z5lMOi+i4eWtfpyC5s=;
        b=gqa1zfhZpH/XoQsnsXOeJQE3z4zB0jQ/0A05eCIxqGXr7tkxtMxIzNVamr5yLMQ4gm
         jdVcMEUTXzK6Yt9a8n+XRurTm1Y8c/bK9G2Wt/uiC86RzKkydDgXDhDZY2Blpr+xwhsb
         hlk0n/q8cGNbKxRFY8UzyC2gMNhyvS46te7HJhXv+8yjMYCBjIRXjckPmENZgB2EcZRL
         DlVCJoVeZkgtyWW8aCFyptr9HUa056uqELyv2pwNgqJ2781ZQXtkAHnlFqnnl6NrAKt4
         cVzQltFlMEHg47/XF7yOhOoF3pZxXkAV/fseMG1ied5B41A3VYER06ZKwlGCsqcIwKFa
         pseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205582; x=1709810382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z3D5o73PHWTzmlfs+M2Cnag+Z5lMOi+i4eWtfpyC5s=;
        b=B1raeUWkPyvofRHMbRE/EwQNK12vdQgjO04YKeB6P6XwxorOL2wADBn5HWbafapCGF
         rJBR6cfSfxMAWhY/lg9AllzYUD7Nfba814PGcddDsz1sY0lBhSebYQlf28SN3HSrBGU6
         0HrHI4ReQtY8gtBgeuj+V6WihommDy9y61bU79WrfbBM/FGMgMhQYn59iyuGA725FqBt
         s/KHPqAR4E7RmFcyxWwVUq/9RXEAd10omV9ONdxhq0wOfWQ36CWy+ac8CvTljqS0ZOTo
         s8kS5gi6kEPcHqVXDjtLjlxdaZkijpGX+RMVfsmwhn1tASn8IY6OngLVBbfUldDQolrm
         3q6A==
X-Forwarded-Encrypted: i=1; AJvYcCVPK3+6FLrlYJKL8PHOI2Wv9S+JGbHCtHi82oLO4jV1fN9jOsfUvXuhRnNUIM0f4Q745O7/M9h1tIyLzXLQFjXbgIKwT9zzN8/tdSjldyE=
X-Gm-Message-State: AOJu0Yzhtfmg4cJ8wgLXqzuorEmlEr6R5fPPfic1LbIjgwsOPlJ3ByLI
	7c3qLJlLw34SGcjbnC4Dykz0GKytiUVQz7dSg50YJ1qSzM2NfdbfhWywinHwX1M=
X-Google-Smtp-Source: AGHT+IEiTJIiVnJYh/o1Q6xEvLv1ebup90kGwCYruTGxf4JFDCbY03BB8m2v4P8ypxT/TpQ4Rn8CDw==
X-Received: by 2002:a17:906:474c:b0:a44:553e:5a1d with SMTP id j12-20020a170906474c00b00a44553e5a1dmr539793ejs.20.1709205582558;
        Thu, 29 Feb 2024 03:19:42 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id r9-20020a170906550900b00a3d5d8ff745sm588862ejp.144.2024.02.29.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:19:42 -0800 (PST)
Date: Thu, 29 Feb 2024 12:19:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Clark Williams <williams@redhat.com>, jlelli@redhat.com,
	Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <ZeBoTNe2cjb4BeXb@alley>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
 <87v86yc88b.fsf@jogness.linutronix.de>
 <ZcaQI8l1dcBx2feC@thinkpad2021>
 <87a5o8j9gp.fsf@jogness.linutronix.de>
 <ZcqMOKtHsZ9qnxNg@thinkpad2021>
 <ZdbZz-v_lug9_t6C@thinkpad2021>
 <ZeBnUCk598gttpds@alley>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBnUCk598gttpds@alley>

On Thu 2024-02-29 12:15:30, Petr Mladek wrote:
> On Thu 2024-02-22 00:21:19, John B. Wyatt IV wrote:
> > On Mon, Feb 12, 2024 at 04:23:04PM -0500, John B. Wyatt IV wrote:
> > > 
> > > Red Hat's conservers are having an issue with the machine I was testing
> > > on. It may take me a while to get back to you with more test results.
> > > 
> > 
> > Found a work-around with conserver. I was able to follow up on the printk-caller
> > info you requested.
> > 
> > I found 2 additional NMIs for a total of 3. Number 2 is very
> > large-please feel free to let me know what specific information you
> > wanted if it was unnecessary.

[...]

> > Compared to the two NMIs with throughput-performance (no preemption)
> > 
> >   <NMI>
> >   cpus=0
> >    .runnable_avg                  : 3072
> >  kthread (kernel/kthread.c:388) 
> >    .util_est_enqueued             : 0
> >   stack:0     pid:1733  tgid:1733  ppid:2      flags:0x00004000
> >    .min_vruntime                  : 2084315.290254
> >    .removed.load_avg              : 0
> >    .avg_vruntime                  : 2084315.290254
> >  console_blast.s  3497     34770.405603 N     34773.405603         3.000000     34764.898340         4   120 
> >    .util_avg                      : 1024
> >    .util_avg                      : 1024
> 
> It looks like messages from more (many) CPUs are mixed. I guess that they
> are printed by print_cfs_rq(). But the order looks random.
> 
> Also I wonder why it is printed from NMI context. Maybe, it is from
> some perf event, similar to hardlockup detector?

I have realized that we most likely see only small part of the mixed
output. I wonder if it is because it is printed from the emergency
context. Here the messages are flushed when leaving the context
and many might be lost.

Best Regards,
Petr
