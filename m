Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528EB2EA755;
	Mon, 11 Aug 2025 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926847; cv=none; b=lR78RxZEKOiPj+Bt4MSA2MF+Zwp1ANqSSUvjOOgBNDL5wO5EspSag6iqXwiLOYhG75Jo4asa8H1wOvLTORR6bHI5EarPknJBaUM2PBZgiwyVHNy8qg+fulzZ1/1gqmhem69UdG+B3DPoAAij4y2djfCkHdeIN7tL/2InSl5cj2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926847; c=relaxed/simple;
	bh=jVCVH2/BrjPYq9tmaVyl+u/aDZPlSuXVvt6G4jzNAA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVHyugiWvEE+P7M+GTjXN2YCuYS9eKLDYajSRC6ZkTZqcmAfXsCmQaXst5TQKZVNZG1s4mGSlZT6mODt6IDA+/9YjTiwvV0laMSSAK5w77WnMLy9hETCx2vfZtZHKgicdRWQbbhBN6RKSvyWb6mRq4ef+mMVJb3cDPNovOXsI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b350c85cf4eso525241a12.1;
        Mon, 11 Aug 2025 08:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926844; x=1755531644;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/lsGJuVcSxEulcmxPExLRcznuDdwmEmGFnSLxnfCJg=;
        b=Jf6FFluKNcwILiOmiCXn3K3IXka8Vp3Lb6tN4Yp9G0j2iXMx3fyPu0CF4HwE+0sMo8
         kc7sruQfMl9infyH2gDGb32G2abwFrsVKtx/SswOZ2RGOo7/B4y6WM/qbhJmRkaRv+mt
         UpCMBvUoDJ2RBsyji7YYO80MP490hQ942Q3cJAWhd4okBO5r57fvr2oQ2D1Y6tef+0Ti
         fjSWnJINFhzU60ytVeCQu/Gl7xB1aQJaOwX3oeeUzo3oj/sTp1VDeiSk/nIOt7sws1A2
         fIJndXPSA8Ekl3w19IHOf3xPtAL0nTZZ3syPrXph68SYvVxVh9OfH+qyrH7ktkmZHZkj
         Si+A==
X-Forwarded-Encrypted: i=1; AJvYcCVbqGWTda1/kpaBOzRbZU21QI2zDN2woRPWgAzTKyYXaOuM6Zn+glSwpWgoXnKHKxIxjesCGzagHF7Kk0Y=@vger.kernel.org, AJvYcCVnt/qY50xl1AoilrUAekALcQxl1wQrW0VZ6UO5Iz4t9Zz/e1dAOR1yQlVBTbj0iz7QaSaIeyEtWKIG2fug2s8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8KsJ8M3X7u4foDjArmMubqyhKnIbJuy4+W5uTH5/gfZfrttQ
	VEwnL8LRIytBN/D7a9QH513mzQ2GP+kZXBBoPyu9YlMm0q2wCe23XaUo
X-Gm-Gg: ASbGncu1aAJpiZ+xBqklGOdv9PZX3Rrt59TA13YQrCBeU2aiN7P8y25/0MrU04D2Scq
	xskI4qbJrSNdtrGiFjwIrn1ZuhSCa/jZOe5xysNFK1opavv2u/7WKjMaIlKv6SFXJHwNZgiiHN4
	RKrlZcagGoHDzF/4VhnhSQ1bc14dxuCDDRFwCkeBSKkHmpMlsWITm+M0SdIVzQWo6CqO7y5x0b2
	lVLcqqwq0DAXvuA6OuO5vQfB1DA3yZ7jguFIOTDe7k82PV+zQrLG0bT22dh5ZR4Zd/emLXAxfYA
	QbkWaHl0QlJU0yv1zOsZ5GXKq/UctLp7j4lBJFTmg8biLBlQarBr9WS45J+3sUYUQeHHpOOKkML
	OjPmNRdOlh/axwnkCmStqfXDCK4tIQsZu
X-Google-Smtp-Source: AGHT+IGYEwS0QZ8ahZbXEAuTTmg5t2D9wKM98Dove8C64W5hDQ8B8uf6rb313Vha65Bikjrhb0orCA==
X-Received: by 2002:a17:902:e546:b0:240:729c:a022 with SMTP id d9443c01a7336-242fc392176mr155965ad.11.1754926844439;
        Mon, 11 Aug 2025 08:40:44 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a48sm275791065ad.104.2025.08.11.08.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 08:40:43 -0700 (PDT)
Message-ID: <a4e338f2-38dd-4c1e-b3c0-e6d18e7568fb@kzalloc.com>
Date: Tue, 12 Aug 2025 00:40:38 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] usb: sleepable spinlock used in USB bh_worker softirq on
 PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-rt-users@vger.kernel.org,
 gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
 Thomas Gleixner <tglx@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
References: <1f8dd706-0eb0-4e09-a0fe-fc48fb24005e@kzalloc.com>
 <20250811091559.CXIs7FvU@linutronix.de>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250811091559.CXIs7FvU@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sebastian,

Thank you for your prompt reply and clarification.

On 8/11/25 6:15 오후, Sebastian Andrzej Siewior wrote:
> On 2025-08-11 00:05:49 [+0900], Yunseong Kim wrote:
>> While running a PREEMPT_RT-enabled kernel I observed a sleepable
>> spinlock (rt_spin_lock) being taken from a softirq context within
>> the USB core framework. On PREEMPT_RT, spin_lock() may sleep when
>> contended. This is unsafe in softirq context and can cause hangs or
>> deadlocks.
>>
> …
>> I believe this requires a change in the USB core framework rather than
>> just in individual drivers.
>>
>> Kernel config, full logs, and reproduction steps can be provided on
>> request.
>>
>> This bug was uncovered during my work to fixing KCOV for PREEMPT_RT awareness.
>> Link: https://lore.kernel.org/all/ee26e7b2-80dd-49b1-bca2-61e460f73c2d@kzalloc.com/t/#u
> 
> I'm confused. Is this new or this the same bug that was reported by you
> in the thread you linked?
> The kcov issue should be fixed by
> 	https://lore.kernel.org/all/20250811082745.ycJqBXMs@linutronix.de/

You are absolutely right.

While PREEMPT_RT does shift most softirq handling to the ksoftirqd process
context where sleeping locks are generally allowed, I overlooked the ironclad
rule: DO NOT SLEEP if interrupts are disabled. Even in ksoftirqd, disabling
interrupts creates an atomic context, and acquiring a sleeping lock while
irqs_disabled() is true can be disastrous in real-time environments.

The bug I reported, specifically the call stack observed where rt_spin_lock was
taken from a softirq context within the USB core framework, was a direct
consequence of this misunderstanding. This issue was uncovered during my work on
fixing KCOV for PREEMPT_RT awareness and was consistently reproducible across my
v1 through v3 patches. For reference, my v3 work can be found here:
 https://lore.kernel.org/lkml/ddd14f62-b6c9-4984-84be-6c999ea92e30@kzalloc.com/t/#u.

I have applied your patch:
 https://lore.kernel.org/all/20250811082745.ycJqBXMs@linutronix.de/

-static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
+static inline void kcov_remote_start_usb_softirq(u64 id)
 {
-	unsigned long flags = 0;
-
-	if (in_serving_softirq()) {
-		local_irq_save(flags);
+	if (in_serving_softirq() && !in_hardirq())
 		kcov_remote_start_usb(id);

!in_hardirq(), I can definitely confirm that the specific call stack and the bug
I reported are no longer reproducible. Your fix has indeed addressed the
underlying issue.

>> Best Regards,
>> Yunseong Kim
> 
> Sebastian


Thank you again for your guidance and for resolving this problem!

Best Regards,
Yunseong Kim


