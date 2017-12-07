From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/5] perf-probe: Improve probing on versioned symbols
Date: Thu, 7 Dec 2017 10:13:28 +0530
Message-ID: <0db660f7-2211-39b0-7491-7fb3cc4fbb8f@linux.vnet.ibm.com>
References: <151252958056.12861.954203514347167563.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Clarke <pc@us.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752498AbdLGEmx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Dec 2017 23:42:53 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB74eQIW079233
        for <linux-rt-users@vger.kernel.org>; Wed, 6 Dec 2017 23:42:52 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2epvrmm40k-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Dec 2017 23:42:52 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <ravi.bangoria@linux.vnet.ibm.com>;
        Thu, 7 Dec 2017 04:42:51 -0000
In-Reply-To: <151252958056.12861.954203514347167563.stgit@devbox>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Masami,


On 12/06/2017 08:36 AM, Masami Hiramatsu wrote:
> [4/5] Find versioned symbol from map without wildcard.
>    This allows user to specify a symbol without version
>    suffix nor wildcard. Anyway, at this point we have
>    no way to specify version suffix, because parser
>    recognizes "@" is a separator of "function@file"
>    syntax. This is fixed in next patch.
> [5/5] Allow user to use backslash-escaped characters
>    on command line. This has 2 effects, user can specify
>    version suffix directly, and we can use special
>    characters in source file.

Just a thought. Will it be good to describe / illustrate this
in man page as well?

Thanks,
Ravi

