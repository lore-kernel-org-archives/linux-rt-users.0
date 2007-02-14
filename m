From: Esben Nielsen <nielsen.esben@googlemail.com>
Subject: Re: 2.6.20-rt5 Oops on boot
Date: Wed, 14 Feb 2007 16:28:47 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0702141619010.7817@frodo.shire>
References: <200702101551.l1AFpKUf019229@cichlid.com>
 <Pine.LNX.4.64.0702141451540.7817@frodo.shire>  <1171462485.6360.7.camel@godzilla.tecnorama.it>
  <Pine.LNX.4.64.0702141528420.7817@frodo.shire> <1171465426.8573.11.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
To: Alessio Igor Bogani <abogani@texware.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:47242 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbXBNP2x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Feb 2007 10:28:53 -0500
Received: by nf-out-0910.google.com with SMTP id o25so756036nfa
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Feb 2007 07:28:52 -0800 (PST)
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
>
> config.common are common options between us configurations
>
> config.Esben is your specific part
> config.Alessio is my specific part
>
> Do you have already tried a pre-compiled kernel?

Nope,
There are no such thing for Gentoo :-)

Esben

>
> Ciao,
> Alessio
>
