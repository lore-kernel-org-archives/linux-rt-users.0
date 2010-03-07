From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/2] remove-incorrect-options-from-smp-help-message-in-cyclictest.patch
Date: Mon, 8 Mar 2010 00:49:25 +0100
Message-ID: <520f0cf11003071549y2e5780c8ua22b525ceaf81e13@mail.gmail.com>
References: <20100307203955.895980022@osadl.org>
	 <20100307204243.501654843@osadl.org>
	 <520f0cf11003071510q5d7c81c3m762f45ef81129683@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f225.google.com ([209.85.219.225]:64260 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab0CGXt1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 7 Mar 2010 18:49:27 -0500
Received: by ewy25 with SMTP id 25so1171462ewy.39
        for <linux-rt-users@vger.kernel.org>; Sun, 07 Mar 2010 15:49:25 -0800 (PST)
In-Reply-To: <520f0cf11003071510q5d7c81c3m762f45ef81129683@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Mar 8, 2010 at 12:10 AM, John Kacur <jkacur@redhat.com> wrote:
> On Sun, Mar 7, 2010 at 9:39 PM, Carsten Emde <C.Emde@osadl.org> wrote=
:
>> The help message of cyclictest's -S option says that it equals -a -t=
 -n -m -d0.
>> In reality, it only equals -a -t -n.
>>
>> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>>
>> Index: rt-tests/src/cyclictest/cyclictest.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- rt-tests.orig/src/cyclictest/cyclictest.c
>> +++ rt-tests/src/cyclictest/cyclictest.c
>> @@ -777,8 +777,8 @@ static void display_help(int error)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"-W =A0 =A0 =A0 --wakeuprt =A0 =A0 =A0=
 =A0rt task wakeup tracing (used with -b)\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"-y POLI =A0--policy=3DPOLI =A0 =A0 p=
olicy of realtime thread (1:FIFO, 2:RR)\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 format: --policy=3Dfifo(default) or --policy=3Drr\n"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0"-S =A0 =A0 =A0 --smp =A0 =A0 =A0 =A0 =A0=
 =A0 Standard SMP testing (equals -a -t -n -m -d0)\n"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 same priority on all threads.\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"-S =A0 =A0 =A0 --smp =A0 =A0 =A0 =A0 =A0=
 =A0 Standard SMP testing: options -a -t -n and\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 " =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 same priority of all threads\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "-U =A0 =A0 =A0 --numa =A0 =A0 =A0 =A0 =A0=
 =A0Standard NUMA testing (similar to SMP option)\n"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 thread data structures allocated from local node\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tracers
>>
>> --
>
> Wow, you're right. I wonder if the intention here was to set -m and
> -d0 for -S, and if we instead need a patch to do exactly
> that if the user selects -S.
>
> Certainly a default of -d0 makes sense for smp, and it probably
> doesn't make sense to let the user override it either.
> However, I'm not sure if -m by default is a good choice to make for
> -S. I suggest we make -d0 the default for -S, and
> then see if anyone has an opinion about whether -m should be the
> default for -S. My vote is no, so then we would need
> to correct the documentation in that case.
>

Okay, looking at the history of cyclictest in git,
77abded073c5d11d118112c46c22a84ddc29e771
indicates that the intention was to set just -t -a and -n, so in that c=
ase
Acked-by: John Kacur <jkacur@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
