From: Esben Nielsen <nielsen.esben@googlemail.com>
Subject: Re: 2.6.20-rt5 Oops on boot
Date: Wed, 14 Feb 2007 21:06:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0702142104310.11160@frodo.shire>
References: <200702101551.l1AFpKUf019229@cichlid.com>
 <Pine.LNX.4.64.0702141451540.7817@frodo.shire>  <1171462485.6360.7.camel@godzilla.tecnorama.it>
  <Pine.LNX.4.64.0702141528420.7817@frodo.shire> <1171465426.8573.11.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:34148 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932532AbXBNUGf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Feb 2007 15:06:35 -0500
Received: by nz-out-0506.google.com with SMTP id s1so313579nze
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Feb 2007 12:06:35 -0800 (PST)
In-Reply-To: <1171465426.8573.11.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 14 Feb 2007, Alessio Igor Bogani wrote:

> Esben please excuse me for my very bad english.
>
> [...]
>>>> 2.6.20-rt5 doesn't boot on my hyperthreaded Pentium 4 2.80GHz either. I
>>>> don't have serial console but I can see that it stops at exit.c:877.
>>>
>>> Only for feedback:
>>> On my P4 3.0GHz HT the 2.6.20-rt5 (Ubuntu) boot perfectly.
>>
>> Let us compare configs then. I have attached my .config.
>
> config-2.6.20-8-realtime is my complete kernel config.

I tried with your config - modified to my setup. It gets furthrer but 
crashes in the assert net/netlink/ad_netlink.c:145.

Something is definitely wrong with 2.6.20-rt5!

Esben

>
> config.common are common options between us configurations
>
> config.Esben is your specific part
> config.Alessio is my specific part
>
> Do you have already tried a pre-compiled kernel?
>
> Ciao,
> Alessio
>
