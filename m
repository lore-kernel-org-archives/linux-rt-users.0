From: David Sommerseth <davids@redhat.com>
Subject: Re: [PATCH 3/4] Added --help screen info about -M / --refresh-on-max
 in cyclictest
Date: Wed, 23 Dec 2009 10:09:53 +0100
Message-ID: <4B31DE61.1030602@redhat.com>
References: <1261496858-12744-1-git-send-email-davids@redhat.com> <1261496858-12744-4-git-send-email-davids@redhat.com> <alpine.LFD.2.00.0912222201120.8838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbZLWJJz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2009 04:09:55 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBN99tbb014665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2009 04:09:55 -0500
In-Reply-To: <alpine.LFD.2.00.0912222201120.8838@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/12/09 22:02, John Kacur wrote:
> 
> 
> On Tue, 22 Dec 2009, David Sommerseth wrote:
> 
>> Also renamed --refresh_on_max to --refresh-on-max
>>
>> Signed-off-by: David Sommerseth <davids@redhat.com>
>> ---
>>  src/cyclictest/cyclictest.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
>> index 223f343..7979a77 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -788,6 +788,7 @@ static void display_help(int error)
>>  	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
>>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
>>  	       "-m       --mlockall        lock current and future memory allocations\n"
>> +	       "-M       --refresh-on-max  delay updating the screen until a new max latency is hit\n"
>>  	       "-n       --nanosleep       use clock_nanosleep\n"
>>  	       "-N       --nsecs           print results in ns instead of us (default us)\n"
>>  	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
>> @@ -910,7 +911,7 @@ static void process_options (int argc, char *argv[])
>>  			{"irqsoff", no_argument, NULL, 'I'},
>>  			{"loops", required_argument, NULL, 'l'},
>>  			{"mlockall", no_argument, NULL, 'm' },
>> -			{"refresh_on_max", no_argument, NULL, 'M' },
>> +			{"refresh-on-max", no_argument, NULL, 'M' },
>>  			{"nanosleep", no_argument, NULL, 'n'},
>>  			{"nsecs", no_argument, NULL, 'N'},
>>  			{"oscope", required_argument, NULL, 'o'},
>> -- 
>> 1.6.2.5
>>
>>
> Hmnn, I'm not sure that I want to apply this one.
> What is the motifivation for changing the name to refresh-on-max?
> Right now refresh_on_max matches the global variable.

The motivation is only to be consistent with the argument handling in
the whole rt-tests suite.  The rt-migrate-test uses dash instead of
underscore (--run-time, --sleep-time).  And considering that this
feature is rather new (introduced in commit fc96b72126e79), I just
thought it would be better to change this as soon as possible, before it
is implemented in too many scripts.

However, this is more a cosmetic change than a feature.  I won't climb
the barricades fighting for this patch ;-)  It's only done to simplify
things for users, not needing to remember which arguments uses
underscore and which uses dash.


David S.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAksx3l8ACgkQIIWEatLf4Hd/QgCeMFG60Jk+92eilUicDhDPXhhL
erkAnjkLH5s9Cd6jDBBH0IY6qS9Zmu69
=xZgN
-----END PGP SIGNATURE-----
