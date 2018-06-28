From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH v4 1/2] timers: Don't wake ktimersoftd on every tick
Date: Thu, 28 Jun 2018 11:36:54 -0500
Message-ID: <7d21ff63-3dce-b8ea-a0f1-81d53617747d@ni.com>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20180306233944.11271-1-haris.okanovic@ni.com>
 <1523332961.4827.1.camel@gmx.de>
 <c2664fbe-52e7-1044-e9f9-de4875047ee8@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@bristot.me, hokanovi <haris.okanovic@ni.com>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c2664fbe-52e7-1044-e9f9-de4875047ee8@ni.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I found the problem: Running `dumpcap -D` (E.g. by wireshark) creates a 
timer that's sometimes re-armed with 0 timeout in it's callback function 
prb_retire_rx_blk_timer_expired(). My change introduced a subtle change 
in __run_timers()'s stop condition, which causes ktimersoftd to spin 
when such a timer is present. This blocks all other timers including 
those from workqueues.

ktimersoftd stack:
  __run_timers()
  [...]
  call_timer_fn()
  prb_retire_rx_blk_timer_expired()
  _prb_refresh_rx_retire_blk_timer()
  mod_timer(..., jiffies + 0)

The current implementation deals with this corner case by deferring 
0-timeout timers to the next tick, where they expires late. I'll submit 
a v5 shortly to match this behavior.

Thanks again for reporting this issue, Mike. It's a good find! And my 
apologies for the late fix. I've been busy the last few months.

-- Haris


On 04/12/2018 10:00 AM, Haris Okanovic wrote:
> Hi Mike,
> 
> I haven't tested the patch with wireshark until now. My system also 
> hangs shortly after it starts. I'm pretty sure I hit workqueues in my 
> earlier tests via the block driver, but it's clearly not whatever 
> wireshark is using. I'll look at it and try to post a fix. CCing the 
> list to avoid this patch until then.
> 
> Thanks,
> Haris
> 
> 
> On 04/09/2018 11:02 PM, Mike Galbraith wrote:
>> Hi,
>>
>> Are these patches dead, or are you planning another submission?  I ask
>> because I discovered that with them applied, firing up wireshark hangs
>> the box 100% repeatably, with wireshark never fully initializing.
>>
>> Applying them to an otherwise virgin 4.14.20-rt17 to be sure...
>>
>> crash> bt 6016PID: 6016   TASK: ffff95dd68572180  CPU: 2   COMMAND:
>> "dumpcap"
>>   #0 [ffffb490094f3bc0] __schedule at ffffffffa56d55b9
>>   #1 [ffffb490094f3c40] schedule at ffffffffa56d5a03
>>   #2 [ffffb490094f3c58] schedule_timeout at ffffffffa56d8467
>>   #3 [ffffb490094f3cd8] wait_for_completion at ffffffffa56d6e34
>>   #4 [ffffb490094f3d18] __wait_rcu_gp at ffffffffa50e59cd
>>   #5 [ffffb490094f3d58] synchronize_rcu at ffffffffa50ec14e
>>   #6 [ffffb490094f3d98] packet_set_ring at ffffffffc0c74da0 [af_packet]
>>   #7 [ffffb490094f3e50] packet_setsockopt at ffffffffc0c75d23 [af_packet]
>>   #8 [ffffb490094f3ef8] sys_setsockopt at ffffffffa558a5e2
>>   #9 [ffffb490094f3f30] do_syscall_64 at ffffffffa5001b05
>> #10 [ffffb490094f3f50] entry_SYSCALL_64_after_hwframe at ffffffffa5800065
>>      RIP: 00007f3107a1cfaa  RSP: 00007ffc9745c2e8  RFLAGS: 00000246
>>      RAX: ffffffffffffffda  RBX: 0000000000000001  RCX: 00007f3107a1cfaa
>>      RDX: 0000000000000005  RSI: 0000000000000107  RDI: 0000000000000003
>>      RBP: 000055ae1d8eb470   R8: 000000000000001c   R9: 0000000000000002
>>      R10: 00007ffc9745c350  R11: 0000000000000246  R12: 00007ffc9745c350
>>      R13: 0000000000000000  R14: 000055ae1d8eb200  R15: 000055ae1d8eb2d0
>>      ORIG_RAX: 0000000000000036  CS: 0033  SS: 002b
>> crash> dmesg
>> ...
>> [  483.808197] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0 
>> nice=0 stuck for 52s!
>> [  483.808204] Showing busy workqueues and worker pools:
>> [  483.808206] workqueue events: flags=0x0
>> [  483.808208]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
>> [  483.808211]     pending: check_corruption
>> [  492.695124] sysrq: SysRq : Trigger a crash
>>
