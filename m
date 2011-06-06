From: Johannes Bauer <hannes_bauer@aon.at>
Subject: Re: Changing Kernel thread priorities
Date: Mon, 6 Jun 2011 14:10:25 +0200 (CEST)
Message-ID: <4829399.10721.1307362225402.JavaMail.root@WARSBL213.highway.telekom.at>
Reply-To: hannes_bauer@aon.at
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Monica Puig-Pey <puigpeym@unican.es>,
	Rolando Martins <rolando.martins@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout04.highway.telekom.at ([195.3.96.117]:48386 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753175Ab1FFMK2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2011 08:10:28 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

i thought i sent you the discussion already...

But again, here is how Remy Bohmer does it using the same sched_setsche=
duler call!
http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg01046.htm=
l

If it does not help you, i woul dsuggest to post your code, maybe this =
would help people to help you...

regards JB



----- Urspr=C3=BCngliche Nachricht -----
Von: "Monica Puig-Pey" <puigpeym@unican.es>
Erhalten: 06.06.2011 13:58
An: "Rolando Martins" <rolando.martins@gmail.com>

El 06/06/11 13:54, Rolando Martins escribi=C3=B3:
> Hi,
> I use the following:
>
> PIDs=3D$(ps -eLo pid,cls,rtprio,pri,nice,cmd | grep -i "irq" | awk '{
> print $1; }' | xargs echo)
> for i in $PIDs
> do
> ret=3D$(chrt -f -p 99 $i)
> done
>
> This will change the kernel thread associated with an irq handler to
> RT FIFO prio 99.
> Just change the script to your specific interrupt.
>
> Hope it helps,
> Rolando
>
> On Mon, Jun 6, 2011 at 12:47 PM, Monica Puig-Pey wrote:
>> I am writing a driver which has one kernel thread associated with it=
=2E
>> I want to change the priority of this thread, so that I can specify =
the
>> order in which it is scheduled following an interrupt.
>> I'm using:
>>
>> sched_setscheduler(struct task_struct *, int, struct sched_param *);
>>
>> but it doesn't work. I tried to change the priority from the init_mo=
dule,
>> and also from the Kernel Thread, but there is no way.
>>
>> Kernel version is 2.6.31-11-rt
>>
>> What do I call to change a kernel thread priority?
>>
>> Thanks you very much
>>
>> M=C3=B3nica
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>

I need to change the priority from inside the driver, when creating the=
=20
kernel thread.
Your script is useful but it is done in user context,
Any other help please?

M=C3=B3nica


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
