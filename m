From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch v2] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()
Date: Wed, 19 Oct 2016 18:54:19 +0200
Message-ID: <20161019165419.wh74ibrlbyd5fy3c@linutronix.de>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
 <1476587662.1538.8.camel@gmail.com>
 <20161017142428.25dyxefk2arjeyfz@linutronix.de>
 <1476892590.3975.6.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476892590.3975.6.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-10-19 17:56:30 [+0200], Mike Galbraith wrote:
> In v4.7, the driver switched to percpu compression streams, disabling
> preemption vai get/put_cpu_ptr().  Use a local lock instead for RT.
> We also have to fix an RT lock order issue in zram_decompress_page()
> such that zs_map_object() nests inside of zcomp_stream_put() as it
> does in zram_bvec_write().

good. I almost had it myself. So let me get that one. And your previous
one (the spinlock replacement) looks also reasonable. With this hunk

@@ -313,6 +314,7 @@ struct mapping_area {
 #endif
        char *vm_addr; /* address of kmap_atomic()'ed pages */
        enum zs_mapmode vm_mm; /* mapping mode */
+       spinlock_t      ma_lock;
 };
 
 #ifdef CONFIG_COMPACTION
@@ -1489,6 +1491,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
        off = (class->size * obj_idx) & ~PAGE_MASK;
 
        area = per_cpu_ptr(&zs_map_area, get_cpu_light());
+       spin_lock(&area->ma_lock);
        area->vm_mm = mm;
        if (off + class->size <= PAGE_SIZE) {
                /* this object is contained entirely within a page */
@@ -1542,6 +1545,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
                __zs_unmap_object(area, pages, off, class->size);
        }
+       spin_unlock(&area->ma_lock);
        put_cpu_light();
 
        migrate_read_unlock(zspage);


I don't see this anymore:

|gcc: internal compiler error: Killed (program cc1)
|Please submit a full bug report,
|with preprocessed source if appropriate.
|See <file:///usr/share/doc/gcc-6/README.Bugs> for instructions.
|Makefile:134: recipe for target 'servconf.o' failed
|make: *** [servconf.o] Error 4
|make: *** Waiting for unfinished jobs....
|
|
|loginrec.c:1722:1: internal compiler error: Bus error
| }
| ^

only 
|gcc: internal compiler error: Killed (program cc1)

which is expected.

> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>

Sebastian
