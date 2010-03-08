From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: Use symbolic names for scheduling policy
Date: Mon, 8 Mar 2010 14:11:44 +0100
Message-ID: <520f0cf11003080511o653693b7xf3db92fada2468c3@mail.gmail.com>
References: <1268011104-22451-1-git-send-email-jkacur@redhat.com>
	 <1268011104-22451-3-git-send-email-jkacur@redhat.com>
	 <4B94B6E1.2060400@osadl.org>
	 <520f0cf11003080448o64b6f8b1nd43be217dcc8fcad@mail.gmail.com>
	 <4B94F514.5090605@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:61204 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab0CHNLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 08:11:45 -0500
Received: by ewy8 with SMTP id 8so40047ewy.28
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Mar 2010 05:11:44 -0800 (PST)
In-Reply-To: <4B94F514.5090605@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 8, 2010 at 2:01 PM, Carsten Emde <Carsten.Emde@osadl.org> w=
rote:
> Hi John,
>
>>> [..]
>>> We need to adapt the help message accordingly.
>> Hmnn, not sure if I like this one. The message is not perfect as it
>> stands, but I don't think this is an improvement.
>> The code seems to parse, fifo, rr, and other.
>> Internally the numbers are as specified, but we're not parsing them =
anyway.
> The original help message says:
>
> -y POLI =A0--policy=3DPOLI =A0 =A0 policy of realtime thread (1:FIFO,=
 2:RR)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format: --policy=3D=
fifo(default) or --policy=3Drr
>
> This *could* be understood that "-y 2" would be a legal way to specif=
y
> SCHED_RR, but it is not. Shouldn't we at least remove the "(1:FIFO,
> 2:RR)" part?
>
> =A0 =A0 =A0 =A0Carsten.

Yes, I agree to that, since what the internal number is, is of no
significance to
the user.

Thanks,
John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
