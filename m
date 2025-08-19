Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF82253AE
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Aug 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612758; cv=none; b=qHzEtMnHIJiQQS0k2N6v67puDMBrCvbeMjRVAcdKspGQe1gIUHz0wgXQKcuk0GOQn4fe+UREFICo0YL11Anq/YfV/8aC4MqSkOVGYOyZr+Qk3rjr8xrmcJuWfhzpDn5ZFum98zikfcTrOHfBZ9naDHL16LkJiebPVF7ravdzhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612758; c=relaxed/simple;
	bh=gt4mRYfjODV9zhqfPjnfdU89Lq3jwQVRdixAwLEWLSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA6HH+4oy801cV49DlLMi09vHt6TjiOHhG2mTsDOa68fmfyK9SWX6YvNsYAP6pKfxAgCgsrK+iA+SV1hy8hCXfu0h8FDAID112VI52tWra4iWttE4PTBBboh1/dbQ6XwyjAAbCjnoFIiP8KhtP7FfGLVb9CyWBdrivUXzN3Hmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=TFfy3k/r; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="TFfy3k/r"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e8705415ceso635066285a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Aug 2025 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755612756; x=1756217556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDLwUY8c5UikKYG43v+aAUoS5K12CXkZu1S6tpWU6eg=;
        b=TFfy3k/rnhuwPkiNn4niFNUXwgmnpl7DS6gFMh18k8UWlbgbmf52NdHiFYbB1xjydb
         wCJ8p3YuHFEkvLlTWoju5a+eHqH9DGz3Hbiif4xV9o9NRpsNjOArzd4M9YvD8VP75ZJX
         pkDOzeFkrTfwpYv+dwmZ45w6j0PVnOoFVlUotxpoU5EiXMIQkDlxBuFLS/CODJVeQqVl
         k2B0iiPHVSDMd355ILgBmMiJ2OxKEf95gtQPrCvxudYLMzuAgQiqJgejHHcARvVrKaGA
         TBtvv0JrFfzEQD9NazxIe/YBHGEyTcHnvSc2Nw8HDkbzcJ2GJdX/JDfZf0O4a5rGMrxI
         pooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612756; x=1756217556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDLwUY8c5UikKYG43v+aAUoS5K12CXkZu1S6tpWU6eg=;
        b=c7utc1YGqdjJPXZGAhza6VLIM45lk2Wmkx5iZDMmkUdHrP5pU2m9AJgDuUl9P9Bu35
         oIlV0+WVJazXCS5PV9AxcU911mpsA2o+95LXGw7t9Wvd42R1agKk8XjUwg58QknINMvX
         tkGLnYA4kbFWYDWluZ4j0i+A1TzYkiyXTrwWRwZ5kB2PIVHFYuzlAzH2BIT5AJm6VNDQ
         Z/YZonnCDyqDP7hb2SsYuLptz0v42M+6kro65rHzqSqgxd5IXgqyOeDc/dpixAXucejT
         YC/z15u207WpMetnzX7JFBldwXg8ufwPqf8VJkb4Bwbi/H7wT/bCZRiLVvwTrng/tdqK
         DAnw==
X-Forwarded-Encrypted: i=1; AJvYcCWBKX4y7mIZanzCg8B1BWtmfUcg3h71q3EYOZhoc1LvRFO7X1HW/U6Hk4oaxTXnLnvb2AD7B+lAzd6mQGpM+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MF116DnoDAQjlS0h9gOwZtCwFFguDvpKtW43k+mm8CvIRlu8
	A0Ak9PEp5moTBhJQMXOEHtKL2nYO14XJ7qER2T89kH1UXuY6q8Gf/4hTjK4bIjc89g==
X-Gm-Gg: ASbGnct0DhCK8VHehBxcqAZPBYBvecxa4A/VoTF3sfSbfN6azURl2OWESBySC9N7Z6U
	ZmmopU4Llq3TJABxGdZhI92Y01dqnQNkedzSUhaqWNVbZQX499/0t+xgpEASJbIdZfG9lFRwNP+
	efTUsSQl3w/7F9KwJgY4Ah6kG8jqscszCJDH6yWP5ioZxr2IvPCKQTAOD1ynSdmLOwi8m35AKfY
	nox7R/lO7cifGPXicRuLm6EQoy5Y71TPXW5/3/uYHmhFrwshvAc2QLQ7zM5cN//3O3sxrQGUI5n
	ajVRAIikUrQmdg1NfZjO28nltL9+M2BGtiUCuF3FXsxyfQcj3SLbHRm6SsHlGgXx0zcl68tjYcl
	EJLdz/UdEZsLAmxrlg4h546MVAvY=
X-Google-Smtp-Source: AGHT+IHQg04DWf8DLLAvL7X03CUOIZTn7DoQBqcIlAoSiqB7A22l6EHFGlPS13+38MuE7eItCA2s6w==
X-Received: by 2002:a05:620a:1a1f:b0:7e9:f17f:65b8 with SMTP id af79cd13be357-7e9f3361b7amr352563585a.39.1755612755346;
        Tue, 19 Aug 2025 07:12:35 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::fa48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e066da8sm771292885a.25.2025.08.19.07.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:12:34 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:12:31 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yunseong Kim <ysk@kzalloc.com>, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [BUG] usbip: vhci: Sleeping function called from invalid context
 in vhci_urb_enqueue on PREEMPT_RT
Message-ID: <49ee1b8a-d47a-42df-aa64-d0d62798c45b@rowland.harvard.edu>
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
 <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
 <28544110-3021-43da-b32e-9785c81a42c1@kzalloc.com>
 <1088432b-b433-4bab-a927-69e55d9eb433@rowland.harvard.edu>
 <2bf33071-e05e-4b89-b149-30b90888606f@rowland.harvard.edu>
 <20250819110457.I46wiKTe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819110457.I46wiKTe@linutronix.de>

On Tue, Aug 19, 2025 at 01:04:57PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-08-17 10:27:11 [-0400], Alan Stern wrote:
> > On Sat, Aug 16, 2025 at 10:16:34AM -0400, Alan Stern wrote:
> > > So it looks like we should be using a different function instead of 
> > > local_irq_disable().  We need something which in a non-RT build will 
> > > disable interrupts on the local CPU, but in an RT build will merely 
> > > disable preemption.  (In fact, every occurrence of local_irq_disable() 
> > > in the USB subsystem probably should be changed in this way.)
> > 
> > Or maybe what we need is something that in a non-RT build will disable 
> > local interrupts and in an RT build will do nothing.  (I suspect that RT 
> > kernels won't like it if we call spin_lock() while preemption is 
> > disabled.)
> 
> This is the local_irq_disable() in vhci_urb_enqueue() before
> usb_hcd_giveback_urb() is invoked. It was added in 9e8586827a706
> ("usbip: vhci_hcd: fix calling usb_hcd_giveback_urb() with irqs
> enabled").
> The warning that fixed back then was 
> |         if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
> which was kernel/kcov.c:834 as of v5.9-rc8 (as of report the mentioned
> in the commit).
> local_irq_disable() does not change the preemption counter so I am a bit
> puzzled why this did shut the warning.
> 
> > > Is there such a function?
> 
> We could use some API that accidentally does what you ask for. There
> would be local_lock_t where local_lock_irq() does that.
> What about moving the completion callback to softirq by setting HCD_BH?

You're missing the point.

There are several places in the USB stack that disable local interrupts.  
The idea was that -- on a non-RT system, which was all we had at the 
time -- spin_lock_irqsave() is logically equivalent to a combination of 
local_irq_save() and spin_lock().  Similarly, spin_lock_irq() is 
logically equivalent to local_irq_disable() plus spin_lock().

So code was written which, for various reasons, used local_irq_save() 
(or local_irq_disable()) and spin_lock() instead of spin_lock_irqsave() 
(or spin_lock_irq()).  But now we see that in RT builds, this 
equivalency is not valid.  Instead, spin_lock_irqsave(flags) is 
logically equivalent to "flags = 0" plus spin_lock() (and 
spin_lock_irq() is logically equivalent to a nop plus spin_lock()).  At 
least, that's how the material quoted earlier by Yunseong defines it.

Therefore, throughout the USB stack, we should replace calls to 
local_irq_save() and local_irq_disable() with functions that behave like 
the original in non-RT builds but do nothing in RT builds.  We shouldn't 
just worry about this one spot.

I would expect that RT already defines functions which do this, but I 
don't know their names.

Alan Stern
