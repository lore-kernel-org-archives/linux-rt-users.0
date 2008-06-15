From: "John Kacur" <jkacur@gmail.com>
Subject: Re: cyclictest -t NUM argument not honoured [PATCH]
Date: Sun, 15 Jun 2008 11:09:26 +0200
Message-ID: <520f0cf10806150209m79c0cf75g400fd55de5b8c333@mail.gmail.com>
References: <520f0cf10806150133h6ec838do1017f1800839fdd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:27459 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438AbYFOJJ1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Jun 2008 05:09:27 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3140259rvb.1
        for <linux-rt-users@vger.kernel.org>; Sun, 15 Jun 2008 02:09:26 -0700 (PDT)
In-Reply-To: <520f0cf10806150133h6ec838do1017f1800839fdd4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Jun 15, 2008 at 10:33 AM, John Kacur <jkacur@gmail.com> wrote:
> On Sat, Jun 14, 2008 at 1:40 AM, Leon Woestenberg
> <leon.woestenberg@gmail.com> wrote:
>>
>> Hello,
>>
>> I noticed many of my tests were bogus, as somehow my "-t NUM" argument
>> is not parsed properly on my target:
>>
>> Linux efika 2.6.25.4-rt6 #10 PREEMPT RT Thu Jun 12 00:34:11 CEST 2008
>> ppc unknown
>>
>> cyclictest 0.21 (with some extra argument printing added)
>>
>> root@efika:~# /cyclictest -t 2 -n -p 50
>
> -t takes an optional argument, that means it will only be parsed
> correctly if you write it together without a space with the t, that
> is, -t2
>
>> threads = 1
>> started with interval 1000
>>
>> T: 0 ( 1178) P:50 I:1000 C:    333 Min:     45 Act:   46 Avg:   49 Max:     100
>>
>> root@efika:~# /cyclictest -t2 -n -p 50
>
> Here you wrote it together and it was parsed properly.
>
>> threads = 2
>> started with interval 1000
>> started with interval 1500
>>
>> on my x86/32 system the same happens (with -t 4 it defaults to 2
>> because it's a dual-core, with -t4 it works).
>>
>> leon@witty:/tmp$ sudo ./cyclictest -t 4 -p 50
>
> Once again, here you wrote it with a space in-between so it is not
> honoured. -p 50 on the other hand is parsed correctly because it takes
> a non-optional argument.
>> threads = 2
>
> ---SNIP---
>>
>> At this moment I am puzzled, but I suspect the optional_argument handling.
>>
> I think you are right, it is just a puzzling thing about getopt since
> it parses non-optional arguments with or without a space, but optional
> arguments must be written without a space. Quoting from the manpage.
>
> Two colons mean an option takes an optional arg; if there  is  text  in
> the  current  argv-element  (i.e.,  in the same word as the option name
> itself, for example, "-oarg"), then it is returned in optarg, otherwise
> optarg is set to zero.
>
> However, if optarg is set to zero, we could still try to parse the
> next argument using the optind, so here is my attempt to do so, can
> you test it?
>
> Index: rt/rt-tests/src/cyclictest/cyclictest.c
> ===================================================================
> --- rt.orig/rt-tests/src/cyclictest/cyclictest.c        2008-06-04
> 17:30:07.000000000 +0200
> +++ rt/rt-tests/src/cyclictest/cyclictest.c     2008-06-15
> 10:28:39.000000000 +0200
> @@ -680,7 +680,8 @@
>                        if (optarg != NULL)
>                                num_threads = atoi(optarg);
>                        else
> -                               num_threads = max_cpus;
> +                               if (!(num_threads = atoi(argv[optind])))
> +                                       num_threads = max_cpus;
>                        break;
>                case 'v': verbose = 1; break;
>                case '?': error = 1; break;
>

Thinking just a bit more about this - I don't want to introduce a new
bug, if you put the -t option at the end without an argument, the
above patch could sigsegv, so the following patch is more robust,
hopefully production ready with the sign-off included

Index: rt/rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt.orig/rt-tests/src/cyclictest/cyclictest.c        2008-06-04
17:30:07.000000000 +0200
+++ rt/rt-tests/src/cyclictest/cyclictest.c     2008-06-15
11:06:34.000000000 +0200
@@ -677,11 +677,13 @@
                case 'r': timermode = TIMER_RELTIME; break;
                case 's': use_system = MODE_SYS_OFFSET; break;
                case 't':
-                       if (optarg != NULL)
-                               num_threads = atoi(optarg);
-                       else
-                               num_threads = max_cpus;
-                       break;
+                         if (optarg != NULL)
+                                 num_threads = atoi(optarg);
+                         else if (argv[optind] && atoi(argv[optind]))
+                                 num_threads = atoi(argv[optind]);
+                         else
+                                 num_threads = max_cpus;
+                         break;
                case 'v': verbose = 1; break;
                case '?': error = 1; break;
                }

Signed-off-by: John Kacur <jkacur@gmail.com>
