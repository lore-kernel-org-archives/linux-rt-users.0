From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] rt-tests: printf format compile warning
Date: Fri, 4 May 2012 00:41:42 +0200
Message-ID: <CAONaPpGwuKdXL8xTGatYN2Rx7eZgJtqn4xaAw4x_N+uQ-if4RQ@mail.gmail.com>
References: <4FA2E120.1020909@am.sony.com>
	<4FA2F514.5070104@linux.intel.com>
	<20120503162633.788367b0@redhat.com>
	<alpine.LFD.2.02.1205040035440.3952@tycho>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Darren Hart <dvhart@linux.intel.com>, frank.rowand@am.sony.com,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	jkacur@redhat.com
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45804 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758862Ab2ECWln convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 18:41:43 -0400
Received: by vbbff1 with SMTP id ff1so1669556vbb.19
        for <linux-rt-users@vger.kernel.org>; Thu, 03 May 2012 15:41:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1205040035440.3952@tycho>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 4, 2012 at 12:37 AM, John Kacur <jkacur@redhat.com> wrote:
>
>
> On Thu, 3 May 2012, Clark Williams wrote:
>
>> On Thu, 03 May 2012 14:13:56 -0700
>> Darren Hart <dvhart@linux.intel.com> wrote:
>>
>> >
>> >
>> > On 05/03/2012 12:48 PM, Frank Rowand wrote:
>> > >
>> > > V2: use type casting instead of ugly constant in format string
>> > >
>> > >
>> > > Fix printf format string to fix compile warning for ARM 32 bit t=
arget.
>> > >
>> >
>> > Oh much better. :-)
>> >
>> > > Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
>> > > ---
>> > > =A0src/cyclictest/cyclictest.c | =A0 =A02 =A0 =A0 =A0 1 + =A0 =A0=
 1 - =A0 =A0 0 !
>> > > =A01 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > Index: b/src/cyclictest/cyclictest.c
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > --- a/src/cyclictest/cyclictest.c
>> > > +++ b/src/cyclictest/cyclictest.c
>> > > @@ -1575,7 +1575,7 @@ int main(int argc, char **argv)
>> > > =A0 =A0 =A0 =A0 =A0 print_tids(parameters, num_threads);
>> > > =A0 =A0 =A0 =A0 =A0 if (break_thread_id) {
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("# Break thread: %d\n=
", break_thread_id);
>> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("# Break value: %lu\n",=
 break_thread_value);
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("# Break value: %llu\n"=
, (unsigned long long)break_thread_value);
>> > > =A0 =A0 =A0 =A0 =A0 }
>> > > =A0 }
>> > >
>> > >
>> >
>> >
>>
>> Yes, I like this better. I pulled the original and applied this.
>
> Well, I really hate the C99 macros too, they're uglier than sin. But,=
 you
> want to fix a compiler error on 32-bit by creating one on 64-bits? Wh=
at
> are you guys smoking?
>
> NAK
>
> The above patch creates the following error on 64-bit
> src/cyclictest/cyclictest.c:1564:4: warning: format =91%llu=92 expect=
s
> argument of type =91long long unsigned int=92, but argument 2 has typ=
e
> =91uint64_t=92 [-Wformat]

Ok, obviously, it's me who must have been smoking something. My bad, my=
 bad.
there is a cast in there.

That patch is way better, sorry. I approve!
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
