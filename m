From: Aaron Fabbri <ajfabbri@gmail.com>
Subject: Re: [patch] cyclictest: CPU affinity now takes arbitrary set of cpus.
Date: Thu, 12 Dec 2013 18:57:16 -0800
Message-ID: <CAF+KLxukz-0kTsORwGNd5uOqS2AOe_NpRpc2MZo-a-UUvCCnbw@mail.gmail.com>
References: <CAF+KLxtyOC7jWcnr1XoF6Su3LeywYpVq5Sac258mUJ9hGrEtKA@mail.gmail.com>
	<20131211153506.1e51328c@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:32874 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab3LMC5Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Dec 2013 21:57:16 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so1636939pde.20
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2013 18:57:16 -0800 (PST)
In-Reply-To: <20131211153506.1e51328c@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Dec 11, 2013 at 1:35 PM, Clark Williams
<clark.williams@gmail.com> wrote:
> On Thu, 5 Dec 2013 16:29:37 -0800
> Aaron Fabbri <ajfabbri@gmail.com> wrote:
>
>> [This patch is rebased on latest rt-tests.git, and is available in the
>> "delivery" branch at https://github.com/ajfabbri/af-rt-tests.git]
>>
>> Change -a (affinity) option to take a set of CPUs, instead of just one.
>>
>> e.g.
>>   cyclictest -a4,6-8 -t5
>>
>> will use 5 threads, assigned round-robin to the set of CPUs {4,6,7,8}.
>> CPU 4 will get threads 1 and 5, CPU 6 gets thread 2, CPU 7 gets thread 3, and
>> CPU 8 gets thread 4.
>>
>> Although this builds without libnuma,  libnuma >= v2 is required for these
>> arbitrary CPU sets.  With libnuma v1, the -a option behaves as before.  As
>> before, compiling without libnuma is supported. The command usage help is fixed
>> up at compile time to always show the correct usage of the -a option.
>>
>> Also note that, since numa_parse_cpustring_all() wasn't available in early
>> libnuma v2 versions, we use numa_parse_cpustring().  This means you'll have to
>> use taskset in some cases (isolcpus kernel parameter) to add the desired CPUs to
>> the set of allowed cores, e.g.:
>>
>>   taskset -c4-6 cyclictest -a4-6
>>
>> Tested without libnuma (numactl), and with versions 1.0.2 and 2.0.9-rc3.
>>
>> Signed-off-by: Aaron Fabbri <ajfabbri@gmail.com>
>
> Thanks, I cherry-picked the commit from your git tree (the included
> patch was too badly line-wrapped for me to use it). The only issue I've
> seen so far was that in display_help() your #endif picked up the -A
> option which is not dependent on libnuma behavior, so I fixed that up.

Ahh. Yes. Thanks for catching that.

> I'll do some testing and push a new rt-tests out soon.

Cool.

-AF
