Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC71A95E;
	Sat, 16 Aug 2025 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310692; cv=none; b=QVUR8WWt/qEOrgIJbMfSGCgHEdMnr8Y8rjMrgLJsi++bR9EqbCii7Ivg86UbAoSf25TkFwP+EnxAUYiIEuHA4xxRO+g/8nzPjKzroz6kJmEl+IqsYsNzgOi/qFWu1S5GklfZJqf4rMZqltARV8t3sHpmIrEhDK+JrgW+alcjoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310692; c=relaxed/simple;
	bh=s4ZInaeHU0K/BWeIVGD8Oh9RU4nlKEkUdtbbM5sTBm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDfLGVQASmn0ZJexTvJ9XRfJkFrETu+Y0zy+HwJtMTiU96UKWgLzZ0R+AVNTMqclv8NIpv6AcpWybNtPRsp7IOxjsPIv+mVnp/5WQ9QPXnKOWf3O/BDQdJCzARHRqQoaECj39p5Re3msUsabqqpDjVsOzBL7Zuzq+i8G7J2FOr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24458293cebso3463575ad.3;
        Fri, 15 Aug 2025 19:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310690; x=1755915490;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7+YvTE3zXrxg2NPoB/pXCcTw+FU7/h69ZU4O7D7BtE=;
        b=uittm4/yXAhJBrd/rGRRdOuTkDPCTgPf2qQRbNcMQiPLW3ohWMCa/A2Zu9ZolaBB10
         5UQtB9fw4zgVUIiVPjwAQrFsSIZMJs00YMU/Q5LHo2/kN6spZs5/z1qLO2ayKe5J9wVW
         V/a3o9Zg0IGHELW9J5lWzRAh60OyYHVBq8tiIp6L6nO5f0IhApA4Gv+ZpHCdXkezSg2s
         BRMSViK8uu7Z40LgrBEmie8zPJ7sqVZ4VPY4FmaXQqnQ2g29/I8eVZY08pdeKtQiBIlO
         e2VrbcsyuCX0udn12A5JR2P73nEY8v5J8r+2Xm+toNHeuJvWO1kgaV8gRi87Fj7QYnao
         /tDA==
X-Forwarded-Encrypted: i=1; AJvYcCUABIGlPXXuATqQESZZw2KAZqhCP2FibUhyxlTfS305x4E/bXOZUjLjTxa7HVoAYjudrpkcxc6GPPT4fQc=@vger.kernel.org, AJvYcCUVvsoHnJK1NYOoxkvFVJtveCuc8x/pvnO2fXkXG6No3oSbX3hUPtlsCVnsVhvqElCbZkpUyXWcrpcgdCO+hxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+1oSbtCf0w4f0BxiBgGOCw3SM7VUhV/o1IK/J/4/m6ngCeKh
	LL00l91YakzNJ7wIEMeINr2IkYLXM95EmQRt2IpWOF3Qx+iMRUnIj4zs
X-Gm-Gg: ASbGncsUZHOqfDe5uPhvfd3xM6HfKO5/eGK+efh6iXPLjWlbwJ1t1lG8lKd2yhEARJm
	6ruoz83Kb4I1VSRsupRKHtGHY0Jp1rzWYR0DvG+Y3C66/fPE2dBKx/749gGCI58v3m0HfukhWgt
	4VUTltqUw46ZDqtJwqN4jF666v/xnGBYXorMtwtH1eFVMcFqcie5ZR7wT4rZddVqwiCDWNcNo/8
	DKcFATDxm1PDp27G1LGtkeQuGGm3HPAKHKpH+UnMIlk2nhGx5s6qQDSMYBayWhd/Uj9TtCk7mzU
	782XhQYs85kFeGTRl58lRPj1IvVhq/G7RDDoJrvopzCFXRZVLQ91XV2brbLLy7QFsl2RMKm5BkP
	Coa6ijREvkDL6pipbFRjM6/n3D4BIBMEa
X-Google-Smtp-Source: AGHT+IGKyVt6YNx8hzsEDiKM3d8MPYTvIJyS5Ze9B4ONXLm2BtBVctGCSWO+iINuXMA6bIG4ClYZeQ==
X-Received: by 2002:a17:902:d482:b0:231:c9bb:6105 with SMTP id d9443c01a7336-2446cb8781amr30203385ad.0.1755310689658;
        Fri, 15 Aug 2025 19:18:09 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d56e9e5sm24691175ad.148.2025.08.15.19.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 19:18:09 -0700 (PDT)
Message-ID: <28544110-3021-43da-b32e-9785c81a42c1@kzalloc.com>
Date: Sat, 16 Aug 2025 11:18:02 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] usbip: vhci: Sleeping function called from invalid context
 in vhci_urb_enqueue on PREEMPT_RT
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
 Andrey Konovalov <andreyknvl@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
 <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <f6cdf21a-642f-458c-85c1-0c2e1526f539@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alan,

On 8/16/25 10:51 AM, Alan Stern wrote:
> On Sat, Aug 16, 2025 at 10:29:34AM +0900, Yunseong Kim wrote:
>> While testing a PREEMPT_RT enabled kernel (based on v6.17.0-rc1),
>> I encountered a "BUG: sleeping function called from invalid context"
>> error originating from the USB/IP VHCI driver.
>>
>> On PREEMPT_RT configurations, standard spin_lock() calls are replaced by
>> rt_spin_lock(). Since rt_spin_lock() may sleep when contended, it must not
>> be called from an atomic context (e.g., with interrupts disabled).
>>
>> The issue occurs within the vhci_urb_enqueue function This function
>> explicitly disables local interrupts using local_irq_disable() immediately
>> before calling usb_hcd_giveback_urb(), adhering to HCD requirements.
> 
> ...
> 
>> This error reported after this work:
>> It occurs after going through the code below:
>>
>>  static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flags)
>>  {
>>  
>>  	...
>>  
>>  no_need_unlink:
>>  	spin_unlock_irqrestore(&vhci->lock, flags);
>>  	if (!ret) {
>>  		/* usb_hcd_giveback_urb() should be called with
>>  		 * irqs disabled
>>  		 */
>>  		local_irq_disable(); // <--- Entering atomic context (IRQs disabled)
>>  		usb_hcd_giveback_urb(hcd, urb, urb->status);
>>  		local_irq_enable();
>>  	}
>>  	return ret;
>>  }
>>
>>  static void mon_bus_complete(struct mon_bus *mbus, struct urb *urb, int status)
>>  {
>>  	...
>>  	spin_lock_irqsave(&mbus->lock, flags);
>                   ^
> ------------------^
> 
>>  	...
>>  }
>>
>> When called with interrupts disabled, usb_hcd_giveback_urb() eventually
>> leads to mon_complete() in the USB monitoring, if usbmon is enabled,
>> via __usb_hcd_giveback_urb().
>>
>> mon_complete() attempts to acquire a lock via spin_lock(), observed in the
>> trace within the inlined mon_bus_complete.
> 
> Look again.  mon_bus_complete() calls spin_lock_irqsave(), not 
> spin_lock().
> 
> Is the kernel tree that you are using different from Linus's tree?
I think this part is a macro, so it appears this way.

Link: https://github.com/torvalds/linux/blob/v6.17-rc1/include/linux/spinlock_rt.h#L96

#define spin_lock_irqsave(lock, flags)			 \
	do {						 \
		typecheck(unsigned long, flags);	 \
		flags = 0;				 \
		spin_lock(lock);			 \
	} while (0)

My tree is indeed 6.17-rc1. I made a mistake in the diagram,
which caused the misunderstanding. I’ve redrawn the diagram:

  kworker (hub_event)
      |
      v
  vhci_urb_enqueue() [drivers/usb/usbip/vhci_hcd.c]
      |
      |---> spin_unlock_irqrestore(&vhci->lock, flags);
      |     (Context: IRQs Enabled, Process Context)
      |---> local_irq_disable();
      |
      |     *** STATE CHANGE: IRQs Disabled (Atomic Context) ***
      |
      +-----> usb_hcd_giveback_urb() [drivers/usb/core/hcd.c]
              |
              v
              __usb_hcd_giveback_urb()
              |
              v
              mon_complete() [drivers/usb/mon/mon_main.c]
              |
              |---> spin_lock_irqsave() [include/linux/spinlock_rt.h]
                    |
                    v https://github.com/torvalds/linux/blob/v6.17-rc1/include/linux/spinlock_rt.h#L96
                    spin_lock() [kernel/locking/spinlock_rt.c] <--- Attempts to acquire lock
                    |
                    | [On PREEMPT_RT]
                    v
                    rt_spin_lock() [kernel/locking/spinlock_rt.c]
                    |
                    v
                    [May Sleep if contended]
                    |
      X <----------- BUG: Sleeping in atomic context (IRQs are disabled!)

      |
      |---> local_irq_enable();
            (Context: IRQs Enabled)


> Alan Stern

Thank you!

Yunseong Kim


