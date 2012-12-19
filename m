From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: Real-time kernel thread performance and optimization
Date: Wed, 19 Dec 2012 09:10:35 +0100
Message-ID: <50D1767B.6070400@osadl.org>
References: <6b5093025753dbc76e1d23af7c999826@mail.gmail.com> <50B933A5.3020400@am.sony.com> <50BCB40E.9050304@osadl.org> <d63382c92165debf7dfcb7c5a6097ee6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: frank.rowand@am.sony.com, linux-rt-users@vger.kernel.org
To: Simon Falsig <simon@newtec.dk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:44119 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab2LSIUN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 03:20:13 -0500
In-Reply-To: <d63382c92165debf7dfcb7c5a6097ee6@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Simon,

>>>> [..]
>>>> Bonus-question:
>>>>    - Additionally, I've tried running cyclictest alongside with all
>>>> the above, and it actually performs rather well, without any
>>>> substantial spikes. A strange thing is though, that the results are
>>>> actually better with load than without? (running with -t1 -p 80 -n -i 10000 -l 10000)
>>>>    - Loaded: Min: 16, Avg: 41, Max: 177
>>>>    - No load: Min: 16, Avg: 97, Max: 263
>>>
>>> If the system is less loaded, then the idle thread might be able to
>>> enter deeper levels of sleep.  Deeper levels of sleep have larger
>>> latencies to exit.  You would have to look at your processor specific
>>> values for exiting sleep states to see if this is sufficient to
>>> explain the difference.
>> If running a half-decent version of cyclictest, sleep states are generally
>> disabled while cyclictest is running. Please watch the line
>>     # /dev/cpu_dma_latency set to 0us
>> which essentially documents this mechanism. Yes, the name of the variable
>> "cpu_dma_latency" is not obvious and cyclictest could do a better job by
>> writing
>>     Wrote 0 to /dev/cpu_dma_latency and keeping the path open to prevent
>>     all cores from entering any sleep state but this is another story.
>>
>> A patch that was merged to 3.7 allows to individually enable or disable sleep
>> states of the ladder governor
>> (http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=62d6ae880e3e76098d5e345decd2dce443975889).
>> It smoothly applies to 3.6-RT as well. This allows to fine-tune the sleep states
>> by state and core, while the /dev/cpu_dma_latency mechanism acts on all
>> states and cores, e.g. to disable sleep state 2 and all deeper states of the
>> ladder governor on core #0, use:
>>     echo 1>/sys/devices/system/cpu/cpu0/cpuidle/state2/disable
>>
>> BTW: To analyze how much time a core spent in a specific sleep state, simply
>> look repeatedly at the "time" variable of a core's sleep state, e.g. for core #0:
>> # for i in /sys/devices/system/cpu/cpu0/cpuidle/state[0-4]
>>   >  do
>>   >  echo -e "`cat $i/name`:\t`cat $i/time`"
>>   >  done
>> POLL:	1342984105
>> C1-IVB:	737109
>> C3-IVB:	3852451
>> C6-IVB:	1702683112
>> C7-IVB:	4366946606
>> While cyclictest is running with /dev/cpu_dma_latency set to 0, only the POLL
>> state times are increasing.
> Thanks for the reply! As I wrote in my reply to Frank, I'm not completely
> sure if P states are correctly implemented in our system. We're using a
> custom BIOS for our custom board, and while P states do show up and are
> modifiable (I've currently installed the userspace-governor, and am
> manually setting the clock-frequency to the lowest possible at startup),
> our board guy is not sure that changing it actually has any effect on the
> processor. Yay...:/
Sorry, but this is a complete misunderstanding. C states and P states 
are very different 
(http://software.intel.com/en-us/blogs/2008/03/12/c-states-and-p-states-are-very-different). 
The point made by Frank and my answer related to C states (aka sleep 
states) a processor may enter when idle. The Linux C state interface is 
called cpuidle. The P states you are referring to are related to the 
processor's clock frequency that may be lowered at any time irrespective 
of idle state. The Linux P state interface is called cpufreq. P states 
generally affect the real-time capabilities in a linear and proportional 
way, e.g. a CPU board with a worst-case latency of 100 microseconds at 1 
GHz will have a latency of approximately 200 microseconds at 500 MHz. 
When idle and in deep C state, however, the processor may take several 
milliseconds to wake up and answer an asynchronous external event. This 
is why deep C states should be disabled in a real-time system that may 
become idle. And this is why I mentioned the new interface that allows 
to individually disable a particular sleep state of a particular 
processor core to ensure its deterministic behavior while the other 
cores still may run in energy-saving mode.

Hope this helps,
Carsten.
