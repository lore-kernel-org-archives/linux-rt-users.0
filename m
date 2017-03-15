From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: oops with 4.9.13-rt12 under mild load (and no rt-tasks active)
Date: Wed, 15 Mar 2017 18:34:31 +0100
Message-ID: <20170315173431.lpuoqsrte2qzyb5s@linutronix.de>
References: <20170310194717.GE32625@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170310194717.GE32625@osadl.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-03-10 19:47:17 [+0000], Nicholas Mc Guire wrote:
> 
> Hi !
Hello Nicholas,

> [ 5329.000726] EXT4-fs (sda2): unable to read superblock
> [ 5329.001648] EXT4-fs (sda2): unable to read superblock
> [ 5329.002564] EXT4-fs (sda2): unable to read superblock
> [ 5329.003584] FAT-fs (sda2): bogus number of reserved sectors
> [ 5329.003588] FAT-fs (sda2): Can't find a valid FAT filesystem
> [ 5329.004645] FAT-fs (sda2): bogus number of reserved sectors
> [ 5329.004649] FAT-fs (sda2): Can't find a valid FAT filesystem
> [ 5329.005561] isofs_fill_super: bread failed, dev=sda2, iso_blknum=16, block=32

This is probably just some random noise. Usually during kernel upgrade
it will try to access all your partition and while doing this it will
try various fs-drivers. So it can happen that it will complain that it
can't mount sdaX with FAT while even if sdaX is swap and you don't use
FAT at all. I wouldn't worry too much about this.

>  but sda2 is the Extended partition - sda5 is the swap and it is mounted.
> 
>  I´ll see if this is reproducible - unfortunately the v2 config was lost as
>  the files that seem to have been in buffer-cache are all 0 size (many of the compiled
>  files in the kernel tree are 0 size - the sources seem ok as it can be recompiled).
> 
> Device     Boot     Start       End   Sectors   Size Id Type
> /dev/sda1  *         2048 470427647 470425600 224.3G 83 Linux
> /dev/sda2       470429694 490348543  19918850   9.5G  5 Extended
> /dev/sda5       470429696 490348543  19918848   9.5G 82 Linux swap / Solaris

So sda1 is with EXT4 and exploded? So besides files with size 0 you have
no further damage?

> [ 9007.810069] ------------[ cut here ]------------
> [ 9007.810071] kernel BUG at fs/inode.c:508!
…
> [ 9007.810107]  [<ffffffff811d7005>] ext4_clear_inode+0x15/0x80
> [ 9007.810109]  [<ffffffff811c6ea9>] ext4_evict_inode+0x69/0x3d0
> [ 9007.810111]  [<ffffffff8115ed50>] evict+0xc0/0x190
> [ 9007.810112]  [<ffffffff8115ee54>] dispose_list+0x34/0x40
> [ 9007.810114]  [<ffffffff8115ff06>] prune_icache_sb+0x46/0x60
> [ 9007.810117]  [<ffffffff8114662c>] super_cache_scan+0x14c/0x1a0
> [ 9007.810121]  [<ffffffff810fce65>] shrink_slab.part.52.constprop.73+0x1b5/0x250
> [ 9007.810124]  [<ffffffff8110047c>] shrink_node+0x5c/0x190
> [ 9007.810126]  [<ffffffff81100dc1>] kswapd+0x2d1/0x5c0
> [ 9007.810128]  [<ffffffff81100af0>] ? node_reclaim+0x200/0x200
> [ 9007.810132]  [<ffffffff8105f388>] ? call_usermodehelper_exec_async+0x148/0x160
> [ 9007.810135]  [<ffffffff810684b7>] kthread+0xd7/0xf0
> [ 9007.810137]  [<ffffffff810683e0>] ? kthread_park+0x60/0x60
> [ 9007.810139]  [<ffffffff8105f240>] ? umh_complete+0x20/0x20
> [ 9007.810143]  [<ffffffff81830612>] ret_from_fork+0x22/0x30

At some point your system decided, that it needs to make room for some
fresh memory so it kicked kswapd. That one invoked shrink_slab() which
is something you can also trigger via
	echo 2 > /proc/sys/vm/drop_caches 

At this point it tried to free memory. It managed to come across an ext4
inode which was not yet ready for clean up.
This "exceptional" counter is used by DAX, shmem and shadow. I assume
you don't use DAX so that leaves us with shmem and shadow.

>  Aside from hoping that I get this a second time - is there any other meaningful
>  info I could provide ?

I've been looking at this for a while now. I try to come up tomorrow.

>  Has anyone seen 4.9.13-rt12 oopses related to ext4 or vfs in general ?

nope, first time I see something like this.

> thx!
> hofrat

Sebastian
