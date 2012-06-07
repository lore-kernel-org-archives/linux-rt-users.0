From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH RT 3/4] mips-remove-smp-reserve-lock.patch
Date: Thu, 07 Jun 2012 12:47:19 -0700
Message-ID: <4FD10547.9080804@gmail.com>
References: <20120607155148.698959275@goodmis.org>		 <20120607155221.836885041@goodmis.org> <4FD0E9F9.60906@gmail.com>	 <1339095399.13377.2.camel@gandalf.stny.rr.com> <4FD0FC26.3030101@gmail.com> <1339097538.13377.11.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339097538.13377.11.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 06/07/2012 12:32 PM, Steven Rostedt wrote:
> On Thu, 2012-06-07 at 12:08 -0700, David Daney wrote:
>
>>> Should it go to mainline stable?
>>>
>>
>> I don't think it is necessary.  As far as I know, RT may be the only
>> thing that needs it.
>
> Ah, you're right. As this is just an issue because it is called with
> interrupts disabled (from stop_machine). Although it's interesting that
> the mips code, re-enables interrupts from that function.
>
>  From kernel/cpu.c:
>
> _cpu_down() {
> 	 __stop_machine(take_cpu_down,&tcd_param, cpumask_of(cpu));
>
> take_cpu_down() {
> 	err = __cpu_disable();
>
> kernel/stop_machine.c:
>
> __stop_machine(int (*fn)(void *) ...) {
> 	local_irq_save(flags);
> 	hard_irq_disable();
> 	ret = (*fn)(data);
> 	local_irq_restore(flags);
>
>
> arch/mips/include/asm/smp.h:
>
> static inline int __cpu_disable(void)
> {
>          extern struct plat_smp_ops *mp_ops;     /* private */
>
>          return mp_ops->cpu_disable();
> }
>
> arch/mips/cavium-octeon/smp.c:
>
> octeon_cpu_disable(void) {
>          local_irq_disable();
>          fixup_irqs();
>          local_irq_enable();
>
> struct plat_smp_ops octeon_smp_ops = {
>          .cpu_disable            = octeon_cpu_disable,
>
>
> Is this expected? It causes the cpu notifiers to be called with
> interrupts enabled. Not sure if that's a problem or not.

I am inclined to go with your instinct here.  Probably we shouldn't 
unconditionally local_irq_enable() here.

Perhaps {,raw}_local_irq_save/{,raw}local_irq_restore would be better. 
Or even no local irq enable manipulation...

In any event, I may let Ralf sort it out.

David Daney
