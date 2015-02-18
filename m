From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Re: RT is freezing
Date: Tue, 17 Feb 2015 22:40:36 -0200
Message-ID: <54E3DF84.1090903@gmail.com>
References: <54AB147E.9060209@gmail.com> <54AB39D2.2090203@gmail.com> <20150107112423.228e67f3@balder.valhalla.alchemy.lu> <54ADC3AC.2090303@gmail.com> <20150217171612.GV26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joakim Hernberg <jhernberg@alchemy.lu>,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:62005 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbBRAkl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 19:40:41 -0500
Received: by mail-qg0-f43.google.com with SMTP id i50so30796896qgf.2
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 16:40:40 -0800 (PST)
In-Reply-To: <20150217171612.GV26177@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On 02/17/2015 03:16 PM, Sebastian Andrzej Siewior wrote:
> * Gustavo Bittencourt | 2015-01-07 21:39:24 [-0200]:
>
>> Unfortunately, the patch didn't work. But now I was able to get the
>> stack (see below). This stack repeats more than 1500 times during 1
>> second.
> I suggest you play with RT without the graphics. I recall a backtrace
> posted here from a crash and I've been told that there was no
> proper locking around it. I think it was v3.12 but I am not sure how
> much changeed since then.
>
> Sebastian
I've found the source of the problem 
(https://www.marc.info/?l=linux-rt-users&m=142178416026907), it is 
working smoothly now. Thanks.


