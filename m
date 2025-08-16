Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3279F5;
	Sat, 16 Aug 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755308838; cv=none; b=NU7dM7AWtTcDfjCx5Td3U6MAsMZjI5l1iA3OoKAv4al50xogM0TvkVeZkWSZNeXJkw/y+ot8zBP078lEnamPupc3aa5xqKcf7/bAk6t2xc3MgM7+INLDwDh5GphGN7741qx9JnZ68oAN4JotHdm7eKebOFap6UuQ3Oe8x+k/Llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755308838; c=relaxed/simple;
	bh=ZNl+A/VOeWzJqHpDjHU2gt89wXtLVix0FtVR+H2uhCg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hp7y+6z6b4cS3u2ZY4qi9ypk5NRHTGsy1d73HfwOjMjE08qXIESfGlLuOVPPVAzpdTVLZjiJYhLk1igQR3H4jUl9YCcfeuZil6kcCIXoJFISqlcNP0Nl0Oi2yY1EXncego0cukWxWRU0dUW9MYE+vy9K63yFWRmz2l2/KKU835g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47173edabaso379837a12.1;
        Fri, 15 Aug 2025 18:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755308835; x=1755913635;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jSv3FQhYcMCWrOngNg4HpVJNH9lv/sB214v2LASB3U=;
        b=gI7seISf+WU7bV5vXPmb7sFZfFj5GUVYlFQPSXQcs5yljy6KFNQ6OkmrgmolbUmZGm
         B5fdk0kwFzYEJT6tkQ3JBFa/xcgGkJmAw6N0HVD/kbcoRGp8u8JJn2KvfC5Q6Tm+Bk3d
         NCXzBZeRXePkZyQgz/zBRUiejNqOsYLq85+a+vhHfcfpjJqAUNmCcOTb9jsyiGuVFnhz
         m2EB50NEhyMYfGu6Pd6zNNI78RU/3l6rS7OlFoWDII8LexmRkGYyOGxIqj4/U9AVonbC
         xFLFFNGE3mJyEz+mmzDwcm0hxbbIf/q0x12qgY0nWZKDSTPBBVbZMq1yvvAwtLOZ9EUh
         l+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGIv/epuUVMSFmK7Nk9aN7zkorT0vCidK/vYnqLIY6YMVyLkszt44OC/WB/y6a7dwtwFvnIUft8Lgipeo=@vger.kernel.org, AJvYcCXBFgpBcEvJfbLaPasW5mDZPHhG8XD2hjAWrDKr0+BoW9DmXjaWbWJsMupRWizSnzjeqFjVcP2iGqHgxVDaIdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKY/umHwcM/d72mCTeuIJcuKwADxXWM1/n8LZFNXXoSNlXQVPl
	vCEkUP400s2KymzR1ETnLtM/owOrbpraCktV3kJ55bJAeHTwMD6ha8FGAMGw8g==
X-Gm-Gg: ASbGncsl6f5M13i04xEendhpbZEQW/fHfkdPgcxoOJ5nihAf0bbNIBObtCS0xkQ6mlp
	mtfnNp/RmZ03YLtDwwH6vTlHMZAFOJOVF3A4RvJCI51K2hmpILz4O5oS0FUFuyMiXHbby87W97H
	l5INi8wyHEGT1BCjNbUgoxAwXDmVCs3OA8Wg0wxRn6o5RIbrsMcv6aIA7WYLMQQ1ytRx+GeTGX6
	EmskjU3dTfVEKlNOa2cinm6a/xAKx9btDmVAog5XNIjMcvyI0RfbCNatBiT566EMgAajJ1lJJ2h
	HsMDtHbcEMiUd4aNbTKTG9R6OjFcPjGXezYyo7q+zZgKqGmmu1PysgpVmwElT+eQurg7CnTAvLN
	90sVuxZ4rQbHLHgarvFOW7fLoHEChtWcL52CAs6zbVIQ=
X-Google-Smtp-Source: AGHT+IF6ESN7j6ZpI/pfyjHrCm+KuYlzLw6/D5+gGp+0Rzi1waZ2LqXToeNT+Uqk/FluSkOS74O1iw==
X-Received: by 2002:a05:6a20:7344:b0:240:6243:b9ac with SMTP id adf61e73a8af0-240d2ba80e7mr3083838637.0.1755308835095;
        Fri, 15 Aug 2025 18:47:15 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d79863dsm2366059a12.56.2025.08.15.18.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 18:47:14 -0700 (PDT)
Message-ID: <b3edc81f-8082-4a7d-9c12-38c44fd3f888@kzalloc.com>
Date: Sat, 16 Aug 2025 10:47:08 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] usbip: vhci: Sleeping function called from invalid context
 in vhci_urb_enqueue on PREEMPT_RT
From: Yunseong Kim <ysk@kzalloc.com>
To: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
 stern@rowland.harvard.edu
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
References: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
Content-Language: en-US
Organization: kzalloc
In-Reply-To: <c6c17f0d-b71d-4a44-bcef-2b65e4d634f7@kzalloc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

P.S.

Just to clarify,

On 8/16/25 10:29 AM, Yunseong Kim wrote:
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
> 
> This error reported after this work:
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-linus&id=9528d32873b38281ae105f2f5799e79ae9d086c2

To be clear and avoid any misunderstanding, reporting was done after
this work "kcov, usb: Don't disable interrupts in kcov_remote_start_usb_softirq()"
because the fuzzing could proceed smoothly on PREEMPT_RT following this work,
which allowed the issue to be discovered. It does not mean that this step
introduced the error at all.

