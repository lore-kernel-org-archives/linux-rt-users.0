From: Grammostola Rosea <rosea.grammostola@gmail.com>
Subject: Re: irqreturn.h:14: error
Date: Thu, 23 Apr 2009 17:15:38 +0200
Message-ID: <49F0861A.40701@gmail.com>
References: <49F06E9A.4070504@gmail.com> <20090423101250.1e228192@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:44483 "EHLO
	smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752935AbZDWPVP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Apr 2009 11:21:15 -0400
Received: from [212.54.42.139] (helo=smtp8.tb.mail.iss.as9143.net)
	by smtpq3.tb.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <rosea.grammostola@gmail.com>)
	id 1Lx0ji-0002ok-Cs
	for linux-rt-users@vger.kernel.org; Thu, 23 Apr 2009 17:21:14 +0200
Received: from cc305009-a.groni1.gr.home.nl ([82.73.157.254] helo=[192.168.1.104])
	by smtp8.tb.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <rosea.grammostola@gmail.com>)
	id 1Lx0jb-00087l-9a
	for linux-rt-users@vger.kernel.org; Thu, 23 Apr 2009 17:21:07 +0200
In-Reply-To: <20090423101250.1e228192@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Thu, 23 Apr 2009 15:35:22 +0200
> Grammostola Rosea <rosea.grammostola@gmail.com> wrote:
>
>   
>> Hi,
>>
>> I get an error when building an RT kernel.
>>
>> Help would be nice :)
>>
>> \r
>>
>>
>> CC [M] drivers/staging/at76_usb/at76_usb.o
>> CC [M] drivers/staging/comedi/comedi_fops.o
>> In file included from drivers/staging/comedi/comedidev.h:40,
>>     
>
> Unless you *really* need it, turn off CONFIG_STAGING. These are
> drivers/modules that aren't really ready for prime time.
>
>
>   
Thanks, that fixed it!

\r

