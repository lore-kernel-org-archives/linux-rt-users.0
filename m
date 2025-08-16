Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F783A14
	for <linux-rt-users@vger.kernel.org>; Sat, 16 Aug 2025 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755309107; cv=none; b=oBY/kI7+Eai1QQ57SpVKgmt4k6WUAm555LaC5TlSz7IBjszZtCrQNnXyZzn1OlSMpFTEMVXbo4dJELqWabsrFB6gmkcdd3ibbOWWkY40jetAU9KKjtz7sFM/ru3hs+37baKcFgqZMqL/eLAxxzqrW1qc95HYaq9a9ZhsLPxF5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755309107; c=relaxed/simple;
	bh=AY3Ez1fFOiHrR8zbxC1ZWGl1P2kYXO+G01JFbsr+kCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8PetnQ0m++gREaiuhQpBk6eqUlNjazqM1IKquMylaH73jb43dQx62V5B4LdG1xw1RYOcZsqxoRlfxq5wIIupA3RdkPZNvbBRg5l+kKHUnme8YjG542+OmXranQmFdgTzVodH+KrlNN9T7Rc2FGMRyAk/XdPp01XCt9Xhh+AohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fmoEf3dP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fmoEf3dP"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8706df76bso364852185a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Aug 2025 18:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755309105; x=1755913905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiJjeXNoxQJj4jGqZ6+x2d77Ma763xVVnmx/xs0jiCg=;
        b=fmoEf3dPfCmD3L3B8imZe8qy3/rUPLWb9clU37n1LbSjxkVJCG1/OA1skVcJ1N4fLU
         pOawwRay5VIWXvHlbkKR1aGSazXAESbU9WGaRE4gH/hRW2asGk1fQrx7JhuIENUEW8hP
         88ltGK68UsB3g3zI8wuuO+3NxTR1qoqcLJUlrVSLx0ZsiRoJOjeZYz+36vmLW1Thme5T
         ewZKFKDvPEhqyWLEaRT8QJfKKFdtKeSDMHRmYQHP9mTTkZfvbhVbKDH/WelqXItZxZWi
         28bNcFGPKmxzaXWaIRX4b5M3nOSaeCZwwajZEuwI141PR7wzODAZVdbiuziCpxCegxfv
         e0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755309105; x=1755913905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiJjeXNoxQJj4jGqZ6+x2d77Ma763xVVnmx/xs0jiCg=;
        b=Mf01+Flbp38DT7Fo9tAq7/NHbiNmpMaqTY/VZrM802itFc4IG3C8X/PsIV8VfGumvj
         VCXIHbdP+JHc59N7moLS0nDtjId3qM37Fbn8rDSFedCLz6LTEWYgcLrxpZoZBdgB91nl
         NH7hxPYypd8vYuzAiXl8Fd1LUKE/RRVVBbIJB7QWgQJk5nIcUqjWOY9KmQHOs63EzTEJ
         a60/qpC8xGvwTkAPrcflzKLKjU4i7a0DUHLEq2/DXrUt6GIlWSO9P56q7c4pMzYyOjfC
         /yPcyPnkzISEeILY6CXypC9tAgfAU3yaeItprsW9Vg4IxvYfOm2DczzGhkizQH4FWuYh
         6bqA==
X-Forwarded-Encrypted: i=1; AJvYcCW4MHn8fAHNjXFAq4gQ46cKMgUVLgBXUN3Ko40UnDGiSrLCVsKDceO466X1Xynkpe5TTt3HD92HxH5sFBw5Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCHxQsz8jiD4mwj3c+tTgnHuLrcd1C67tSq4GYzwandu8MTgL
	LDwek7wdpJ9ctw2REmJmACtc1lNDG3o3E9a/RkJ6ODoUrv7Pn30MuHf51V/fF7uc3g==
X-Gm-Gg: ASbGncuPd5NyC4Ggq2nUFRIkH4Dcqx9OwnR68CmUgI06fv3o3md+HD1yzAkRliEjfjl
	hegSnQ96adto1CspZvgoa9+zsuD3zLvD5fNIF99kFcyg0Czov54tGDOvDM0NvSPWaIPE0beGR9A
	ZWT9WwuwTrOIgvbHK/pCL3F97JeUh1Qf0ydFciNioLH2YgFsZ8eRBFm1XTo7MmomroEQdjdduSg
	Plsy+fH9KwoD3ZJPX9jgTD21toeaDqdMcdo0W6qNqAhEyJgXYsQhSu4KpoTA+iEiD0KupOotWSE
	BCwLrPFi/b7CDJsJCRbqksMkdtbCYwwJWw/aIpqXVtJSxTn09YjbJP2RbnHD+sGL9xhuM9JNlf3
	VlmkKEgzDfcJ9kTnbAqxhCGMRrmU=
X-Google-Smtp-Source: AGHT+IGuOWAa7+/aKw4luwz4pks1sM1MfiHlIQp3XISShJpZ41YNX25ovPIrIZEseryRiQKSx0vwxw==
X-Received: by 2002:a05:620a:280a:b0:7e8:7b6c:f2d8 with SMTP id af79cd13be357-7e87e1223bfmr642098085a.50.1755309104844;
        Fri, 15 Aug 2025 18:51:44 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::f777])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e020b30sm199784485a.16.2025.08.15.18.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 18:51:44 -0700 (PDT)
Date: Fri, 15 Aug 2025 21:51:39 -0400
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
Message-ID: <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>

On Sat, Aug 16, 2025 at 10:29:34AM +0900, Yunseong Kim wrote:
> While testing a PREEMPT_RT enabled kernel (based on v6.17.0-rc1),
> I encountered a "BUG: sleeping function called from invalid context"
> error originating from the USB/IP VHCI driver.
> 
> On PREEMPT_RT configurations, standard spin_lock() calls are replaced by
> rt_spin_lock(). Since rt_spin_lock() may sleep when contended, it must not
> be called from an atomic context (e.g., with interrupts disabled).
> 
> The issue occurs within the vhci_urb_enqueue function This function
> explicitly disables local interrupts using local_irq_disable() immediately
> before calling usb_hcd_giveback_urb(), adhering to HCD requirements.

...

> This error reported after this work:
> It occurs after going through the code below:
> 
>  static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flags)
>  {
>  
>  	...
>  
>  no_need_unlink:
>  	spin_unlock_irqrestore(&vhci->lock, flags);
>  	if (!ret) {
>  		/* usb_hcd_giveback_urb() should be called with
>  		 * irqs disabled
>  		 */
>  		local_irq_disable(); // <--- Entering atomic context (IRQs disabled)
>  		usb_hcd_giveback_urb(hcd, urb, urb->status);
>  		local_irq_enable();
>  	}
>  	return ret;
>  }
> 
>  static void mon_bus_complete(struct mon_bus *mbus, struct urb *urb, int status)
>  {
>  	...
>  	spin_lock_irqsave(&mbus->lock, flags);
                  ^
------------------^

>  	...
>  }
> 
> When called with interrupts disabled, usb_hcd_giveback_urb() eventually
> leads to mon_complete() in the USB monitoring, if usbmon is enabled,
> via __usb_hcd_giveback_urb().
> 
> mon_complete() attempts to acquire a lock via spin_lock(), observed in the
> trace within the inlined mon_bus_complete.

Look again.  mon_bus_complete() calls spin_lock_irqsave(), not 
spin_lock().

Is the kernel tree that you are using different from Linus's tree?

Alan Stern
