From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH v2 2/5] perf-probe: Cut off the version suffix from event
 name
Date: Thu, 7 Dec 2017 11:24:47 -0600
Message-ID: <8f1f552c-c5d0-40e3-14d9-96a4a38b33c6@us.ibm.com>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
 <151263122864.13843.10998234736675352577.stgit@devbox>
 <20171207165659.GD3173@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171207165659.GD3173@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 12/07/2017 10:56 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 07, 2017 at 04:20:28PM +0900, Masami Hiramatsu escreveu:
>> Cut off the version suffix (e.g. @GLIBC_2.2.5 etc.) from
>> automatic generated event name. This fixes wildcard event
>> adding like below case;
>>
>>   =====
>>   # perf probe -x /lib64/libc-2.25.so malloc*
>>   Internal error: "malloc_get_state@GLIBC_2" is wrong event name.
>>     Error: Failed to add events.
>>   =====
>>
>> This failure was caused by a versioned suffix symbol.
>> With this fix, perf probe automatically cuts the
>> suffix after @ as below.
>>
>>   =====
>>   # ./perf probe -x /lib64/libc-2.25.so malloc*
>>   Added new events:
>>     probe_libc:malloc_printerr (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc_consolidate (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc_check (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc_hook_ini (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc    (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc_trim (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc_usable_size (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc_stats (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc_info (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:mallochook (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc_get_state (on malloc* in /usr/lib64/libc-2.25.so)
>>     probe_libc:malloc_set_state (on malloc* in /usr/lib64/libc-2.25.so)
> 
> Thanks for working on this! I'm now going over it, and one thing I
> noticed was that the (on malloc*) on all the entries matched by that
> wildcard, can I suggest that you expand it there as well? I.e.
> 
>      probe_libc:malloc_set_state (on malloc_set_state in /usr/lib64/libc-2.25.so)
> 
> This way we'll now when aliases are used, and also for the versioning
> case, i.e. to which version is a probe pointing?
> 
> See also Paul Clarke's question and suggestion, which I agree, i.e.
> instead of chopping off the version, just replace the chars with valid
> ones or better, do what Paul suggests, be more flexible in interpreting
> @, i.e. if it is a number and/or fails to point to any file, interpret
> it as versioning.

It's a nit, and subjective, but I'd favor checking for versioning first, then file.  The namespaces are very unlikely to intersect, but I could foresee symbols like "sym@implA.c" and "sym@implB.c" more likely than a symbol in a file "GLIBC_2.2.5".

Perhaps straying toward bikeshedding...

PC
