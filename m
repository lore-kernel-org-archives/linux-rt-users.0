From: Paul Clarke <pc@us.ibm.com>
Subject: Re: uprobes enable condition (user space) - sysfs interface
Date: Tue, 5 Dec 2017 07:58:34 -0600
Message-ID: <bace0c39-894c-7c68-cc3b-6646938d1a47@us.ibm.com>
References: <CA+bpL9+McSzeKW+eXHfMJMFRm-EenC9_0pGZkGpSdFzOVozKiw@mail.gmail.com>
 <20171201164039.GC3298@kernel.org>
 <20171204213619.973d74567a7de0af15876aac@kernel.org>
 <20171204145558.GA27554@kernel.org>
 <5246be84-1fb5-c1d7-130f-b990b3bac471@us.ibm.com>
 <20171205164547.144c51e493a05b61907dda01@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750810AbdLEN6m (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Dec 2017 08:58:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB5DueXg104285
        for <linux-rt-users@vger.kernel.org>; Tue, 5 Dec 2017 08:58:41 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2envgp8y6c-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Dec 2017 08:58:41 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <pc@us.ibm.com>;
        Tue, 5 Dec 2017 06:58:40 -0700
In-Reply-To: <20171205164547.144c51e493a05b61907dda01@kernel.org>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/05/2017 01:45 AM, Masami Hiramatsu wrote:
> On Mon, 4 Dec 2017 09:23:16 -0600
> Paul Clarke <pc@us.ibm.com> wrote:
>> On 12/04/2017 08:55 AM, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Dec 04, 2017 at 09:36:19PM +0900, Masami Hiramatsu escreveu:
>>>> On Fri, 1 Dec 2017 13:40:39 -0300
>>>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>
>>>>> Adding Masami to the CC list, to see if he can come up with a fix for
>>>>> the 'perf probe' failure below, improving the message or ignoring
>>>>> versioned symbols (with a warning perhaps).
>>>>
>>>> Thanks. Should we ignore the versioned symbols? or can we put a probe
>>>> on that? If we have symbol address, we can put a probe on it, even
>>>> if it is versioned.
>>>
>>> Lemme try...
>>>
>>> [root@jouet ~]# perf probe -x /usr/lib64/libc-2.25.so malloc_get_state_225=malloc_get_state@GLIBC_2.2.5
>>> The /usr/lib64/libc-2.25.so file has no debug information.
>>> Rebuild with -g, or install an appropriate debuginfo package.
>>>   Error: Failed to add events.
>>> [root@jouet ~]# perf probe -x /usr/lib64/libc-2.25.so malloc_get_state@GLIBC_2.2.5
>>> The /usr/lib64/libc-2.25.so file has no debug information.
>>> Rebuild with -g, or install an appropriate debuginfo package.
>>>   Error: Failed to add events.
>>
>> commit d80406453ad4a69932dc17a617d5b7bc7ae80b8f should have allowed adding probes on versioned symbols if you omit the versioning part of the symbol.  So, in the above example, this should work:
>>
>> # perf probe -x /usr/lib64/libc-2.25.so malloc_get_state
> 
> No, it doesn't, the above commit improves *find_symbol_by_name(),
> but perf probe uses its own lookup function, because it has to
> support glob pattern matching.

That commit was explicitly to allow perf probe on versioned symbols.  However, it was limited to creating probes on _default_ versioned symbols (marked by '@@").  So, you're correct that it would not work on this symbol in particular.

The value of the commit was to prevent something like the following from failing, even though the symbol existed, but was versioned (presuming one of the versions of the symbol was marked as default ('@@')):

# perf probe perf probe -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create

PC

