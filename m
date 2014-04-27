From: Stefan Jenisch <stefan.jenisch@gmail.com>
Subject: Difficulties with cyclictest on AMD CPU
Date: Sun, 27 Apr 2014 13:01:08 +0200
Message-ID: <535CE374.7050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:45592 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbaD0LBN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 27 Apr 2014 07:01:13 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so3957899eek.40
        for <linux-rt-users@vger.kernel.org>; Sun, 27 Apr 2014 04:01:11 -0700 (PDT)
Received: from [192.168.0.10] (82-194-155-17.dyn.salzburg-online.at. [82.194.155.17])
        by mx.google.com with ESMTPSA id o5sm40818968eeg.8.2014.04.27.04.01.09
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 04:01:09 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello folks!

I am having some difficulties with cyclictest on an =93AMD GX-210HA SOC=
=20
with Radeon(tm) HD Graphics=94 CPU. Latency values are better with some=
=20
CPU load (execution of an endless loop) than without.

When running the command =93cyclictest -c 0 -t15 -p 95 -i 500 -n -l=20
100000=94 I get the output:

policy: fifo: loadavg: 0.25 0.09 0.06 1/201 2349

T: 0 ( 2335) P:95 I:500 C: 100000 Min: 11 Act: 19 Avg: 21 Max: 231

T: 1 ( 2336) P:95 I:1000 C: 50000 Min: 10 Act: 13 Avg: 23 Max: 222

T: 2 ( 2337) P:95 I:1500 C: 33333 Min: 11 Act: 19 Avg: 24 Max: 198

T: 3 ( 2338) P:95 I:2000 C: 25000 Min: 10 Act: 16 Avg: 25 Max: 185

T: 4 ( 2339) P:95 I:2500 C: 20000 Min: 12 Act: 22 Avg: 25 Max: 196

T: 5 ( 2340) P:95 I:3000 C: 16666 Min: 11 Act: 20 Avg: 23 Max: 233

T: 6 ( 2341) P:95 I:3500 C: 14285 Min: 12 Act: 19 Avg: 25 Max: 209

T: 7 ( 2342) P:95 I:4000 C: 12500 Min: 10 Act: 13 Avg: 25 Max: 123

T: 8 ( 2343) P:95 I:4500 C: 11111 Min: 11 Act: 65 Avg: 29 Max: 203

T: 9 ( 2344) P:95 I:5000 C: 10000 Min: 11 Act: 26 Avg: 22 Max: 175

T:10 ( 2345) P:95 I:5500 C: 9091 Min: 13 Act: 30 Avg: 31 Max: 165

T:11 ( 2346) P:95 I:6000 C: 8333 Min: 12 Act: 19 Avg: 23 Max: 161

T:12 ( 2347) P:95 I:6500 C: 7692 Min: 12 Act: 19 Avg: 24 Max: 194

T:13 ( 2348) P:95 I:7000 C: 7142 Min: 12 Act: 64 Avg: 23 Max: 185

T:14 ( 2349) P:95 I:7500 C: 6666 Min: 12 Act: 20 Avg: 23 Max: 192

Now the thing is when getting the CPUs a little bit busy with something=
=20
else(e.g. simultaneous running =93while true; do echo loop; done=94 on =
in=20
another shell) the same cyclictest results in:

root@host:[~]# cyclictest -c 0 -t15 -p 95 -i 500 -n -l 100000

policy: fifo: loadavg: 1.78 0.54 0.22 3/203 2431

T: 0 ( 2417) P:95 I:500 C: 100000 Min: 10 Act: 19 Avg: 16 Max: 44

T: 1 ( 2418) P:95 I:1000 C: 49998 Min: 10 Act: 16 Avg: 15 Max: 45

T: 2 ( 2419) P:95 I:1500 C: 33335 Min: 9 Act: 16 Avg: 15 Max: 33

T: 3 ( 2420) P:95 I:2000 C: 25000 Min: 10 Act: 14 Avg: 16 Max: 40

T: 4 ( 2421) P:95 I:2500 C: 20000 Min: 10 Act: 15 Avg: 16 Max: 33

T: 5 ( 2422) P:95 I:3000 C: 16667 Min: 10 Act: 15 Avg: 16 Max: 60

T: 6 ( 2423) P:95 I:3500 C: 14286 Min: 10 Act: 14 Avg: 16 Max: 35

T: 7 ( 2424) P:95 I:4000 C: 12500 Min: 12 Act: 24 Avg: 16 Max: 33

T: 8 ( 2425) P:95 I:4500 C: 11111 Min: 11 Act: 15 Avg: 16 Max: 34

T: 9 ( 2426) P:95 I:5000 C: 10000 Min: 10 Act: 15 Avg: 17 Max: 46

T:10 ( 2427) P:95 I:5500 C: 9091 Min: 10 Act: 15 Avg: 15 Max: 38

T:11 ( 2428) P:95 I:6000 C: 8333 Min: 10 Act: 13 Avg: 15 Max: 35

T:12 ( 2429) P:95 I:6500 C: 7692 Min: 11 Act: 13 Avg: 16 Max: 42

T:13 ( 2430) P:95 I:7000 C: 7143 Min: 11 Act: 12 Avg: 16 Max: 32

T:14 ( 2431) P:95 I:7500 C: 6666 Min: 11 Act: 15 Avg: 17 Max: 37

As can be seen the max-latency improved!

It=92s like ordering in an empty restaurant. Takes hours to get the din=
ner=20
if you are the only customer. As soon as some more people are around=20
everything is getting faster...

So my guess is that the cpu goes into some sort of powersave mode from=20
time to time. The wakeup from these powersave state results in=20
latencies. Currently I am looking for a proper solution to this problem=
=20
and what I have tried so far:

- BIOS upgrade
- Upgraded to linux-3.10.12-rt25
- Disabling all sort of powersave modes in the kernel config
- Activated cpufreq-performance (which seems to be ignored anyway)
- Searched the BIOS for any powersave modes to deactivate (none found)

I got rather clueless on what else to try! Does anyone has a helping=20
hint on how to solve this one???

With many thanks in advance,

Stefan J.

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
