From: Nicholas Kinar <n.kinar@usask.ca>
Subject: Re: Implementing real-time embedded system to sample from five SPI ADCs
Date: Thu, 04 Nov 2010 09:43:17 -0600
Message-ID: <4CD2D495.6040600@usask.ca>
References: <4CD1EAF0.6030709@usask.ca> <4CD26EE0.7040705@tu-ilmenau.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: linux-rt-users@vger.kernel.org
To: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.usask.ca ([128.233.192.40]:34452 "EHLO smtp.usask.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160Ab0KDPnU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Nov 2010 11:43:20 -0400
Received: from conversion-daemon.usask.ca by usask.ca
 (Sun Java(tm) System Messaging Server 7.3-11.01 64bit (built Sep  1 2009))
 id <0LBD00700ABFA000@usask.ca> for linux-rt-users@vger.kernel.org; Thu,
 04 Nov 2010 09:43:19 -0600 (CST)
In-reply-to: <4CD26EE0.7040705@tu-ilmenau.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> Hi Nicholas,
>
> according to what I understood, you want to use the data coming from 
> your ADCs in a userspace application which implements the control loop.
>
> I think there is a good chance you can then do all the steps (1)-(3) 
> within an userspace application. However, I am not 100% certain about 
> the best solution to implement (2) on this setup. May be anybody else
> knows something about the maximum sample frequency, but this also 
> depends on how complicated your algorithms are.
>
> Here [1] you can find a good example on how to write a RT userspace 
> application. Using the SPI character devices it should also be 
> possible to talk to your hardware.
>
> Regards,
> Andre
>
>
> [1] https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO
>
>

Thanks, Andre; that is a very good link, and thank you for the 
information.  I am hoping that I can sample from the ADCs at a rate of 
at least 1 kHz, and I am wondering if it is best to do this in a 
userspace program or in a kernel driver.

My processing algorithms are not very complicated.  If one of the ADC 
data values is greater than a certain value, then a digital-to-analog 
converter (DAC) control register is updated.  All that I want to do is 
to collect data at a rate of 1 kHz by toggling a port pin and then 
reading the data values over SPI.

Nicholas
