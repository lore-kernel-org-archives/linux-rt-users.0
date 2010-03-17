From: John Kacur <jkacur@redhat.com>
Subject: [BUG-REPORT] [PREEMPT_RT] Build break with DRM_I915 and
	HAVE_ATOMIC_IOMAP
Date: Wed, 17 Mar 2010 15:08:02 +0100
Message-ID: <520f0cf11003170708w758d3008n515a2f8d7d8751d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>, tremyfr@yahoo.fr
To: Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:63089 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab0CQOIG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Mar 2010 10:08:06 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a compile failure on 2.6.33.1-rt9 on x86

ERROR: "iounmap_atomic" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "iomap_atomic_prot_pfn" [drivers/gpu/drm/i915/i915.ko] undefined!

Analysis:

i915_drv.c and i915_gem.c include i915_drv.h which includes io_mapping.h
file: io_mapping.h
     has function io_mapping_map_atomic_wc which calls iomap_atomic_prot_pfn
     has function io_mapping_unmap_atomic which calls iounmap_atomic

These functions are defined in iomap_32.c but not ifdef PREEMPT_RT
