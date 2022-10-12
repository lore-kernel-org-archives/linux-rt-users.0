Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828C4C4332F
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Oct 2022 23:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJLX0D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Oct 2022 19:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiJLXZz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Oct 2022 19:25:55 -0400
Received: from smtp.centurylink.net (mail.onyx.syn-alias.com [206.152.134.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507161285F1
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Oct 2022 16:25:52 -0700 (PDT)
Feedback-ID: dfw:ctl:res:onyx
X-Authed-Username: aGlnaGxhYkBxLmNvbQ==
X-Rcptto: linux-rt-users@vger.kernel.org
Authentication-Results:  smtp02.onyx.dfw.sync.lan smtp.user=highlab@q.com; auth=pass (LOGIN)
Received: from [174.16.217.19] ([174.16.217.19:37609] helo=bifrost)
        by smtp.centurylink.net (envelope-from <seb@highlab.com>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPSA (cipher=AES256-GCM-SHA384) 
        id 5A/41-31802-00D47436; Wed, 12 Oct 2022 19:25:52 -0400
Received: from openwrt.lan ([10.0.0.1]:41266 helo=[10.0.0.109])
        by bifrost with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <seb@highlab.com>)
        id 1oil6l-007hGz-AU
        for linux-rt-users@vger.kernel.org; Wed, 12 Oct 2022 17:25:51 -0600
Message-ID: <adfcede2-0da1-233d-09d7-004688e39178@highlab.com>
Date:   Wed, 12 Oct 2022 17:25:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: SCHED_OTHER > SCHED_FIFO?
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
References: <ea166a37-09c2-04ab-fda8-98a6b29608ab@highlab.com>
 <CAMLffL-Zr6aj6LojpbKfHEHjV=y=P3dRhBL4=Fh0+X-SKFg-UQ@mail.gmail.com>
From:   Sebastian Kuzminsky <seb@highlab.com>
In-Reply-To: <CAMLffL-Zr6aj6LojpbKfHEHjV=y=P3dRhBL4=Fh0+X-SKFg-UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejledgvddvucetufdoteggodetrfdotffvucfrrhho
X-Vade-Analysis-2: fhhilhgvmecuufgjpfetvefqtfdpvefvnfdpgffpggdqvefvnfdpqfgfvfenuceurghilhhouhhtmecu
X-Vade-Analysis-3: fedtudenucenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefuvggs
X-Vade-Analysis-4: rghsthhirghnucfmuhiimhhinhhskhihuceoshgvsgeshhhighhhlhgrsgdrtghomheqnecuggftrfgr
X-Vade-Analysis-5: thhtvghrnhepteeiffeigeejheevffeitdekledukeeflefgveejkeeggeejgeegledutdejueefnecu
X-Vade-Analysis-6: ffhomhgrihhnpeguvggsihgrnhdrnhgvthdpghhithhhuhgsrdgtohhmnecukfhppedujeegrdduiedr
X-Vade-Analysis-7: vddujedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudejgedrudei
X-Vade-Analysis-8: rddvudejrdduledphhgvlhhopegsihhfrhhoshhtpdhmrghilhhfrhhomhepshgvsgeshhhighhhlhgr
X-Vade-Analysis-9: sgdrtghomhdprhgtphhtthhopehlihhnuhigqdhrthdquhhsvghrshesvhhgvghrrdhkvghrnhgvlhdr
X-Vade-Analysis-10: ohhrghdpmhhtrghhohhsthepshhmthhptddvrdhonhihgidrughffidrshihnhgtrdhlrghnpdhnsggp
X-Vade-Analysis-11: rhgtphhtthhopedupdhishgpnhgrpehtrhhuvgdprghuthhhpghushgvrhephhhighhhlhgrsgesqhdr
X-Vade-Analysis-12: tghomh
X-Vade-Client: CTL
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thanks for the suggestion, but it gives results that are only slightly 
better:

> using PTHREAD_EXPLICT_SCHED to set SCHED_FIFO (with highest priority)
> scheduling policy: SCHED_FIFO
> scheduling parameter priority: 2 (min=1, max=99)
> cpu affinity: 3
> after 10000 iterations:
>     min=54001 cycles (1000.019 us, 1.000 ms)
>     avg=61990.288 cycles (1147.968 us, 1.148 ms)
>     max=21197391 cycles (392544.278 us, 392.544 ms)
> ERROR: worst latency > 2 ms

-- 
Sebastian Kuzminsky


On 10/12/22 17:14, Clark Williams wrote:
> It's never a good idea to use fifo:99 for a realtime application; the
> migration thread uses fifo:99 and all the interrupt threads run at
> fifo:50, so your busy-wait fifo:99 thread is holding off interrupts
> (devices, IPIs, etc) on tho
> 
> Try running your SCHED_FIFO thread at something like fifo:2 and see if
> your performance improves.
> 
> Clark
> 
> On Wed, Oct 12, 2022 at 9:35 PM Sebastian Kuzminsky <seb@highlab.com> wrote:
>>
>> Hi folks, I'm seeing a behavior I don't understand, that I'm hoping you
>> can help me with.
>>
>> The setup is:
>>       Raspberry Pi 4 (4x ARMv8 Cortex-A72)
>>       Debian Bookworm arm64 (https://raspi.debian.net/tested-images/)
>>       Linux 5.19.14 with 5.19-rt10 patches (config in git repo below)
>>       cmdline:
>>          irqaffinity=0-1
>>          rcu_nocbs=2-3
>>          rcu_nocb_poll
>>          nohz_full=2-3
>>          isolcpus=nohz,domain,managed_irq,2-3
>>
>> On this system I run a realtime thread that does all the
>> latency-reducing tricks I know of:
>>       kernel command line as specified above
>>       cpufreq scaling governor = performance
>>       mlockall()
>>       set cpu affinity to an isolcpu processor
>>       run in userspace continuously, never sleep or yield the cpu
>>
>> The surprising behavior is that if I set the realtime thread to use
>> scheduling policy SCHED_FIFO, and set its priority to the max, i get
>> terrible behavior - lots of preemption, and lots of idle time on the
>> CPU.  On the other hand, if I leave the realtime thread with scheduling
>> policy SCHED_OTHER, and the default priority of 0, then the system
>> performs great - hardly any preemption.
>>
>> The test program is here:
>>       https://github.com/SebKuzminsky/preempt-rt-latency-test
>>
>> That program does the process-wide realtime setup, then runs a realtime
>> thread with SCHED_OTHER (which performs well), joins that thread and
>> instead runs a second thread with SCHED_FIFO (which performs poorly).
>> It doesn't matter which order I run the threads in, SCHED_FIFO first
>> still performs poorly.  Both threads run the same function:
>>       busywait 1 ms (using the hardware cycle counter for timing)
>>       check the cycle count
>>       repeat 10k times
>>       return
>>
>> So it doesn't do anything useful, it just looks for latency.
>>
>> The results look like this:
>>
>>> using PTHREAD_INHERIT_SCHED to keep SCHED_OTHER (with default priority)
>>> scheduling policy: SCHED_OTHER
>>> scheduling parameter priority: 0 (min=0, max=0)
>>> cpu affinity: 3
>>> after 10000 iterations:
>>>      min=54001 cycles (1000.019 us, 1.000 ms)
>>>      avg=54002.001 cycles (1000.037 us, 1.000 ms)
>>>      max=54009 cycles (1000.167 us, 1.000 ms)
>>> OK: worst latency < 2 ms
>>>
>>> using PTHREAD_EXPLICT_SCHED to set SCHED_FIFO (with highest priority)
>>> scheduling policy: SCHED_FIFO
>>> scheduling parameter priority: 99 (min=1, max=99)
>>> cpu affinity: 3
>>> after 10000 iterations:
>>>      min=54001 cycles (1000.019 us, 1.000 ms)
>>>      avg=78900.171 cycles (1461.114 us, 1.461 ms)
>>>      max=53188533 cycles (984972.833 us, 984.973 ms)
>>> ERROR: worst latency > 2 ms
>>
>> The results with SCHED_OTHER are great, but the results with SCHED_FIFO
>> are terrible.  This is surprising to me!  I'd expect a thread using
>> SCHED_FIFO with max priority to behave at least as well as a thread
>> using SCHED_OTHER with the default priority.  Am I misunderstanding
>> something here, or is this a bug?
>>
>> I'm happy to run any experiments people suggest.
>>
>>
>> --
>> Sebastian Kuzminsky
>>
> 
