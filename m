From: John Kacur <jkacur@redhat.com>
Subject: Re: Real time micro benchmark suite - thread priority fix
Date: Mon, 21 May 2012 17:59:25 +0200
Message-ID: <CAONaPpHyVGR9DEWGcDM2fRr52V4EMWs6JUUf6FGCLXqpD816Xw@mail.gmail.com>
References: <4FB56A88.7050705@caviumnetworks.com>
	<CAONaPpFi8M7tutcvyMaTeCk5gYk2UjVBKJkorssAKYSEAzJYPw@mail.gmail.com>
	<4FBA60F6.7090008@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Venkat Subbiah <vsubbiah@caviumnetworks.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Nivedita Singhvi <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:65168 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab2EUP70 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 May 2012 11:59:26 -0400
Received: by vbbff1 with SMTP id ff1so3573276vbb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 21 May 2012 08:59:25 -0700 (PDT)
In-Reply-To: <4FBA60F6.7090008@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, May 21, 2012 at 5:36 PM, Nivedita Singhvi <niv@us.ibm.com> wrot=
e:
> On 05/18/2012 05:54 AM, John Kacur wrote:
>>
>> On Thu, May 17, 2012 at 11:15 PM, Venkat Subbiah
>> <vsubbiah@caviumnetworks.com> =A0wrote:
>>>
>>> Not sure whether Real time micro benchmark suite is still being
>>> maintained
>>> at http://sourceforge.net/projects/rtmicrobench. The latest code fr=
om
>>> sourceforge has issues while running rtmb_c tests. It fails complai=
ning
>>> about not being able to set thread priority. =A0Here's a fix for it=
=2E
>>>
>>>
>>> https://github.com/vsubbiah/rtmb/commit/2a6714030a4009b50b76e99a83b=
f4b042cc82780
>>>
>>> Thanks,
>>> Venkat
>>
>>
>> Are you on some kind of a quest to seek out obscure benchmarks? You
>> need to track down Mike Fulton and ask him if he is maintaining it,
>> no-one here is.
>
>
> I'm pretty sure Mike Fulton isn't maintaining it, but I'll ask around=
 to see
> if anyone else is.
>
> thanks,
> Nivedita

I'm pretty sure he isn't either. In fact I bcced him on my first reply
to Venkat. I haven't had a good look at the benchmark yet to see if it
is anything we want to pick-up. It is the Eclipse license - I'd prefer
GPL. Do you regularly use this at IBM?

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
