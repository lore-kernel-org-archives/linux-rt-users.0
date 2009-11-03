From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: Odd bug in SATA link power management
Date: Tue, 3 Nov 2009 15:33:21 +0000
Message-ID: <74fd948d0911030733o47817673la81b34057c1f68f4@mail.gmail.com>
References: <74fd948d0910301225k207ec1f9sf2744ba0c5de6d33@mail.gmail.com>
	 <alpine.LFD.2.00.0911021550120.12138@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64327 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbZKCPdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Nov 2009 10:33:17 -0500
Received: by ewy3 with SMTP id 3so2079778ewy.37
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Nov 2009 07:33:21 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911021550120.12138@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Apparently this a vanilla kernel bug. Thanks for your help.

On Mon, Nov 2, 2009 at 2:51 PM, Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> On Fri, 30 Oct 2009, Pedro Ribeiro wrote:
>> This bug is always reproducible and does not happen with Debian kern=
el
>> 2.6.30.2. I didn't test any other kernel, not even the 2.6.31.4
>> vanilla.
>>
>> Below I'm sending the script which does the pm-utils action and my
>> lspci -vv. Is there any advice you can give me?
>
> Yes, please test 2.6.31.4 vanilla so we know whether the problem is
> related to the -rt patch or not.
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
