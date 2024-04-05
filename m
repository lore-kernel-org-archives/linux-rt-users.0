Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9794639
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275856; cv=none; b=WKfAgzCEu6SRoT0kbiIZZ38Nm5uWDXjL0h7kcxX98zzRIMt0ZqOAASC4jk5g/+B89vR3pRLxgIp44eoZAy7EnO5xgetJXGirghcqSvvnI7E5z1wZDdPTt/H6xstz+JHvM/G9m7qfTI2BANlXV06+iMvgLpl8j6iOuILGsf3w43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275856; c=relaxed/simple;
	bh=BmBMLXUxUdQY6RZx6aOTeW4K15net+pmM7o/+Du4xfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7KAN/7chVlZxK/dBuVLWUfOkOWiZd+em2UF5noa5ObZZZgWt6VwDQfPhvtnSYKhSFfZrWLXBhypxk99fh6Jal685b8kO5KDoLYykPa5yCrxetSyjXo2Aca1S4lmFRg/OC0FQx6WkiRdONAvUnvRNJ0PnCnd2tZr8zEk0LzmSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCm8ypvX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCm8ypvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712275853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPChRIv8A7YfUteYh5+G6hC7ECPnSAUjkzqqJ0L1F/Y=;
	b=iCm8ypvX+3CZZ4jXItm3aJfV+6UgpQB2VKrT6TnHUYLO3RyC9PSggo+Ck2JvyygfhCsFdM
	9oIaZpMGfx4dAm26a2KaK8LQYcQ2YeXVXwrGnS/CnGm3KQpRaJTbSF0Df7QmwH5qrfSQzV
	LhtX5jV+wUhIM1/cBjXiCxi0SUhtuWA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-SDYJID6MNMmPrWAI9goZBQ-1; Thu, 04 Apr 2024 20:10:52 -0400
X-MC-Unique: SDYJID6MNMmPrWAI9goZBQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c3c73e89fdso1350952b6e.0
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Apr 2024 17:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275852; x=1712880652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPChRIv8A7YfUteYh5+G6hC7ECPnSAUjkzqqJ0L1F/Y=;
        b=BWc0Rt+YMWvxky1gIediiNsLVqxVa5wISdS+0uuxDbW61dXCSy0FFCgHkHZ7d+zg7M
         0R3yE0yBb0As0lwqMMGg3qzowO+wZ/4hCIzm1ABWq5uHMb76EQaTrWO7zCLVTP9MtoBU
         C4etFaP8Tj8uN6MjXVKPftqOxtcNlhoi663E80ERN/4Whyawv5PBFb/80xP76cxPU+F/
         4Ago2dBFFqHbUdqmrj8v2YVmxsFysoNWeUUydXncKSQJAORLy4zUTr7t191tQ376unTJ
         paMqIPuyW49aRJXEaU0M8vhe3u9CKgU4tmrNaCUsGLQgVSMUG0bLaeny9Vj1XkLH/LN7
         Iv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8kBRDXHOCekafwYWuzPjmv72MkKFKvD4DVBUabk+eNI6ZpYYDSKXQZuscLiHy/2bDf3mefhuIcoei5Y1PvRz5nvriF4ICGvpW/6Z26Es=
X-Gm-Message-State: AOJu0YwlcbFzJPXbf5EhPZDVvk+4NX6Ns4YVPQcxkRcASOMTFttJquBR
	9CwXmXmV9pEoLlqexe/lji3uC2P265EI4G2I7cAUClz/YhLKXRMa/XkJlRi9nJziS7i6sg61RgE
	aaKGJMZPd0rjwJp89uIQfO8ssfFRyoWfJ7L5KGtel1sVsyo1voKrYR/MWjJfvEwZs
X-Received: by 2002:a05:6808:1a94:b0:3c3:e78d:f1be with SMTP id bm20-20020a0568081a9400b003c3e78df1bemr3224537oib.57.1712275851136;
        Thu, 04 Apr 2024 17:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYvDwwFdzbAzzTkv9y5a2UnJif8xQ//ZZbKdgL0bzXnHd+ilqRDAJVDXGbLCNvPpqaWSRZYg==
X-Received: by 2002:a05:6808:1a94:b0:3c3:e78d:f1be with SMTP id bm20-20020a0568081a9400b003c3e78df1bemr3224503oib.57.1712275850193;
        Thu, 04 Apr 2024 17:10:50 -0700 (PDT)
Received: from hatbackup ([71.217.47.58])
        by smtp.gmail.com with ESMTPSA id cm23-20020a05622a251700b00432ed7d7b7csm213093qtb.85.2024.04.04.17.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:10:49 -0700 (PDT)
Date: Thu, 4 Apr 2024 20:10:47 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMIs reported by console_blast.sh with 6.6.20-rt25
Message-ID: <Zg9BhxtWepFZyH8t@hatbackup>
References: <ZfSfrzak9WS0ZFv7@thinkpad2021>
 <20240322122921.U3WRsO4X@linutronix.de>
 <ZgSvVCDja6yFCC0Y@thinkpad2021>
 <20240402103414.KkkX5RuV@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402103414.KkkX5RuV@linutronix.de>

On Tue, Apr 02, 2024 at 12:34:14PM +0200, Sebastian Andrzej Siewior wrote:
> > Just before the sysrq that crashes the system.
> 
> so this is intentional.

Yes.

> > 
> > This is part of the console_blast.sh script that John Ogness sent me.
> > 
> > Please see below:
> …
> 
> Okay. Then everything works as it should…

Correct.

> 
> > > > NMI Backtrace for 6.6.20-rt25 no forced preemption with tuned throughput-performance profile
> > > > -----------------------------
> > > 
> > > This and the following backtrace shows the same picture: The CPU is
> > > crashing due to proc/sysrq request and does CPU-backtraces via NMI and
> > > polls in early_printk, waiting for the UART to become idle (probably).
> > > 
> > > I don't see an issue here so far.
> > 
> > Luis Goncalves discussed it with me after reading your response. Thank
> > you for your help. The NMI was needed to flush the buffers upon the
> > system crashing itself. Does this part about NMI watchdog need to be
> > documented?
> 
> Not sure about that one. There is an _a_ _lot_ to be printed from NMI
> and the NMI watchdog might trigger if nothing is triggering the
> NMI-watchdog during the print job. Also, the crash was requested.

I reran the 6.6 test and no NMI was reported with fully preemptive and
the realtime tuned profile. It was my error; my apologies for that.

I did include more of logs if you want to see here for my 6.8 testing.

https://lore.kernel.org/linux-rt-users/ZgWL2UyknaE2T70C@thinkpad2021/T/#u

Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

