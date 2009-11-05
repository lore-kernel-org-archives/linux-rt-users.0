From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: rt file i/o
Date: Thu, 05 Nov 2009 01:22:17 -0800
Message-ID: <4AF29949.40303@thebigcorporation.com>
References: <hcs6dr$235$1@ger.gmane.org> <5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com> <4AF1A327.3040103@klingt.org> <20091104171412.GB1702@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tim Blechmann <tim@klingt.org>, y@opentech.at,
	Mark Knecht <markknecht@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f185.google.com ([209.85.216.185]:35904 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbZKEJ3a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Nov 2009 04:29:30 -0500
Received: by pxi15 with SMTP id 15so6002662pxi.23
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Nov 2009 01:29:35 -0800 (PST)
In-Reply-To: <20091104171412.GB1702@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/04/2009 09:14 AM, Nicholas Mc Guire wrote:
> On Wed, 04 Nov 2009, Tim Blechmann wrote:
>
>    
>>>     I'm not a developer and cannot really address your specific
>>> question but for my use of the rt-kernel I put important rt-audio
>>> files on a 1394 drive and give the 1394 driver higher priorities using
>>> the IRQ scheduling tools. I don't have any trouble running 2 or 3 1394
>>> drives recording and playing back 48 channels in Ardour.
>>>
>>>     While I agree you should do everything the right way technically in
>>> the code maybe part of your solution is outside of the app you are
>>> writing and in the use of these support tools?
>>>        
>> well, if i understand the rt howto correctly, _no_ disc access is
>> allowed, neither from rt nor from non-rt threads, since it may produce
>> page faults, which introduce latencies ...
>>      
> I would be supprised if the rt howto states that page-faults in non-rt
> threads is a critical problem - that would not significantly impact RT
> performance - atelast not the worst case - it will (as every other system
> load) impact the average case. so having a non-rt thread reading disk-files
> to a buffer and a rt-thread processing this buffer should be perfectly fine.
>
>    

Ack. I agree with Herr Hofrat, and would only add, that it is helpful to 
pre-allocate and mlock() memory you use to pipe data from RT tasks to 
the I/O subsystem.

It is possible to trigger delays in a priority-agnostic manner when a 
large number of tasks end up all hammering heavily on malloc().

Sven

> hofrat
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    

