From: John Kacur <jkacur@redhat.com>
Subject: Re: Real time micro benchmark suite - thread priority fix
Date: Mon, 21 May 2012 12:15:11 +0200
Message-ID: <CAONaPpFvDUsBF4EYL1p9oJ7m_K98Z87G8edDJbZcdTcL0Z9_Hw@mail.gmail.com>
References: <4FB56A88.7050705@caviumnetworks.com>
	<CAONaPpFi8M7tutcvyMaTeCk5gYk2UjVBKJkorssAKYSEAzJYPw@mail.gmail.com>
	<4FB9B841.7020409@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Subbiah, Venkat" <Venkat.Subbiah@caviumnetworks.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53075 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab2EUKPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 May 2012 06:15:12 -0400
Received: by vbbff1 with SMTP id ff1so3415284vbb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 21 May 2012 03:15:11 -0700 (PDT)
In-Reply-To: <4FB9B841.7020409@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, May 21, 2012 at 5:36 AM, Venkat Subbiah
<vsubbiah@caviumnetworks.com> wrote:
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
>> Are you on some kind of a quest to seek out obscure benchmarks? You
>> need to track down Mike Fulton and ask him if he is maintaining it,
>> no-one here is.
>
> I got a list of benchmarks of the RT wiki and have been trying to exe=
rcise
> them. After looking into I do see that some of them are obscure. In t=
he
> process ran into this and the fix I sent to
> the maintainers bounced back, so wanted to send the fix out through
> this forum.
> Thanks,
> Venkat


Okay. The Wiki contains a lot of historical material, plus it has been
down for quite awhile because of the kernel.org problems. Now that it
is back in service why don't you update the pages with the results of
your research. For example, if you find a benchmark / test that seems
to be defunct / not maintained, why not add a short note at the bottom
of the page saying so.

Thank you.

John Kacur
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
