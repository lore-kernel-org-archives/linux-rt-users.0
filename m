From: John Kacur <jkacur@redhat.com>
Subject: Re: merge of real-time 2.6.33.9-rt31 with stable 2.6.33.13
Date: Wed, 18 May 2011 09:52:46 +0200
Message-ID: <BANLkTinoOnp1XN1ZNYK5L68FDW3EknFcxg@mail.gmail.com>
References: <alpine.LFD.2.00.1105141749180.29326@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57524 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379Ab1ERHwr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 May 2011 03:52:47 -0400
In-Reply-To: <alpine.LFD.2.00.1105141749180.29326@localhost6.localdomain6>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, May 14, 2011 at 5:59 PM, John Kacur <jkacur@redhat.com> wrote:
>
> Hi Thomas
>
> I did some light testing merging 2.6.33.13 into real-time 2.6.33.9-rt=
31.
> In addition I cherry-picked 3c955b407a084810f57260d61548cc92c14bc627
> in order to compile on newer distros.
>
> Please consider picking this up. You can get it from
> git://git.kernel.org/pub/scm/linux/kernel/git/jkacur/jk-2.6.git rt/2.=
6.33
>
> Thanks
>
> John Kacur
>
> Here is the result of cyclic test on one machine
> sudo ./cyclictest -t32 -p 80 -n -i 10000 -l 10000
> policy: fifo: loadavg: 0.00 0.00 0.00 1/541 3759
>
> T: 0 ( 3728) P:80 I:10000 C: =A010000 Min: =A0 =A0 =A07 Act: =A0104 A=
vg: =A0114 Max: =A0 =A0 470
> T: 1 ( 3729) P:79 I:10500 C: =A0 9524 Min: =A0 =A0 =A04 Act: =A0 93 A=
vg: =A0105 Max: =A0 =A0 417
> T: 2 ( 3730) P:78 I:11000 C: =A0 9091 Min: =A0 =A0 =A04 Act: =A0114 A=
vg: =A0125 Max: =A0 =A0 420
> T: 3 ( 3731) P:77 I:11500 C: =A0 8696 Min: =A0 =A0 =A04 Act: =A0 58 A=
vg: =A0 91 Max: =A0 =A0 387
> T: 4 ( 3732) P:76 I:12000 C: =A0 8333 Min: =A0 =A0 =A04 Act: =A0 84 A=
vg: =A0114 Max: =A0 =A0 425
> T: 5 ( 3733) P:75 I:12500 C: =A0 8000 Min: =A0 =A0 =A04 Act: =A0133 A=
vg: =A0112 Max: =A0 =A0 385
> T: 6 ( 3734) P:74 I:13000 C: =A0 7692 Min: =A0 =A0 =A03 Act: =A0 =A08=
 Avg: =A0 65 Max: =A0 =A0 377
> T: 7 ( 3735) P:73 I:13500 C: =A0 7407 Min: =A0 =A0 =A03 Act: =A0 91 A=
vg: =A0 71 Max: =A0 =A0 358
> T: 8 ( 3736) P:72 I:14000 C: =A0 7143 Min: =A0 =A0 =A04 Act: =A0 78 A=
vg: =A0 98 Max: =A0 =A0 323
> T: 9 ( 3737) P:71 I:14500 C: =A0 6897 Min: =A0 =A0 =A07 Act: =A0133 A=
vg: =A0109 Max: =A0 =A0 300
> T:10 ( 3738) P:70 I:15000 C: =A0 6667 Min: =A0 =A0 =A05 Act: =A0115 A=
vg: =A0 98 Max: =A0 =A0 314
> T:11 ( 3739) P:69 I:15500 C: =A0 6452 Min: =A0 =A0 =A03 Act: =A0 =A06=
 Avg: =A0 79 Max: =A0 =A0 280
> T:12 ( 3740) P:68 I:16000 C: =A0 6250 Min: =A0 =A0 =A03 Act: =A0 68 A=
vg: =A0 80 Max: =A0 =A0 317
> T:13 ( 3741) P:67 I:16500 C: =A0 6061 Min: =A0 =A0 =A04 Act: =A0142 A=
vg: =A0 82 Max: =A0 =A0 255
> T:14 ( 3742) P:66 I:17000 C: =A0 5882 Min: =A0 =A0 =A04 Act: =A0132 A=
vg: =A0102 Max: =A0 =A0 253
> T:15 ( 3743) P:65 I:17500 C: =A0 5714 Min: =A0 =A0 =A04 Act: =A0135 A=
vg: =A0111 Max: =A0 =A0 342
> T:16 ( 3744) P:64 I:18000 C: =A0 5556 Min: =A0 =A0 =A04 Act: =A0 16 A=
vg: =A0 37 Max: =A0 =A0 315
> T:17 ( 3745) P:63 I:18500 C: =A0 5405 Min: =A0 =A0 =A03 Act: =A0 12 A=
vg: =A0 53 Max: =A0 =A0 322
> T:18 ( 3746) P:62 I:19000 C: =A0 5263 Min: =A0 =A0 =A03 Act: =A0 62 A=
vg: =A0 37 Max: =A0 =A0 250
> T:19 ( 3747) P:61 I:19500 C: =A0 5128 Min: =A0 =A0 =A03 Act: =A0 65 A=
vg: =A0 35 Max: =A0 =A0 276
> T:20 ( 3748) P:60 I:20000 C: =A0 5000 Min: =A0 =A0 =A03 Act: =A0180 A=
vg: =A0 81 Max: =A0 =A0 295
> T:21 ( 3749) P:59 I:20500 C: =A0 4878 Min: =A0 =A0 =A03 Act: =A0 76 A=
vg: =A0 45 Max: =A0 =A0 314
> T:22 ( 3750) P:58 I:21000 C: =A0 4762 Min: =A0 =A0 =A03 Act: =A0133 A=
vg: =A0 38 Max: =A0 =A0 265
> T:23 ( 3751) P:57 I:21500 C: =A0 4651 Min: =A0 =A0 =A03 Act: =A0132 A=
vg: =A0 71 Max: =A0 =A0 300
> T:24 ( 3752) P:56 I:22000 C: =A0 4546 Min: =A0 =A0 =A03 Act: =A0 =A06=
 Avg: =A0 57 Max: =A0 =A0 227
> T:25 ( 3753) P:55 I:22500 C: =A0 4445 Min: =A0 =A0 =A03 Act: =A0 72 A=
vg: =A0 50 Max: =A0 =A0 258
> T:26 ( 3754) P:54 I:23000 C: =A0 4348 Min: =A0 =A0 =A04 Act: =A0 97 A=
vg: =A0106 Max: =A0 =A0 335
> T:27 ( 3755) P:53 I:23500 C: =A0 4255 Min: =A0 =A0 =A03 Act: =A0 67 A=
vg: =A0 80 Max: =A0 =A0 244
> T:28 ( 3756) P:52 I:24000 C: =A0 4167 Min: =A0 =A0 =A03 Act: =A0 =A07=
 Avg: =A0 26 Max: =A0 =A0 232
> T:29 ( 3757) P:51 I:24500 C: =A0 4082 Min: =A0 =A0 =A03 Act: =A0 =A06=
 Avg: =A0 81 Max: =A0 =A0 353
> T:30 ( 3758) P:50 I:25000 C: =A0 4000 Min: =A0 =A0 =A03 Act: =A0 11 A=
vg: =A0 31 Max: =A0 =A0 418
> T:31 ( 3759) P:49 I:25500 C: =A0 3922 Min: =A0 =A0 =A03 Act: =A0 =A06=
 Avg: =A0 21 Max: =A0 =A0 433

Yeah, the numbers are a bit weird. I unfortunately choose odd hardware
to report numbers on, since it is known to have problems with -rt.
It was more a correctness test than an -rt performance test.
However, here are the numbers with 2.6.33.9-rt31 to compare and contras=
t.

uname -r
2.6.33.9-rt31-00001-g76582bb

sudo ./cyclictest -t32 -p 80 -n -i 10000 -l 10000
policy: fifo: loadavg: 0.10 0.31 0.15 1/543 3471

T: 0 ( 3440) P:80 I:10000 C:   5442 Min:      4 Act:   88 Avg:  138 Max=
:     486
T: 1 ( 3441) P:79 I:10500 C:   5183 Min:      6 Act:   70 Avg:  133 Max=
:     462
T: 2 ( 3442) P:78 I:11000 C:   4947 Min:      4 Act:   86 Avg:  127 Max=
:     399
T: 3 ( 3443) P:77 I:11500 C:   4732 Min:      5 Act:  120 Avg:  105 Max=
:     368
T: 4 ( 3444) P:76 I:12000 C:   4535 Min:      5 Act:   90 Avg:  126 Max=
:     424
T: 5 ( 3445) P:75 I:12500 C:   4354 Min:      4 Act:   89 Avg:  113 Max=
:     419
T: 6 ( 3446) P:74 I:13000 C:   4186 Min:      4 Act:   14 Avg:   89 Max=
:     428
T: 7 ( 3447) P:73 I:13500 C:   4031 Min:      3 Act:    9 Avg:   55 Max=
:     402
T: 8 ( 3448) P:72 I:14000 C:   3887 Min:      3 Act:   84 Avg:   65 Max=
:     375
T: 9 ( 3449) P:71 I:14500 C:   3753 Min:      4 Act:   68 Avg:  101 Max=
:     271
T:10 ( 3450) P:70 I:15000 C:   3628 Min:      3 Act:  130 Avg:   82 Max=
:     334
T:11 ( 3451) P:69 I:15500 C:   3511 Min:      3 Act:  110 Avg:   79 Max=
:     310
T:12 ( 3452) P:68 I:16000 C:   3401 Min:      3 Act:    9 Avg:   71 Max=
:     280
T:13 ( 3453) P:67 I:16500 C:   3298 Min:      3 Act:    7 Avg:   70 Max=
:     255
T:14 ( 3454) P:66 I:17000 C:   3201 Min:      5 Act:  112 Avg:   97 Max=
:     296
T:15 ( 3455) P:65 I:17500 C:   3110 Min:      4 Act:   69 Avg:   92 Max=
:     312
T:16 ( 3456) P:64 I:18000 C:   3023 Min:      4 Act:  138 Avg:   94 Max=
:     311
T:17 ( 3457) P:63 I:18500 C:   2942 Min:      4 Act:   86 Avg:  108 Max=
:     289
T:18 ( 3458) P:62 I:19000 C:   2864 Min:      3 Act:   15 Avg:   31 Max=
:     335
T:19 ( 3459) P:61 I:19500 C:   2791 Min:      4 Act:   71 Avg:   89 Max=
:     274
T:20 ( 3460) P:60 I:20000 C:   2721 Min:      4 Act:    8 Avg:   74 Max=
:     287
T:21 ( 3461) P:59 I:20500 C:   2655 Min:      3 Act:   68 Avg:   62 Max=
:     339
T:22 ( 3462) P:58 I:21000 C:  10000 Min:      3 Act:  186 Avg:   94 Max=
:     407
T:23 ( 3463) P:57 I:21500 C:  10000 Min:      3 Act:   93 Avg:   64 Max=
:     373
T:24 ( 3464) P:56 I:22000 C:  10000 Min:      4 Act:  132 Avg:   82 Max=
:     356
T:25 ( 3465) P:55 I:22500 C:  10000 Min:      3 Act:  133 Avg:   93 Max=
:     323
T:26 ( 3466) P:54 I:23000 C:  10000 Min:      3 Act:   97 Avg:   64 Max=
:     333
T:27 ( 3467) P:53 I:23500 C:  10000 Min:      3 Act:  134 Avg:   70 Max=
:     320
T:28 ( 3468) P:52 I:24000 C:  10000 Min:      3 Act:  123 Avg:   59 Max=
:     226
T:29 ( 3469) P:51 I:24500 C:  10000 Min:      3 Act:  143 Avg:   73 Max=
:     241
T:30 ( 3470) P:50 I:25000 C:  10000 Min:      3 Act:   15 Avg:   82 Max=
:     241
T:31 ( 3471) P:49 I:25500 C:  10000 Min:      3 Act:   10 Avg:   49 Max=
:     294
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
