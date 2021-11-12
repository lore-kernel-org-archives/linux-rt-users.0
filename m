Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32582C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 17:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AF260EBD
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 17:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhKLR6g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 12:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhKLR6f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Nov 2021 12:58:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91246C061766;
        Fri, 12 Nov 2021 09:55:44 -0800 (PST)
Date:   Fri, 12 Nov 2021 18:55:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636739741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QcYZDxEdTseC8UyknnTGMm4qN7M2lOv3FNbjYR8bVJo=;
        b=FaZEGc3i+CBQJtNRXXc2vz0tpi2onlBTjSgqmfKM8612hhrIPD1ssUkC2w6WBnKoki/CLy
        2uyYgqi6Ra/WBXJ03+9b1Mxpijek/P6wQWMLIM+cXwGVEfNoZ82EdKr8HWOmAN1ehiy3xv
        MDcQl58aSRpQ5OwJpbdBMcxQI0MPIHSEXsgyyw6IDFDZgMG9j8SIgwJaMv8OOBX4zNmHxb
        0eAwThO6BrcRUyAdO8qyJhSKzsn/Wa6PaPHydx+omHwyToLxiVqMRXlHIme/fllz/4zitw
        o7MlojNV5jkhq5oHAr9sdauHjopuFqVNrJby7WETavO1z+aeyKiaH/H6iTkyyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636739741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QcYZDxEdTseC8UyknnTGMm4qN7M2lOv3FNbjYR8bVJo=;
        b=3OYl0et1EV1E9549KF0DWWLOSojIBhEOfe59arGs9mC4fjsUq5BEF2gxDYoaGuFc8lJd0X
        6zG9br4hV0qdMwAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.15.2-rt19
Message-ID: <20211112175540.grp6vgrudiuq66lt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.15.2-rt19 patch set. 

Changes since v5.15.2-rt18:

  - Remove an unused variable in mm/ so that the compiler so there is
    neither a warning from the compiler nor a complaint from the bot.
    Reported by kernel test robot <lkp@intel.com>.

Known issues
     - netconsole triggers WARN.

     - The "Memory controller" (CONFIG_MEMCG) has been disabled.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.15.2-rt18 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.2-rt18-rt19.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.15.2-rt19

The RT patch against v5.15.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15.2-rt19.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patches-5.15.2-rt19.tar.xz

Sebastian

diff --git a/localversion-rt b/localversion-rt
index 9e7cd66d9f44f..483ad771f201a 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt18
+-rt19
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index eb714f00c1342..3c5be440ab303 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1881,7 +1881,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	struct vmap_block *vb;
 	struct vmap_area *va;
 	unsigned long vb_idx;
-	int node, err, cpu;
+	int node, err;
 	void *vaddr;
 
 	node = numa_node_id();
@@ -1918,7 +1918,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		return ERR_PTR(err);
 	}
 
-	cpu = get_cpu_light();
+	get_cpu_light();
 	vbq = this_cpu_ptr(&vmap_block_queue);
 	spin_lock(&vbq->lock);
 	list_add_tail_rcu(&vb->free_list, &vbq->free);
@@ -1988,7 +1988,6 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 	struct vmap_block *vb;
 	void *vaddr = NULL;
 	unsigned int order;
-	int cpu;
 
 	BUG_ON(offset_in_page(size));
 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
@@ -2003,7 +2002,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 	order = get_order(size);
 
 	rcu_read_lock();
-	cpu = get_cpu_light();
+	get_cpu_light();
 	vbq = this_cpu_ptr(&vmap_block_queue);
 	list_for_each_entry_rcu(vb, &vbq->free, free_list) {
 		unsigned long pages_off;
