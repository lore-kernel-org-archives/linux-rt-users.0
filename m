From: Daniel Wagner <wagi@monom.org>
Subject: Re: Some benchmark results
Date: Thu, 28 Aug 2014 08:11:47 +0200
Message-ID: <53FEC823.5030709@monom.org>
References: <53FAFBA8.3050009@monom.org> <1657147.MGSNxR1uXh@bs8>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Bernhard Schiffner <bernhard@schiffner-limbach.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:36306 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaH1GLw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Aug 2014 02:11:52 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so254987wes.32
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Aug 2014 23:11:50 -0700 (PDT)
In-Reply-To: <1657147.MGSNxR1uXh@bs8>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Bernhard,

On 08/25/2014 04:14 PM, Bernhard Schiffner wrote:
> Am Montag, 25. August 2014, 11:02:32 schrieb Daniel Wagner:
>> Hi,
>>
>> I wanted to know how good or bad mainline vs RT is, therefore I let
>> MMTests torture my laptop for a while. I selected a few of the suppo=
rted
>> benchmarks by MMTests in order to keep to a reasonable time frame.
>>
>> The aim was to see the impact of normal (no RT) workloads with diffe=
rent
>> preempt configurations on mainline and RT patched kernel. I tried to=
 not
>> to change other configuration flags except the preempt one. There ar=
e
>> some small difference due to dependencies but the rest looks ok to m=
e.
>>
>> http://www.monom.org/rt/mmtests/
>>
>> Suggestion, improvements, comments?
>>
>> cheers,
>> daniel
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> Hi Daniel,
>=20
> I had a first look at the above mentioned page.
>=20
> The thing I'am complety missing in the huge amount of numbers is: Wha=
t is your=20
> demand, your primary topic to solve in or with RT?

Thanks looking at the numbers and the feedback from you. I really
appreciate that.

To your question: My goal is to help out to get this patch set merged
into mainline. I know an ambitious goal and I might be too incompetent
(I may suffering from the Dunning=96Kruger effect. but hey, I am not th=
e
one who recognize this).

So I figured the best thing is to start playing with different loads an=
d
see how they compare to mainline and trying to understand why they are
different.

> And as I interprete the numbers: a RT kernel is a little bit more CPU=
-hungry=20
> then normal and this is nothing new.

Sure, I am well aware that RT is  'a little bit more CPU-hungry', but I
wondered how much is a little and what are the effects of it?

I am doing those tests for myself to get a better understanding. I just
shared the results in case someone else finds them interesting. I shoul=
d
have stated that more clearly to avoid burning time from you. Sorry
about that.

cheers,
daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
