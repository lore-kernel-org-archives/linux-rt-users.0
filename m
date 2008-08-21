From: Gilles Carry <glscarry@free.fr>
Subject: Re: [PATCH 2/2] [RT] hrtimer __run_hrtimer code cleanup
Date: Thu, 21 Aug 2008 14:18:16 +0200
Message-ID: <C9802590-A1FD-454C-9499-D6A07CBBBA01@free.fr>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net> <1219070552-30783-3-git-send-email-gilles.carry@bull.net> <520f0cf10808201448g2d0906c8g2ab18a8547fe285a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Gilles Carry" <gilles.carry@bull.net>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: John Kacur <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailfe07.tele2.fr ([212.247.154.204]:55373 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752931AbYHUMSU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Aug 2008 08:18:20 -0400
In-Reply-To: <520f0cf10808201448g2d0906c8g2ab18a8547fe285a@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le 20 ao=FBt 08 =E0 23:48, John Kacur a =E9crit :

>
> I kind of find this confusing, because the return value is only usefu=
l
> in one specific instance. In other cases, the return value is thrown
> away. People who are not aware of the history of this code and examin=
e
> it later may ask why the return value is being ignored in some cases.
>
>>

John,

I don't see anything confusing here. It's similar to a function where =20
you have plenty
of parameters and depending on the context, only a few are useful. In =20
the present
case, the timers mode names (...NOSOFTIRQ) speak for themselves. They =20
don't need
this return code.
As there is already plenty of explanations and comments within the code=
,
people 'not aware' will do as everbody else do: decrypt and =20
understand. ;-)
Anyway, I don't mind adding comments at the head of the function.

My goal here is only to make the code more readable and easier to =20
maintain by
factorization this is why I separated this patch from the fix.
If you look at the factorized code, you see the only difference is the =
=20
raisesoftirq stuff.
I thought it was worth doing it.

Gilles.--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
