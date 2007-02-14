From: Esben Nielsen <nielsen.esben@googlemail.com>
Subject: Re: 2.6.20-rt5 Oops on boot
Date: Wed, 14 Feb 2007 14:55:15 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0702141451540.7817@frodo.shire>
References: <200702101551.l1AFpKUf019229@cichlid.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: mingo@elte.hu, rncbc@rncbc.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Andrew Burgess <aab@cichlid.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:28019 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282AbXBNNz0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Feb 2007 08:55:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so195156uga
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Feb 2007 05:55:23 -0800 (PST)
In-Reply-To: <200702101551.l1AFpKUf019229@cichlid.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Sat, 10 Feb 2007, Andrew Burgess wrote:

>> I have terrible news: 2.6.20-rt5 does not boot at all on a couple
>> machines I was brave enough to try -- a P4@3.3Ghz SMP/HT desktop, and a
>> Core2 Duo T7200@2.0Ghz laptop.
>
> Ditto for me on an ASUS AMD64 x2, just hangs, I have no
> serial console. 2.6.20-rc5-rt7 booted ok (the last one I
> tried). Both using SMP.
>

2.6.20-rt5 doesn't boot on my hyperthreaded Pentium 4 2.80GHz either. I 
don't have serial console but I can see that it stops at exit.c:877.

Esben

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
