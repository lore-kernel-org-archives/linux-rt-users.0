From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [v4.9-rt PATCH] ARM: mm: remove tasklist locking from
 update_sections_early()
Date: Wed, 19 Apr 2017 14:58:47 -0500
Message-ID: <05456050-7dc2-d58e-5250-bbb369d5d927@ti.com>
References: <20170418204815.9001-1-grygorii.strashko@ti.com>
 <CAGXu5j+=6iEK2-cEih6wvPabautwvMgsAFBw=31r8CttW-5uLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
 Laura Abbott <labbott@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: Kees Cook <keescook@chromium.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGXu5j+=6iEK2-cEih6wvPabautwvMgsAFBw=31r8CttW-5uLA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-rt-users.vger.kernel.org



On 04/18/2017 07:15 PM, Kees Cook wrote:
> On Tue, Apr 18, 2017 at 1:48 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> The below backtrace can be observed on -rt kernel with CONFIG_DEBUG_RODATA
>> option enabled:
>>
>>  BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:993
>>  in_atomic(): 1, irqs_disabled(): 128, pid: 14, name: migration/0
>>  1 lock held by migration/0/14:
>>   #0:  (tasklist_lock){+.+...}, at: [<c01183e8>] update_sections_early+0x24/0xdc
>>  irq event stamp: 38
>>  hardirqs last  enabled at (37): [<c08f6f7c>] _raw_spin_unlock_irq+0x24/0x68
>>  hardirqs last disabled at (38): [<c01fdfe8>] multi_cpu_stop+0xd8/0x138
>>  softirqs last  enabled at (0): [<c01303ec>] copy_process.part.5+0x238/0x1b64
>>  softirqs last disabled at (0): [<  (null)>]   (null)
>>  Preemption disabled at: [<c01fe244>] cpu_stopper_thread+0x80/0x10c
>>  CPU: 0 PID: 14 Comm: migration/0 Not tainted 4.9.21-rt16-02220-g49e319c #15
>>  Hardware name: Generic DRA74X (Flattened Device Tree)
>>  [<c0112014>] (unwind_backtrace) from [<c010d370>] (show_stack+0x10/0x14)
>>  [<c010d370>] (show_stack) from [<c049beb8>] (dump_stack+0xa8/0xd4)
>>  [<c049beb8>] (dump_stack) from [<c01631a0>] (___might_sleep+0x1bc/0x2ac)
>>  [<c01631a0>] (___might_sleep) from [<c08f7244>] (__rt_spin_lock+0x1c/0x30)
>>  [<c08f7244>] (__rt_spin_lock) from [<c08f77a4>] (rt_read_lock+0x54/0x68)
>>  [<c08f77a4>] (rt_read_lock) from [<c01183e8>] (update_sections_early+0x24/0xdc)
>>  [<c01183e8>] (update_sections_early) from [<c01184b0>] (__fix_kernmem_perms+0x10/0x1c)
>>  [<c01184b0>] (__fix_kernmem_perms) from [<c01fe010>] (multi_cpu_stop+0x100/0x138)
>>  [<c01fe010>] (multi_cpu_stop) from [<c01fe24c>] (cpu_stopper_thread+0x88/0x10c)
>>  [<c01fe24c>] (cpu_stopper_thread) from [<c015edc4>] (smpboot_thread_fn+0x174/0x31c)
>>  [<c015edc4>] (smpboot_thread_fn) from [<c015a988>] (kthread+0xf0/0x108)
>>  [<c015a988>] (kthread) from [<c0108818>] (ret_from_fork+0x14/0x3c)
>>  Freeing unused kernel memory: 1024K (c0d00000 - c0e00000)
>>
>> The stop_machine() is called with cpus = NULL from fix_kernmem_perms() and
>> mark_rodata_ro() which means only one CPU will execute
>> update_sections_early() while all other CPUs will spin and wait. Hence,
>> it's safe to remove tasklist locking from update_sections_early(). As part of
>> this change also mark functions which are local to this module as static
>> to simplify code analize in the future.
> 
> Hm, yes, good point. It's only every called while other CPUs are stopped.
> 
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Laura Abbott <labbott@redhat.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>  arch/arm/mm/init.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>> index 370581a..a77953a 100644
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c

/**
 * update_sections_early intended to be called only through stop_machine 
 * framework and be executed by only one CPU while all other CPUs will spin and
 * wait, so no locking is required in this function.
 */
>> @@ -693,30 +693,28 @@ static void update_sections_early(struct section_perm perms[], int n)
> 
> Maybe this should be renamed update_sections_stopped()? Or at least
> comments added to help see why it's safe.

would it be ok if I add above comment before update_sections_early?
Also I can rename it to update_sections_stopped() if you want - not sure about the name.


> 
>>  {
>>         struct task_struct *t, *s;
>>
>> -       read_lock(&tasklist_lock);
>>         for_each_process(t) {
>>                 if (t->flags & PF_KTHREAD)
>>                         continue;
>>                 for_each_thread(t, s)
>>                         set_section_perms(perms, n, true, s->mm);
>>         }
>> -       read_unlock(&tasklist_lock);
>>         set_section_perms(perms, n, true, current->active_mm);
>>         set_section_perms(perms, n, true, &init_mm);
>>  }
>>
>> -int __fix_kernmem_perms(void *unused)
>> +static int __fix_kernmem_perms(void *unused)
>>  {
>>         update_sections_early(nx_perms, ARRAY_SIZE(nx_perms));
>>         return 0;
>>  }
>>
>> -void fix_kernmem_perms(void)
>> +static void fix_kernmem_perms(void)
>>  {
>>         stop_machine(__fix_kernmem_perms, NULL, NULL);
>>  }
>>
>> -int __mark_rodata_ro(void *unused)
>> +static int __mark_rodata_ro(void *unused)
>>  {
>>         update_sections_early(ro_perms, ARRAY_SIZE(ro_perms));
>>         return 0;
> 
> Yeah, the static marks are all correct, thanks for fixing these!
> 
> -Kees
> 

-- 
regards,
-grygorii
