From: Sujit Karataparambil <sjt.kar@gmail.com>
Subject: Re: Re: Ethernet communication from real time thread
Date: Thu, 30 Apr 2009 16:34:41 +0530
Message-ID: <921ca19c0904300404x5193a9d0s1c52c688826d7912@mail.gmail.com>
References: <20308172.1241074857487.JavaMail.ngmail@webmail19.ha2.local>
	 <921ca19c0904300229g47889c67yedd3aa4acb73b20d@mail.gmail.com>
	 <14844227.1241088061552.JavaMail.ngmail@webmail12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "M. Koehrer" <mathias_koehrer@arcor.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:50549 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbZD3LEn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2009 07:04:43 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1320946wfd.4
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2009 04:04:42 -0700 (PDT)
In-Reply-To: <14844227.1241088061552.JavaMail.ngmail@webmail12.arcor-online.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I think you have a point it certainly needs to be checked whether
the RT_PREEMPT patch behaves with an package like Xenomai.
My initial reaction is just that in the case of Xenomai, it just applie=
s
an Hard Real time constraint on the RT_PREEMPT patch.

But it is certainly much better to investigate what happens when we
have an Xenomai like RT System behave otherwise. Does it change
the RT_PREEMPT patch.



On Thu, Apr 30, 2009 at 4:11 PM, M. Koehrer <mathias_koehrer@arcor.de> =
wrote:
> Hi Sujit,
>
> thanks for your response.
> I am actually interested in the way, the communication with the RT_PR=
EEMPT patch
> works to get an understanding what pieces of the overall system can b=
e tuned and
> which priorities of threads are relevant and which SMP affinities are=
 relevant.
>
> As rtnet can only handle UDP it is obvious, that it is performing sli=
ghtly better,
> however a good understanding is important in any case.
>
>> 1. Is Xenomai is Configured to take care of Multicore Hard real time
>> Computation? Since
>> =A0 you say that the Thread is running in Processor 3. How is Xenoma=
i
>> Configured in case
>> =A0 of the Multicore Solution
>> 2. What are these hard real time computations in this particular thr=
ead?
>> 3. How is Xenomai Taking care of this thread?
>> 4. RTNET is running the UDP Part of Thread or Does not fork in Xenom=
ai.
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
