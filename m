Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comfiletech-com.20230601.gappssmtp.com header.i=@comfiletech-com.20230601.gappssmtp.com header.b="eR+MscJS"
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07902B7
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 19:33:27 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b9dbbaa9a9so5314099b6e.2
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 19:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comfiletech-com.20230601.gappssmtp.com; s=20230601; t=1702438406; x=1703043206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DzNtCKEvrxdPN/NMqGR2trO/52NTxhRHnszuReyH/dI=;
        b=eR+MscJSTBzqNbZ+2VaKbjrj/WWR115BkYeBU4tO0/nPDT76GvZD+59EU2BVaTTuUX
         zvLRfTthamWxlWJmvr6JfL9Vsh4gWQ/nWQPev4l+y90BRd5aoWLJ1vM+67imIIkIrDhU
         lGR26c3+9SlNnkpqGua3FfkpwWoQrs7lUMRUtPsG6A/0sO4Ljb0txTFc+HJnoPXyWwcD
         KJNf5ZrIpncc0rPsgbO9ShS0YZ6QWM3adZpAGRovPTfEZwTCBLRsk1ktxYdH039pPwHc
         qgmK4VPhQXA6/FTa09ax3oweAwAhUkub65QoCyLETNvVA+/iVAz/0HLcv4UZNTQ4ehEa
         xtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702438406; x=1703043206;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzNtCKEvrxdPN/NMqGR2trO/52NTxhRHnszuReyH/dI=;
        b=DjdO5lqrc0D6Fie3zqN4IKf4T+k4T5JY/dfqiglmMsWIOfTZtf4aYQ/eYLoR2AmNHq
         h6L9SESN9GQnmelOTQ73vCI3DWNdNtFUWyUdaBZP2flaXcgWkw91Vxxlg/IIoEDs/E4F
         djwGcbQ9UrDbkIcRkCrzCF7jDpPJjMwBM3oyJkutZ2qwgZDy0SHukn3Lqe3EO/1Nw2ck
         4ynMKib4po+9N5325Hsxscb2IbzV2KM+TY1NeRWIFFoYOqORu2OGXK9HRKQKhEpQ+yuZ
         d40uchkx5OuVhE7MCrgbPedbcS0aSbkOR9Mxme+ATIGcfktIgW4VM/QrJunUtucnRyyC
         HSFA==
X-Gm-Message-State: AOJu0Ywui9jwfZj+mb6voiEU/UK/j9BF4vpe1IEDD6YCt0ZrgHeVo2m3
	dpVchygXgLmezUll7ea/askjRebl+PY4kEZGdIA=
X-Google-Smtp-Source: AGHT+IEQ03tiEIszFTvwMWtQITdmaaUcNbzj0SA6u5C26uIxgB9jiZ7Ml0/M4xQvv+QIcUAa+jrJeQ==
X-Received: by 2002:a05:6808:2e9a:b0:3ba:f7:ce16 with SMTP id gt26-20020a0568082e9a00b003ba00f7ce16mr9842202oib.64.1702438406268;
        Tue, 12 Dec 2023 19:33:26 -0800 (PST)
Received: from [192.168.0.11] ([115.94.64.218])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001d06ca51be3sm9346179plf.88.2023.12.12.19.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 19:33:26 -0800 (PST)
Message-ID: <3feecb7c-72a9-4778-930f-764495a91448@comfiletech.com>
Date: Wed, 13 Dec 2023 12:33:24 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: mfranklin@comfiletech.com
Subject: Re: i2c jitter is worse in PREEMPT_RT kernel than stock Raspberry Pi
 kernel
Content-Language: en-US
To: Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org
References: <44fb3d4d-6303-4287-b2ac-7898cc237c47@comfiletech.com>
 <da41b939c1f2bbc9735250301ba3c4e735dfb313.camel@gmx.de>
From: Michael Franklin <mfranklin@comfiletech.com>
Organization: COMFILE Technology
In-Reply-To: <da41b939c1f2bbc9735250301ba3c4e735dfb313.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/2023 9:42 PM, Mike Galbraith wrote:
> On Tue, 2023-12-12 at 11:53 +0900, Michael Franklin wrote:
>
>> Interestingly, in the stock kernel, `htop` shows that most CPU activity
>> is concentrated on core 3 (which is what I expected and preferred),
>> while in the realtime kernel, the CPU activity is distributed across all
>> cores, despite booting with `isolcpus=3` and running the test program
>> with `task set -cp 3 $(pidof i2ctest)` in both kernels.
>>
>> Q1:  Why is i2c communication is more jittery in the realtime kernel
>> than the stock kernel?
> 
> I'd speculate it's primarily due to threaded IRQ handling being both
> more expensive and preemptible.
> 
>> Q2:  Why is activity distributed across all cores in the realtime
>> kernel, but more concentrated on core 3 in the stock kernel?
> 
> I don't see that.  Using isolcpus or not, the test proggy wakes only on
> CPU3 (as it had damn well better), and box wide affinity i2c IRQ thread
> wakes on CPU0.
> 
> Booting the non-rt kernel with 'threadirqs' behaves the same, and I
> suspect will jitter about the same should you try it.  You're isolating
> the test proggy, but for the rt kernel the IRQ thread is left dangling
> in the breeze to be perturbed by other IRQ threads or whatnot.
> 
> 	-Mike

Thanks.

I tested the stock kernel with `threadirqs` and indeed the jitter was worse, but the RT kernel still 
seemed to be more jittery.

However, based on what you mentioned, I decided to look further interrupts/IRQ behavior, and found 
this in /proc/interrupts:

PREEMPT_RT kernel:
            CPU0       CPU1       CPU2       CPU3
109:   22625815          0          0          0  rp1_irq_chip   8 Level     1f00074000.i2c
IPI0:     19640   12018430    6870398    5548908       Rescheduling interrupts
IPI1:       713      26295      18104        367       Function call interrupts

Stock Kernel:
            CPU0       CPU1       CPU2       CPU3
109:   11129247          0          0          0  rp1_irq_chip   8 Level     1f00074000.i2c
IPI0:       582        620        572        694       Rescheduling interrupts
IPI1:     40061      12360     108946    5475437       Function call interrupts

Stock Kernel with `threadirqs`:
            CPU0       CPU1       CPU2       CPU3
109:   21774128          0          0          0  rp1_irq_chip   8 Level     1f00074000.i2c
IPI0:       674        657        687        617       Rescheduling interrupts
IPI1:     58655     127527   21331238    5780380       Function call interrupts

There you can see that, in the PREEMPT_RT kernel, there are a very large number of 'Rescheduling 
interrupts' and only a few 'Function call interrupts'.  However, in the stock kernel it is the 
opposite -- a large number of 'Function call interrupts' and a few 'Rescheduling interrupts'.

Adding `threadirqs` to the stock kenel seemed to just distribute many of the Function call 
interrupts over more cores.

Is there anything that can be done about the large number of Rescheduling interrupts in the 
PREEMPT_RT kernel?
