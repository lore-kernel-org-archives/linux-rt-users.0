From: Dragan Noveski <perodog@gmx.net>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Thu, 11 Oct 2007 12:37:00 +0200
Message-ID: <470DFCCC.2080606@gmx.net>
References: <470B44A1.7080007@free.fr> <1191921343.13628.0.camel@godzilla.tecnorama.it> <470B49BD.4070506@free.fr> <alpine.LFD.0.9999.0710091131400.25146@localhost.localdomain> <470B5971.40601@free.fr> <470BA56F.9090509@gmx.net> <alpine.LFD.0.9999.0710091911550.7766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40147 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751456AbXJKKhx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2007 06:37:53 -0400
In-Reply-To: <alpine.LFD.0.9999.0710091911550.7766@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> On Tue, 9 Oct 2007, Dragan Noveski wrote:
>   
>> hallo, i am using the 2.6.22.1-rt9 kernel too, and it runs pretty good for me,
>> but following this thread i got very unsure, if the hrtimer is being used
>> here.
>>  .resolution: 1 nsecs
>>     
>
> Yes, it switched to high resolution (1 nsec). Otherwise it would show 10, 4 or 1 ms
>
>      tglx
>
>   
hallo thomas, very much thanks for the response - it clarifies some 
things here for me!

cheers,
doc
