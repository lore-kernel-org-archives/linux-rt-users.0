From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: 1us latency?
Date: Tue, 04 Aug 2015 13:27:25 -0700
Message-ID: <55C1202D.9060108@gmail.com>
References: <55BF4CD7.8000007@pavlinux.ru> <20150803114422.0efbea1b@sluggy> <55BFAC1C.9020508@pavlinux.ru> <55BFB4AA.4020901@pavlinux.ru> <20150803135326.3fd23809@sluggy>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pavel <pavel@pavlinux.ru>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36358 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbbHDU13 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Aug 2015 16:27:29 -0400
Received: by lbbud7 with SMTP id ud7so12907012lbb.3
        for <linux-rt-users@vger.kernel.org>; Tue, 04 Aug 2015 13:27:27 -0700 (PDT)
In-Reply-To: <20150803135326.3fd23809@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 8/3/2015 11:53 AM, Clark Williams wrote:
> On Mon, 3 Aug 2015 21:36:26 +0300
> pavel <pavel@pavlinux.ru> wrote:
>=20
>> 1. Without patch
>>
>> # ./cyclictest -S -p fifo -D60s
>> defaulting realtime priority to 9
>> # /dev/cpu_dma_latency set to 0us
>> policy: fifo: loadavg: 0.00 0.01 0.05 1/207 12378
>>
>> T: 0 (12361) P: 9 I:1000 C:  59993 Min:      1 Act:    1 Avg:    1 M=
ax:       8
>> T: 1 (12362) P: 9 I:1500 C:  39995 Min:      1 Act:    1 Avg:    1 M=
ax:       9
>> T: 2 (12363) P: 9 I:2000 C:  29996 Min:      1 Act:    1 Avg:    1 M=
ax:      12
>> T: 3 (12364) P: 9 I:2500 C:  23997 Min:      1 Act:    1 Avg:    1 M=
ax:       9
>> T: 4 (12365) P: 9 I:3000 C:  19997 Min:      1 Act:    1 Avg:    1 M=
ax:       6
>> T: 5 (12366) P: 9 I:3500 C:  17141 Min:      1 Act:    1 Avg:    1 M=
ax:       11
>> T: 6 (12367) P: 9 I:4000 C:  14998 Min:      0 Act:    1 Avg:    1 M=
ax:       10
>> T: 7 (12368) P: 9 I:4500 C:  13331 Min:      0 Act:    1 Avg:    1 M=
ax:       6
>>
>> 2. With patch
>>
>>   # ./cyclictest -S -p fifo -D60s
>> defaulting realtime priority to 9
>> # /dev/cpu_dma_latency set to 0us
>> policy: fifo: loadavg: 0.05 0.04 0.05 1/206 12469
>>
>> T: 0 (12452) P: 9 I:1000 C:  59997 Min:      1 Act:    1 Avg:    1 M=
ax:       3
>> T: 1 (12453) P: 9 I:1500 C:  39998 Min:      1 Act:    1 Avg:    1 M=
ax:       2
>> T: 2 (12454) P: 9 I:2000 C:  29998 Min:      1 Act:    1 Avg:    1 M=
ax:       4
>> T: 3 (12455) P: 9 I:2500 C:  23999 Min:      1 Act:    1 Avg:    1 M=
ax:       4
>> T: 4 (12456) P: 9 I:3000 C:  19999 Min:      1 Act:    1 Avg:    1 M=
ax:       4
>> T: 5 (12457) P: 9 I:3500 C:  17142 Min:      1 Act:    1 Avg:    1 M=
ax:       3
>> T: 6 (12458) P: 9 I:4000 C:  14999 Min:      1 Act:    1 Avg:    1 M=
ax:       2
>> T: 7 (12459) P: 9 I:4500 C:  13332 Min:      1 Act:    1 Avg:    1 M=
ax:       3
>>
>>
>> Patch  ---
>>
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest=
=2Ec
>> index 34053c5..84a70de 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -1727,6 +1727,9 @@ static void print_stat(FILE *fp, struct thread=
_param *par,=20
>> int index, int verbos
>>   {
>>          struct thread_stat *stat =3D par->stats;
>>
>> +       if ( stat->cycles < 5000)
>> +                stat->max =3D 0;
>> +
>>          if (!verbose) {
>>                  if (quiet !=3D 1) {
>>                          char *fmt;
>>
>> ---
>>
>>
>> 03.08.2015 20:59, pavel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>>>
>>>>> # ./cyclictest -S -p fifo
>>>>> defaulting realtime priority to 9
>>>>> # /dev/cpu_dma_latency set to 0us
>>>>> policy: fifo: loadavg: 0.00 0.03 0.05 1/218 4240
>>>>>
>>>>> T: 0 ( 4174) P: 9 I:1000 C: 430806 Min:      1 Act:    1 Avg:    =
1 Max:      10
>>>>> T: 1 ( 4175) P: 9 I:1500 C: 287204 Min:      1 Act:    1 Avg:    =
1 Max:       6
>>>>> T: 2 ( 4176) P: 9 I:2000 C: 215403 Min:      1 Act:    2 Avg:    =
1 Max:      11
>>>>> T: 3 ( 4177) P: 9 I:2500 C: 172322 Min:      1 Act:    1 Avg:    =
1 Max:       9
>>>>> T: 4 ( 4178) P: 9 I:3000 C: 143602 Min:      1 Act:    1 Avg:    =
1 Max:      10
>>>>> T: 5 ( 4179) P: 9 I:3500 C: 123087 Min:      1 Act:    1 Avg:    =
1 Max:      11
>>>>> T: 6 ( 4180) P: 9 I:4000 C: 107701 Min:      1 Act:    1 Avg:    =
1 Max:      10
>>>>> T: 7 ( 4181) P: 9 I:4500 C: 108232 Min:      1 Act:    2 Avg:    =
1 Max:      11
>>>>>
>>>>>
>>>>> It possible? 1us latency?  o_O
>>>> No, your latency is 11us. Max latency is what we care about, not t=
he
>>>> average.
>>> By the way, max values appear only at the start, then they are roug=
hly equal to
>>> the average.
>>
>=20
> Interesting. Betting that's page faults and cache filling.=20

You might want to try running a background load on the system that poll=
utes
the cache and TLB and see if you get larger values after the start up p=
eriod.

>=20
> I don't think we want to arbitrarily pick some number of cycles for a
> "settle time" (i.e. a grace period for the application to reach stead=
y
> state). Possibly we should add an option for that? Specify some numbe=
r
> of cycles or some amount of time that where the measurement threads r=
un
> before actual measurements start?
>=20
>   $ cyclictest --numa -p95 -m --settle=3D10ms
>=20
> That would say "run the measurement threads for ten milliseconds befo=
re
> actually starting the measurement period". That would allow them to
> fault in and fill cache lines before starting real work.
>=20
> Anyone else have an opinion?
>=20
> Clark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> .
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
