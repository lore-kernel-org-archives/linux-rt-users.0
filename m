Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from toro.web-alm.net ([62.245.132.31]:45474 "EHLO toro.web-alm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeFWNwy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Jun 2018 09:52:54 -0400
Subject: Re: [PATCH rt-tests] queuelat: fix get_cpuinfo_mhz.sh script on SMP
 systems
References: <20180620132129.GA7983@amt.cnet>
 <87vaaad219.fsf@kerf.amer.corp.natinst.com>
From: Carsten Emde <C.Emde@osadl.org>
Message-ID: <1b0ea84b-56d1-758b-c6c2-5e67582db134@osadl.org>
Date: Sat, 23 Jun 2018 15:24:35 +0200
MIME-Version: 1.0
In-Reply-To: <87vaaad219.fsf@kerf.amer.corp.natinst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Gratian Crisan <gratian.crisan@ni.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org

On 06/22/2018 10:00 PM, Gratian Crisan wrote:
> Marcelo Tosatti writes:
>> get_cpuinfo_mhz.sh fails on SMP systems because 
>> /proc/cpuinfo returns multiple "cpu MHz" containing
>> lines.
>>
>> Get only the first one.
>>
>> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>>
>> diff --git a/src/queuelat/get_cpuinfo_mhz.sh b/src/queuelat/get_cpuinfo_mhz.sh
>> index fb5158f..46f94c4 100755
>> --- a/src/queuelat/get_cpuinfo_mhz.sh
>> +++ b/src/queuelat/get_cpuinfo_mhz.sh
>> @@ -1,5 +1,5 @@
>>  #!/bin/bash
>>  
>> -mhz=`cat /proc/cpuinfo  | grep "cpu MHz" | uniq | cut -f 3 -d " "`
>> +mhz=`cat /proc/cpuinfo  | grep "cpu MHz" | uniq | cut -f 3 -d " " | head -1`
> 
> Not sure how much it matters here but you can make this more compact by
> using the '-m' grep option to stop the search after one match, something
> like:
> 
> mhz = `cat /proc/cpuinfo  | grep -m 1 "cpu MHz" | cut -f 3 -d " "`
Want to make it even shorter? Then skip the cat command and grep /proc/cpuinfo directly:
-mhz = `cat /proc/cpuinfo  | grep -m 1 "cpu MHz" | cut -f 3 -d " "
+mhz = `grep -m 1 "cpu MHz" /proc/cpuinfo | cut -f 3 -d " "`

	-Carsten
