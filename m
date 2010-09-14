From: Manikandan Ramachandran <crmanik@gmail.com>
Subject: Re: problem in kzalloc or rt_spin_lock_fastlock?
Date: Tue, 14 Sep 2010 09:33:27 -0700
Message-ID: <AANLkTimFrX+OdiF3cbmO8DB09Ux9aBxESckFdBNYTFLE@mail.gmail.com>
References: <8EA2C2C4116BF44AB370468FBF85A7770179FAA964@orsmsx504.amr.corp.intel.com>
	<AANLkTinGVU28F_qoGmmJYW59c7buOVv2haOZf3VRYGdb@mail.gmail.com>
	<8EA2C2C4116BF44AB370468FBF85A777017E5F8FDE@orsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Sydir, Jerry" <jerry.sydir@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45581 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab0INQd3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 12:33:29 -0400
Received: by wyf22 with SMTP id 22so7600357wyf.19
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 09:33:28 -0700 (PDT)
In-Reply-To: <8EA2C2C4116BF44AB370468FBF85A777017E5F8FDE@orsmsx504.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

My understanding is that sleep in kzalloc is intended change to be in
align with RT philosophy, that is preempt if possible.

I believe that, oprofile should be changed to accomdate this behaviour.

On Tue, Sep 14, 2010 at 8:46 AM, Sydir, Jerry <jerry.sydir@intel.com> w=
rote:
>
>
>>-----Original Message-----
>>From: Manikandan Ramachandran [mailto:crmanik@gmail.com]
>>Sent: Friday, September 10, 2010 9:51 AM
>>To: Sydir, Jerry
>>Cc: linux-rt-users@vger.kernel.org
>>Subject: Re: problem in kzalloc or rt_spin_lock_fastlock?
>>
>>i did come across this issue, in different context. I worked around
>>this by not using kzalloc, instead by having static allocation.
>
> I was able to cobble together a version of oprofile in which I have r=
eplaced the calls to kzalloc/kfree with static allocations. Its not an =
elegant solution, but it seems to work.
>
> I am still hoping that somebody can answer my question about whether =
this is a real bug (a bug where things are really going wrong) or wheth=
er might_sleep is being called unnecessarily. What would be the symptom=
 if the call to kzalloc (or kfree) did sleep? Would the system hang? Do=
es that fact that it makes it through the call without any apparent sym=
ptoms besides the kernel oops mean that things are OK?
>
> Jerry
>
>>
>>I guess this is one of the RT related changes to make atomic calls
>>preemptible.
>>
>>HTH,
>>Mani
>>
>>
>>On Thu, Sep 9, 2010 at 2:28 PM, Sydir, Jerry <jerry.sydir@intel.com> =
wrote:
>>> Hello all,
>>>
>>> I had posted a question a few weeks ago concerning problems with pe=
rf and
>>oprofile when running on the 2.6.33.7-rt29 kernel. I received help on=
 how
>>to fix the problem with perf, but no replies about oprofile. Having l=
ooked
>>into the oprofile problem more carefully, I have a more specific ques=
tion
>>that I'm hoping somebody can answer.
>>>
>>>
>>> Below is the stack trace that I received when starting the oprofile
>>daemon. (It's the same trace that I included in my previous post). Fi=
lling
>>in some of the macros and inlined functions the call sequence is as
>>follows: Ppro_setup_cntrs calls kzalloc with the GFP_ATOMIC flag set.
>>According to kmalloc documentation this means that the call should no=
t
>>sleep. Kmalloc calls kmem_cache_alloc_notrace, calls kmem_cache_alloc=
,
>>calls __cache_alloc, calls _slab_irq_disable, calls get_cpu_val_locke=
d (a
>>macro in which a call to rt_spin_lock is generated). Rt_spin_lock cal=
ls
>>rt_spin_lock_fastlock which has the following code:
>>>
>>> =A0 /* Temporary HACK! */
>>> 706 =A0 =A0 =A0 =A0 if (likely(!current->in_printk))
>>> 707 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 might_sleep();
>>> 708 =A0 =A0 =A0 =A0 else if (in_atomic() || irqs_disabled())
>>> 709 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* don't grab locks for printk =
in atomic */
>>> 710 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>
>>> Might_sleep is called and the kernel notes this as an error. I'm gu=
essing
>>that since this call did not originate in printk, might_sleep is gett=
ing
>>called.
>>>
>>> I have very little knowledge of the inner workings of the kernel, s=
o I
>>don't know whether the error is with one of the functions in the call
>>sequence, or with the check on line 706 which results in an unnecessa=
ry
>>call to might_sleep(). I have found that although the kernel reports =
an
>>oops, the oprofile daemon and the system seem to operate correctly. C=
an
>>someone please confirm whether there is a real error here or whether =
the
>>problem is that might_sleep is being called unnecessarily in this cas=
e? Can
>>I assume that all is well with oprofile and ignore the kernel oops?
>>>
>>> Thanks in advance for your help.
>>> Jerry Sydir
>>>
>>>
>>> oprofile: using NMI interrupt.
>>> BUG: sleeping function called from invalid context at
>>kernel/rtmutex.c:707
>>> pcnt: 2 0 in_atomic(): 1, irqs_disabled(): 1, pid: 4020, name: opro=
filed
>>> Pid: 4020, comm: oprofiled Not tainted 2.6.33.7-rt29 #3
>>> Call Trace:
>>> [<c104e8c4>] ? rt_spin_lock_fastlock+0x26/0x58
>>> [<c108ff56>] ? _slab_irq_disable+0x22/0x42
>>> [<c109108a>] ? __kmalloc+0x7d/0xf0
>>> [<e0071529>] ? ppro_setup_ctrs+0x29/0x1b8 [oprofile]
>>> [<e0071529>] ? ppro_setup_ctrs+0x29/0x1b8 [oprofile]
>>> [<e0070e8d>] ? nmi_cpu_setup+0x87/0xcc [oprofile]
>>> [<e0070e06>] ? nmi_cpu_setup+0x0/0xcc [oprofile]
>>> [<c102fa7b>] ? on_each_cpu+0x25/0x50
>>> [<e0070dd9>] ? nmi_setup+0x11d/0x14a [oprofile]
>>> [<e006f133>] ? oprofile_setup+0x2d/0x86 [oprofile]
>>> [<e006fede>] ? event_buffer_open+0x42/0x60 [oprofile]
>>> [<c109363d>] ? __dentry_open+0x1a4/0x29a
>>> [<c109b09b>] ? generic_permission+0xc/0x7e
>>> [<c10937c1>] ? nameidata_to_filp+0x27/0x38
>>> [<e006fe9c>] ? event_buffer_open+0x0/0x60 [oprofile]
>>> [<c109d214>] ? do_filp_open+0x439/0x843
>>> [<c10808f6>] ? __do_fault+0x2bf/0x2ef
>>> [<c1090091>] ? slab_irq_enable+0x45/0x79
>>> [<c10933a2>] ? do_sys_open+0x4c/0xe4
>>> [<c109347e>] ? sys_open+0x1e/0x23
>>> [<c1002750>] ? sysenter_do_call+0x12/0x26
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-=
users"
>>in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>>
>>
>>--
>>Thanks,
>>Manik
>>
>>Think twice about a tree before you take a printout
>



--=20
Thanks,
Manik

Think twice about a tree before you take a printout
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
