From: Aaron Fabbri <ajfabbri@gmail.com>
Subject: Re: Non-Preempt Test v1.01
Date: Tue, 15 Oct 2013 17:10:02 -0700
Message-ID: <CAF+KLxu9HHqKuODhkSDSMdsGfPYd4Z9arnXE2JvP1v=t5btZtA@mail.gmail.com>
References: <525C406A.5050000@gmail.com>
	<CAF+KLxtaqEg9Z+cEwcALEHQ-D6kkKXbj0E100pTz5PxQKwd+0g@mail.gmail.com>
	<525D8D6F.5000207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, lttng-dev@lists.lttng.org,
	lwn@lwn.net
To: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:57460 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759923Ab3JPAKD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Oct 2013 20:10:03 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so6822pbb.24
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Oct 2013 17:10:03 -0700 (PDT)
In-Reply-To: <525D8D6F.5000207@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Cool.  Just FYI, did a quick run on two machines and got sane results
(maximums near what I'd expect).  First is generic kernel, second is
-RT w/ NO_HZ_FULL & CPU isolation.

1. Desktop (Ivy Bridge , default 3.8.0-31-generic ubuntu 13 kernel)
$ sudo ./npt -n 100 -l 5234567890 -p 80 -e
# CPU affinity set on CPU 1
# Application priority set to 80
# CPU frequency (evaluation): 2594.10 MHz
# Running for 5234567890 loops.. Please wait.
5234567890 loops done.
Loops duration:
        min:            0.004626 us
        max:            303.812622 us
        mean:           0.031345 us
        sum:            164075829.870756 us
        variance:       0.00079042 us
        std dev:        0.028114 us
--------------------------
duration (us)   nb. loops
--------------------------
0               5234494969
1               3629
2               8119
3               15105
4               4112
5               5200
6               1013
7               2176
8               29702
9               1929
10              910
11              309
12              241
13              179
14              47
15              23
16              26
17              22
18              13
19              18
20              31
21              48
22              20
23              6
24              3
25              5
26              3
27              4
28              2
29              4
30              2
31              4
32              2
33              2
34              5
35              1
36              1
39              1
41              1
48              1
56              1
303             1
--------------------------
Overruns (1000000+): 0


2. Server (3.10.10-rt7, isolcpus / NO_HZ_FULL / rcu thread offloading
/ ftrace built, not enabled)

$ sudo ./npt -n 100 -a 10 -l 5234567890 -p80
# CPU affinity set on CPU 10
# Application priority set to 80
# CPU frequency (/proc/cpuinfo): 1995.18 MHz
# Running for 5234567890 loops.. Please wait.
5234567890 loops done.
Loops duration:
        min:            0.014034 us
        max:            31.275311 us
        mean:           0.024035 us
        sum:            125811537.493472 us
        variance:       0.000198279 us
        std dev:        0.014081 us
--------------------------
duration (us)   nb. loops
--------------------------
0               5234536424
1               9870
2               7926
3               2048
4               200
5               30
6               22
7               1491
8               8666
9               307
10              330
11              31
12              1
14              5
15              19
16              103
17              308
18              11
22              7
23              25
24              63
25              1
31              2
--------------------------
Overruns (1000000+): 0


To generate a little load I just did this during both tests:
$ sudo find / -type f -exec md5sum "{}" \; > /dev/null 2>&1

As well as
$ sudo ping -i 0.001 localhost


On Tue, Oct 15, 2013 at 11:46 AM, Rapha=EBl Beamonte
<raphael.beamonte@gmail.com> wrote:
> On 2013-10-14 18:04, Aaron Fabbri wrote:
>> Thanks for sharing this, will check it out if I get a chance.  Do yo=
u
>> have a http git url that I can clone?  I'm behind a firewall.
>
> Hello Aaron,
>
> Thanks for your interest!
> It is now possible to clone the repository using http:
>         git clone http://git.dorsal.polymtl.ca/git/npt.git
>
> Regards,
> Rapha=EBl
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
