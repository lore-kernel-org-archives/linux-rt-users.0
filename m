From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH v2 2/5] perf-probe: Cut off the version suffix from event
 name
Date: Thu, 7 Dec 2017 10:34:51 -0600
Message-ID: <dd7ab590-f5bc-e7bb-6807-210c099072fe@us.ibm.com>
References: <151263115609.13843.6362262297053841418.stgit@devbox>
 <151263122864.13843.10998234736675352577.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753308AbdLGQe7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Dec 2017 11:34:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB7GYl5g130293
        for <linux-rt-users@vger.kernel.org>; Thu, 7 Dec 2017 11:34:58 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eq6y7qxxg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Dec 2017 11:34:57 -0500
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 7 Dec 2017 09:34:56 -0700
In-Reply-To: <151263122864.13843.10998234736675352577.stgit@devbox>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 12/07/2017 01:20 AM, Masami Hiramatsu wrote:
> Cut off the version suffix (e.g. @GLIBC_2.2.5 etc.) from
> automatic generated event name. This fixes wildcard event
> adding like below case;
> 
>   =====
>   # perf probe -x /lib64/libc-2.25.so malloc*
>   Internal error: "malloc_get_state@GLIBC_2" is wrong event name.
>     Error: Failed to add events.
>   =====
> 
> This failure was caused by a versioned suffix symbol.
> With this fix, perf probe automatically cuts the
> suffix after @ as below.
> 
>   =====
>   # ./perf probe -x /lib64/libc-2.25.so malloc*
>   Added new events:
>     probe_libc:malloc_printerr (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_consolidate (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_check (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_hook_ini (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc    (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_trim (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_usable_size (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_stats (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_info (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:mallochook (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_get_state (on malloc* in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_set_state (on malloc* in /usr/lib64/libc-2.25.so)
> 
>   You can now use it in all perf tools, such as:
> 
> 	  perf record -e probe_libc:malloc_set_state -aR sleep 1
> 
>   =====

I think this will still fall over for a case where there are multiple versions of the same base symbol, like:

$ nm /lib64/libc.so.6 | egrep ' sched_getaffinity'
0000000000134430 T sched_getaffinity@GLIBC_2.3.3
00000000000dcf00 T sched_getaffinity@@GLIBC_2.3.4

Should we retain the versioning string in some form?  "sched_getaffinity--GLIBC_2.3.4"?  Should we instead interpret the '@' symbol more flexibly, so maybe first assume it is a version string, and if not found, try to see if it's a valid "@SRC" specification?

PC

