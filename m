From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 2/3] rt-tests: Silence unused-but-set warning in rt-migrate-test
Date: Wed, 21 Mar 2012 07:44:16 -0700
Message-ID: <4F69E940.9060808@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>  <b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com> <1332338731.23924.40.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11110 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757634Ab2CUOpB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 10:45:01 -0400
In-Reply-To: <1332338731.23924.40.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/21/2012 07:05 AM, Steven Rostedt wrote:
> On Tue, 2012-03-20 at 12:05 -0700, Darren Hart wrote:
> 
>> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
>> index 1963641..d2ac400 100644
>> --- a/src/rt-migrate-test/rt-migrate-test.c
>> +++ b/src/rt-migrate-test/rt-migrate-test.c
>> @@ -532,7 +532,7 @@ int main (int argc, char **argv)
>>  	logdev_switch_set(1);
>>  
>>  	for (loop=0; loop < nr_runs; loop++) {
>> -		unsigned long long end;
>> +		unsigned long long __attribute__ ((unused)) end;
> 
> I don't like this. It seems to be a gcc bug. What version of gcc is
> this?
> 

gcc (GCC) 4.6.1 20110908 (Red Hat 4.6.1-9)

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
