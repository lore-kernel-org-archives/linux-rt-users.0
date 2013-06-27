From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-next] kvm: don't try to take mmu_lock while holding the
 main raw kvm_lock
Date: Thu, 27 Jun 2013 15:01:29 +0200
Message-ID: <51CC37A9.4030506@redhat.com>
References: <1372199643-3936-1-git-send-email-paul.gortmaker@windriver.com> <20130627110911.GH18508@redhat.com> <51CC2435.7080204@redhat.com> <51CC2D07.8080105@siemens.com> <20130627123251.GO18508@redhat.com> <51CC3750.7070706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Gleb Natapov <gleb@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, mtosatti@redhat.com
To: unlisted-recipients:; (no To-header on input)
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <51CC3750.7070706@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Il 27/06/2013 15:00, Paolo Bonzini ha scritto:
> Il 27/06/2013 14:32, Gleb Natapov ha scritto:
>>>>>>>>>> In commit e935b8372cf8 ("KVM: Convert kvm_lock to raw_spinlock"),
>>>>>>>> I am copying Jan, the author of the patch. Commit message says:
>>>>>>>> "Code under this lock requires non-preemptibility", but which code
>>>>>>>> exactly is this? Is this still true?
>>>>>>
>>>>>> hardware_enable_nolock/hardware_disable_nolock does.
>>>>
>>>> IIRC, also the loop in kvmclock_cpufreq_notifier needs it because it
>>>> reads the processor ID of the caller. That implies the caller cannot be
>>>> preempted, but theses days a migration lock should be fine as well.
>>>>
>> OK, adding Marcelo to the party. This code is called from cpufreq
>> notifier. I would expect that it will be called from the context that
>> prevents migration to another cpu.
> 
> No, the CPU is in freq->cpu and may not even be the CPU that changed
> frequency.

Try again: "No, the CPU is in freq->cpu and smp_processor_id() may not
even be the CPU that changed frequency".  It probably makes more sense now.

Paolo

> But even then I'm not sure the loop needs to be non-preemptible.  If it
> were, the smp_call_function_single just before/after the loop would have
> to be non-preemptable as well.  So it is just an optimization and it can
> use raw_smp_processor_id() instead.
> 
> Paolo

