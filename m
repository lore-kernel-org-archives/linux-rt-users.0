From: Gilles Carry <glscarry@free.fr>
Subject: Re: [PATCH 2/2] [RT] hrtimer __run_hrtimer code cleanup
Date: Fri, 22 Aug 2008 08:04:36 +0200
Message-ID: <57EB7B7D-5A32-4BFB-8D3A-1D41166B12B4@free.fr>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net> <1219070552-30783-3-git-send-email-gilles.carry@bull.net> <520f0cf10808201448g2d0906c8g2ab18a8547fe285a@mail.gmail.com> <C9802590-A1FD-454C-9499-D6A07CBBBA01@free.fr> <520f0cf10808210603u2d63fe2dq9c34272ed510b89@mail.gmail.com>
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
Received: from mailfe13.tele2.fr ([212.247.155.140]:47126 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753412AbYHVHEm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Aug 2008 03:04:42 -0400
In-Reply-To: <520f0cf10808210603u2d63fe2dq9c34272ed510b89@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Le 21 ao=FBt 08 =E0 15:03, John Kacur a =E9crit :

> On Thu, Aug 21, 2008 at 2:18 PM, Gilles Carry <glscarry@free.fr> =20
> wrote:
>> Le 20 ao=FBt 08 =E0 23:48, John Kacur a =E9crit :
>>
>>>
>>> I kind of find this confusing, because the return value is only =20
>>> useful
>>> in one specific instance. In other cases, the return value is throw=
n
>>> away. People who are not aware of the history of this code and =20
>>> examine
>>> it later may ask why the return value is being ignored in some =20
>>> cases.
>>>
>>>>
>>
>> John,
>>
>> I don't see anything confusing here. It's similar to a function =20
>> where you
>> have plenty
>> of parameters and depending on the context, only a few are useful. =20
>> In the
>> present
>> case, the timers mode names (...NOSOFTIRQ) speak for themselves. =20
>> They don't
>> need
>> this return code.
>> As there is already plenty of explanations and comments within the =20
>> code,
>> people 'not aware' will do as everbody else do: decrypt and =20
>> understand. ;-)
>> Anyway, I don't mind adding comments at the head of the function.
>>
>> My goal here is only to make the code more readable and easier to =20
>> maintain
>> by
>> factorization this is why I separated this patch from the fix.
>> If you look at the factorized code, you see the only difference is =20
>> the
>> raisesoftirq stuff.
>> I thought it was worth doing it.
>>
>> Gilles.--
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-=20
>> users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> The goal of factorization is a good one of course. I also don't want
> to argue too much about the implementation when you have done the
> detective work to solve a hard problem, but I am just wondering if
> there is a better way to do this - that would make the code even more
> readable. As I go over this code again, I'm also thinking that it
> conceptually doesn't really belong in the __run_timer function, even
> if it works. If you look at the code before your changes, the functio=
n
> __run_timer did just that, it ran a timer, but now it's manipulating
> callback lists. Is there perhaps another way to common this code up
> then?

True, __run_hrtimer does a bit more than it used to but if you consider
that this function as a method of an object of class_hrtimer, it is
exactly what it would do. Also, wakeup_thread simply puts a thread
back on a run queue which somewhat similar to put a timer in a
callback list and change its status.

But as I told you, this patch is only a proposal.

Gilles.--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
