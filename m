Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20A443F
	for <linux-rt-users@vger.kernel.org>; Fri,  1 Mar 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312006; cv=none; b=fBDCtq3l0jq2fomHaLRo7FXQ7TjD4tNilRqRuBOuUstuFqg+tWw+nOp3qYmP7SLZ5+0OtkCYsSCNSia6PD/EIeswR3VscXmpd0u2i1jwGLlG7GC7kTAtdKHYQuPxf4FJ5tLCUNp4S1/gTbEMyVbP8tNC9fQeYmgx5rakq2++vqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312006; c=relaxed/simple;
	bh=Bxr2z1UM0sWuyWBlEwdzeGviNQBX/Cz7gaBXN/LSnFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn8UWClDGv/AFnWmTGu6DKy020XVMcJ50sSPSxd8JRFD6q9gExK4JnWC+55t5dW5i6AwoKtmQzkKbyJFO7aa9tpvwfS8YR6JZy2te2p7hxMg3fAWeFncq88Ch6vN/J55+OU1aXg3nw/uVg2YAWO9uLubJdnNuyq05nZQCjOOELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAjIq2ec; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAjIq2ec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709312003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnTwiMADK8/eZ4X5li0kPAr1pEQ+f6B4THtEc6ABCsk=;
	b=SAjIq2ecEYPmBDBQyA/qvGsBXvDWrED699C4NSbRKuLNHCt/D9cZ8nR6BbiLjYCQXNgRXe
	xzgsS5RrOeg3HCE4DZ0Lh7hA7N47BNS9JqLE5JpTFs6p5UTN/vAAewNiQftZtzsmlZtKqB
	04n5g8N78qoAGPFSSPonQk0fV6oBtHY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-JCUNJIzeOQSL_VFcFZsskw-1; Fri, 01 Mar 2024 11:53:21 -0500
X-MC-Unique: JCUNJIzeOQSL_VFcFZsskw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-787c04e48a7so252080585a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Mar 2024 08:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312001; x=1709916801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnTwiMADK8/eZ4X5li0kPAr1pEQ+f6B4THtEc6ABCsk=;
        b=uTdTzoYMigCzPwUm6NcvSsQ8E0cbOw4zOLxVV7Hev9SuboYBp49kio5n/2EbNnrgDe
         A3tKAkYFoIkncq9pX1RMFr8AyIAjkN+Nn3HA8rICp89uveaKt6a9CE+yZLtnR0H2AMtf
         Dl8swJOy6tPksIoK6SfFE0vjn2Kuaa0WD+bPiGpVw5R01DTaM//AN8r6WCUjSY1EzglP
         BY1k5T54tidrFOVc3Cr6MRQCwkReIHsO/dRQ98a6vQKTIqyRVz7KzweoMe5i7KWfKAXA
         kCxAuzxI+XC914Fbj1Ld0wVwFRctczO7q5D7qMpW1xbwG/mFXV4xbuAB29mqgV+jI8Nh
         6JSA==
X-Forwarded-Encrypted: i=1; AJvYcCWffgUUZXVuBU429wLacc57Imisztfg5OQ9yoo2oOX6IJK6oApoaYgtPK6h3ePzTxpyVFHlm6A31xjv5d19JHfpbC+WUUR69IRSGNEMtRY=
X-Gm-Message-State: AOJu0Yy0xgNiV72rokTW/WMuYQTUKfl/H4vBKzFWs/HCupHRjWKqUr4I
	AGn6+zfDyhi9zPuQn7vcoifo7jb25dQqrBde7WMRYXWcKkbsUfoWX2u8Jj2nolp+pwtcJwFDWpr
	pLObiw58g0zWg7SnH+9tfd8sInV5w06iLb+TczD0I39XVidSCpfMs2R9YtQjOWpB8
X-Received: by 2002:ae9:e119:0:b0:787:ec02:92f4 with SMTP id g25-20020ae9e119000000b00787ec0292f4mr2233159qkm.19.1709312001070;
        Fri, 01 Mar 2024 08:53:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdyu/Q+jPAX2NusR1rW5HWBPK4b/7c04/rUi1ZZ5DQbDJ5K9ToAF5bsYSo1bU39ml2s/y2LQ==
X-Received: by 2002:ae9:e119:0:b0:787:ec02:92f4 with SMTP id g25-20020ae9e119000000b00787ec0292f4mr2233147qkm.19.1709312000847;
        Fri, 01 Mar 2024 08:53:20 -0800 (PST)
Received: from thinkpad2021 ([71.217.42.17])
        by smtp.gmail.com with ESMTPSA id b5-20020a05620a118500b00787ec3a77c4sm1781021qkk.100.2024.03.01.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:53:20 -0800 (PST)
Date: Fri, 1 Mar 2024 11:53:18 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Clark Williams <williams@redhat.com>, jlelli@redhat.com,
	Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <ZeIH_l4T2uIanMyZ@thinkpad2021>
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

On Thu, Feb 29, 2024 at 12:15:28PM +0100, Petr Mladek wrote:
> On Thu 2024-02-22 00:21:19, John B. Wyatt IV wrote:
> > On Mon, Feb 12, 2024 at 04:23:04PM -0500, John B. Wyatt IV wrote:
> > 
> > I found 2 additional NMIs for a total of 3. Number 2 is very
> > large-please feel free to let me know what specific information you
> > wanted if it was unnecessary.
> > 
> > This first one (the original) is with the real-time profile (no preemption).
> > The next two are with the performance-througput (no preemption).
> > 
> > This is what real-time NMI reports with the caller information enabled. It
> > looks like it is lacking some information compared to the other two further below.
> > 
> > [ T2481] Call Trace:
> > [ T2477] Kernel panic - not syncing: sysrq triggered crash
> > [    C0] NMI backtrace for cpu 0
> 
> This message seems to be printed by nmi_cpu_backtrace().
> 
> I am surprised. I would expect to see the backtrace printed from panic().
> It calls dump_stack() directly on the panic-CPU. And this panic() should
> be called from sysrq_handle_crash(). IMHO, it should be (normal)
> interrupt context.
> 
> Is it different on RT?

Yes. There are no NMIs on this machine in my tests for when I run an RT
enabled kernel.

> 
> Or have you somehow modified the kernel to use NMI for sysrq?
> 

I have not modified the kernel source code from 6.7.0-rt6.

-- 
Sincerly,
John Wyatt
Software Engineer, Core Kernel

