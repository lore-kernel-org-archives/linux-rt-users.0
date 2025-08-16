Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0514D2B7
	for <linux-rt-users@vger.kernel.org>; Sat, 16 Aug 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353801; cv=none; b=Xpzb91SfgIaSaj9LQrSp74ipgJB3KphfMXMgAJwD4s95VM2lQYcQGpr3DS25Z1JG4X88rBqgQ81ZQR7NTUVWwNnkI0vSx/NKeuImLlBSlHul0mA5XIEjpu0WA0J/ybFdMDsJQDR2UdMjWxqJSxnwtkDLaImJIPCS9UPBgMVYN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353801; c=relaxed/simple;
	bh=jRn+68TydpTDnUBx92tCFQOcAjFK+D29aieMu5Iz3wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTE7PUxjTkLUSdYtaNxMM1kZ8+V7GUEXkuOHcwmU5oOeMv80QKbCW/mpmmYbuQEd+MZZesMopUFTgzRhaLzlEmBrgX8GElMMx+Z3UIAF6JKRuGc9wXDoUJ+dqj/6MHXvovFPuRYJ9kg/F74nvMOKX+HPfZurGXeP3MZfJ/FO4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=r3t4TTOM; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="r3t4TTOM"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70a9f15f15fso23307096d6.2
        for <linux-rt-users@vger.kernel.org>; Sat, 16 Aug 2025 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755353799; x=1755958599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/WPrq9qE/mcKs1KinEiimPYdP4EDUSl2u22e6GWf8XM=;
        b=r3t4TTOMVxWO4lDPtw+8o8GZCz7odm3/TzNlcAuqEKpdQP9BKdWnx9bxMaMqkA2zQ9
         Peaw6tJsZkWF2plopa/QSA4XE3c6p6yLv1loBMS/zuERrbx0uhCG4VvN02SHEaDvmVwe
         700ihruGn23VWMcPiV0fqoXyIi7x99zSlzdoqiH17nPXrbgkzDB2sl6D1xyEnfyKwrr4
         mMDGWpSfh9tD3MZVmyK811otkddP6n20pShem7zDb34dcetA5KZFRmi4AAGpOzNn+PcM
         1oEp213J2bU37RtCxwvfRDj42fUWUBML8NLw4O614Bilw/oKlJ2sr3S8xYI0VgZpgFOE
         0xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755353799; x=1755958599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WPrq9qE/mcKs1KinEiimPYdP4EDUSl2u22e6GWf8XM=;
        b=V8FLdhuX2ah85o8mGoGW95G6OcVX48qZncJGXPMu9fTf4CWG0yn2rRWXJiSsBRnjkm
         xSV0nkducTLkMD0ISIvZMBaLbR8tx5wyXpLCoFupuKZXPNjVoKzSSwBSmyWHDrA78uqh
         zWC2IlNQ6XtZBIH4x37YGACyO+qsR7Ah5jNFekzQ4WG2ca53U2k+uZ8bNtZwy87t19gB
         VjaUDtZzolKTkaKc6+C4/qYEWSSUgf2NIQRjwUKwCrMugfLxAWPcwB9pYNnkfvF2ms8b
         /3yj0nsPysB26L1MTpWkI57F18C67bq3Yujc0JZGI80SEFj4Vzhg+WKfm9+ooRpABiLq
         eCrw==
X-Forwarded-Encrypted: i=1; AJvYcCWsfeuMv3zq/D+eQj5hdPUeov+g2BVg3uFQ2x8jplH/kEeFpwwVE/Jr3Uh2XHY2FpkL/INwhv+BtfQQM40ogw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUzGRJNZyjoHHf7zHkODw5dzL8AQXedpve+5BWgjDZbkUXZkjb
	eamhh7RbpY98lDkTsmrQvTbyarqKFJ+Yvd9grHMBNL3ukacCY5XNKK50/psliyd1vA==
X-Gm-Gg: ASbGncspze6KFWGXxlY9hrtxOojRdj6gkt9feNXrwxxsTQnwuLtPW6QJ/rcuyqrDYj2
	rLMk4VYY8yWfVrOu/I74TCWvUQTAnSYmqLNhsdWhVV4M8JtvTIUp3/X2FST/TyXAaGZ5EGJhRr3
	1Pdw6LnT+joz70LDC+vQdGBmy/to+cW+UM88AGVgphcgAKDKbY+PT9PmmXkWp0nn37uaHWEbNHS
	ML2MPUuEEDBm4GUY+50UqtBKMALNZT+Kny4b+vbU367QOTYm3Q/NgrJHGLZklPQte8fgJpv1+CS
	0T/2ITkDk9wflRnAtZG9l7hVavIrvmmE6grqWh/tCrnJNXhA9aKmjizvEsrLzSbaiWPIVl7cQJ7
	KiRFQkEqcp9SmfzooBBCZiHCJ2Ag=
X-Google-Smtp-Source: AGHT+IFg9HLizvQGJ4TwOzHyQne2Pjmhu3qTT34UGiwiDfF6gJsi9Wq8f0M9Mbi0CDc3I4ce5R6Msg==
X-Received: by 2002:a05:6214:3014:b0:709:76b4:5933 with SMTP id 6a1803df08f44-70ba7cb1a68mr71180886d6.52.1755353798673;
        Sat, 16 Aug 2025 07:16:38 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::f777])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9097688sm23736106d6.25.2025.08.16.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 07:16:38 -0700 (PDT)
Date: Sat, 16 Aug 2025 10:16:34 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [BUG] usbip: vhci: Sleeping function called from invalid context
 in vhci_urb_enqueue on PREEMPT_RT
Message-ID: <1088432b-b433-4bab-a927-69e55d9eb433@rowland.harvard.edu>
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
 <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
 <28544110-3021-43da-b32e-9785c81a42c1@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28544110-3021-43da-b32e-9785c81a42c1@kzalloc.com>

On Sat, Aug 16, 2025 at 11:18:02AM +0900, Yunseong Kim wrote:
> I think this part is a macro, so it appears this way.
> 
> Link: https://github.com/torvalds/linux/blob/v6.17-rc1/include/linux/spinlock_rt.h#L96
> 
> #define spin_lock_irqsave(lock, flags)			 \
> 	do {						 \
> 		typecheck(unsigned long, flags);	 \
> 		flags = 0;				 \
> 		spin_lock(lock);			 \
> 	} while (0)
> 
> My tree is indeed 6.17-rc1. I made a mistake in the diagram,
> which caused the misunderstanding. I’ve redrawn the diagram:
> 
>   kworker (hub_event)
>       |
>       v
>   vhci_urb_enqueue() [drivers/usb/usbip/vhci_hcd.c]
>       |
>       |---> spin_unlock_irqrestore(&vhci->lock, flags);
>       |     (Context: IRQs Enabled, Process Context)
>       |---> local_irq_disable();
>       |
>       |     *** STATE CHANGE: IRQs Disabled (Atomic Context) ***
>       |
>       +-----> usb_hcd_giveback_urb() [drivers/usb/core/hcd.c]
>               |
>               v
>               __usb_hcd_giveback_urb()
>               |
>               v
>               mon_complete() [drivers/usb/mon/mon_main.c]
>               |
>               |---> spin_lock_irqsave() [include/linux/spinlock_rt.h]
>                     |
>                     v https://github.com/torvalds/linux/blob/v6.17-rc1/include/linux/spinlock_rt.h#L96
>                     spin_lock() [kernel/locking/spinlock_rt.c] <--- Attempts to acquire lock
>                     |
>                     | [On PREEMPT_RT]
>                     v
>                     rt_spin_lock() [kernel/locking/spinlock_rt.c]
>                     |
>                     v
>                     [May Sleep if contended]
>                     |
>       X <----------- BUG: Sleeping in atomic context (IRQs are disabled!)
> 
>       |
>       |---> local_irq_enable();
>             (Context: IRQs Enabled)

So it looks like we should be using a different function instead of 
local_irq_disable().  We need something which in a non-RT build will 
disable interrupts on the local CPU, but in an RT build will merely 
disable preemption.  (In fact, every occurrence of local_irq_disable() 
in the USB subsystem probably should be changed in this way.)

Is there such a function?

Alan Stern

