From: "John Kacur" <jkacur@gmail.com>
Subject: Re: [PATCH 2/2] [RT] hrtimer __run_hrtimer code cleanup
Date: Thu, 21 Aug 2008 15:03:11 +0200
Message-ID: <520f0cf10808210603u2d63fe2dq9c34272ed510b89@mail.gmail.com>
References: <1219070552-30783-1-git-send-email-gilles.carry@bull.net>
	 <1219070552-30783-3-git-send-email-gilles.carry@bull.net>
	 <520f0cf10808201448g2d0906c8g2ab18a8547fe285a@mail.gmail.com>
	 <C9802590-A1FD-454C-9499-D6A07CBBBA01@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Gilles Carry" <gilles.carry@bull.net>,
	linux-rt-users@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
	tinytim@us.ibm.com, jean-pierre.dion@bull.net,
	sebastien.dugue@bull.net
To: "Gilles Carry" <glscarry@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:16423 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbYHUNDM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Aug 2008 09:03:12 -0400
Received: by ey-out-2122.google.com with SMTP id 6so32847eyi.37
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Aug 2008 06:03:11 -0700 (PDT)
In-Reply-To: <C9802590-A1FD-454C-9499-D6A07CBBBA01@free.fr>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Aug 21, 2008 at 2:18 PM, Gilles Carry <glscarry@free.fr> wrote:
> Le 20 ao=FBt 08 =E0 23:48, John Kacur a =E9crit :
>
>>
>> I kind of find this confusing, because the return value is only usef=
ul
>> in one specific instance. In other cases, the return value is thrown
>> away. People who are not aware of the history of this code and exami=
ne
>> it later may ask why the return value is being ignored in some cases=
=2E
>>
>>>
>
> John,
>
> I don't see anything confusing here. It's similar to a function where=
 you
> have plenty
> of parameters and depending on the context, only a few are useful. In=
 the
> present
> case, the timers mode names (...NOSOFTIRQ) speak for themselves. They=
 don't
> need
> this return code.
> As there is already plenty of explanations and comments within the co=
de,
> people 'not aware' will do as everbody else do: decrypt and understan=
d. ;-)
> Anyway, I don't mind adding comments at the head of the function.
>
> My goal here is only to make the code more readable and easier to mai=
ntain
> by
> factorization this is why I separated this patch from the fix.
> If you look at the factorized code, you see the only difference is th=
e
> raisesoftirq stuff.
> I thought it was worth doing it.
>
> Gilles.--
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

The goal of factorization is a good one of course. I also don't want
to argue too much about the implementation when you have done the
detective work to solve a hard problem, but I am just wondering if
there is a better way to do this - that would make the code even more
readable. As I go over this code again, I'm also thinking that it
conceptually doesn't really belong in the __run_timer function, even
if it works. If you look at the code before your changes, the function
__run_timer did just that, it ran a timer, but now it's manipulating
callback lists. Is there perhaps another way to common this code up
then?
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
