From: dashesy <dashesy@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.33.9-rt31
Date: Tue, 3 May 2011 17:16:41 -0600
Message-ID: <BANLkTi=OKcO=ouVD3kOzFK4_acK9-kk1Eg@mail.gmail.com>
References: <alpine.LFD.2.00.1104111723020.4501@localhost6.localdomain6>
	<497D1168CB2F407F9005845B39FEF144@e1705>
	<alpine.LFD.2.00.1104111806021.4501@localhost6.localdomain6>
	<BANLkTin594W7qFUhmBAAGwSfwaCEqCX+hA@mail.gmail.com>
	<4DA954DE.4060907@autostatic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jeremy Jongepier <jeremy@autostatic.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42064 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171Ab1ECXQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 May 2011 19:16:43 -0400
Received: by bwz15 with SMTP id 15so535164bwz.19
        for <linux-rt-users@vger.kernel.org>; Tue, 03 May 2011 16:16:41 -0700 (PDT)
In-Reply-To: <4DA954DE.4060907@autostatic.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Apr 16, 2011 at 2:35 AM, Jeremy Jongepier <jeremy@autostatic.co=
m> wrote:
> On 04/15/2011 05:02 PM, dashesy wrote:
>>
>> Thanks, works great on 64-bit Ubuntu (Selected SMP and Core i7 and
>> minimal ACPI), the only problem I have is with two displays and
>> nouveau driver.
>
> Which is exactly the same issue I am having. This is because the nouv=
eau
> driver is crippled since rt29.
I applied this patch and now nouveau driver works fine with two monitor=
s:
http://forums.debian.net/viewtopic.php?f=3D6&t=3D59599#p348758
>
> Best,
>
> Jeremy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
