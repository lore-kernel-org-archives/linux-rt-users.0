Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A289CC388F9
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 07:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FFF82071A
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 07:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507880AbgJ0HkM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:40:12 -0400
Received: from mx0b-00000d04.pphosted.com ([148.163.153.235]:18184 "EHLO
        mx0b-00000d04.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507876AbgJ0HkM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 03:40:12 -0400
X-Greylist: delayed 2766 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 03:40:10 EDT
Received: from pps.filterd (m0102896.ppops.net [127.0.0.1])
        by mx0a-00000d04.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09R6UidN025552;
        Mon, 26 Oct 2020 23:53:26 -0700
Received: from mx0a-00000d03.pphosted.com (mx0a-00000d03.pphosted.com [148.163.149.244])
        by mx0a-00000d04.pphosted.com with ESMTP id 34ch8yk8mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 23:53:26 -0700
Received: from pps.filterd (m0190089.ppops.net [127.0.0.1])
        by mx0a-00000d03.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09R6qADk028914;
        Mon, 26 Oct 2020 23:53:25 -0700
Received: from mx0b-00000d06.pphosted.com (mx0b-00000d06.pphosted.com [148.163.139.119])
        by mx0a-00000d03.pphosted.com with ESMTP id 34cjsn3xvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 23:53:25 -0700
Received: from pps.filterd (m0195433.ppops.net [127.0.0.1])
        by mx0a-00000d06.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09R6ZDke023945;
        Mon, 26 Oct 2020 23:53:24 -0700
Received: from smtp.stanford.edu (smtp5.stanford.edu [171.67.219.71])
        by mx0a-00000d06.pphosted.com with ESMTP id 34ch23u5rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 23:53:24 -0700
Received: from cm-mail.stanford.edu (cm-mail.stanford.edu [171.64.197.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 0D990142272;
        Mon, 26 Oct 2020 23:53:24 -0700 (PDT)
Received: from unknown54e1adf9a8e5.attlocal.net (c-67-161-27-134.hsd1.ca.comcast.net [67.161.27.134])
        (authenticated bits=0)
        by cm-mail.stanford.edu (8.14.4/8.14.4) with ESMTP id 09R6rK9X015023
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 26 Oct 2020 23:53:22 -0700
Cc:     nando@ccrma.Stanford.EDU, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt18
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <20201021131449.qlwjiq2l6embaii3@linutronix.de>
From:   Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Message-ID: <54d33ca5-107e-e269-8c47-a1ae0dc60b0e@ccrma.stanford.edu>
Date:   Mon, 26 Oct 2020 23:53:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021131449.qlwjiq2l6embaii3@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
x-proofpoint-stanford-dir: outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-27_03:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-27_03:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=100 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270043
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/21/20 6:14 AM, Sebastian Andrzej Siewior wrote:
> On 2020-10-21 14:53:27 [+0200], To Thomas Gleixner wrote:
>> Dear RT folks!
>>
>> I'm pleased to announce the v5.9.1-rt18 patch set.

Maybe I'm doing something wrong but I get a compilation error (see 
below) when trying to do a debug build (building rpm packages for 
Fedora). 5.9.1 + rt19...

Builds fine otherwise...
Thanks,
-- Fernando



+ make -s 'HOSTCFLAGS=-O2 -g -pipe -Wall -Werror=format-security 
-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions 
-fstack-protector-strong -grecord-gcc-switches 
-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 
-specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -fcommon -m64 
-mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection 
-fcf-protection' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now 
-specs=/usr/lib/rpm/redhat/redhat-hardened-ld' ARCH=x86_64 KCFLAGS= 
WITH_GCOV=0 -j4 modules
BUILDSTDERR: In file included from <command-line>:
BUILDSTDERR: lib/test_lockup.c: In function 'test_lockup_init':
BUILDSTDERR: lib/test_lockup.c:484:31: error: 'spinlock_t' {aka 'struct 
spinlock'} has no member named 'rlock'; did you mean 'lock'?
BUILDSTDERR:   484 |          offsetof(spinlock_t, rlock.magic),
BUILDSTDERR:       |                               ^~~~~
BUILDSTDERR: ././include/linux/compiler_types.h:135:57: note: in 
definition of macro '__compiler_offsetof'
BUILDSTDERR:   135 | #define __compiler_offsetof(a, b) 
__builtin_offsetof(a, b)
BUILDSTDERR:       | 
      ^
BUILDSTDERR: lib/test_lockup.c:484:10: note: in expansion of macro 
'offsetof'
BUILDSTDERR:   484 |          offsetof(spinlock_t, rlock.magic),
BUILDSTDERR:       |          ^~~~~~~~
BUILDSTDERR: ././include/linux/compiler_types.h:135:35: error: 
'rwlock_t' {aka 'struct rt_rw_lock'} has no member named 'magic'
BUILDSTDERR:   135 | #define __compiler_offsetof(a, b) 
__builtin_offsetof(a, b)
BUILDSTDERR:       |                                   ^~~~~~~~~~~~~~~~~~
BUILDSTDERR: ./include/linux/stddef.h:17:32: note: in expansion of macro 
'__compiler_offsetof'
BUILDSTDERR:    17 | #define offsetof(TYPE, MEMBER) 
__compiler_offsetof(TYPE, MEMBER)
BUILDSTDERR:       |                                ^~~~~~~~~~~~~~~~~~~
BUILDSTDERR: lib/test_lockup.c:487:10: note: in expansion of macro 
'offsetof'
BUILDSTDERR:   487 |          offsetof(rwlock_t, magic),
BUILDSTDERR:       |          ^~~~~~~~
BUILDSTDERR: lib/test_lockup.c:488:10: error: 'RWLOCK_MAGIC' undeclared 
(first use in this function); did you mean 'STACK_MAGIC'?
BUILDSTDERR:   488 |          RWLOCK_MAGIC) ||
BUILDSTDERR:       |          ^~~~~~~~~~~~
BUILDSTDERR:       |          STACK_MAGIC
BUILDSTDERR: lib/test_lockup.c:488:10: note: each undeclared identifier 
is reported only once for each function it appears in
BUILDSTDERR: In file included from <command-line>:
BUILDSTDERR: ././include/linux/compiler_types.h:135:35: error: 'struct 
mutex' has no member named 'wait_lock'
BUILDSTDERR:   135 | #define __compiler_offsetof(a, b) 
__builtin_offsetof(a, b)
BUILDSTDERR:       |                                   ^~~~~~~~~~~~~~~~~~
BUILDSTDERR: ./include/linux/stddef.h:17:32: note: in expansion of macro 
'__compiler_offsetof'
BUILDSTDERR:    17 | #define offsetof(TYPE, MEMBER) 
__compiler_offsetof(TYPE, MEMBER)
BUILDSTDERR:       |                                ^~~~~~~~~~~~~~~~~~~
BUILDSTDERR: lib/test_lockup.c:490:10: note: in expansion of macro 
'offsetof'
BUILDSTDERR:   490 |          offsetof(struct mutex, wait_lock.rlock.magic),
BUILDSTDERR:       |          ^~~~~~~~
BUILDSTDERR: ././include/linux/compiler_types.h:135:35: error: 'struct 
rw_semaphore' has no member named 'wait_lock'
BUILDSTDERR:   135 | #define __compiler_offsetof(a, b) 
__builtin_offsetof(a, b)
BUILDSTDERR:       |                                   ^~~~~~~~~~~~~~~~~~
BUILDSTDERR: ./include/linux/stddef.h:17:32: note: in expansion of macro 
'__compiler_offsetof'
BUILDSTDERR:    17 | #define offsetof(TYPE, MEMBER) 
__compiler_offsetof(TYPE, MEMBER)
BUILDSTDERR:       |                                ^~~~~~~~~~~~~~~~~~~
BUILDSTDERR: lib/test_lockup.c:493:10: note: in expansion of macro 
'offsetof'
BUILDSTDERR:   493 |          offsetof(struct rw_semaphore, 
wait_lock.magic),
BUILDSTDERR:       |          ^~~~~~~~
BUILDSTDERR: make[1]: *** [scripts/Makefile.build:283: 
lib/test_lockup.o] Error 1
BUILDSTDERR: make: *** [Makefile:1784: lib] Error 2
BUILDSTDERR: make: *** Waiting for unfinished jobs....



>>
>> Changes since v5.9.1-rt17:
>>
>>    - Update the migrate-disable series by Peter Zijlstra to v3. Include
>>      also fixes discussed in the thread.
>>
>>    - UP builds did not boot since the replace of the migrate-disable
>>      code. Reported by Christian Egger. Fixed as a part of v3 by Peter
>>      Zijlstra.
>>
>>    - Rebase the printk code on top of the ringer buffer designed for
>>      printk which was merged in the v5.10 merge window. Patches by John
>>      Ogness.
>>
>> Known issues
>>       - It has been pointed out that due to changes to the printk code the
>>         internal buffer representation changed. This is only an issue if tools
>>         like `crash' are used to extract the printk buffer from a kernel memory
>>         image.
>>
>> The delta patch against v5.9.1-rt17 is appended below and can be found here:
>>   
>>       https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9.1-rt17-rt18.patch.xz
>>
>> You can get this release via the git tree at:
>>
>>      git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9.1-rt18
>>
>> The RT patch against v5.9.1 can be found here:
>>
>>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9.1-rt18.patch.xz
>>
>> The split quilt queue is available at:
>>
>>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9.1-rt18.tar.xz
>>
> 
> The attached diff was too large and the mail was dropped. It is
> available at
> 	https://git.kernel.org/rt/linux-rt-devel/d/v5.9.1-rt18/v5.9.1-rt17
> 
> Sebastian
> 

