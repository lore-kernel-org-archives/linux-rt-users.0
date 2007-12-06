From: "Phil K." <binutz@gmail.com>
Subject: Re: Problems with cyclictest and ps
Date: Thu, 06 Dec 2007 11:19:36 +0100
Message-ID: <4757CCB8.6090107@gmail.com>
References: <47570B50.9060502@gmail.com> <47571828.6000406@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "K.R. Foley" <kr@cybsft.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:57846 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbXLFKVy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 6 Dec 2007 05:21:54 -0500
Received: by nf-out-0910.google.com with SMTP id g13so58776nfb
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Dec 2007 02:21:52 -0800 (PST)
In-Reply-To: <47571828.6000406@cybsft.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

K.R. Foley wrote:
> Phil K. wrote:
>> Hi,
>>
>> I tried cyclictest under Debian Lenny with Kernel-2.6.23.8-hrt3 and
>> Kernel-2.6.22 as user root. As decribed on the cyclictest-wikipage all
>> cyclictest-tasks run with the scheduler class SCHED_FIFO. I controlled
>> the scheduler class with "ps -ce" and ps showed me SCHED_OTHER for the
>> cyclictest-task.
>>
>> #> ./cyclictest -t 1 -p 80 -n -i 10000
>>
>> #> ps -ce | grep cyclic
>>    PID CLS PRI TTY          TIME CMD
>>   9693 TS   19 pts/5    00:00:00 cyclictest
>>
>> I am wondering why cyclictest runs as SCHED_OTHER I expected SCHED_FIFO
>> instead. Any explanations of this behavior are welcome.
>>
>> Regards,
>>
>> Phil
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> try "ps -eLc | grep cyclic"
> 
> Without the "L" you don't see threads/lightweight processes.
> 

Thanks for the solution, I have postet this on the RTWiki
(http://rt.wiki.kernel.org/index.php/Cyclictest#FAQ).

Greetings,

Phil
