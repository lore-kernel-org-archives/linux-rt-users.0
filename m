From: PRINGLE Chris <chris.pringle@miranda.com>
Subject: Lookaside cache with high volume of objects hangs the kernel on
 destruction (deadlock)
Date: Fri, 29 Jun 2012 08:08:42 +0000
Message-ID: <E7D6489E57008E4088E37F78D30C62E60BAB7A@LB-OPS-EXCH01.miranda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from stanmail.omnibus.co.uk ([194.201.223.253]:32038 "EHLO
	exch-lb.miranda.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750714Ab2F2IJB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jun 2012 04:09:01 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear All,

I posted about this a little while ago but ran out of time to look at the problem; unfortunately our problem has now resurfaced and I'm looking for some advice as to what might be going wrong.

We have a device driver that utilises lookaside caches; some of those caches are subject to a fairly high volume of objects. During normal operation there isn't a problem, however on destruction (when we unload the driver) the kernel hangs. I've tried this on v3.0.3 on 32 bit i686 with rt12 (9 months ago), and I've also tried it on PowerPC kernel v3.0.34 with rt55 (this week); both exhibit the same behaviour. Without the RT patches, everything appears to be okay; the code also appears to work on older 2.6.33 kernels (with the rt patch).

As far as I can tell, it looks like kmem_cache_free is trying to acquire a lock that it already has and the system subsequently deadlocks; I'm no expert on the PI code and I'm not entirely sure what is wrong, but it looks like it's the RT patches that have created the problem.

The following simplified driver reproduces the issue:

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#include <linux/init.h>
#include <linux/module.h>
#include <linux/poll.h>
#include <linux/version.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/delay.h>
#include <linux/slab.h>

MODULE_DESCRIPTION("test - driver module for Development Testing");
MODULE_AUTHOR("Chris Pringle");
MODULE_LICENSE("GPL");

struct test_struct
{
    unsigned int test[4096];
};

#define NUM_TESTS 1000

void test_func(void)
{
    struct kmem_cache* testcache;
    struct test_struct** structs;
    int i;

    structs= (struct test_struct**)kmalloc(sizeof(struct test_struct*) * NUM_TESTS, GFP_KERNEL);
    if (structs == NULL)
    {
        printk(KERN_ERR "%s: Unable to allocate memory\n", __func__);
        return;
    }

    printk(KERN_ERR "Creating\n");
    testcache= KMEM_CACHE(test_struct, 0);
    if (testcache == NULL)
    {
        printk(KERN_ERR "ERROR: %s: Failed to allocate lookaside cache \n", __func__);
        kfree(structs);
        return;
    }

    printk(KERN_ERR "Allocating\n");
    for (i= 0; i < NUM_TESTS; i++)
    {
        structs[i]= kmem_cache_alloc(testcache, GFP_KERNEL);
        if (structs[i] == NULL)
        {
            printk(KERN_ERR "ERROR: Failed to allocate\n");
        }
    }

    printk(KERN_ERR "Freeing\n");
    for (i= 0; i < NUM_TESTS; i++)
    {
        if (structs[i])
            kmem_cache_free(testcache, structs[i]);
    }

    printk(KERN_ERR "Shrinking\n");
    kmem_cache_shrink(testcache);
    printk(KERN_ERR "Destroying\n");
    kmem_cache_destroy(testcache);

    kfree(structs);
}


static int __init test_init(void)
{
    int ret= 0;

    test_func();

    if (ret == 0)
        printk(KERN_INFO "test driver version loaded\n");
    return (ret);
}

static void __exit test_exit(void)
{
}

module_init(test_init);
module_exit(test_exit);


>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Upon insertion of the driver, the following output & OOPS is generated:

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Creating
Allocating
Freeing
Shrinking
------------[ cut here ]------------
kernel BUG at kernel/rtmutex.c:725!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT SMP NR_CPUS=8 TEST
Modules linked in: test(+)
NIP: c04e5058 LR: c04e503c CTR: 00000000
REGS: e9af3cd0 TRAP: 0700   Not tainted  (3.0.34-rt55)
MSR: 00029002 <EE,ME,CE>  CR: 84000882  XER: 20000000
TASK = e9c533b0[325] 'insmod' THREAD: e9af2000 CPU: 0
GPR00: 00000001 e9af3d80 e9c533b0 00000000 e9c533b0 00000000 00000001 0000383a 
GPR08: e9c533b0 e9c533b0 e9c533b0 e9c533b1 24000822 10019904 10007234 100176e0 
GPR16: 00000001 1001a964 1001a960 10008bc1 10008b91 10008bcd 10008bcf 10008aa1 
GPR24: c065d234 ebc87728 00100100 c065b348 eb7c1b40 c062dc24 e9c533b0 c0ce5c24 
NIP [c04e5058] rt_spin_lock_slowlock+0x80/0x278
LR [c04e503c] rt_spin_lock_slowlock+0x64/0x278
Call Trace:
[e9af3d80] [c04e503c] rt_spin_lock_slowlock+0x64/0x278 (unreliable)
[e9af3df0] [c00daa58] kmem_cache_free+0x74/0x11c
[e9af3e10] [c00dad3c] free_block+0x1a4/0x1b0
[e9af3e40] [c00dafac] do_drain+0x94/0x124
[e9af3e80] [c00d9ef8] slab_on_each_cpu+0x48/0x90
[e9af3ea0] [c00db3b4] __cache_shrink+0x28/0xc8
[e9af3eb0] [c00db4a0] kmem_cache_shrink+0x4c/0x7c
[e9af3ec0] [f11dd160] test_func+0x160/0x180 [test]
[e9af3ee0] [f11f1010] test_init+0x10/0x50 [test]
[e9af3ef0] [c0001fa4] do_one_initcall+0x50/0x1ec
[e9af3f20] [c0082ff4] sys_init_module+0xc8/0x1d4
[e9af3f40] [c000f10c] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xfe9ab08
    LR = 0x1000143c
Instruction dump:
7fe3fb78 7fc4f378 38a00000 38c00001 4bb9725d 2f830000 409e0174 801f0010 
5400003c 7fc00278 7c000034 5400d97e <0f000000> 3bbe0500 3b810008 7fa3eb78

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

The call always fails when calling __cache_shrink (regardless of whether it's from kmem_cache_shrink or kmem_cache_destroy).

Does anyone have any idea what this might be? 

Cheers,
Chris


