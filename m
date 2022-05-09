Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEBDC4332F
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 May 2022 07:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiEIH5v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 May 2022 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiEIHov (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 May 2022 03:44:51 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA36140D4
        for <linux-rt-users@vger.kernel.org>; Mon,  9 May 2022 00:40:58 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e3so14401544ios.6
        for <linux-rt-users@vger.kernel.org>; Mon, 09 May 2022 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=uHiXPQflXLu83Qz6bRpPxclgDNSz+UBknNjLFTDF3Y0=;
        b=gi5QRK5iqS9Dz/E+6FuInqws2fNBuz7JlwhRoO3K9Vy/NjmGhRU6fk6Z43Nsdv5wkm
         hCWoF1CnOKI2he71ppDgNacwOpk0KFkKI5n8fahotGhSjrlL4OnUDPOuhN1AtAYdJ0DJ
         4563TMeuE3mHW91GDStE+GXbtgvQ4009docuqAzq9vdrifu3MDjHKx9lbLOZ1I848SdN
         u8D+QFSTxKHYkM0CGD0wRep1CvoQUrYonSPLNumKUN0LKBAeJl0/+LvmA+dO2OQHQv92
         cP50zvKpq9YF72BkMsEDueTKec5Z8sBrYCeuq7MQo45RCuAFN3CiVm3PDzIW3BuP1uJM
         mHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uHiXPQflXLu83Qz6bRpPxclgDNSz+UBknNjLFTDF3Y0=;
        b=elFKd/8eEGX9L3HkF9Sh4DPNnQ7gOP5MToWdPsWHDUsDOgRCmtnIZWk87FjkfwqrIR
         QbdJ+D2x1IIKO0SIe+/EL8hPGwTnjA0WIXnp5XWmiO9hkEz6Kk5ncofeX+BnKK0vhO0b
         Xw7T/8fO5qs4cZaCY5YwAhVAJVfBCCGdkv3EVvF5KftZ0hxtBKvQVfP/iImFCpHE0eLy
         ZLgFX4yNUrD6IswiUKboIqv66gPIVqf1EubPDI6PMU6zdfl6MkSrc/ETdr+q3BCVoCuL
         bsETOPeD8rc8TIcmbcp5r09TtZ2AWMAiYh+26gFfWUXiB5v+yCvouHXFhNlEwvsxPiBO
         yFQA==
X-Gm-Message-State: AOAM531ujj89YEPtymwXHCsIUtrQTpU9INSA4s4Da+js7ZHmm7JQfLZh
        ngMNy22uVVzLw2cQT8CIKgdp9mTwoUR3efpvAIFA6RBk/7lJlla4L48=
X-Google-Smtp-Source: ABdhPJxr8v17/xXE3zyVMDJFExbjv46kRzpKZC68R8SYu844O6s+IMkvrMpCpiE1BtqQd7q/TWoMihtitaN4SiPXm9o=
X-Received: by 2002:a02:3506:0:b0:328:9a29:678 with SMTP id
 k6-20020a023506000000b003289a290678mr6516419jaa.33.1652082054452; Mon, 09 May
 2022 00:40:54 -0700 (PDT)
MIME-Version: 1.0
From:   Yimin Deng <yimin11.deng@gmail.com>
Date:   Mon, 9 May 2022 15:40:43 +0800
Message-ID: <CAAh1qtktzZQxXp_t43YhxL6FZTS58rn_xvK2Zrq33-s3=j_sGQ@mail.gmail.com>
Subject: Oops or bad page in page_alloc.c
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi

I encountered an oops in isolate_pcp_pages() and a bad page in
get_page_from_freelist().

linux: 3.12.37-rt51  (CONFIG_PREEMPT_RT_BASE not enabled)
arch: PowperPC (e500)

The appmon.sh below is a shell script who periodically check whether
other applications is still existing, if not, print some info into a
uniq log file under the directory /tmp and restart that application
again. Normally, other applications are existing and there's no need
to be restart. But because bug, there's one application won't be
restart successfully (There's no such an application. Failed to start
it won't impact the system except printing some info into the log file
periodically.).
It's hard to reproduce it. It's reported in real world after running
more than 217 days (about 5233 ~ 5238 hours).
I tried to reproduce it in small app but failed.

From the oops below, it's really strange. The page to be deleted from
the pcp free list has been deleted in the past. From the 'Bad page'
issue, it seems that we could get a page who is still in use?
To me, the issue seems related to some race condition (maybe between
the parent and it's child processes). But no clue yet.
Any suggestions will be appreciated!

[18857088.953420] Unable to handle kernel paging request for data at
address 0x00100104
[18857089.046143] Faulting instruction address: 0xc0075624
[18857089.108654] Oops: Kernel access of bad area, sig: 11 [#1]
[18857089.176366] SMP NR_CPUS=8 CoreNet Generic
[18857089.227419] Modules linked in: napt(O)
[18857089.275357] CPU: 1 PID: 10357 Comm: appmon.sh Tainted: G
  O 3.12.37-rt51 #1
[18857089.371202] task: caba75b0 ti: cab2c000 task.ti: cab2c000
[18857089.438917] NIP: c0075624 LR: c0078f24 CTR: 00000007
[18857089.501427] REGS: cab2dbc0 TRAP: 0300   Tainted: G           O
(3.12.37-rt51)
[18857089.591014] MSR: 00021002 <CE,ME>  CR: 44448888  XER: 20000000
[18857089.663967] DEAR: 00100104, ESR: 00800000
[18857089.715017]
[18857089.715017] GPR00: 00100100 cab2dc70 caba75b0 00000006 c0728054
cab2dc88 c0728070 00000002
[18857089.715017] GPR08: c0728064 c0641814 00000002 00200200 00100100
100f9890 100f1d2c 100f0000
[18857089.715017] GPR16: 100f0000 100f0000 100bd61c c04b8d80 00029002
00000000 00200200 00100100
[18857089.715017] GPR24: cab8b00c 00000007 c04b8d80 00289000 00029002
00000000 cab2dc88 00200200
[18857090.073578] NIP [c0075624] isolate_pcp_pages+0x84/0xc4
[18857090.138173] LR [c0078f24] free_hot_cold_page+0x124/0x174
[18857090.204849] Call Trace:
[18857090.237156] [cab2dc70] [00080008] 0x80008 (unreliable)
[18857090.301762] [cab2dc80] [c0078e34] free_hot_cold_page+0x34/0x174
[18857090.375736] [cab2dcc0] [c0079300] free_hot_cold_page_list+0x44/0x54
[18857090.453876] [cab2dce0] [c007c588] release_pages+0x74/0x1c8
[18857090.522645] [cab2dd30] [c008d500] tlb_flush_mmu+0x60/0x70
[18857090.590370] [cab2dd50] [c008d528] tlb_finish_mmu+0x18/0x44
[18857090.659137] [cab2dd60] [c0093cb8] exit_mmap+0xb8/0x11c
[18857090.723741] [cab2ddd0] [c0019514] mmput+0x3c/0xf4
[18857090.783133] [cab2ddf0] [c00a8878] flush_old_exec+0x514/0x58c
[18857090.853986] [cab2de20] [c00d2208] load_elf_binary+0x1f0/0xfa4
[18857090.925875] [cab2dea0] [c00a8308] search_binary_handler+0x16c/0x1c8
[18857091.004015] [cab2ded0] [c00a8fcc] do_execve+0x2f0/0x4f8
[18857091.069655] [cab2df20] [c00a93d4] SyS_execve+0x40/0x58
[18857091.134257] [cab2df40] [c000cb38] ret_from_syscall+0x0/0x3c
[18857091.204067] --- Exception: c01 at 0xfdb75b4
[18857091.204067]     LR = 0x10032c24
[18857091.297826] Instruction dump:
[18857091.336385] 8128000c 7cc43214 7f864800 41feffd4 2f8a0003
40fe0008 7c6a1b78 7c6903a6
[18857091.432277] 81280010 3863ffff 81690004 81890000 <916c0004>
918b0000 90090000 93e90004
[18857091.530255] ---[ end trace ea47a50e65f9635c ]---
[18857091.588595]
[18857091.609453] Unable to handle kernel paging request for data at
address 0x00100104
[18857091.702170] Faulting instruction address: 0xc0075624
[18857091.764680] Oops: Kernel access of bad area, sig: 11 [#2]
[18857091.832394] SMP NR_CPUS=8 CoreNet Generic
[18857091.883446] Modules linked in: napt(O)
[18857091.931383] CPU: 1 PID: 10357 Comm: appmon.sh Tainted: G      D
  O 3.12.37-rt51 #1
[18857092.027222] task: caba75b0 ti: cab2c000 task.ti: cab2c000
[18857092.094938] NIP: c0075624 LR: c0078f24 CTR: 00000007
[18857092.157448] REGS: cab2d940 TRAP: 0300   Tainted: G      D    O
(3.12.37-rt51)
[18857092.247036] MSR: 00021002 <CE,ME>  CR: 24442288  XER: 20000000
[18857092.319989] DEAR: 00100104, ESR: 00800000
[18857092.371039]
[18857092.371039] GPR00: 00100100 cab2d9f0 caba75b0 00000006 c0728054
cab2da08 c0728070 00000002
[18857092.371039] GPR08: c0728064 c0641814 00000002 00200200 00100100
100f9890 100f1d2c 100f0000
[18857092.371039] GPR16: 100f0000 100f0000 100bd61c c04b8d80 00029002
00000000 c0000000 cabb57fc
[18857092.371039] GPR24: c0000000 00000007 c04b8d80 00289000 00021002
00000000 cab2da08 00200200
[18857092.729594] NIP [c0075624] isolate_pcp_pages+0x84/0xc4
[18857092.794187] LR [c0078f24] free_hot_cold_page+0x124/0x174
[18857092.860857] Call Trace:
[18857092.893165] [cab2da00] [c0078e34] free_hot_cold_page+0x34/0x174
[18857092.967139] [cab2da40] [c008d790] free_pgd_range+0x148/0x15c
[18857093.037987] [cab2da70] [c008d81c] free_pgtables+0x78/0xa4
[18857093.105710] [cab2daa0] [c0093ca4] exit_mmap+0xa4/0x11c
[18857093.170308] [cab2db10] [c0019514] mmput+0x3c/0xf4
[18857093.229700] [cab2db30] [c001cbb4] do_exit+0x2d0/0x790
[18857093.293261] [cab2db80] [c0008fbc] die+0x23c/0x244
[18857093.352654] [cab2dbb0] [c000d060] handle_page_fault+0x7c/0x80
[18857093.424547] --- Exception: 300 at isolate_pcp_pages+0x84/0xc4
[18857093.424547]     LR = free_hot_cold_page+0x124/0x174
[18857093.557893] [cab2dc70] [00080008] 0x80008 (unreliable)
[18857093.622500] [cab2dc80] [c0078e34] free_hot_cold_page+0x34/0x174
[18857093.696474] [cab2dcc0] [c0079300] free_hot_cold_page_list+0x44/0x54
[18857093.774613] [cab2dce0] [c007c588] release_pages+0x74/0x1c8
[18857093.843378] [cab2dd30] [c008d500] tlb_flush_mmu+0x60/0x70
[18857093.911102] [cab2dd50] [c008d528] tlb_finish_mmu+0x18/0x44
[18857093.979866] [cab2dd60] [c0093cb8] exit_mmap+0xb8/0x11c
[18857094.044464] [cab2ddd0] [c0019514] mmput+0x3c/0xf4
[18857094.103855] [cab2ddf0] [c00a8878] flush_old_exec+0x514/0x58c
[18857094.174705] [cab2de20] [c00d2208] load_elf_binary+0x1f0/0xfa4
[18857094.246594] [cab2dea0] [c00a8308] search_binary_handler+0x16c/0x1c8
[18857094.324732] [cab2ded0] [c00a8fcc] do_execve+0x2f0/0x4f8
[18857094.390373] [cab2df20] [c00a93d4] SyS_execve+0x40/0x58
[18857094.454973] [cab2df40] [c000cb38] ret_from_syscall+0x0/0x3c
[18857094.524779] --- Exception: c01 at 0xfdb75b4
[18857094.524779]     LR = 0x10032c24
[18857094.618538] Instruction dump:
[18857094.657091] 8128000c 7cc43214 7f864800 41feffd4 2f8a0003
40fe0008 7c6a1b78 7c6903a6
[18857094.752982] 81280010 3863ffff 81690004 81890000 <916c0004>
918b0000 90090000 93e90004
[18857094.850954] ---[ end trace ea47a50e65f9635d ]---
[18857094.909294]
[18857094.930140] Fixing recursive fault but reboot is needed!

static void isolate_pcp_pages(int to_free, struct per_cpu_pages *src,
struct list_head *dst)
{
int migratetype = 0, batch_free = 0;

while (to_free) {
struct page *page;
struct list_head *list;

/*
* Remove pages from lists in a round-robin fashion. A
* batch_free count is maintained that is incremented when an
* empty list is encountered.  This is so more pages are freed
* off fuller lists instead of spinning excessively around empty
* lists
*/
do {
batch_free++;
if (++migratetype == MIGRATE_PCPTYPES)
migratetype = 0;
list = &src->lists[migratetype];
} while (list_empty(list));

/* This is the only non-empty list. Free them all. */
if (batch_free == MIGRATE_PCPTYPES)
batch_free = to_free;

do {
page = list_last_entry(list, struct page, lru);
list_del(&page->lru);
list_add(&page->lru, dst);
} while (--to_free && --batch_free && !list_empty(list));
}
}

(gdb) disas isolate_pcp_pages
Dump of assembler code for function isolate_pcp_pages:
   0xc00755a0 <+0>: stwu    r1,-16(r1)
   0xc00755a4 <+4>: lis     r0,16
   0xc00755a8 <+8>: li      r10,0
   0xc00755ac <+12>: li      r7,0
   0xc00755b0 <+16>: ori     r0,r0,256
   0xc00755b4 <+20>: stw     r31,12(r1)
   0xc00755b8 <+24>: lis     r31,32
   0xc00755bc <+28>: ori     r31,r31,512
   0xc00755c0 <+32>: cmpwi   cr7,r3,0
   0xc00755c4 <+36>: bne+    cr7,0xc00755d4 <isolate_pcp_pages+52>
   0xc00755c8 <+40>: lwz     r31,12(r1)
   0xc00755cc <+44>: addi    r1,r1,16
   0xc00755d0 <+48>: blr
   0xc00755d4 <+52>: cmpwi   cr7,r7,2
   0xc00755d8 <+56>: addi    r10,r10,1
   0xc00755dc <+60>: addi    r7,r7,1
   0xc00755e0 <+64>: bne+    cr7,0xc00755e8 <isolate_pcp_pages+72>
   0xc00755e4 <+68>: li      r7,0
   0xc00755e8 <+72>: rlwinm  r8,r7,3,0,28
   0xc00755ec <+76>: addi    r6,r8,12
   0xc00755f0 <+80>: add     r8,r4,r8
   0xc00755f4 <+84>: lwz     r9,12(r8)
   0xc00755f8 <+88>: add     r6,r4,r6
   0xc00755fc <+92>: cmpw    cr7,r6,r9
   0xc0075600 <+96>: beq+    cr7,0xc00755d4 <isolate_pcp_pages+52>
   0xc0075604 <+100>: cmpwi   cr7,r10,3
   0xc0075608 <+104>: bne+    cr7,0xc0075610 <isolate_pcp_pages+112>
   0xc007560c <+108>: mr      r10,r3
   0xc0075610 <+112>: mtctr   r3
   0xc0075614 <+116>: lwz     r9,16(r8)
   0xc0075618 <+120>: addi    r3,r3,-1
   0xc007561c <+124>: lwz     r11,4(r9)
   0xc0075620 <+128>: lwz     r12,0(r9)
   0xc0075624 <+132>: stw     r11,4(r12)
   0xc0075628 <+136>: stw     r12,0(r11)
   0xc007562c <+140>: stw     r0,0(r9)
   0xc0075630 <+144>: stw     r31,4(r9)
   0xc0075634 <+148>: lwz     r11,0(r5)
   0xc0075638 <+152>: stw     r9,4(r11)
   0xc007563c <+156>: stw     r11,0(r9)
   0xc0075640 <+160>: stw     r5,4(r9)
   0xc0075644 <+164>: stw     r9,0(r5)
   0xc0075648 <+168>: bdz     0xc00755c0 <isolate_pcp_pages+32>
   0xc007564c <+172>: addic.  r10,r10,-1
   0xc0075650 <+176>: beq-    0xc00755c0 <isolate_pcp_pages+32>
   0xc0075654 <+180>: lwz     r9,12(r8)
   0xc0075658 <+184>: cmpw    cr7,r6,r9
   0xc007565c <+188>: bne+    cr7,0xc0075614 <isolate_pcp_pages+116>
   0xc0075660 <+192>: b       0xc00755c0 <isolate_pcp_pages+32>
End of assembler dump.

Below is another occurence:
[18855563.899808] BUG: Bad page state in process appmon.sh  pfn:08349
[18855563.973857] page:c063e920 count:1 mapcount:1 mapping:ca8ab541 index:0xfc73
[18855564.059306] page flags: 0x80068(uptodate|lru|active|swapbacked)
[18855564.133354] Modules linked in: napt(O)
[18855564.181334] CPU: 1 PID: 259 Comm: appmon.sh Tainted: G
O 3.12.37-rt51 #1
[18855564.275116] Call Trace:
[18855564.307444] [ca39bce0] [c0005cd0] show_stack+0x54/0x13c (unreliable)
[18855564.386697] [ca39bd20] [c0365d90] dump_stack+0x74/0x94
[18855564.451332] [ca39bd30] [c007779c] bad_page+0xec/0xf0
[18855564.513884] [ca39bd40] [c0077d00] get_page_from_freelist+0x438/0x4f8
[18855564.593103] [ca39bde0] [c0078800] __alloc_pages_nodemask+0xf4/0x6a4
[18855564.671281] [ca39bea0] [c008fc10] handle_mm_fault+0x9cc/0xc1c
[18855564.743205] [ca39bf10] [c000f6a0] do_page_fault+0x304/0x468
[18855564.813141] [ca39bf40] [c000cff0] handle_page_fault+0xc/0x80
[18855564.884050] --- Exception: 301 at 0xfd812c8
[18855564.884050]     LR = 0xfea31f4
[18855564.976803] Disabling lock debugging due to kernel taint


B.R.
Yimin
