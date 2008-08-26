From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Subject: x86: Move crashkernel reservation before
 dma32_reserve_bootmem()
Date: Tue, 26 Aug 2008 10:38:42 +0200
Message-ID: <20080826103842.2fc95c93@halley.suse.de>
References: <20080825125639.26874.80623.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: srostedt@redhat.com, mingo@elte.hu, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Gregory Haskins <ghaskins@novell.com>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:33221 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbYHZIin (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Aug 2008 04:38:43 -0400
In-Reply-To: <20080825125639.26874.80623.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Gregory Haskins [2008-08-25 08:58]:
>
>   Bernard (cc'd) sent me this patch for 26.3-rt3 to fix an issue where a kdump
>   kernel will fail to load, thereby disabling the crashdump feature.  Please
>   consider this patch for -rt4.  IIUC, this patch is already upstream in the
>   .27 series.

commit 91467bdf6e53058af13fd255375d6634ba0c70e0
Author: Bernhard Walle <bwalle@suse.de>
Date:   Fri Jul 18 19:07:53 2008 +0200



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development
