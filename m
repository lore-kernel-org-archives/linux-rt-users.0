Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:46832 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934393AbeFVUA5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jun 2018 16:00:57 -0400
References: <20180620132129.GA7983@amt.cnet>
From: Gratian Crisan <gratian.crisan@ni.com>
Subject: Re: [PATCH rt-tests] queuelat: fix get_cpuinfo_mhz.sh script on SMP systems
In-reply-to: <20180620132129.GA7983@amt.cnet>
Date: Fri, 22 Jun 2018 15:00:50 -0500
Message-ID: <87vaaad219.fsf@kerf.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org


Marcelo Tosatti writes:

> get_cpuinfo_mhz.sh fails on SMP systems because 
> /proc/cpuinfo returns multiple "cpu MHz" containing
> lines.
>
> Get only the first one.
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>
> diff --git a/src/queuelat/get_cpuinfo_mhz.sh b/src/queuelat/get_cpuinfo_mhz.sh
> index fb5158f..46f94c4 100755
> --- a/src/queuelat/get_cpuinfo_mhz.sh
> +++ b/src/queuelat/get_cpuinfo_mhz.sh
> @@ -1,5 +1,5 @@
>  #!/bin/bash
>  
> -mhz=`cat /proc/cpuinfo  | grep "cpu MHz" | uniq | cut -f 3 -d " "`
> +mhz=`cat /proc/cpuinfo  | grep "cpu MHz" | uniq | cut -f 3 -d " " | head -1`

Not sure how much it matters here but you can make this more compact by
using the '-m' grep option to stop the search after one match, something
like:

mhz = `cat /proc/cpuinfo  | grep -m 1 "cpu MHz" | cut -f 3 -d " "`

-Gratian
