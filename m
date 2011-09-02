From: Michael Mueller <ss7box@gmail.com>
Subject: Re: Issue (NOT RELATED TO RT-PATCH) with clock_gettime /
 clock_nanosleep APIs with high resolution timer on panda board
Date: Fri, 2 Sep 2011 07:29:05 -0400
Message-ID: <CA+zZMHGndWUm09CT+ogoAPMM61FYcYG453KcAjtxOtjNoSB17A@mail.gmail.com>
References: <CAFQPvXfaisNL9YN+pUp_cYCRp4YZFCEPt33ZUAZ-Sa6VieAing@mail.gmail.com>
	<alpine.LFD.2.02.1109012121580.2723@ionos>
	<CA+zZMHFhJ81EjM09jRkfyGXtucASf3Ac1KS65TuYw4VDaJ5jFQ@mail.gmail.com>
	<alpine.LFD.2.02.1109020937190.2723@ionos>
	<CA+zZMHGg=Q3rxW9j5iW0CqNNjKbrbSyi6OxQjRe9i1cO5mFRuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sankara Muthukrishnan <sankara.m@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45720 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab1IBL3H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Sep 2011 07:29:07 -0400
Received: by fxh19 with SMTP id 19so1545548fxh.19
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Sep 2011 04:29:05 -0700 (PDT)
In-Reply-To: <CA+zZMHGg=Q3rxW9j5iW0CqNNjKbrbSyi6OxQjRe9i1cO5mFRuA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

repost attempt - kernel.org correctly rejects html email - i blame
gmail - hopefully fixed

On Fri, Sep 2, 2011 at 7:19 AM, Michael Mueller <ss7box@gmail.com> wrot=
e:
>
>
> On Fri, Sep 2, 2011 at 3:37 AM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>>
>> Mike,
>>
>> On Thu, 1 Sep 2011, Michael Mueller wrote:
>> > On Thu, Sep 1, 2011 at 3:33 PM, Thomas Gleixner <tglx@linutronix.d=
e>
>> > wrote:
>> >
>> > >
>> > > That looks like a problem in the clocksource. i.e. time is going
>> > > backward or having weird momentary jumps. You could verify that =
by
>> > > running one ore more tight loops which do
>> > >
>> > > =A0 =A0 =A0 =A0clock_gettime(CLOCK_MONOTONIC, &prev);
>> > > =A0 =A0 =A0 =A0while (1) {
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0clock_gettime(CLOCK_MONOTONIC, &curr)=
;
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0if (curr < prev) /* Use a proper comp=
are function for
>> > > timespec! */
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(.....);
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0prev =3D curr;
>> > > =A0 =A0 =A0 =A0}
>> > >
>> > > If that triggers on RT or on a vanilla kernel, then the problem =
is
>> > > definitely somewhere in the timekeeping/clocksource area.
>> >
>> >
>> > have seen this problem in vanilla kernels; developed a work-around=
 that
>> > calls
>> > clock_gettime(CLOCK_MONOTONIC, &curr); until curr>prev
>> > a couple of times, and if that doesn't work, then it gets a new pr=
ev
>> > value
>> > and a new curr value; rinse and repeat until curr<prev; not sure w=
hat
>> > precipitates the problem; will post workaround code if wanted
>>
>> Is that on a Panda board as well?
>
> older and newer Dell boxes with 2.6.old kernels; a few weeks ago I
> discovered a newer box time leaping/lagging so much that I had to thr=
ottle
> back the syslog messages indicating detection/correction
> if needed I can try to isolate and gather more info - see if a newer =
kernel
> generates the problem
> edit above: rinse and repeat until curr>prev
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
