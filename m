From: Sujit Karataparambil <sjt.kar@gmail.com>
Subject: Re: Re: Re: Ethernet communication from real time thread
Date: Thu, 30 Apr 2009 17:05:32 +0530
Message-ID: <921ca19c0904300435v39df310bk517ed841cf2a7318@mail.gmail.com>
References: <20308172.1241074857487.JavaMail.ngmail@webmail19.ha2.local>
	 <921ca19c0904300229g47889c67yedd3aa4acb73b20d@mail.gmail.com>
	 <14844227.1241088061552.JavaMail.ngmail@webmail12.arcor-online.net>
	 <921ca19c0904300404x5193a9d0s1c52c688826d7912@mail.gmail.com>
	 <438094.1241090250891.JavaMail.ngmail@webmail11.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "M. Koehrer" <mathias_koehrer@arcor.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:63031 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762988AbZD3Lfd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2009 07:35:33 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1329746wfd.4
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2009 04:35:32 -0700 (PDT)
In-Reply-To: <438094.1241090250891.JavaMail.ngmail@webmail11.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> now I got your point!
> I think I did not tell it clearly:
> I want to replace a running Xenomai/RTNET approach by completely
> using the RT_PREEMPT patch. I do not want to do any mix of Xenomai an=
d RT_PREEMPT.
> The target is to have a RT_PREEMPT only system that performs similar =
to the Xenomai/rtnet
> approach.


What you mean to say is the pthread library.
http://en.wikipedia.org/wiki/POSIX_Threads
http://www.net.t-labs.tu-berlin.de/~gregor/tools/pthread-scheduling.htm=
l


How will you replace Xenomai/RTNET Completely. You don't even know how
it behaves with
RT_PREEMPT patch. Also why do you think it necessary to have an common
guide line
on Priorities on thread's. I dont think they follow any standard on thi=
s regard.
=46or Example QT might be following some other Thread Priority standard
in regards to number
of levels, thread nomenclature etc.


> Sorry for any confusion here...
>
> Thus, the concrete question (in short) is:
> - Which (user/kernel) threads (prio, affinity) are relevant for using=
 Ethernet (UDP/IP) communication
> with the RT_PREEMPT patch.


you could look up these articles. based on what i have discussed.

http://lists.trolltech.com/qt-interest/2007-05/thread00746-0.html

On Thu, Apr 30, 2009 at 4:47 PM, M. Koehrer <mathias_koehrer@arcor.de> =
wrote:
> Hi Sujit,
>
> now I got your point!
> I think I did not tell it clearly:
> I want to replace a running Xenomai/RTNET approach by completely
> using the RT_PREEMPT patch. I do not want to do any mix of Xenomai an=
d RT_PREEMPT.
> The target is to have a RT_PREEMPT only system that performs similar =
to the Xenomai/rtnet
> approach.
>
> Sorry for any confusion here...
>
> Thus, the concrete question (in short) is:
> - Which (user/kernel) threads (prio, affinity) are relevant for using=
 Ethernet (UDP/IP) communication
> with the RT_PREEMPT patch.
>
>> I think you have a point it certainly needs to be checked whether
>> the RT_PREEMPT patch behaves with an package like Xenomai.
>> My initial reaction is just that in the case of Xenomai, it just app=
lies
>> an Hard Real time constraint on the RT_PREEMPT patch.
>>
>> But it is certainly much better to investigate what happens when we
>> have an Xenomai like RT System behave otherwise. Does it change
>> the RT_PREEMPT patch.
>>
>
> Regards
>
> Mathias
>
> --
> Mathias Koehrer
> mathias_koehrer@arcor.de
>
>
> Arcor.de Gaming Area - kostenfrei daddeln bis der Arzt kommt!
> Jetzt checken und aus =FCber 80 Spielen w=E4hlen!
> http://www.arcor.de/footer-gaming/
>



--=20
-- Sujit K M
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
