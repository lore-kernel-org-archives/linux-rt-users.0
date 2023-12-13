Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comfiletech-com.20230601.gappssmtp.com header.i=@comfiletech-com.20230601.gappssmtp.com header.b="PN6+U8J+"
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B53BE
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 20:37:34 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b9e2a014e8so4486977b6e.2
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 20:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comfiletech-com.20230601.gappssmtp.com; s=20230601; t=1702442254; x=1703047054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:reply-to:organization
         :references:to:from:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=leD7Pf0I0hmZhDRQWiuY34fSRheLxYj0uvbQr6gjd0c=;
        b=PN6+U8J+bLOQ5CmLGO71dljtTKmBnd8kiu/tpp3QVZ2F1neQEzOavmKprSiRsQQ5Pb
         4jfnKwwqxULTbE+eB7/lnbR7Gyw13VCdg1s5PnucnVQ/SAQI1Qk/AQFTsge23cpSCbPx
         E+Sq4/9cENUys3SltmDyLz3x1qBJyxNQNwvP+uL3WhUZJDWmdp9t/bbniaNtUxGpr9mE
         aLJ1zVI9tT0QJufaDjpH9JjWrrd9zDbyiXSearVrdjYbTLWz79s7M18Kt3R9jk3TPM+b
         1fYp1Kij+ihckOrIMSmgxVUrcwdNqUrWBEs+Nwgah3JXHD9wITuaTwpr5nwOahgLLheY
         jjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702442254; x=1703047054;
        h=content-transfer-encoding:in-reply-to:reply-to:organization
         :references:to:from:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leD7Pf0I0hmZhDRQWiuY34fSRheLxYj0uvbQr6gjd0c=;
        b=K7gPSi/xzwmBMEjDBBovuNpUIFQDbVhDTrnH7E1bEE8NyQ6bQbJDEDVCfEXXoqk6gA
         ZgP352aC0+hzduToFBbaefpz45a1+qegTTmR6Q9abUhMd2XES+cUdNLgQpcL5aNnAq7/
         GfAtDEMwec7zEBeSQsWb9Tf/mMc2XEG5EdalJ1lM10Ubkxzvy8quTq6+iQ0iuYcDwpga
         x0uFWq54EUdTJJIb0sDur8twbIKusVPN7cC6YVtH5tIkZJlrfomQxcNZ/w3OICeDVpVb
         rIYcnTVuhem3gwrDutzebRdCjigD1++BovjVWIi2Gla02+PUHAO99ddPM1M/zpp6H37c
         927Q==
X-Gm-Message-State: AOJu0Yxzqi92jBniISxZHcKLJR6j75HRilMvMaTtXg1G6e9stF9MbfMa
	bhspZKvNas7U6TzwhggAbMOfpiYF5wHYoMmYPV8=
X-Google-Smtp-Source: AGHT+IFsEGCHZ3a8urMxKv9PNCycHy7oRpJF1j8L+slbVey7F8q0QyPclOZziZIiK2EI+ImF37JWfQ==
X-Received: by 2002:a05:6808:1183:b0:3b8:b063:6bb2 with SMTP id j3-20020a056808118300b003b8b0636bb2mr9158716oil.97.1702442254149;
        Tue, 12 Dec 2023 20:37:34 -0800 (PST)
Received: from [192.168.0.11] ([115.94.64.218])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006cef6293132sm6737042pfl.101.2023.12.12.20.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 20:37:33 -0800 (PST)
Message-ID: <e9f551e9-a0ae-4e10-8a77-54f91dfed700@comfiletech.com>
Date: Wed, 13 Dec 2023 13:37:31 +0900
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i2c jitter is worse in PREEMPT_RT kernel than stock Raspberry Pi
 kernel
Content-Language: en-US
From: Michael Franklin <mfranklin@comfiletech.com>
To: Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org
References: <44fb3d4d-6303-4287-b2ac-7898cc237c47@comfiletech.com>
 <da41b939c1f2bbc9735250301ba3c4e735dfb313.camel@gmx.de>
 <3feecb7c-72a9-4778-930f-764495a91448@comfiletech.com>
Organization: COMFILE Technology
Reply-To: mfranklin@comfiletech.com
In-Reply-To: <3feecb7c-72a9-4778-930f-764495a91448@comfiletech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Michael Franklin
Software Engineer
COMFILE Technology
82-2-711-2592 ext 510
Skype: MFranklinAtComfile
On 12/13/2023 12:33 PM, Michael Franklin wrote:
> On 12/12/2023 9:42 PM, Mike Galbraith wrote:
>> On Tue, 2023-12-12 at 11:53 +0900, Michael Franklin wrote:
>>
>>> Interestingly, in the stock kernel, `htop` shows that most CPU activity
>>> is concentrated on core 3 (which is what I expected and preferred),
>>> while in the realtime kernel, the CPU activity is distributed across all
>>> cores, despite booting with `isolcpus=3` and running the test program
>>> with `task set -cp 3 $(pidof i2ctest)` in both kernels.
>>>
>>> Q1:  Why is i2c communication is more jittery in the realtime kernel
>>> than the stock kernel?
>>
>> I'd speculate it's primarily due to threaded IRQ handling being both
>> more expensive and preemptible.
>>
>>> Q2:  Why is activity distributed across all cores in the realtime
>>> kernel, but more concentrated on core 3 in the stock kernel?
>>
>> I don't see that.  Using isolcpus or not, the test proggy wakes only on
>> CPU3 (as it had damn well better), and box wide affinity i2c IRQ thread
>> wakes on CPU0.
>>
>> Booting the non-rt kernel with 'threadirqs' behaves the same, and I
>> suspect will jitter about the same should you try it.  You're isolating
>> the test proggy, but for the rt kernel the IRQ thread is left dangling
>> in the breeze to be perturbed by other IRQ threads or whatnot.
>>
>>     -Mike
> 
> Thanks.
> 
> I tested the stock kernel with `threadirqs` and indeed the jitter was worse, but the RT kernel still 
> seemed to be more jittery.
> 
> However, based on what you mentioned, I decided to look further interrupts/IRQ behavior, and found 
> this in /proc/interrupts:
> 
> PREEMPT_RT kernel:
>             CPU0       CPU1       CPU2       CPU3
> 109:   22625815          0          0          0  rp1_irq_chip   8 Level     1f00074000.i2c
> IPI0:     19640   12018430    6870398    5548908       Rescheduling interrupts
> IPI1:       713      26295      18104        367       Function call interrupts
> 
> Stock Kernel:
>             CPU0       CPU1       CPU2       CPU3
> 109:   11129247          0          0          0  rp1_irq_chip   8 Level     1f00074000.i2c
> IPI0:       582        620        572        694       Rescheduling interrupts
> IPI1:     40061      12360     108946    5475437       Function call interrupts
> 
> Stock Kernel with `threadirqs`:
>             CPU0       CPU1       CPU2       CPU3
> 109:   21774128          0          0          0  rp1_irq_chip   8 Level     1f00074000.i2c
> IPI0:       674        657        687        617       Rescheduling interrupts
> IPI1:     58655     127527   21331238    5780380       Function call interrupts
> 
> There you can see that, in the PREEMPT_RT kernel, there are a very large number of 'Rescheduling 
> interrupts' and only a few 'Function call interrupts'.  However, in the stock kernel it is the 
> opposite -- a large number of 'Function call interrupts' and a few 'Rescheduling interrupts'.
> 
> Adding `threadirqs` to the stock kenel seemed to just distribute many of the Function call 
> interrupts over more cores.
> 
> Is there anything that can be done about the large number of Rescheduling interrupts in the 
> PREEMPT_RT kernel?

I was able to reduce the number of Rescheduling interrupts on the isolated core by `echo -1 > 
/proc/sys/kernel/sched_rt_runtime_us` but there are still too many Rescheduling interrupts relative 
to Function call interrupts on the other 3 cores and the jitter is still pretty bad.

