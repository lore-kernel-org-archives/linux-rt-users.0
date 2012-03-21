From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 3/3] rt-tests: Remove unused status variable
Date: Wed, 21 Mar 2012 07:45:24 -0700
Message-ID: <4F69E984.4010608@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com> <c85461ecd2a73b044d01ec1880e583764e28492a.1332270303.git.dvhart@linux.intel.com> <CAONaPpE-C4W3v1hazzr-gw=4BRCEVuF+5crJCY1gi6N+syxZ_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49852 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965179Ab2CUOqM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 10:46:12 -0400
In-Reply-To: <CAONaPpE-C4W3v1hazzr-gw=4BRCEVuF+5crJCY1gi6N+syxZ_w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/21/2012 06:35 AM, John Kacur wrote:
> On Tue, Mar 20, 2012 at 8:05 PM, Darren Hart <dvhart@linux.intel.com> wrote:
>> The status variable is not used. Remove it and avoid the warning from gcc.
>>
>> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
>> CC: Clark Williams <williams@redhat.com>
>> CC: John Kacur <jkacur@redhat.com>
>> ---
>>  src/pi_tests/pi_stress.c |    3 +--
>>  1 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
>> index 0940567..b89dec8 100644
>> --- a/src/pi_tests/pi_stress.c
>> +++ b/src/pi_tests/pi_stress.c
>> @@ -596,10 +596,9 @@ void *reporter(void *arg)
>>
>>  int verify_cpu(int cpu)
>>  {
>> -       int status;
>>        cpu_set_t mask;
>>
>> -       status = sched_getaffinity(0, sizeof(cpu_set_t), &mask);
>> +       sched_getaffinity(0, sizeof(cpu_set_t), &mask);
>>
>>        if (CPU_ISSET(cpu, &mask))
>>                return SUCCESS;
>> --
> 
> Don't you think it would be smarter to test the return status of
> sched_getaffinity, than to shut-up the warning by removing the status
> variable? I say we leave the variable in to remind us that we're not
> finished.
> 

My view was that rather than test status, we are testing the cpu mask
explicitly. That should pick up any error.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
