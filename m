From: "Sydir, Jerry" <jerry.sydir@intel.com>
Subject: RE: problem in kzalloc or rt_spin_lock_fastlock?
Date: Tue, 14 Sep 2010 08:46:09 -0700
Message-ID: <8EA2C2C4116BF44AB370468FBF85A777017E5F8FDE@orsmsx504.amr.corp.intel.com>
References: <8EA2C2C4116BF44AB370468FBF85A7770179FAA964@orsmsx504.amr.corp.intel.com>
 <AANLkTinGVU28F_qoGmmJYW59c7buOVv2haOZf3VRYGdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Manikandan Ramachandran <crmanik@gmail.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23759 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491Ab0INPqM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 11:46:12 -0400
In-Reply-To: <AANLkTinGVU28F_qoGmmJYW59c7buOVv2haOZf3VRYGdb@mail.gmail.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



>-----Original Message-----
>From: Manikandan Ramachandran [mailto:crmanik@gmail.com]
>Sent: Friday, September 10, 2010 9:51 AM
>To: Sydir, Jerry
>Cc: linux-rt-users@vger.kernel.org
>Subject: Re: problem in kzalloc or rt_spin_lock_fastlock?
>
>i did come across this issue, in different context. I worked around
>this by not using kzalloc, instead by having static allocation.

I was able to cobble together a version of oprofile in which I have rep=
laced the calls to kzalloc/kfree with static allocations. Its not an el=
egant solution, but it seems to work.

I am still hoping that somebody can answer my question about whether th=
is is a real bug (a bug where things are really going wrong) or whether=
 might_sleep is being called unnecessarily. What would be the symptom i=
f the call to kzalloc (or kfree) did sleep? Would the system hang? Does=
 that fact that it makes it through the call without any apparent sympt=
oms besides the kernel oops mean that things are OK?

Jerry

>
>I guess this is one of the RT related changes to make atomic calls
>preemptible.
>
>HTH,
>Mani
>
>
>On Thu, Sep 9, 2010 at 2:28 PM, Sydir, Jerry <jerry.sydir@intel.com> w=
rote:
>> Hello all,
>>
>> I had posted a question a few weeks ago concerning problems with per=
f and
>oprofile when running on the 2.6.33.7-rt29 kernel. I received help on =
how
>to fix the problem with perf, but no replies about oprofile. Having lo=
oked
>into the oprofile problem more carefully, I have a more specific quest=
ion
>that I'm hoping somebody can answer.
>>
>>
>> Below is the stack trace that I received when starting the oprofile
>daemon. (It's the same trace that I included in my previous post). Fil=
ling
>in some of the macros and inlined functions the call sequence is as
>follows: Ppro_setup_cntrs calls kzalloc with the GFP_ATOMIC flag set.
>According to kmalloc documentation this means that the call should not
>sleep. Kmalloc calls kmem_cache_alloc_notrace, calls kmem_cache_alloc,
>calls __cache_alloc, calls _slab_irq_disable, calls get_cpu_val_locked=
 (a
>macro in which a call to rt_spin_lock is generated). Rt_spin_lock call=
s
>rt_spin_lock_fastlock which has the following code:
>>
>> =A0 /* Temporary HACK! */
>> 706 =A0 =A0 =A0 =A0 if (likely(!current->in_printk))
>> 707 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 might_sleep();
>> 708 =A0 =A0 =A0 =A0 else if (in_atomic() || irqs_disabled())
>> 709 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* don't grab locks for printk i=
n atomic */
>> 710 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> Might_sleep is called and the kernel notes this as an error. I'm gue=
ssing
>that since this call did not originate in printk, might_sleep is getti=
ng
>called.
>>
>> I have very little knowledge of the inner workings of the kernel, so=
 I
>don't know whether the error is with one of the functions in the call
>sequence, or with the check on line 706 which results in an unnecessar=
y
>call to might_sleep(). I have found that although the kernel reports a=
n
>oops, the oprofile daemon and the system seem to operate correctly. Ca=
n
>someone please confirm whether there is a real error here or whether t=
he
>problem is that might_sleep is being called unnecessarily in this case=
? Can
>I assume that all is well with oprofile and ignore the kernel oops?
>>
>> Thanks in advance for your help.
>> Jerry Sydir
>>
>>
>> oprofile: using NMI interrupt.
>> BUG: sleeping function called from invalid context at
>kernel/rtmutex.c:707
>> pcnt: 2 0 in_atomic(): 1, irqs_disabled(): 1, pid: 4020, name: oprof=
iled
>> Pid: 4020, comm: oprofiled Not tainted 2.6.33.7-rt29 #3
>> Call Trace:
>> [<c104e8c4>] ? rt_spin_lock_fastlock+0x26/0x58
>> [<c108ff56>] ? _slab_irq_disable+0x22/0x42
>> [<c109108a>] ? __kmalloc+0x7d/0xf0
>> [<e0071529>] ? ppro_setup_ctrs+0x29/0x1b8 [oprofile]
>> [<e0071529>] ? ppro_setup_ctrs+0x29/0x1b8 [oprofile]
>> [<e0070e8d>] ? nmi_cpu_setup+0x87/0xcc [oprofile]
>> [<e0070e06>] ? nmi_cpu_setup+0x0/0xcc [oprofile]
>> [<c102fa7b>] ? on_each_cpu+0x25/0x50
>> [<e0070dd9>] ? nmi_setup+0x11d/0x14a [oprofile]
>> [<e006f133>] ? oprofile_setup+0x2d/0x86 [oprofile]
>> [<e006fede>] ? event_buffer_open+0x42/0x60 [oprofile]
>> [<c109363d>] ? __dentry_open+0x1a4/0x29a
>> [<c109b09b>] ? generic_permission+0xc/0x7e
>> [<c10937c1>] ? nameidata_to_filp+0x27/0x38
>> [<e006fe9c>] ? event_buffer_open+0x0/0x60 [oprofile]
>> [<c109d214>] ? do_filp_open+0x439/0x843
>> [<c10808f6>] ? __do_fault+0x2bf/0x2ef
>> [<c1090091>] ? slab_irq_enable+0x45/0x79
>> [<c10933a2>] ? do_sys_open+0x4c/0xe4
>> [<c109347e>] ? sys_open+0x1e/0x23
>> [<c1002750>] ? sysenter_do_call+0x12/0x26
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
>--
>Thanks,
>Manik
>
>Think twice about a tree before you take a printout
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
