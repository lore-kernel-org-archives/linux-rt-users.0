From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: PowerPC: massive "scheduling while atomic" reports
Date: Wed, 16 Sep 2015 11:48:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509161112230.3951@nanos>
References: <201509101106.56931.jbe@pengutronix.de> <alpine.DEB.2.11.1509142235440.3971@nanos> <201509151053.16563.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Juergen Borleis <jbe@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201509151053.16563.jbe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 15 Sep 2015, Juergen Borleis wrote:
> On Tuesday 15 September 2015 00:05:31 Thomas Gleixner wrote:
> > If you encounter such a 'confusing' problem the next time, then look
> > out for commonalities, AKA patterns. 99% of all problems can be
> > decoded via patterns. And if you look at the other call chains you'll
> > find more instances of those pte_*_lock() calls, which all end up in
> > kmap_atomic().
> 
> Sounds easy. But we stared with two developers on the code and the bug traces 
> and were lost in the code. Seems you are in a pole position due to your 
> experience with the RT preempt code.

That has nothing to do with RT experience.

The problem at hand is just bog standard kernel debugging of a
might_sleep/scheduling while atomic splat. You get a backtrace and you
need to figure out what in the callchain disables preemption. With
access to vmlinux it's not that hard, really.

When I did the anlysis I had no access to a PPC machine, so it was a
bit harder.

So now I have and decided to figure out how hard it is. First instance
of the splat:

[    2.427060] [c383fcf0] [c04be240] dump_stack+0x24/0x34 (unreliable)
[    2.427103] [c383fd00] [c0042d60] ___might_sleep+0x158/0x180
[    2.427128] [c383fd10] [c04baa84] rt_spin_lock+0x34/0x74
[    2.427177] [c383fd20] [c00d9560] handle_mm_fault+0xe44/0x11e0
[    2.427206] [c383fd90] [c00d3fe8] __get_user_pages+0x134/0x3b0

# addr2line -e ../build-power/vmlinux c00d9560
arch/powerpc/include/asm/pgtable.h:38

Not very helpful, but:

# addr2line -e ../build-power/vmlinux c00d955c
mm/memory.c:2710

# addr2line -e ../build-power/vmlinux c00d9564
mm/memory.c:2711

2710:        page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
2711:        if (!pte_none(*page_table))

So the issue is inside of pte_offset_map_lock, which is not that hard
to follow. If you think that's hard, then you can do:

# objdump -dS ../build-power/vmlinux

and search for c00d9560

static inline void *kmap_atomic(struct page *page)
{
        preempt_disable();
c00d9524:       38 60 00 01     li      r3,1
c00d9528:       3b f7 00 34     addi    r31,r23,52
c00d952c:       57 9c c9 f4     rlwinm  r28,r28,25,7,26
c00d9530:       7f 80 e2 14     add     r28,r0,r28
c00d9534:       4b f6 99 c5     bl      c0042ef8 <preempt_count_add>
#include <linux/sched.h>
#include <asm/uaccess.h>

static __always_inline void pagefault_disabled_inc(void)
{
        current->pagefault_disabled++;
c00d9538:       81 62 05 a8     lwz     r11,1448(r2)
c00d953c:       38 0b 00 01     addi    r0,r11,1
c00d9540:       90 02 05 a8     stw     r0,1448(r2)
c00d9544:       80 18 c2 40     lwz     r0,-15808(r24)
c00d9548:       7f 80 e0 50     subf    r28,r0,r28
c00d954c:       57 9b 38 26     rlwinm  r27,r28,7,0,19
c00d9550:       3f 7b c0 00     addis   r27,r27,-16384
c00d9554:       7f 9b ca 14     add     r28,r27,r25
c00d9558:       7f e3 fb 78     mr      r3,r31
c00d955c:       48 3e 14 f5     bl      c04baa50 <rt_spin_lock>
static inline int pte_write(pte_t pte)
{       return (pte_val(pte) & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO; }
static inline int pte_dirty(pte_t pte)          { return pte_val(pte) & _PAGE_DIRTY; }
static inline int pte_young(pte_t pte)          { return pte_val(pte) & _PAGE_ACCESSED; }
static inline int pte_special(pte_t pte)        { return pte_val(pte) & _PAGE_SPECIAL; }
static inline int pte_none(pte_t pte)           { return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
c00d9560:       7c 1b c8 2e     lwzx    r0,r27,r25
        if (!pte_none(*page_table))

The offending preempt_disable() is pretty prominent, isn't it?

The hardest part of that exercise was to fix the %$!#@'ed boot loader
to use the proper device tree for that machine.

Thanks,

	tglx
