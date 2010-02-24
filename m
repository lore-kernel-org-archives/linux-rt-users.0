From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] KVM: x86: Kick VCPU outside PIC lock again
Date: Wed, 24 Feb 2010 12:04:31 +0200
Message-ID: <4B84F9AF.8060804@redhat.com>
References: <20100217135901.331576359@linutronix.de> <4B842A1F.50601@siemens.com> <alpine.LFD.2.00.1002232321320.3232@localhost.localdomain> <4B84F466.2080009@siemens.com> <4B84F5D4.5020202@redhat.com> <4B84F765.5040209@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, KVM <kvm@vger.kernel.org>,
	Gleb Natapov <gleb@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B84F765.5040209@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/24/2010 11:54 AM, Jan Kiszka wrote:
> Avi Kivity wrote:
>    
>> On 02/24/2010 11:41 AM, Jan Kiszka wrote:
>>      
>>> Thomas Gleixner wrote:
>>>
>>>        
>>>> On Tue, 23 Feb 2010, Jan Kiszka wrote:
>>>>
>>>>
>>>>          
>>>>> Thomas Gleixner wrote:
>>>>>
>>>>>            
>>>>>> The i8254/i8259 locks need to be real spinlocks on preempt-rt. Convert
>>>>>> them to raw_spinlock. No change for !RT kernels.
>>>>>>
>>>>>>              
>>>>> Doesn't fly for -rt anymore: pic_irq_update runs under this raw lock and
>>>>> calls kvm_vcpu_kick which tries to wake_up some thread ->   scheduling
>>>>> while atomic.
>>>>>
>>>>>            
>>>> Hmm, a wakeup itself is fine. Is that code waking a wake queue ?
>>>>
>>>>          
>>> Yes, it's a wake queue.
>>>
>>>        
>> So what's the core issue?  Is the lock_t in the wait_queue a sleeping mutex?
>>      
> Yep.
>    

I see.  Won't we hit the same issue when we call pic functions from 
atomic context during the guest entry sequence?

-- 
error compiling committee.c: too many arguments to function
