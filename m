From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: Re: Implementing real-time embedded system to sample from five SPI
 ADCs
Date: Thu, 04 Nov 2010 09:29:20 +0100
Message-ID: <4CD26EE0.7040705@tu-ilmenau.de>
References: <4CD1EAF0.6030709@usask.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:48507 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564Ab0KDIkF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Nov 2010 04:40:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1PDvMa-0008E9-AS
	for linux-rt-users@vger.kernel.org; Thu, 04 Nov 2010 09:40:04 +0100
Received: from ih5.theoinf.tu-ilmenau.de ([141.24.203.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Nov 2010 09:40:04 +0100
Received: from andre.puschmann by ih5.theoinf.tu-ilmenau.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Nov 2010 09:40:04 +0100
In-Reply-To: <4CD1EAF0.6030709@usask.ca>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Nicholas,

according to what I understood, you want to use the data coming from 
your ADCs in a userspace application which implements the control loop.

I think there is a good chance you can then do all the steps (1)-(3) 
within an userspace application. However, I am not 100% certain about 
the best solution to implement (2) on this setup. May be anybody else
knows something about the maximum sample frequency, but this also 
depends on how complicated your algorithms are.

Here [1] you can find a good example on how to write a RT userspace 
application. Using the SPI character devices it should also be possible 
to talk to your hardware.

Regards,
Andre


[1] https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO


On 11/04/2010 12:06 AM, Nicholas Kinar wrote:
> Hello,
>
> I would like to implement a real-time embedded Linux system on an
> AT91SAM ARM processor. Attached to the SPI bus of this processor are 5
> Analog-to-Digital converters (ADCs) that can be read using the Linux SPI
> bus subsystem.
>
> The ADCs are sampled by having the AT91SAM ARM processor toggle a GPIO
> at a rate of at least 1 KHz. The GPIO is attached to a pin on the ADC. A
> high voltage level on this pin instructs all of the ADCs to take a
> sample. The sample is then read over the SPI bus by the embedded system
> master. This implies that data will be read from each SPI slave device
> every (1 / 1000 Hz) = 1.0e-3 seconds.
>
> I am wondering if the following could be done with real-time Linux:
>
> (1) I would have to write a Linux kernel module to toggle the GPIO pin.
> The rate of toggling would be controlled by a high-resolution timer, and
> would occur with a period of at least 1 kHz.
> (2) After the GPIO is brought to a high voltage level, the master must
> wait for at least 3.7 microseconds before reading from the SPI bus.
> (3) Each ADC would be read in sequential order.
>
> The ADC being used is the AD7691 from Analog Devices
> (http://www.analog.com/static/imported-files/data_sheets/AD7691.pdf).
>
> The data from the ADCs could be used in a real-time control system loop.
> Can this be done with real-time Linux, or is the latency too high? What
> is the maximum rate at which I could read data from these ADCs? Could it
> be 10 kHz or even 100 kHz?
>
> Nicholas
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>


