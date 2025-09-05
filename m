Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD111713
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Sep 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078607; cv=none; b=qi6Ula4qPVooZZxG3t9GeJUR2mGWuZFfrJnuAIy+yWm+qx1/ST0L+X1LfkgcoBObNdx0RRu1b1X0Y58CfqVnJWKa8eMMv7h0OXMavTTtiYJ+aU3VvWPGjpU2sh30VS2/o5eVjYbkoDeo7o6P6EBvw1aMICXi0bstKS6hL5wS9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078607; c=relaxed/simple;
	bh=MldiG4NSZxqWF9ncIRsagjaNM1QCIIWhSWthJF6wSwU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=orYCQcPou6/1ntoJkLEV2mUifD9qHjfNXGrBSicMJ7Xr/UVMSrIaIeHSFDpzBdHo4NxQTgcqI0VFJnjrH4aTauIeR/0WrZXLCzYSVNrfTkBP0Ep/w2dTyVcKq/nFCCc58kq6Ql5ZlNWZFG3JnBl938q0nKG/z9iaocbYbWLSQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=bJrzF+3b; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="bJrzF+3b"
Received: from [IPV6:2a01:e34:ec24:52e0:f5ae:e894:8298:679c] (unknown [IPv6:2a01:e34:ec24:52e0:f5ae:e894:8298:679c])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id E70F060147;
	Fri,  5 Sep 2025 15:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1757078601;
	bh=MldiG4NSZxqWF9ncIRsagjaNM1QCIIWhSWthJF6wSwU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=bJrzF+3bwY2TkLaYNfKz/jKRGqWQpTo6MJfbJ43FbMd7OwchDkyI7SrVgQT/mzhjC
	 AqDx87yKEdLO41yA7CfZx23hb5y8JzV26bu7OzZ9RJXva3kx1y6KHXXWfGvNdCbDVa
	 4X6b9fa3IzrgFzZR13GQk4mRi2UGWKTil3jU6FCjHHUi+GrgItf/RjqPUNAleJHKGB
	 jH0JpW18WcSX+fssr6cVhCJrDflHCVfUZGzuoWwTbw++xUJr+WURJRK/b/GJjhyFrR
	 r70/dRZnQpMjyxYax6YYW3/AmiBl2NF5Fzk3OcrBRjf51Nkal4gO0XNA0BBF5r5xOX
	 d8ajr241/UMDg==
Message-ID: <afc4c145-4758-4924-b106-e7844624d269@free.fr>
Date: Fri, 5 Sep 2025 15:23:09 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: Large(ish) variance induced by SCHED_FIFO
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Daniel Wagner <daniel.wagner@suse.com>, Clark Williams
 <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
 Luis Goncalves <lgoncalv@redhat.com>,
 John McCalpin <mccalpin@tacc.utexas.edu>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
Content-Language: en-US
In-Reply-To: <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello David :)

On 05/09/2025 10:25, Daniel Wagner wrote:

> On Fri, Sep 05, 2025 at 01:45:31AM +0200, Marc Gonzalez wrote:
>
>> Then I run this script as root:
>> #!/bin/bash
>>
>> CMD="taskset -c 1 ./a.out"
>> if [ "$1" = "fifo" ]; then CMD="chrt -f 99 $CMD"; fi
>>
>> for I in $(seq 1 30); do
>>   T0=$(date "+%s.%N")
>>   $CMD
>>   T1=$(date "+%s.%N")
>>   echo "$T1-$T0" | bc -l
>> done
> 
> This setup is forking processes in order to get timestamps. This
> gives you uncontrollable variance in the measurement. Use clock_gettime
> inside your test program.

I had already tested your suggestion, and observed it did not
make any difference. I will test again nonetheless.

(I used CLOCK_MONOTONIC_RAW.)

NB: if the large variance were induced by getting timestamps outside
the program, then SCHED_OTHER runs should be similarly impacted
(however, they are not).

> Also you might want to reduce the prio to 98.

May I ask why?

I'm guessing it's bad(TM) to potentially block the migration task?

I will lower the priority to 90.

Here is my current test code:

#include <stdio.h>
#include <time.h>
#define N (1 << 30)
#define G (1000*1000*1000L)
int main(void)
{
	struct timespec t0, t1;
	clock_gettime(CLOCK_MONOTONIC_RAW, &t0);
	for (volatile int i = 0; i < N; ++i);
	clock_gettime(CLOCK_MONOTONIC_RAW, &t1);
	long diff = (t1.tv_sec*G + t1.tv_nsec) - (t0.tv_sec*G + t0.tv_nsec);
	printf("%ld\n", diff);
	return 0;
}

associated script:

#!/bin/bash
CMD="taskset -c 1 ./a.out"
if [ "$1" = "fifo" ]; then CMD="chrt -f 90 $CMD"; fi
for I in $(seq 1 30); do $CMD; done


The results are the same as before:

SCHED_OTHER
MIN=2156085411 MAX=2156133420
All within 11 ppm of the average (EXCELLENT RESULTS)

SCHED_FIFO
MIN=2205859200 (first run again, how strange)
MAX=2304868902
All within 21950 ppm of the average (TERRIBLE RESULTS)
21950 ppm = 2.2%

Looking at the distribution of SCHED_FIFO again, I notice a pattern:
first run-time is the minimum outlier = 2.20 seconds
21 (again!!) results around 2.25 seconds
8 (again!!) results around 2.30 seconds

BRAIN DUMP:
"First" run is meaningless.
First since what? Previous batch of runs?
In that case, sleeping between runs should work around the issue?

It looks like there is some kind of 50 millisecond quantum
involved somewhere somehow.

$ grep HZ /boot/config-6.8.0-79-generic 
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000

(Not sure what it means to have CONFIG_NO_HZ_FULL && CONFIG_HZ_1000)

This is driving me crazy.
I'm all ears if anyone has other suggestions.

Regards


Raw results for reference:

SCHED_OTHER
2156120840
2156110092
2156111812
2156117629
2156111235
2156104159
2156109850
2156120644
2156100701
2156085456
2156133420
2156130993
2156087623
2156120236
2156114137
2156099823
2156122243
2156095888
2156114046
2156102910
2156120532
2156102464
2156100703
2156125228
2156119672
2156110619
2156131331
2156085411
2156098780
2156121458

SCHED_FIFO
2205859200
2254828687
2254866765
2304868902
2254849969
2253908545
2254811821
2304845457
2253814019
2254834900
2304858026
2254845905
2253835350
2254815775
2304860984
2253824572
2254816525
2254800880
2303875283
2254826189
2254813961
2304850479
2254832102
2253816865
2254820633
2304847552
2253841768
2254807812
2254810662
2303848123
