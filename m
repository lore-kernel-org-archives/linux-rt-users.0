From: Raz <raziebe@gmail.com>
Subject: Re: [DISCUSS : vxwork to linux]
Date: Sat, 14 Aug 2010 20:11:40 +0300
Message-ID: <AANLkTin3+RbRSZ0pTBPwB-Sm6MoKL4dQWoHDYTnw+oPm@mail.gmail.com>
References: <AANLkTikMjYAMZEvsYwJ0mQ7LyU5Ko4GizvjM1WqeZmdt@mail.gmail.com> <1281739980.13891.7.camel@baracus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55487 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757179Ab0HNRMB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Aug 2010 13:12:01 -0400
Received: by ywh1 with SMTP id 1so1423204ywh.19
        for <linux-rt-users@vger.kernel.org>; Sat, 14 Aug 2010 10:12:00 -0700 (PDT)
In-Reply-To: <1281739980.13891.7.camel@baracus>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Aug 14, 2010 at 1:53 AM, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
> On Sat, 2010-08-14 at 00:27 +0300, Raz wrote:
>> Hello rt. I wish to write a paper that describes what it means to po=
rt
>> from vxworks to linux rt in all apects but from your experience. The=
 bellow
>> is a list of questions.
>>
>
> Sounds like you are trying to get someone to write the paper for you?
no.  i want statistics.
> I don't think too many folks on this list are porting from VxWorks to
> Linux.
>
> But you might want to contact Wind River, they might have a migration
> guide you could cite. (Although I would speculate that a migration gu=
ide
> the OTHER way might be easier to find)
> Also, some of your questions are curiously irrelevant. Exchange serve=
r?
> VPN.
they are if your IT manager does not know much about linux. 6 years
has passed and i still have no VPN access through linux.
> Where did you get this survey anyways?
>
> Is it copyrighted?
i did not write anything yet. the only information i have is my own.
if i will write it, it will be copywrited but free.
> Cheers.
>
> Sven
thank you.
>> why did you port ? lack of hardware support ?
>>
>> Is your system soft real time or hard time system ?
>>
>> Can you estimate how many lines of code were ported ?
>>
>> Was there an effort to teach the vxwork engineers linux ? did it
>> succeed / partialy succeed ?
>> If new engineers were recruited, was it difficult to find linux rt
>> programmers ? how long did
>> it take to recruit ?
>>
>> Was the same team structure preserved or a new hirarchy created ?
>>
>> how long did it take to the first linux product ?
>>
>> Did you release new vxworks versions while migrating ? after the
>> migration is done ?
>> =A0 =A0 =A0 =A0 =A0if so , do you have the same engineers supporting=
 the old code ?
>>
>> What are the information resources you used for that ?
>> Did you consult with professionals ? how did you reach a decision wh=
at
>> sort of rt flavor to use ?
>>
>> Were new positions/skills required =A0? Did you recruit platform
>> engineers ? Kernel engineers ?
>>
>> Did you use porting libraries or a nother solution ? did you change
>> the system design ? Did you use other programming languages other th=
an
>> c and c++
>> to migrate ?
>>
>> once the porting was complete can you estimate, does it take the sam=
e
>> effort to release
>> a product ?
>>
>> What was the clients response when they were told you changed Os ? D=
id
>> they know or care ?
>>
>> Is the linux product required to do more than the vx works product?
>>
>> Were all engineers using the same operating system or did some
>> programmers use linux while others running
>> windows ? Did it matter ?
>>
>> Were there any logistics changes due to the porting ? Did the IT
>> department took part , like switching exchange server
>> to something else ? vpn ?
>>
>> Did you use the same source control system ? bug tracking system ?
>>
>> Did you keep your code closed or is it open/partialy open ?
>>
>> thank you
>> raz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
